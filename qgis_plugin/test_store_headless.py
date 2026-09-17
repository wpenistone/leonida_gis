"""Headless smoke test for RestrictionStore (writes to a temp copy, not the real file)."""
import importlib.util
import json
import os
import sys
import types
import tempfile
import shutil

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLUGIN = os.path.join(REPO, "qgis_plugin", "leonida_turn_restrictions")

# --- Stub the qgis module tree so plugin.py imports headlessly ---
for name in ["qgis", "qgis.PyQt", "qgis.PyQt.QtWidgets", "qgis.PyQt.QtCore",
             "qgis.PyQt.QtGui", "qgis.core", "qgis.utils"]:
    mod = types.ModuleType(name)
    sys.modules[name] = mod
for sub in ["qgis.PyQt.QtWidgets", "qgis.PyQt.QtCore", "qgis.PyQt.QtGui", "qgis.core"]:
    sys.modules[sub].__path__ = []

def _stub(name):
    m = types.ModuleType(name)
    return m

qtwidgets = sys.modules["qgis.PyQt.QtWidgets"]
for cls in ["QAction", "QDockWidget", "QWidget", "QVBoxLayout", "QHBoxLayout",
            "QLabel", "QPushButton", "QComboBox", "QLineEdit", "QListWidget",
            "QListWidgetItem", "QMessageBox", "QGroupBox", "QFormLayout",
            "QTableWidget", "QTableWidgetItem", "QHeaderView", "QAbstractItemView",
            "QCheckBox"]:
    setattr(qtwidgets, cls, type(cls, (), {}))
qtcore = sys.modules["qgis.PyQt.QtCore"]
qtcore.Qt = types.SimpleNamespace(
    LeftDockWidgetArea=1, RightDockWidgetArea=2, UserRole=32, LeftButton=1, DashLine=2, NoPen=0, AlignCenter=132)
qtcore.QPointF = type("QPointF", (), {"__init__": lambda s, x=0, y=0: setattr(s, "x", lambda: x) or setattr(s, "y", lambda: y)})
qtcore.QRectF = type("QRectF", (), {})
qtgui = sys.modules["qgis.PyQt.QtGui"]
for cls in ["QColor", "QIcon", "QPainter", "QPen", "QBrush", "QPolygonF", "QFont"]:
    setattr(qtgui, cls, type(cls, (), {}))
qcore = sys.modules["qgis.core"]
class _QgsPointXY:
    def __init__(self, x=None, y=None):
        self._x, self._y = float(x), float(y)
    def x(self): return self._x
    def y(self): return self._y
qcore.QgsPointXY = _QgsPointXY
qcore.QgsWkbTypes = types.SimpleNamespace(LineGeometry=1, PointGeometry=0)
for cls in ["QgsProject", "QgsRubberBand", "QgsMapToolEmitPoint"]:
    setattr(qcore, cls, type(cls, (), {}))
sys.modules["qgis.utils"] = types.ModuleType("qgis.utils")

# --- Import the plugin module ---
spec = importlib.util.spec_from_file_location(
    "plugin", os.path.join(PLUGIN, "plugin.py"))
plugin = importlib.util.module_from_spec(spec)
spec.loader.exec_module(plugin)

# --- Redirect the store to a temp sandbox ---
tmp = tempfile.mkdtemp()
os.makedirs(os.path.join(tmp, "layers"))
shutil.copyfile(os.path.join(REPO, "layers", "restrictions.geojson"),
                os.path.join(tmp, "layers", "restrictions.geojson"))
shutil.copyfile(os.path.join(REPO, "layers", "roads.geojson"),
                os.path.join(tmp, "layers", "roads.geojson"))

store = plugin.RestrictionStore(os.path.join(tmp, "qgis_plugin", "leonida_turn_restrictions"))
assert store.path == os.path.join(tmp, "layers", "restrictions.geojson")

# 1. next_id
nid = store.next_id()
assert nid == 4, f"expected 4, got {nid}"

# 2. save_feature round-trip (schema: no county or length attributes)
props = {"id": nid, "type": "restriction", "restriction": "no_right_turn",
         "from_way": "R_0005", "to_way": "R_0009",
         "description": "smoke test"}
feat = store.save_feature(props, _QgsPointXY(-269.23456, 1813.34567))
raw = open(store.path, encoding="utf-8").read()
assert "county" not in raw, "county must NOT be saved in restrictions.geojson"
assert "-269.23" in raw  # rounded to 2dp
assert "NaN" not in raw

# 3. round-trip determinism: run project formatter on plugin output and compare bytes
sys.path.insert(0, os.path.join(REPO, "scripts"))
import format as fmt
before = open(store.path, "rb").read()
fmt.format_geojson_file(store.path)
after = open(store.path, "rb").read()
assert before == after, "Plugin output differs from formatter output."

# 4. delete_feature
removed = store.delete_feature(1)
assert removed == 1

# 5. nearest_road / snap_to_way
roads = store.roads()
assert len(roads) == 195, f"expected 195 roads, got {len(roads)}"
ref = sorted(roads)[0]
coords = roads[ref]["coordinates"]
mid = coords[len(coords)//2]
pt = _QgsPointXY(mid[0] + 3.0, mid[1] + 2.0)
hit = plugin.nearest_road(pt, roads, tolerance=25.0)
assert hit is not None and hit[0] == ref
snapped, dist = plugin.snap_to_way(pt, coords, tolerance=50.0)
assert snapped is not None and dist <= 5.0

# 6. Turn angle calculation & classification (OSM iD style)
angle_left = plugin.calculate_turn_angle((0, 0), (10, 0), (10, 10))
desc_left, no_left, only_left = plugin.classify_turn(angle_left)
assert desc_left == "Left Turn" and no_left == "no_left_turn" and only_left == "only_left_turn"

angle_right = plugin.calculate_turn_angle((0, 0), (10, 0), (10, -10))
desc_right, no_right, only_right = plugin.classify_turn(angle_right)
assert desc_right == "Right Turn" and no_right == "no_right_turn" and only_right == "only_right_turn"

angle_straight = plugin.calculate_turn_angle((0, 0), (10, 0), (20, 0))
desc_straight, no_straight, only_straight = plugin.classify_turn(angle_straight)
assert desc_straight == "Straight On" and no_straight == "no_straight_on" and only_straight == "only_straight_on"

angle_uturn = plugin.calculate_turn_angle((0, 0), (10, 0), (0, 0))
desc_uturn, no_uturn, _ = plugin.classify_turn(angle_uturn)
assert desc_uturn == "U-Turn" and no_uturn == "no_u_turn"

# 7. strict JSON validity of plugin output
json.loads(raw, parse_constant=lambda c: (_ for _ in ()).throw(ValueError(c)))

print("All plugin store tests passed.")
