#!/usr/bin/env python3
"""
Step 03: Build Publication Release Package
==========================================
Packages production-ready deliverables into:
- publication/geojson/ (Master layers and by_county split)
- publication/geopackage/leonida_map.gpkg (Master OGC GeoPackage)
- publication/shapefiles/ (ESRI Shapefiles + .prj + .qml)
- publication/styles/ (QGIS QML Styles)

All spatial vector layers are in native in-game metric coordinates.
"""

import os
import shutil
import glob
import geopandas as gpd
from config import (
    LAYERS_DIR, DERIVED_DIR, DERIVED_BY_COUNTY_DIR,
    PUB_GEOJSON_DIR, PUB_GEOJSON_BY_COUNTY_DIR, PUB_SHAPEFILES_DIR,
    PUB_GEOPACKAGE_DIR, PUB_STYLES_DIR, MASTER_GPKG_PATH, CRS_WKT,
    PROJECT_ROOT, WORK_ROADS_PATH, WORK_RAIL_PATH, WORK_SECTIONS_PATH, WORK_RESTRICTIONS_PATH,
    WORK_WATER_PATH, WORK_LANDMARKS_PATH, WORK_WATERWAYS_PATH, WORK_AREAS_PATH,
    DERIVED_CONTOURS_PATH, DERIVED_COASTLINE_PATH, DERIVED_PEAKS_PATH,
    DERIVED_BUILDINGS_PATH, DERIVED_WATER_PATH, DERIVED_VEGETATION_PATH,
    DERIVED_SAND_PATH, DERIVED_LANDMASS_PATH, DERIVED_COASTAL_SHELF_PATH
)

