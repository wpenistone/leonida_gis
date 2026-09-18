# -*- coding: utf-8 -*-
"""
Leonida Turn Restrictions - QGIS plugin
=======================================
Interactive turn-restriction mapping tool for the State of Leonida GIS.

Visual Turn Arrows:
  - Only displayed when an intersection is actively selected (not permanently visible).
  - Automatically hidden when you:
      * Deselect / click away in empty space
      * Right-click on the map canvas
      * Press the Escape key (Esc)
      * Switch to any other QGIS tool (Pan, Zoom, Select, Node tool)
      * Close or hide the Turn Restrictions dock
  - Clicking a circular turn arrow button on the canvas cycles its restriction:
      Allowed (Green) -> Prohibited (Red) -> Only (Blue) -> Allowed
"""

import os
import json
import math

from qgis.PyQt.QtWidgets import (
    QAction, QDockWidget, QWidget, QVBoxLayout, QHBoxLayout, QLabel,
    QPushButton, QComboBox, QLineEdit, QListWidget, QListWidgetItem,
    QMessageBox, QGroupBox, QFormLayout, QCheckBox
)
from qgis.PyQt.QtCore import Qt, QPointF, QRectF
from qgis.PyQt.QtGui import QColor, QIcon, QPainter, QPen, QBrush, QPolygonF, QFont
from qgis.core import (
    QgsPointXY, QgsWkbTypes, QgsProject
)

try:
    from qgis.gui import QgsMapCanvasItem, QgsMapTool, QgsRubberBand
except ImportError:
    class QgsMapCanvasItem:
        def __init__(self, canvas): pass
        def update(self): pass
        def toCanvasCoordinates(self, pt): return QPointF(pt.x(), pt.y())
    class QgsMapTool:
        def __init__(self, canvas): pass
        def deactivate(self): pass
        def keyPressEvent(self, event): pass
    class QgsRubberBand:
        def __init__(self, canvas, geometryType=None): pass
        def setColor(self, color): pass
        def setWidth(self, width): pass
        def reset(self): pass
        def addPoint(self, pt): pass
        def show(self): pass
        def hide(self): pass

RESTRICTION_TYPES = [
    ("no_left_turn", "No Left Turn"),
    ("no_right_turn", "No Right Turn"),
    ("no_u_turn", "No U-Turn"),
    ("no_straight_on", "No Straight On"),
    ("only_straight_on", "Only Straight On"),
    ("only_left_turn", "Only Left Turn"),
    ("only_right_turn", "Only Right Turn"),
]

PICK_TOLERANCE_M = 35.0
VIA_SNAP_TOLERANCE_M = 50.0
BUTTON_RADIUS_PX = 15.0
BUTTON_DISTANCE_PX = 42.0

STEP_IDLE = "idle"
STEP_FROM = "pick_from"
STEP_VIA = "pick_via"


