#!/usr/bin/env python3
"""
Render Verification Renders for OSM Carto Road Styling & Leonida GIS
====================================================================
Generates multi-scale QA renders to verify:
1. 3-tier parametric road rendering (bridges, surface roads, tunnels).
2. 1:1 OSM Carto colors, casings, widths, and symbol levels.
3. Scale-adaptive 1:1 SVG oneway chevrons.
4. Clean, seamless junction merging.
Views are specified as (name, width_px, height_px, extent) or via extent_for_scale()
so that a render lands on an exact scale denominator (e.g. 1:931) for close-zoom
digitizing QA.
"""

import os
import sys
import subprocess

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
    QgsApplication, QgsProject, QgsMapSettings,
    QgsMapRendererParallelJob, QgsRectangle,
    QgsExpressionContext, QgsExpressionContextUtils,
    QgsCoordinateReferenceSystem
)
from PyQt5.QtCore import QSize
from PyQt5.QtGui import QColor


def extent_for_scale(scale, width_px, height_px, center_pt, out_dpi=96):
    """Return the map extent (meters) whose render at the given pixel size and DPI
    lands on exactly 1:`scale`.

    map units per pixel = scale * 25.4 / (dpi * 1000)
    """
    mupp = scale * 25.4 / (out_dpi * 1000.0)
    half_w = width_px * mupp / 2.0
    half_h = height_px * mupp / 2.0
    return QgsRectangle(center_pt.x() - half_w, center_pt.y() - half_h,
                        center_pt.x() + half_w, center_pt.y() + half_h)


def run_verification():
    print(">>> Initializing QGIS for verification rendering...")
    QgsApplication.setPrefixPath(r"C:\Program Files\QGIS 3.44.7\apps\qgis", True)
    qgs_app = QgsApplication([], False)
    qgs_app.initQgis()

    os.makedirs("scratch/renders", exist_ok=True)

    def _render_all():
        project = QgsProject.instance()
        project.read("leonida_map_project.qgs")

        roads_layers = project.mapLayersByName("Road Network")
        if not roads_layers:
            print("ERROR: Road Network layer not found in project!")
            return False
        roads_layer = roads_layers[0]
        print(f"  Road Network loaded: {roads_layer.featureCount()} features")

        # Find a oneway freeway ramp / loop feature (e.g. R_0175 or similar)
        sample_oneway = None
        for f in roads_layer.getFeatures():
            if f["ref_id"] == "R_0175":
                sample_oneway = f
                break
            if sample_oneway is None and str(f["oneway"]) in ["yes", "1", "-1"]:
                sample_oneway = f

        pt = sample_oneway.geometry().interpolate(sample_oneway.geometry().length() / 2.0).asPoint()
        print(f"  Focus oneway feature: {sample_oneway['ref_id']} ({sample_oneway['highway']}) at ({pt.x():.1f}, {pt.y():.1f})")

        visible_names = [
            "Road Network",
            "Rail Network",
            "County Boundaries",
            "Buildings",
            "Water Bodies & Canals",
            "Hillshade Relief",
            "GTA 6 Satellite Map"
        ]
        render_layers = [l for name in visible_names for l in project.mapLayersByName(name)]

        views = [
            ("state_overview", 1200, 900, project.viewSettings().defaultViewExtent()),
            ("metro_vice_city", 1200, 1000, QgsRectangle(pt.x() - 3500, pt.y() - 3000, pt.x() + 3500, pt.y() + 3000)),
            ("interchange_oneway_detail", 1200, 800, QgsRectangle(pt.x() - 400, pt.y() - 250, pt.x() + 400, pt.y() + 250)),
            ("bridge_overpass_detail", 1000, 800, QgsRectangle(-3160, 140, -2990, 276)),
            ("rail_transit_detail", 1000, 800, QgsRectangle(-1130, -530, -530, -30)),
            # Close-zoom digitizing QA: exact mapping scales used for editing.
            ("scale_1863_mapping", 1200, 800, extent_for_scale(1863, 1200, 800, pt)),
            ("scale_931_mapping", 1200, 800, extent_for_scale(931, 1200, 800, pt))
        ]

        for v_name, w, h, ext in views:
            ms = QgsMapSettings()
            ms.setDestinationCrs(QgsCoordinateReferenceSystem("EPSG:4087"))
            ms.setOutputDpi(96)
            ms.setLayers(render_layers)
            ms.setOutputSize(QSize(w, h))
            ms.setExtent(ext)
            ms.setBackgroundColor(project.backgroundColor())

            ctx = QgsExpressionContext()
            ctx.appendScope(QgsExpressionContextUtils.projectScope(project))
            ctx.appendScope(QgsExpressionContextUtils.mapSettingsScope(ms))
            ms.setExpressionContext(ctx)

            job = QgsMapRendererParallelJob(ms)
            job.start()
            job.waitForFinished()

            out_file = f"scratch/renders/{v_name}.png"
            job.renderedImage().save(out_file)
            print(f"  [OK] Rendered {v_name} (scale 1:{int(ms.scale())}) -> {out_file}")

        return True

    ok = _render_all()
    qgs_app.exitQgis()
    return ok


if __name__ == "__main__":
    success = run_verification()
    sys.exit(0 if success else 1)