def build_publication():
    print(">>> [Step 03] Building publication release deliverables...")

    # 1. GeoJSON Master Layers
    master_mappings = {
        "counties.geojson": os.path.join(DERIVED_DIR, "counties_dissolved.geojson"),
        "sections.geojson": WORK_SECTIONS_PATH,
        "rail.geojson": WORK_RAIL_PATH,
        "roads.geojson": WORK_ROADS_PATH,
        "roads_oneway.geojson": os.path.join(DERIVED_DIR, "roads_oneway.geojson"),
        "roads_bidi.geojson": os.path.join(DERIVED_DIR, "roads_bidi.geojson"),
        "landmarks.geojson": WORK_LANDMARKS_PATH,
        "restrictions.geojson": WORK_RESTRICTIONS_PATH,
        "waterways.geojson": WORK_WATERWAYS_PATH,
        "water.geojson": WORK_WATER_PATH,
        "areas.geojson": WORK_AREAS_PATH,
        "elevation_peaks.geojson": DERIVED_PEAKS_PATH,
        "contours.geojson": DERIVED_CONTOURS_PATH,
        "coastline.geojson": DERIVED_COASTLINE_PATH,
        "buildings.geojson": DERIVED_BUILDINGS_PATH,
        "water_bodies.geojson": DERIVED_WATER_PATH,
        "vegetation.geojson": DERIVED_VEGETATION_PATH,
        "sand_beaches.geojson": DERIVED_SAND_PATH,
        "coastal_shelf.geojson": DERIVED_COASTAL_SHELF_PATH,
    }

    for name, src in master_mappings.items():
        dst = os.path.join(PUB_GEOJSON_DIR, name)
        shutil.copyfile(src, dst)
        print(f"  Published GeoJSON: publication/geojson/{name}")

    # 2. County splits
    # Roads by county (copied from auto-derived splits)
    for rf in glob.glob(os.path.join(DERIVED_BY_COUNTY_DIR, "roads_*.geojson")):
        shutil.copyfile(rf, os.path.join(PUB_GEOJSON_BY_COUNTY_DIR, os.path.basename(rf)))
    # Sections by county
    sec_gdf = gpd.read_file(WORK_SECTIONS_PATH)
    county_slugs = {
        "Vice-Dale County": "sections_vice_dale.geojson",
        "Kelly County": "sections_kelly.geojson",
        "Leonard County": "sections_leonard.geojson",
        "Lummox County": "sections_lummox.geojson",
        "Mariana County": "sections_mariana.geojson"
    }
    for c_name, out_name in county_slugs.items():
        subset = sec_gdf[sec_gdf["county"] == c_name]
        if not subset.empty:
            subset.to_file(os.path.join(PUB_GEOJSON_BY_COUNTY_DIR, out_name), driver="GeoJSON")

    print(f"  Published county splits in publication/geojson/by_county/")

    # 3. Master GeoPackage
    if os.path.exists(MASTER_GPKG_PATH):
        try:
            os.remove(MASTER_GPKG_PATH)
        except PermissionError:
            print(f"  [WARNING] GeoPackage file is locked by an open process (e.g. QGIS): {MASTER_GPKG_PATH}")

    print(f"  Assembling Master GeoPackage: {MASTER_GPKG_PATH}")
    gpkg_layers = [
        ("counties", "counties.geojson"),
        ("sections", "sections.geojson"),
        ("roads", "roads.geojson"),
        ("roads_oneway", "roads_oneway.geojson"),
        ("roads_bidi", "roads_bidi.geojson"),
        ("rail", "rail.geojson"),
        ("landmarks", "landmarks.geojson"),
        ("restrictions", "restrictions.geojson"),
        ("waterways", "waterways.geojson"),
        ("water", "water.geojson"),
        ("areas", "areas.geojson"),
        ("elevation_peaks", "elevation_peaks.geojson"),
        ("contours", "contours.geojson"),
        ("coastline", "coastline.geojson"),
        ("buildings", "buildings.geojson"),
        ("water_bodies", "water_bodies.geojson"),
        ("vegetation", "vegetation.geojson"),
        ("sand_beaches", "sand_beaches.geojson"),
        ("coastal_shelf", "coastal_shelf.geojson"),
    ]

    for tbl_name, json_name in gpkg_layers:
        json_path = os.path.join(PUB_GEOJSON_DIR, json_name)
        gdf = gpd.read_file(json_path)
        gdf.to_file(MASTER_GPKG_PATH, layer=tbl_name, driver="GPKG")
        print(f"    Added '{tbl_name}' ({len(gdf)} features)")

    # Embed QML styles directly into Master GeoPackage layer_styles table
    import sqlite3, datetime
    conn = sqlite3.connect(MASTER_GPKG_PATH)
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
    for tbl_name, json_name in gpkg_layers:
        if "contour" in tbl_name:
            base_style = "contours"
        elif "roads_" in tbl_name:
            base_style = "roads"
        elif tbl_name == "sand_beaches":
            base_style = "sand"
        else:
            base_style = tbl_name

        qml_path = os.path.join(PROJECT_ROOT, "styles", f"{base_style}.qml")
        if os.path.exists(qml_path):
            with open(qml_path, "r", encoding="utf-8") as qf:
                q_text = qf.read()
            cur.execute('DELETE FROM layer_styles WHERE f_table_name=?', (tbl_name,))
            cur.execute('''
                INSERT INTO layer_styles 
                (f_table_name, f_geometry_column, styleName, styleQML, styleSLD, useAsDefault, description, owner, update_time)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (tbl_name, 'geom', 'default', q_text, '', 1, f'Default {tbl_name} style', 'FA', datetime.datetime.now().isoformat()))
    conn.commit()
    conn.close()
    print("    Embedded default QML styles into GeoPackage layer_styles table")

    # 4. ESRI Shapefiles
    print("  Assembling ESRI Shapefiles...")
    shp_layers = [
        "counties", "sections", "roads", "roads_oneway", "roads_bidi",
        "rail", "landmarks", "restrictions", "waterways", "water", "areas",
        "elevation_peaks", "contours", "coastline",
        "buildings", "water_bodies", "vegetation", "sand_beaches", "coastal_shelf"
    ]
    for lyr_name in shp_layers:
        json_path = os.path.join(PUB_GEOJSON_DIR, f"{lyr_name}.geojson")
        gdf = gpd.read_file(json_path)
        shp_path = os.path.join(PUB_SHAPEFILES_DIR, f"{lyr_name}.shp")
        gdf.to_file(shp_path, driver="ESRI Shapefile")

        # Write matching .prj
        prj_path = os.path.join(PUB_SHAPEFILES_DIR, f"{lyr_name}.prj")
        with open(prj_path, "w", encoding="utf-8") as f:
            f.write(CRS_WKT)

        # Attach sidecar QML style if available
        base_style = lyr_name
        if "roads_" in lyr_name:
            base_style = "roads"
        elif lyr_name == "sand_beaches":
            base_style = "sand"

        qml_src = os.path.join(PROJECT_ROOT, "styles", f"{base_style}.qml")
        if os.path.exists(qml_src):
            with open(qml_src, "r", encoding="utf-8") as qf:
                qml_content = qf.read()
            if lyr_name == "contours":
                qml_content = qml_content.replace('"elevation_m"', '"elevation_"').replace('&quot;elevation_m&quot;', '&quot;elevation_&quot;')
            elif lyr_name == "restrictions":
                qml_content = qml_content.replace('attr="restriction"', 'attr="restrictio"').replace('"restriction"', '"restrictio"').replace('&quot;restriction&quot;', '&quot;restrictio&quot;')
            with open(os.path.join(PUB_SHAPEFILES_DIR, f"{lyr_name}.qml"), "w", encoding="utf-8") as out_qf:
                out_qf.write(qml_content)
            shutil.copyfile(qml_src, os.path.join(PUB_STYLES_DIR, f"{lyr_name}.qml"))

    # Copy master styles into publication/styles/
    for qml in glob.glob(os.path.join(PROJECT_ROOT, "styles", "*.qml")):
        shutil.copyfile(qml, os.path.join(PUB_STYLES_DIR, os.path.basename(qml)))

    print("  Publication deliverables assembled successfully.")

if __name__ == "__main__":
    build_publication()