class RestrictionStore:
    """Reads and writes layers/restrictions.geojson."""

    def __init__(self, plugin_dir):
        self.repo_root = os.path.abspath(os.path.join(plugin_dir, "..", ".."))
        self.path = os.path.join(self.repo_root, "layers", "restrictions.geojson")
        self.roads_path = os.path.join(self.repo_root, "layers", "roads.geojson")

    def load(self):
        if not os.path.exists(self.path):
            return {
                "type": "FeatureCollection",
                "name": "restrictions",
                "crs": {"type": "name", "properties": {"name": "urn:ogc:def:crs:EPSG::4087"}},
                "features": []
            }
        with open(self.path, "r", encoding="utf-8") as f:
            return json.load(f, parse_constant=lambda c: None)

    def features(self):
        return self.load().get("features", [])

    def next_id(self):
        ids = [f.get("properties", {}).get("id", 0) for f in self.features()]
        return (max(ids) + 1) if ids else 1

    def roads(self):
        """Returns {ref_id: {"coordinates": coords, "name": name, "highway": highway, "oneway": oneway}}."""
        roads = {}
        if not os.path.exists(self.roads_path):
            return roads
        with open(self.roads_path, "r", encoding="utf-8") as f:
            data = json.load(f, parse_constant=lambda c: None)
        for feat in data.get("features", []):
            p = feat.get("properties", {})
            ref = p.get("ref_id")
            geom = feat.get("geometry", {})
            if ref and geom.get("type") in ["LineString", "MultiLineString"]:
                coords = geom["coordinates"]
                if geom["type"] == "MultiLineString":
                    coords = [pt for line in coords for pt in line]
                roads[ref] = {
                    "coordinates": coords,
                    "name": p.get("name"),
                    "highway": p.get("highway", "residential"),
                    "oneway": p.get("oneway", "no"),
                    "lanes": p.get("lanes", 2)
                }
        return roads

    @staticmethod
    def _sort_keys(obj):
        if isinstance(obj, dict):
            return {k: RestrictionStore._sort_keys(v) for k, v in sorted(obj.items())}
        if isinstance(obj, list):
            return [RestrictionStore._sort_keys(e) for e in obj]
        return obj

    def get_restriction(self, from_way, to_way):
        """Finds any active restriction between from_way and to_way."""
        for f in self.features():
            p = f.get("properties", {})
            if p.get("from_way") == from_way and p.get("to_way") == to_way:
                return f
        return None

    def save_feature(self, props, point_xy):
        fc = self.load()
        clean_props = {
            "id": int(props["id"]),
            "type": "restriction",
            "restriction": str(props["restriction"]),
            "from_way": str(props["from_way"]),
            "to_way": str(props["to_way"]),
            "layer": int(props.get("layer", 0)),
        }
        if props.get("except"):
            clean_props["except"] = str(props["except"]).strip()
        else:
            clean_props["except"] = None

        if props.get("description"):
            clean_props["description"] = str(props["description"]).strip()

        feature = {
            "type": "Feature",
            "id": clean_props["id"],
            "properties": self._sort_keys(clean_props),
            "geometry": self._sort_keys({
                "type": "Point",
                "coordinates": [round(point_xy.x(), 2), round(point_xy.y(), 2)]
            })
        }
        features = fc.get("features", [])
        existing_idx = next((i for i, f in enumerate(features)
                             if f.get("properties", {}).get("from_way") == clean_props["from_way"]
                             and f.get("properties", {}).get("to_way") == clean_props["to_way"]), None)
        if existing_idx is not None:
            feature["id"] = features[existing_idx].get("properties", {}).get("id", clean_props["id"])
            feature["properties"]["id"] = feature["id"]
            features[existing_idx] = feature
        else:
            features.append(feature)

        features.sort(key=lambda f: f.get("properties", {}).get("id", 0))
        fc["features"] = features
        self._write(fc)
        return feature

    def delete_feature(self, fid):
        fc = self.load()
        before = len(fc.get("features", []))
        fc["features"] = [f for f in fc.get("features", []) if f.get("properties", {}).get("id") != fid]
        self._write(fc)
        return before - len(fc["features"])

    def delete_by_ways(self, from_way, to_way):
        fc = self.load()
        before = len(fc.get("features", []))
        fc["features"] = [f for f in fc.get("features", [])
                          if not (f.get("properties", {}).get("from_way") == from_way
                                  and f.get("properties", {}).get("to_way") == to_way)]
        self._write(fc)
        return before - len(fc["features"])

    def _write(self, fc):
        lines = [
            '{\n',
            '  "type": "FeatureCollection",\n',
            '  "name": "restrictions",\n',
            '  "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },\n',
            '  "features": [\n'
        ]
        strs = []
        for f in fc.get("features", []):
            line = json.dumps(f, separators=(',', ': '), ensure_ascii=False, allow_nan=False)
            strs.append(f"    {line}")
        lines.append(',\n'.join(strs))
        lines.append('\n  ]\n}\n')
        with open(self.path, "w", encoding="utf-8") as f:
            f.writelines(lines)


def calculate_turn_angle(p_prev, p_via, p_next):
    """Calculates relative turn angle in degrees [-180, +180]. Counter-clockwise (+) = Left, Clockwise (-) = Right."""
    v1_x = p_via[0] - p_prev[0]
    v1_y = p_via[1] - p_prev[1]
    v2_x = p_next[0] - p_via[0]
    v2_y = p_next[1] - p_via[1]
    ang1 = math.atan2(v1_y, v1_x)
    ang2 = math.atan2(v2_y, v2_x)
    diff = math.degrees(ang2 - ang1)
    while diff <= -180: diff += 360
    while diff > 180: diff -= 360
    return diff


