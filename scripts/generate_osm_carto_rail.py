#!/usr/bin/env python3
"""
Generate Full-Scale OpenStreetMap-Carto Parametric Railway Style for QGIS (Leonida GIS)
================================================================================
Generates styles/rail.qml using native QGIS 3.x API based directly on the
canonical OpenStreetMap-Carto specification (roads.mss),
at full 1x scale calibrated for Leonida's native metric space.

Key Architectural Features:
1. 3 Flat Parametric Physical Tiers (NO Nested Rule Trees):
   - Tier 1: Bridges (Elevated Viaducts) - Black Casing Ring (Pass 4), Trackbed (Pass 5), Ties (Pass 6)
   - Tier 2: Surface Rail (Ground Level) - Trackbed (Pass 2), Ties / Rails (Pass 3)
   - Tier 3: Tunnels (Subterranean) - Dashed Trackbed (Pass 0), Transparent Fill (Pass 1)

2. Scale-Dependent Zoom Curves & Service Hierarchy:
   - Heavy rail mainline: Crisp 0.40mm solid at macro scale, classic 0.70mm/0.30mm ties at metro scale.
   - Yards & sidings: Subordinate, lighter grey, and hidden at >= 1:35,000 to prevent yard bloat.
   - Light rail & metro transit: Sleek #666666 line, distinct from heavy rail tie pattern.

3. OSM Carto 1:1 Bridge Casings:
   - Bridges draw a solid black ring (@bridge-casing) wider than the trackbed.
   - Tunnel dashed casings with proper scale-adaptive widths.

4. Form field aliases and defaults:
   - Automatic incrementing ID, ref_id (T_0001..), and layer derivation.
"""

import sys
import os
import subprocess

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
OUTPUT_QML = os.path.join(PROJECT_ROOT, "styles", "rail.qml")
RAIL_GEOJSON = os.path.join(PROJECT_ROOT, "layers", "rail.geojson")

# Add Windows DLL directories before importing PyQt5/QGIS
if hasattr(os, "add_dll_directory"):
    for p in [
        r"C:\Program Files\QGIS 3.44.7\bin",
        r"C:\Program Files\QGIS 3.44.7\apps\qgis\bin",
        r"C:\Program Files\QGIS 3.44.7\apps\Qt5\bin",
        r"C:\PROGRA~1\QGIS34~1.7\bin",
        r"C:\PROGRA~1\QGIS34~1.7\apps\qgis\bin",
        r"C:\PROGRA~1\QGIS34~1.7\apps\Qt5\bin"
    ]:
        if os.path.exists(p):
            try:
                os.add_dll_directory(p)
            except Exception:
                pass

# Ensure QGIS python environment if called via standard python
try:
    import qgis.core
except ModuleNotFoundError:
    runner_bat = os.path.join(os.path.dirname(__file__), "run_qgis_py.bat")
    if os.path.exists(runner_bat):
        print(f">>> Invoking QGIS Python via {runner_bat}...", flush=True)
        res = subprocess.run(f'cmd.exe /c ""{runner_bat}" "{__file__}""', shell=True)
        sys.exit(res.returncode)
    else:
        print("ERROR: QGIS python environment not found. Please run this script in QGIS Python.")
        sys.exit(1)

from qgis.core import (
    QgsApplication, QgsVectorLayer, QgsLineSymbol,
    QgsSimpleLineSymbolLayer, QgsRuleBasedRenderer,
    QgsFeatureRequest, QgsSymbolLayer, QgsProperty, QgsUnitTypes,
    QgsDefaultValue, QgsEditorWidgetSetup
)
from PyQt5.QtGui import QColor
from PyQt5.QtCore import Qt


# =============================================================================
# 1:1 OSM Carto Parametric Railway Expressions
# =============================================================================

RAIL_BED_COLOR_EXPR = """CASE
  WHEN "railway" = 'light_rail' THEN '#666666'
  WHEN coalesce("service", '') IN ('yard', 'siding', 'spur', 'crossover') THEN '#9e9e9e'
  ELSE '#707070'
END"""

RAIL_TUNNEL_BED_COLOR_EXPR = """CASE
  WHEN "railway" = 'light_rail' THEN '#888888'
  WHEN coalesce("service", '') IN ('yard', 'siding', 'spur', 'crossover') THEN '#b0b0b0'
  ELSE '#787878'
END"""

