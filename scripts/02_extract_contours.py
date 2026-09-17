#!/usr/bin/env python3
"""
scripts/02_extract_contours.py
Extracts elevation contours, coastline, and mountain peak summits
from the 16-bit DEM heightmap (rasters/heightmap_16bit.png)
in native in-game metric coordinates.
"""

import os
import sys
import json
import numpy as np
from PIL import Image
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy.ndimage import maximum_filter
from shapely.geometry import LineString, Point, mapping
import geopandas as gpd

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from config import DERIVED_DIR, HEIGHTMAP_16BIT_PNG, CRS_WKT

SEA_LEVEL = 28150.0
PEAK = 65358.0
SCALE_M = (PEAK - SEA_LEVEL) / 800.0  # 46.51 raw units per meter

# World file transform parameters
DX = 12.01652939
DY = -12.01652939
X0 = -13318.09624072
Y0 = 11265.41629079


def build_contours():
    print(">>> Extracting elevation contours, peaks, and coastline from 16-bit DEM...")
    if not os.path.exists(HEIGHTMAP_16BIT_PNG):
        print(f"[ERROR] {HEIGHTMAP_16BIT_PNG} not found.")
        return

    im = Image.open(HEIGHTMAP_16BIT_PNG)
    arr = np.array(im, dtype=np.float32)
    ny, nx = arr.shape
    x_coords = X0 + np.arange(nx) * DX
    y_coords = Y0 + np.arange(ny) * DY

    os.makedirs(DERIVED_DIR, exist_ok=True)

    # -------------------------------------------------------------------------
    # 1. Extract Empirical Quantile Contours across 16-bit DEM Land Values
    # -------------------------------------------------------------------------
    land_mask = arr >= SEA_LEVEL
    land_elev_m = (arr[land_mask] - SEA_LEVEL) / SCALE_M

    # Non-fixed intervals evenly distributed among elevation values
    # Dense coverage in lowlands (where 75% of land resides) and tail coverage up to summit
    percentiles = [
        2.5, 5.0, 7.5, 10.0, 14.0, 18.0, 22.0, 26.0, 30.0, 35.0, 40.0, 45.0,
        50.0, 55.0, 60.0, 65.0, 70.0, 75.0, 80.0, 85.0, 90.0, 93.0, 95.0, 97.0,
        98.5, 99.3, 99.8
    ]
    q_elevs_m = [float(v) for v in np.percentile(land_elev_m, percentiles)]
    contour_levels = [SEA_LEVEL + el * SCALE_M for el in q_elevs_m]

    fig, ax = plt.subplots()
    cs = ax.contour(x_coords, y_coords, arr, levels=contour_levels)
    plt.close(fig)

    INDEX_PERCENTILES = {10.0, 26.0, 50.0, 75.0, 90.0, 95.0, 98.5}

    def get_tier(elev: float) -> str:
        if elev < 3.0:
            return "coastal_plain"
        elif elev < 10.0:
            return "lowland"
        elif elev < 25.0:
            return "interior_plain"
        elif elev < 60.0:
            return "rolling_hills"
        elif elev < 150.0:
            return "highland_plateau"
        elif elev < 450.0:
            return "mountain_ridge"
        else:
            return "alpine_summit"

    contour_features = []
    feat_id = 1

    for lvl_idx, (pct, el_m) in enumerate(zip(percentiles, q_elevs_m)):
        segs = cs.allsegs[lvl_idx]
        is_index = pct in INDEX_PERCENTILES
        tier = get_tier(el_m)
        rounded_el = round(el_m, 1)

        for seg in segs:
            if len(seg) >= 3:
                line = LineString([[round(float(pt[0]), 2), round(float(pt[1]), 2)] for pt in seg])
                if line.length >= 60.0:  # Filter noise artifacts < 60m
                    contour_features.append({
                        "type": "Feature",
                        "properties": {
                            "id": feat_id,
                            "elevation_m": rounded_el,
                            "quantile_pct": round(pct, 1),
                            "is_index": is_index,
                            "index": is_index,
                            "tier": tier,
                            "length_m": round(line.length, 1),
                            "source": "16-bit DEM Quantile Contours"
                        },
                        "geometry": mapping(line)
                    })
                    feat_id += 1

    fc = {
        "type": "FeatureCollection",
        "name": "contours",
        "crs": {"type": "name", "properties": {"name": "urn:ogc:def:crs:EPSG::4087"}},
        "features": contour_features
    }

    out_contours_main = os.path.join(DERIVED_DIR, "contours.geojson")
    with open(out_contours_main, "w", encoding="utf-8") as f:
        json.dump(fc, f, indent=2)

    # Build spatially indexed GeoPackage for QGIS rendering
    out_gpkg = os.path.join(DERIVED_DIR, "contours.gpkg")
    if os.path.exists(out_gpkg):
        try:
            os.remove(out_gpkg)
        except Exception:
            pass
    gdf_contours = gpd.GeoDataFrame.from_features(contour_features, crs="EPSG:4087")
    gdf_contours.to_file(out_gpkg, layer="contours", driver="GPKG")

    # Embed QML style into layer_styles table of contours.gpkg
    import sqlite3, datetime
    style_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "styles", "contours.qml")
    if os.path.exists(style_path):
        with open(style_path, "r", encoding="utf-8") as sf:
            style_qml = sf.read()
        conn = sqlite3.connect(out_gpkg)
        cur = conn.cursor()
        cur.execute('''
            CREATE TABLE IF NOT EXISTS layer_styles (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                f_table_catalog TEXT,
                f_table_schema TEXT,
                f_table_name TEXT NOT NULL,
                f_geometry_column TEXT,
                styleName TEXT,
                styleQML TEXT,
                styleSLD TEXT,
                useAsDefault BOOLEAN,
                description TEXT,
                owner TEXT,
                ui TEXT,
                update_time TIMESTAMP DEFAULT (datetime('now'))
            )
        ''')
        cur.execute('DELETE FROM layer_styles WHERE f_table_name=?', ('contours',))
        cur.execute('''
            INSERT INTO layer_styles 
            (f_table_name, f_geometry_column, styleName, styleQML, styleSLD, useAsDefault, description, owner, update_time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', ('contours', 'geom', 'default', style_qml, '', 1, 'Default contours style', 'FA', datetime.datetime.now().isoformat()))
        conn.commit()
        conn.close()

    print(f"  Saved {len(contour_features)} quantile contour line segments (27 levels, 0.5m-650.7m) -> {out_contours_main} & {out_gpkg}")

    # -------------------------------------------------------------------------
    # 2. Extract Mountain Peak Summits & Spot Heights (Local Maxima)
    # -------------------------------------------------------------------------
    elev_arr = np.maximum(0, (arr - SEA_LEVEL) / SCALE_M)
    fp = np.ones((25, 25))
    local_max = (maximum_filter(arr, footprint=fp) == arr) & (elev_arr >= 100.0)
    peak_indices = np.argwhere(local_max)

    counties_path = os.path.join(DERIVED_DIR, "counties_dissolved.geojson")
    gdf_counties = gpd.read_file(counties_path) if os.path.exists(counties_path) else None

    peak_features = []
    sorted_peaks = sorted(
        [(X0 + c * DX, Y0 + r * DY, float(elev_arr[r, c])) for r, c in peak_indices],
        key=lambda x: x[2],
        reverse=True
    )

    for p_id, (gx, gy, el) in enumerate(sorted_peaks, start=1):
        pt = Point(round(gx, 2), round(gy, 2))
        county_name = "Leonida"
        if gdf_counties is not None:
            for _, c_row in gdf_counties.iterrows():
                if c_row["geometry"].contains(pt):
                    county_name = c_row.get("county", "Leonida")
                    break

        if p_id == 1:
            name = "Mount Kalaga Summit"
        elif el >= 500.0:
            name = f"Mount Kalaga Ridge Peak {p_id}"
        elif el >= 300.0:
            name = f"{county_name} Highland Peak {p_id}"
        else:
            name = f"{county_name} Hill Summit {p_id}"

        peak_features.append({
            "type": "Feature",
            "properties": {
                "id": p_id,
                "name": name,
                "elevation_m": round(el, 1),
                "county": county_name,
                "type": "mountain_peak" if el >= 400.0 else "hill_summit",
                "source": "GitHub 16-bit DEM"
            },
            "geometry": mapping(pt)
        })

    out_peaks = os.path.join(DERIVED_DIR, "elevation_peaks.geojson")
    with open(out_peaks, "w", encoding="utf-8") as f:
        json.dump({
            "type": "FeatureCollection",
            "name": "elevation_peaks",
            "crs": {"type": "name", "properties": {"name": "urn:ogc:def:crs:EPSG::4087"}},
            "features": peak_features
        }, f, indent=2)

    with open(os.path.splitext(out_peaks)[0] + ".prj", "w", encoding="utf-8") as f:
        f.write(CRS_WKT)

    print(f"  Saved {len(peak_features)} mountain peak summits -> {out_peaks}")

    # -------------------------------------------------------------------------
    # 3. Extract Coastline at Sea Level (28150.0)
    # -------------------------------------------------------------------------
    fig, ax = plt.subplots()
    cs_coast = ax.contour(x_coords, y_coords, arr, levels=[SEA_LEVEL])
    plt.close(fig)

    coast_features = []
    c_id = 1
    for seg in cs_coast.allsegs[0]:
        if len(seg) >= 3:
            line = LineString([[round(float(pt[0]), 2), round(float(pt[1]), 2)] for pt in seg])
            if line.length >= 80.0:
                coast_features.append({
                    "type": "Feature",
                    "properties": {
                        "id": c_id,
                        "elevation_m": 0.0,
                        "length_m": round(line.length, 1),
                        "source": "GitHub 16-bit DEM"
                    },
                    "geometry": mapping(line)
                })
                c_id += 1

    out_coast = os.path.join(DERIVED_DIR, "coastline.geojson")
    with open(out_coast, "w", encoding="utf-8") as f:
        json.dump({
            "type": "FeatureCollection",
            "name": "coastline",
            "crs": {"type": "name", "properties": {"name": "urn:ogc:def:crs:EPSG::4087"}},
            "features": coast_features
        }, f, indent=2)

    with open(os.path.splitext(out_coast)[0] + ".prj", "w", encoding="utf-8") as f:
        f.write(CRS_WKT)

    print(f"  Saved {len(coast_features)} coastline shoreline segments -> {out_coast}")


if __name__ == "__main__":
    build_contours()