def classify_turn(diff):
    """Classifies angle into OSM movement description and standard restriction tags."""
    if abs(diff) >= 140:
        return "U-Turn", "no_u_turn", "no_u_turn"
    elif diff >= 45:
        return "Left Turn", "no_left_turn", "only_left_turn"
    elif diff <= -45:
        return "Right Turn", "no_right_turn", "only_right_turn"
    else:
        return "Straight On", "no_straight_on", "only_straight_on"


def nearest_road(point, roads, tolerance=PICK_TOLERANCE_M):
    """Return (ref_id, snapped_point, distance) for nearest road line, or None."""
    best = None
    for ref, info in roads.items():
        coords = info["coordinates"] if isinstance(info, dict) else info
        for i in range(len(coords) - 1):
            x1, y1 = coords[i]
            x2, y2 = coords[i + 1]
            dx, dy = x2 - x1, y2 - y1
            seg_len2 = dx * dx + dy * dy
            if seg_len2 == 0:
                t = 0.0
            else:
                t = max(0.0, min(1.0, ((point.x() - x1) * dx + (point.y() - y1) * dy) / seg_len2))
            px, py = x1 + t * dx, y1 + t * dy
            dist = ((point.x() - px) ** 2 + (point.y() - py) ** 2) ** 0.5
            if best is None or dist < best[3]:
                best = (ref, QgsPointXY(px, py), i, dist)
    if best and best[3] <= tolerance:
        return best[0], best[1], best[3]
    return None


def snap_to_way(point, coords, tolerance=VIA_SNAP_TOLERANCE_M):
    """Snap a click onto the nearest point of a way line."""
    best = None
    for i in range(len(coords) - 1):
        x1, y1 = coords[i]
        x2, y2 = coords[i + 1]
        dx, dy = x2 - x1, y2 - y1
        seg_len2 = dx * dx + dy * dy
        if seg_len2 == 0:
            t = 0.0
        else:
            t = max(0.0, min(1.0, ((point.x() - x1) * dx + (point.y() - y1) * dy) / seg_len2))
        px, py = x1 + t * dx, y1 + t * dy
        dist = ((point.x() - px) ** 2 + (point.y() - py) ** 2) ** 0.5
        if best is None or dist < best[2]:
            best = (QgsPointXY(px, py), i, dist)
    if best and best[2] <= tolerance:
        return best[0], best[2]
    return None, (best[2] if best else float("inf"))