# Scale-adaptive trackbed width (full scale, yard-aware)
RAIL_BED_WIDTH_EXPR = """CASE
  -- 1. Minor Rail (Yards, Sidings, Spurs)
  WHEN coalesce("service", '') IN ('yard', 'siding', 'spur', 'crossover') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.50
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.90
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.15
      ELSE 1.40
    END

  -- 2. Light Rail & Metro Transit
  WHEN "railway" = 'light_rail' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.60
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.90
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.15
      ELSE 1.45
    END

  -- 3. Heavy Rail Mainline & Branch lines
  ELSE
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.60
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.05
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.45
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.75
      ELSE 2.20
    END
END"""

# White dashed crossties width (visible only on heavy rail at >= z12)
RAIL_TIE_WIDTH_EXPR = """CASE
  -- Light rail has no ties (solid transit track)
  WHEN "railway" = 'light_rail' THEN 0.00

  -- Macro scale (>= 35,000): In OSM Carto, ties do not appear at low zoom!
  WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00

  -- Minor Rail (Yards, Sidings)
  WHEN coalesce("service", '') IN ('yard', 'siding', 'spur', 'crossover') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.35
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 0.50
      ELSE 0.60
    END

  -- Heavy Rail Mainline
  ELSE
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.45
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.60
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 0.75
      ELSE 1.00
    END
END"""

# Dynamic tie dash pattern (custom dash 1.8;1.8 mm on screen)
RAIL_TIE_DASH_EXPR = """CASE
  WHEN "railway" = 'light_rail' OR coalesce(@map_scale, 1000) >= 35000 THEN '1;0'
  ELSE '1.8;1.8'
END"""

# Scale-adaptive bridge parapet thickness
RAIL_BRIDGE_CASING_BAND_EXPR = """CASE
  WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.30
  WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.45
  WHEN coalesce(@map_scale, 1000) >= 3000 THEN 0.55
  ELSE 0.70
END"""

# Hierarchical drawing order: Mainline rail on top of yards/sidings
RAIL_ORDER_BY_EXPR = """CASE
  WHEN "railway" = 'rail' AND coalesce("service", '') NOT IN ('yard', 'siding', 'spur', 'crossover') THEN 4
  WHEN "railway" = 'light_rail' THEN 3
  WHEN "railway" = 'rail' THEN 2
  ELSE 1
END"""