class IDTurnArrowsCanvasItem(QgsMapCanvasItem):
    """Draws interactive circular turn arrows at the junction node directly on the map canvas when selected."""

    def __init__(self, canvas):
        super().__init__(canvas)
        self.canvas = canvas
        self.via_pt = None
        self.branches = []

    def set_data(self, via_pt, branches):
        self.via_pt = via_pt
        self.branches = branches
        self.update()

    def clear(self):
        self.via_pt = None
        self.branches = []
        self.update()

    def paint(self, painter, option=None, widget=None):
        # Only render when an active junction with branches is selected
        if not self.via_pt or not self.branches:
            return

        painter.setRenderHint(QPainter.Antialiasing, True)
        via_screen = self.toCanvasCoordinates(self.via_pt)

        # 1. Draw junction node marker
        painter.setPen(QPen(QColor(255, 255, 255, 240), 2.5))
        painter.setBrush(QBrush(QColor(255, 214, 0, 230)))  # Gold/Yellow
        painter.drawEllipse(via_screen, 9, 9)

        # 2. Draw radiating turn arrow circular buttons for each branch
        font = QFont("Arial", 8, QFont.Bold)
        painter.setFont(font)

        for b in self.branches:
            rad = math.radians(b["angle_screen"])
            bx = via_screen.x() + BUTTON_DISTANCE_PX * math.cos(rad)
            by = via_screen.y() - BUTTON_DISTANCE_PX * math.sin(rad)
            b["center_screen"] = QPointF(bx, by)

            status = b["status"]  # 'allowed', 'prohibited', 'only'
            r = BUTTON_RADIUS_PX

            # Connector line from junction to button
            painter.setPen(QPen(QColor(255, 255, 255, 170), 2, Qt.DashLine))
            painter.drawLine(via_screen, b["center_screen"])

            # Button Circle Background
            if status == "prohibited":
                bg_col = QColor(224, 49, 49)      # Red
            elif status == "only":
                bg_col = QColor(25, 113, 194)     # Blue
            else:
                bg_col = QColor(43, 138, 62)      # Green (Allowed)

            # Outer white border & fill
            painter.setPen(QPen(QColor(255, 255, 255), 2.0))
            painter.setBrush(QBrush(bg_col))
            painter.drawEllipse(b["center_screen"], r, r)

            # Draw directional arrow icon rotated along outgoing heading
            painter.save()
            painter.translate(b["center_screen"])
            painter.rotate(-b["angle_screen"])

            arrow = QPolygonF([
                QPointF(6.0, 0.0),
                QPointF(-2.0, -5.0),
                QPointF(-2.0, -2.0),
                QPointF(-6.0, -2.0),
                QPointF(-6.0, 2.0),
                QPointF(-2.0, 2.0),
                QPointF(-2.0, 5.0)
            ])
            painter.setPen(Qt.NoPen)
            painter.setBrush(QBrush(QColor(255, 255, 255)))
            painter.drawPolygon(arrow)

            # Draw prohibition diagonal slash if prohibited (OSM iD style)
            if status == "prohibited":
                painter.setPen(QPen(QColor(255, 255, 255), 2.5))
                painter.drawLine(QPointF(-r + 4, -r + 4), QPointF(r - 4, r - 4))

            painter.restore()

            # Small road tag label beside button
            painter.setPen(QPen(QColor(255, 255, 255), 1))
            painter.setBrush(QBrush(QColor(0, 0, 0, 180)))
            text_rect = QRectF(bx - 22, by + r + 2, 44, 14)
            painter.drawRoundedRect(text_rect, 3, 3)
            painter.setPen(QPen(QColor(255, 255, 255)))
            painter.drawText(text_rect, Qt.AlignCenter, b["ref"])


class IDTurnRestrictionTool(QgsMapTool):
    """Interactive map tool that activates visual turn arrows on selection and clears them on deactivation/deselect."""

    def __init__(self, canvas, dock):
        super().__init__(canvas)
        self.canvas = canvas
        self.dock = dock

    def deactivate(self):
        """Called automatically by QGIS when switching to another tool (Pan, Zoom, Select, etc.)."""
        if self.dock:
            self.dock.reset_workflow()
        if hasattr(super(), "deactivate"):
            super().deactivate()

    def keyPressEvent(self, event):
        """Pressing Escape (Esc) cancels selection and turns off visual arrows."""
        if event.key() == Qt.Key_Escape:
            if self.dock:
                self.dock.reset_workflow()
                self.dock.status.setText("Escape pressed. Selection cleared and arrows hidden.")
            return
        if hasattr(super(), "keyPressEvent"):
            super().keyPressEvent(event)

    def canvasPressEvent(self, event):
        if event.button() == Qt.RightButton:
            # Right-click cancels selection and turns off visual arrows
            self.dock.reset_workflow()
            self.dock.status.setText("Right-clicked. Selection cleared and arrows hidden.")
            return

        pos = event.pos()
        # 1. Check if clicked directly on an interactive turn arrow button
        if self.dock.handle_arrow_button_click(pos):
            return

        # 2. Otherwise route click to picking FROM way or VIA junction
        map_pt = self.toMapCoordinates(pos)
        self.dock.handle_map_click(map_pt, event.button())


class TurnRestrictionDock(QDockWidget):
    """Interactive Turn Restrictions Dock Panel."""

    def __init__(self, parent, store, canvas=None):
        super().__init__("Turn Restrictions", parent)
        self.store = store
        self.canvas = canvas
        self.setObjectName("LeonidaTurnRestrictionsDock")
        self.setAllowedAreas(Qt.LeftDockWidgetArea | Qt.RightDockWidgetArea)

        self.step = STEP_IDLE
        self.from_way = None
        self.via_point = None
        self.roads = self.store.roads()
        self.branches = []

        # Canvas overlays
        self.turn_arrows_item = None
        self.rb_from = None
        if self.canvas:
            self._init_canvas_items()

        panel = QWidget()
        layout = QVBoxLayout(panel)

        # Header Instructions
        self.lbl_step = QLabel(
            "Select an intersection to view and edit turn restrictions."
        )
        self.lbl_step.setWordWrap(True)
        layout.addWidget(self.lbl_step)

        # Active Selection Box
        pick_box = QGroupBox("Selected Intersection")
        pick_layout = QVBoxLayout(pick_box)
        btn_h = QHBoxLayout()
        self.btn_pick_from = QPushButton("1. Pick FROM Way")
        self.btn_pick_via = QPushButton("2. Pick VIA Junction")
        self.btn_clear = QPushButton("Clear / Hide Arrows (Esc)")
        btn_h.addWidget(self.btn_pick_from)
        btn_h.addWidget(self.btn_pick_via)
        btn_h.addWidget(self.btn_clear)
        pick_layout.addLayout(btn_h)

        self.lbl_from_info = QLabel("FROM: <i>None selected (arrows off)</i>")
        self.lbl_via_info = QLabel("VIA: <i>None selected (arrows off)</i>")
        pick_layout.addWidget(self.lbl_from_info)
        pick_layout.addWidget(self.lbl_via_info)
        layout.addWidget(pick_box)

        # Visual Legend
        legend_box = QGroupBox("Legend")
        legend_layout = QVBoxLayout(legend_box)
        legend_layout.addWidget(QLabel("<b>Green:</b> Allowed"))
        legend_layout.addWidget(QLabel("<b>Red:</b> Prohibited"))
        legend_layout.addWidget(QLabel("<b>Blue:</b> Mandatory (Only)"))
        layout.addWidget(legend_box)

        # Optional tags
        tag_box = QGroupBox("Optional Tags")
        form = QFormLayout(tag_box)
        self.txt_except = QLineEdit()
        self.txt_except.setPlaceholderText("e.g. emergency, psv, delivery")
        form.addRow("Exceptions:", self.txt_except)
        self.txt_desc = QLineEdit()
        self.txt_desc.setPlaceholderText("e.g. Overpass ramp through-traffic only")
        form.addRow("Description:", self.txt_desc)
        layout.addWidget(tag_box)

        self.status = QLabel("Ready. Click a road on the map to begin.")
        self.status.setWordWrap(True)
        layout.addWidget(self.status)

        # Saved Restrictions Manager
        list_box = QGroupBox("Saved Restrictions")
        list_layout = QVBoxLayout(list_box)
        self.list_widget = QListWidget()
        list_layout.addWidget(self.list_widget)

        btn_list_h = QHBoxLayout()
        self.btn_zoom = QPushButton("Zoom to Selected")
        self.btn_delete = QPushButton("Delete Selected")
        self.btn_zoom.setEnabled(False)
        self.btn_delete.setEnabled(False)
        btn_list_h.addWidget(self.btn_zoom)
        btn_list_h.addWidget(self.btn_delete)
        list_layout.addLayout(btn_list_h)
        layout.addWidget(list_box)

        self.setWidget(panel)

        # Signals
        self.btn_pick_from.clicked.connect(self.activate_pick_from)
        self.btn_pick_via.clicked.connect(self.activate_pick_via)
        self.btn_clear.clicked.connect(self.reset_workflow)
        self.btn_delete.clicked.connect(self.delete_selected)
        self.btn_zoom.clicked.connect(self.zoom_to_selected)
        self.list_widget.currentRowChanged.connect(
            lambda r: [self.btn_delete.setEnabled(r >= 0), self.btn_zoom.setEnabled(r >= 0)]
        )

        self.refresh_list()

    def _init_canvas_items(self):
        try:
            self.turn_arrows_item = IDTurnArrowsCanvasItem(self.canvas)
            self.rb_from = QgsRubberBand(self.canvas, QgsWkbTypes.LineGeometry)
            self.rb_from.setColor(QColor(0, 229, 255, 210))  # Cyan approach highlight
            self.rb_from.setWidth(4)
        except Exception:
            pass

    def reload_qgis_layer(self):
        """Invalidate QGIS layer cache and repaint canvas when restrictions change."""
        try:
            from qgis.core import QgsProject
            for lyr in QgsProject.instance().mapLayers().values():
                if "restriction" in lyr.name().lower() or "restriction" in lyr.id().lower():
                    lyr.reload()
                    lyr.triggerRepaint()
        except Exception:
            pass

    def cleanup(self):
        """Safely remove canvas graphics items from the scene on plugin unload."""
        try:
            if self.turn_arrows_item and self.canvas:
                self.canvas.scene().removeItem(self.turn_arrows_item)
                self.turn_arrows_item = None
            if self.rb_from and self.canvas:
                self.canvas.scene().removeItem(self.rb_from)
                self.rb_from = None
        except Exception:
            pass

    def closeEvent(self, event):
        """When dock is closed, immediately turn off all visual arrows and highlights."""
        self.reset_workflow()
        super().closeEvent(event)

    def activate_pick_from(self):
        self.step = STEP_FROM
        self.roads = self.store.roads()
        self.status.setText("Click a road to select the incoming FROM way.")

    def activate_pick_via(self):
        if not self.from_way:
            self.status.setText("Pick a FROM way first.")
            return
        self.step = STEP_VIA
        self.status.setText("Click near the intersection junction node (snaps automatically).")

    def reset_workflow(self):
        """Turns off all visual arrows, rubberbands, and resets selection state."""
        self.step = STEP_IDLE
        self.from_way = None
        self.via_point = None
        self.branches.clear()
        self.lbl_from_info.setText("FROM: <i>None selected (arrows off)</i>")
        self.lbl_via_info.setText("VIA: <i>None selected (arrows off)</i>")
        if self.turn_arrows_item:
            self.turn_arrows_item.clear()
        if self.rb_from:
            self.rb_from.reset()
        if self.canvas:
            self.canvas.refresh()

    def handle_map_click(self, point, button):
        hit = nearest_road(point, self.roads)

        # If clicked in empty space, deselect and turn off visual arrows
        if not hit:
            self.reset_workflow()
            self.status.setText("Clicked empty space. Selection cleared and visual arrows hidden.")
            return

        road_ref, snapped_pt, dist = hit

        # Step 1: Picking FROM way
        if self.step == STEP_FROM or self.step == STEP_IDLE:
            self.from_way = road_ref
            r_info = self.roads[self.from_way]
            name_str = f" ('{r_info['name']}')" if r_info.get("name") else ""
            self.lbl_from_info.setText(f"FROM: <b>{self.from_way}</b>{name_str} [{r_info['highway']}]")

            if self.rb_from:
                self.rb_from.reset()
                for pt in r_info["coordinates"]:
                    self.rb_from.addPoint(QgsPointXY(pt[0], pt[1]))
                self.rb_from.show()

            self.step = STEP_VIA
            self.status.setText(f"FROM={self.from_way} selected. Now click the junction node to display turn arrows.")

        # Step 2: Picking VIA junction
        elif self.step == STEP_VIA:
            coords = self.roads[self.from_way]["coordinates"]
            snapped, dist = snap_to_way(point, coords)
            if not snapped:
                self.status.setText(f"VIA point is {dist:.1f}m away (must be within {VIA_SNAP_TOLERANCE_M}m of FROM way).")
                return
            self.via_point = snapped
            self.lbl_via_info.setText(f"VIA: <b>({snapped.x():.2f}, {snapped.y():.2f})</b>")

            # Discover outgoing branches and render visual turn arrows
            self.build_canvas_turn_arrows()
            self.status.setText("Turn arrows active. Click an arrow on the map to toggle restriction.")

    def build_canvas_turn_arrows(self):
        """Discovers all branches at junction and renders interactive visual turn arrows."""
        self.branches.clear()
        if not self.via_point or not self.from_way:
            return

        vx, vy = self.via_point.x(), self.via_point.y()
        from_coords = self.roads[self.from_way]["coordinates"]

        # Incoming vector into junction
        dists = [((p[0] - vx) ** 2 + (p[1] - vy) ** 2) ** 0.5 for p in from_coords]
        min_idx = dists.index(min(dists))
        if min_idx > 0:
            approach_prev = from_coords[min_idx - 1]
        elif len(from_coords) > 1:
            approach_prev = from_coords[1]
        else:
            approach_prev = (vx - 1.0, vy)

        for ref, r_info in self.roads.items():
            coords = r_info["coordinates"]
            v_dists = [((p[0] - vx) ** 2 + (p[1] - vy) ** 2) ** 0.5 for p in coords]
            min_d = min(v_dists)
            if min_d <= 25.0:  # within junction tolerance
                idx = v_dists.index(min_d)
                if idx < len(coords) - 1:
                    outgoing_next = coords[idx + 1]
                elif idx > 0:
                    outgoing_next = coords[idx - 1]
                else:
                    continue

                if ref == self.from_way and outgoing_next == approach_prev:
                    continue

                rel_angle = calculate_turn_angle(approach_prev, (vx, vy), outgoing_next)
                desc, no_tag, only_tag = classify_turn(rel_angle)

                dx = outgoing_next[0] - vx
                dy = outgoing_next[1] - vy
                screen_angle = math.degrees(math.atan2(dy, dx))

                existing = self.store.get_restriction(self.from_way, ref)
                if existing:
                    r_type = existing.get("properties", {}).get("restriction", "")
                    status = "only" if r_type.startswith("only_") else "prohibited"
                    curr_tag = r_type
                else:
                    status = "allowed"
                    curr_tag = None

                self.branches.append({
                    "ref": ref,
                    "name": r_info.get("name") or ref,
                    "highway": r_info.get("highway", "residential"),
                    "rel_angle": rel_angle,
                    "desc": desc,
                    "no_tag": no_tag,
                    "only_tag": only_tag,
                    "angle_screen": screen_angle,
                    "status": status,
                    "curr_tag": curr_tag,
                })

        if self.turn_arrows_item:
            self.turn_arrows_item.set_data(self.via_point, self.branches)
        if self.canvas:
            self.canvas.refresh()

    def handle_arrow_button_click(self, screen_pos):
        """Hit tests click against on-canvas turn arrow buttons."""
        if not self.branches or not self.turn_arrows_item:
            return False

        for b in self.branches:
            center = b.get("center_screen")
            if not center:
                continue
            dist2 = (screen_pos.x() - center.x()) ** 2 + (screen_pos.y() - center.y()) ** 2
            if dist2 <= (BUTTON_RADIUS_PX + 4.0) ** 2:
                self.cycle_branch_restriction(b)
                return True
        return False

    def cycle_branch_restriction(self, branch):
        """OSM iD State Machine: Allowed (Green) -> Prohibited (Red) -> Only (Blue) -> Allowed."""
        curr_status = branch["status"]
        to_ref = branch["ref"]

        if curr_status == "allowed":
            new_status = "prohibited"
            new_tag = branch["no_tag"]
            props = {
                "id": self.store.next_id(),
                "type": "restriction",
                "restriction": new_tag,
                "from_way": self.from_way,
                "to_way": to_ref,
                "layer": 0
            }
            if self.txt_except.text().strip():
                props["except"] = self.txt_except.text().strip()
            if self.txt_desc.text().strip():
                props["description"] = self.txt_desc.text().strip()

            self.store.save_feature(props, self.via_point)
            branch["status"] = new_status
            branch["curr_tag"] = new_tag
            self.status.setText(f"Prohibited: {self.from_way} -> {to_ref} [{new_tag}]")

        elif curr_status == "prohibited":
            new_status = "only"
            new_tag = branch["only_tag"]
            props = {
                "id": self.store.next_id(),
                "type": "restriction",
                "restriction": new_tag,
                "from_way": self.from_way,
                "to_way": to_ref,
                "layer": 0
            }
            if self.txt_except.text().strip():
                props["except"] = self.txt_except.text().strip()
            if self.txt_desc.text().strip():
                props["description"] = self.txt_desc.text().strip()

            self.store.save_feature(props, self.via_point)
            branch["status"] = new_status
            branch["curr_tag"] = new_tag
            self.status.setText(f"Only: {self.from_way} -> {to_ref} [{new_tag}]")

        else:
            self.store.delete_by_ways(self.from_way, to_ref)
            branch["status"] = "allowed"
            branch["curr_tag"] = None
            self.status.setText(f"Allowed: {self.from_way} -> {to_ref} (Restriction removed)")

        self.refresh_list()
        self.reload_qgis_layer()
        if self.turn_arrows_item:
            self.turn_arrows_item.update()
        if self.canvas:
            self.canvas.refresh()

    def refresh_list(self):
        self.list_widget.clear()
        for feat in self.store.features():
            p = feat.get("properties", {})
            fid = p.get("id")
            rest = p.get("restriction", "restriction")
            fw = p.get("from_way")
            tw = p.get("to_way")
            tag_prefix = "[Prohibited] " if rest.startswith("no_") else "[Mandatory] "
            lbl = f"{tag_prefix}#{fid:02d} | {rest.upper()} | {fw} -> {tw}"
            if p.get("except"):
                lbl += f" (exc: {p['except']})"
            item = QListWidgetItem(lbl)
            item.setData(Qt.UserRole, fid)
            self.list_widget.addItem(item)

    def delete_selected(self):
        item = self.list_widget.currentItem()
        if not item:
            return
        fid = item.data(Qt.UserRole)
        confirm = QMessageBox.question(
            self, "Delete Turn Restriction",
            f"Are you sure you want to delete restriction #{fid}?",
            QMessageBox.Yes | QMessageBox.No
        )
        if confirm == QMessageBox.Yes:
            self.store.delete_feature(fid)
            self.refresh_list()
            self.reload_qgis_layer()
            if self.via_point:
                self.build_canvas_turn_arrows()
            self.status.setText(f"Deleted restriction #{fid}.")

    def zoom_to_selected(self):
        item = self.list_widget.currentItem()
        if not item or not self.canvas:
            return
        fid = item.data(Qt.UserRole)
        for feat in self.store.features():
            if feat.get("properties", {}).get("id") == fid:
                coords = feat.get("geometry", {}).get("coordinates")
                if coords:
                    from qgis.core import QgsRectangle
                    pt = QgsPointXY(coords[0], coords[1])
                    rect = QgsRectangle(pt.x() - 120, pt.y() - 120, pt.x() + 120, pt.y() + 120)
                    self.canvas.setExtent(rect)
                    self.canvas.refresh()
                break