def build_parametric_rail_renderer():
    """Builds the 3-Tier Parametric RuleRenderer for Railways without nesting."""
    root = QgsRuleBasedRenderer.Rule(None)

    # -------------------------------------------------------------------------
    # TIER 1: BRIDGES (Pass 4-6) - Elevated Rail Viaducts
    # -------------------------------------------------------------------------
    bridge_sym = QgsLineSymbol()

    # Pass 4: Black Bridge Casing Ring (@bridge-casing: black)
    # OSM Carto 1:1: bridge casing = trackbed + 2 x casing band, black, so a
    # solid black viaduct ring shows around the unchanged trackbed.
    l_b_casing = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.7)
    l_b_casing.setRenderingPass(4)
    l_b_casing.setPenJoinStyle(Qt.RoundJoin)
    l_b_casing.setPenCapStyle(Qt.FlatCap)
    l_b_casing.setDataDefinedProperty(
        QgsSymbolLayer.PropertyStrokeWidth,
        QgsProperty.fromExpression(f'({RAIL_BED_WIDTH_EXPR}) + 2 * ({RAIL_BRIDGE_CASING_BAND_EXPR})')
    )

    # Pass 5: Trackbed (unchanged)
    l_b_bed = QgsSimpleLineSymbolLayer(QColor(112, 112, 112), 0.7)
    l_b_bed.setRenderingPass(5)
    l_b_bed.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(RAIL_BED_COLOR_EXPR))
    l_b_bed.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(RAIL_BED_WIDTH_EXPR))

    # Pass 6: White Crossties
    l_b_ties = QgsSimpleLineSymbolLayer(QColor(255, 255, 255), 0.3)
    l_b_ties.setRenderingPass(6)
    l_b_ties.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(RAIL_TIE_WIDTH_EXPR))
    l_b_ties.setDataDefinedProperty(QgsSymbolLayer.PropertyCustomDash, QgsProperty.fromExpression(RAIL_TIE_DASH_EXPR))

    bridge_sym.changeSymbolLayer(0, l_b_casing)
    bridge_sym.appendSymbolLayer(l_b_bed)
    bridge_sym.appendSymbolLayer(l_b_ties)

    bridge_filter = 'coalesce(to_string("bridge"), \'\') IN (\'yes\', \'1\', \'true\', \'viaduct\')'
    r_bridges = QgsRuleBasedRenderer.Rule(bridge_sym, 0, 0, bridge_filter, "Rail Bridges (Viaducts)")
    root.appendChild(r_bridges)

    # -------------------------------------------------------------------------
    # TIER 2: SURFACE RAILWAYS (Pass 2-3) - Ground Level
    # -------------------------------------------------------------------------
    surface_sym = QgsLineSymbol()

    # Pass 2: Trackbed
    l_s_bed = QgsSimpleLineSymbolLayer(QColor(112, 112, 112), 0.7)
    l_s_bed.setRenderingPass(2)
    l_s_bed.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(RAIL_BED_COLOR_EXPR))
    l_s_bed.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(RAIL_BED_WIDTH_EXPR))

    # Pass 3: White Crossties
    l_s_ties = QgsSimpleLineSymbolLayer(QColor(255, 255, 255), 0.3)
    l_s_ties.setRenderingPass(3)
    l_s_ties.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(RAIL_TIE_WIDTH_EXPR))
    l_s_ties.setDataDefinedProperty(QgsSymbolLayer.PropertyCustomDash, QgsProperty.fromExpression(RAIL_TIE_DASH_EXPR))

    surface_sym.changeSymbolLayer(0, l_s_bed)
    surface_sym.appendSymbolLayer(l_s_ties)

    surface_filter = 'coalesce(to_string("bridge"), \'\') NOT IN (\'yes\', \'1\', \'true\', \'viaduct\') AND coalesce(to_string("tunnel"), \'\') NOT IN (\'yes\', \'1\', \'true\', \'culvert\')'
    r_surface = QgsRuleBasedRenderer.Rule(surface_sym, 0, 0, surface_filter, "Surface Railways (Ground Level)")
    root.appendChild(r_surface)

    # -------------------------------------------------------------------------
    # TIER 3: TUNNELS (Pass 0-1) - Subterranean Tracks
    # -------------------------------------------------------------------------
    tunnel_sym = QgsLineSymbol()

    # Pass 0: Dashed Trackbed
    l_t_bed = QgsSimpleLineSymbolLayer(QColor(120, 120, 120), 0.7)
    l_t_bed.setRenderingPass(0)
    l_t_bed.setCustomDashVector([2.5, 1.5])
    l_t_bed.setUseCustomDashPattern(True)
    l_t_bed.setCustomDashPatternUnit(QgsUnitTypes.RenderMillimeters)
    l_t_bed.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(RAIL_TUNNEL_BED_COLOR_EXPR))
    l_t_bed.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(RAIL_BED_WIDTH_EXPR))

    tunnel_sym.changeSymbolLayer(0, l_t_bed)

    tunnel_filter = 'coalesce(to_string("tunnel"), \'\') IN (\'yes\', \'1\', \'true\', \'culvert\')'
    r_tunnels = QgsRuleBasedRenderer.Rule(tunnel_sym, 0, 0, tunnel_filter, "Rail Tunnels (Subterranean)")
    root.appendChild(r_tunnels)

    renderer = QgsRuleBasedRenderer(root)
    renderer.setUsingSymbolLevels(True)
    clause = QgsFeatureRequest.OrderByClause(RAIL_ORDER_BY_EXPR, True)
    renderer.setOrderBy(QgsFeatureRequest.OrderBy([clause]))
    renderer.setOrderByEnabled(True)

    return renderer