class LeonidaTurnRestrictions:
    """Standard QGIS plugin entry point."""

    def __init__(self, iface):
        self.iface = iface
        self.canvas = iface.mapCanvas() if iface else None
        self.plugin_dir = os.path.dirname(os.path.abspath(__file__))
        self.store = RestrictionStore(self.plugin_dir)
        self.dock = None
        self.action = None
        self.tool = None

    def initGui(self):
        icon_path = os.path.join(self.plugin_dir, "icon.png")
        icon = QIcon(icon_path) if os.path.exists(icon_path) else QIcon()
        self.action = QAction(icon, "Turn Restrictions", self.iface.mainWindow())
        self.action.setObjectName("actionLeonidaTurnRestrictions")
        self.action.triggered.connect(self.toggle_dock)
        self.iface.addToolBarIcon(self.action)
        self.iface.addPluginToMenu("&Leonida GIS", self.action)

        self.dock = TurnRestrictionDock(self.iface.mainWindow(), self.store, self.canvas)
        self.iface.addDockWidget(Qt.RightDockWidgetArea, self.dock)
        self.dock.hide()

        self.tool = IDTurnRestrictionTool(self.canvas, self.dock)

    def unload(self):
        if self.action:
            self.iface.removePluginMenu("&Leonida GIS", self.action)
            self.iface.removeToolBarIcon(self.action)
        if self.dock:
            self.dock.reset_workflow()
            self.dock.cleanup()
            self.iface.removeDockWidget(self.dock)
            self.dock = None

    def toggle_dock(self):
        if not self.dock:
            return
        if self.dock.isVisible():
            self.dock.reset_workflow()
            self.dock.hide()
            if self.canvas and self.canvas.mapTool() == self.tool:
                self.canvas.unsetMapTool(self.tool)
        else:
            self.dock.show()
            if self.canvas and self.tool:
                self.canvas.setMapTool(self.tool)