def configure_form_settings(layer):
    """Configures digitizing form aliases, default expressions, and widgets for rail."""
    aliases = [
        ("id", "Rail ID"),
        ("ref_id", "Reference ID"),
        ("railway", "Railway Class"),
        ("service", "Service Category"),
        ("name", "Line Name"),
        ("bridge", "Bridge"),
        ("tunnel", "Tunnel"),
        ("layer", "Layer"),
        ("source", "Source"),
    ]
    for f_name, a_name in aliases:
        idx = layer.fields().indexOf(f_name)
        if idx != -1:
            layer.setFieldAlias(idx, a_name)

    defaults = [
        ("id", 'coalesce(maximum("id") + 1, count(1) + 1)', False),
        ("ref_id", "'T_' || lpad(coalesce(maximum(to_int(replace(\"ref_id\", 'T_', ''))) + 1, count(1) + 1), 4, '0')", False),
        ("layer", 'CASE WHEN "bridge" IN (\'yes\', \'viaduct\') THEN 1 WHEN "tunnel" IN (\'yes\', \'culvert\') THEN -1 ELSE NULL END', True),
    ]
    for f_name, expr, on_upd in defaults:
        idx = layer.fields().indexOf(f_name)
        if idx != -1:
            layer.setDefaultValueDefinition(idx, QgsDefaultValue(expr, on_upd))

    widgets = {
        "railway": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"Heavy Rail": "rail"},
                {"Light Rail Transit": "light_rail"},
                {"Subway / Metro": "subway"},
                {"Monorail": "monorail"},
                {"Tram": "tram"},
            ]
        }),
        "service": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"Mainline": "mainline"},
                {"Branch": "branch"},
                {"Yard": "yard"},
                {"Siding": "siding"},
                {"Spur": "spur"},
                {"Crossover": "crossover"},
            ]
        }),
        "bridge": QgsEditorWidgetSetup("CheckBox", {
            "CheckedState": "yes",
            "UncheckedState": "no",
        }),
        "tunnel": QgsEditorWidgetSetup("CheckBox", {
            "CheckedState": "yes",
            "UncheckedState": "no",
        }),
        "layer": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"-2 (Deep Subterranean)": "-2"},
                {"-1 (Subterranean / Underpass)": "-1"},
                {"0 (Ground Level)": "0"},
                {"1 (Overpass / Bridge)": "1"},
                {"2 (High-Level Flyover)": "2"},
            ]
        }),
        "id": QgsEditorWidgetSetup("Range", {
            "Min": 1,
            "Max": 2147483647,
            "Step": 1,
            "AllowNull": False,
        }),
    }
    for f_name, setup in widgets.items():
        idx = layer.fields().indexOf(f_name)
        if idx != -1:
            layer.setEditorWidgetSetup(idx, setup)


def generate_rail_style():
    print(">>> Generating Full-Scale OSM Carto Parametric Railway Style (styles/rail.qml)...", flush=True)
    QgsApplication.setPrefixPath(r"C:\Program Files\QGIS 3.44.7\apps\qgis", True)
    qgs_app = QgsApplication([], False)
    qgs_app.initQgis()

    def _work():
        layer = QgsVectorLayer(RAIL_GEOJSON, "rail", "ogr")
        if not layer.isValid():
            print(f"ERROR: Could not load {RAIL_GEOJSON}")
            return False

        renderer = build_parametric_rail_renderer()
        layer.setRenderer(renderer)
        configure_form_settings(layer)

        msg, ok = layer.saveNamedStyle(OUTPUT_QML)
        if not ok:
            print(f"ERROR: Failed to save style: {msg}")
            return False

        print(f"  Successfully wrote Full-Scale OSM Carto Parametric style to {OUTPUT_QML}")
        print("  3 Canonical Tiers: Bridges (Viaducts), Surface Railways, Tunnels")
        print("  Full 1x scale, yard/siding subordination, light rail distinct signature")
        print("  Black @bridge-casing rings on bridges, symbol levels enabled")

        # Verify reloading
        retest_layer = QgsVectorLayer(RAIL_GEOJSON, "rail", "ogr")
        load_msg, load_ok = retest_layer.loadNamedStyle(OUTPUT_QML)
        if load_ok:
            print("  Verified: QGIS loaded generated style cleanly with 0 errors.")
        else:
            print(f"  Warning: Reload test returned: {load_msg}")
        return True

    success = _work()
    qgs_app.exitQgis()
    return success


if __name__ == "__main__":
    success = generate_rail_style()
    sys.exit(0 if success else 1)
