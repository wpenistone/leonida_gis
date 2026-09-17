#!/usr/bin/env python3
"""
scripts/extract_figma_terrain.py
Extracts landmass/shelf, water bodies, vegetation, sand/beaches,
and buildings from the Figma community vector map (sources/figma_vector_map.svg).

Coordinate transformation from Figma canvas (21001 x 20000) to In-Game Metric CRS:
    X_geo = x_svg - 17000.0  (meters)
    Y_geo = 11000.0 - y_svg  (meters)
"""

import os
import sys
import json
import time
import shutil
import xml.etree.ElementTree as ET
from shapely.geometry import box, mapping, Polygon, MultiPolygon
from shapely.validation import make_valid

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from config import (
    DERIVED_DIR,
    CRS_WKT,
    FIGMA_SVG_SRC,
    DERIVED_BUILDINGS_PATH,
    DERIVED_WATER_PATH,
    DERIVED_VEGETATION_PATH,
    DERIVED_SAND_PATH,
    DERIVED_COASTAL_SHELF_PATH,
)

CMD_TRANS = str.maketrans({
    'M': ' M ', 'L': ' L ', 'H': ' H ', 'V': ' V ', 'C': ' C ', 'Z': ' Z ',
    'm': ' M ', 'l': ' L ', 'h': ' H ', 'v': ' V ', 'c': ' C ', 'z': ' Z ',
    ',': ' '
})

COASTAL_BATHYMETRY = {"#2a6da7", "#2871ab", "#2676ae", "#247ab1", "#227fb4", "#2083b8"}
INLAND_WATER = {
    "#1b8dbe", "#1991c2", "#159ac8", "#1796c5", "#139fcb", "#11a3cf",
    "#00e1ff", "#0fa8d2", "#1e88bb", "#003f87"
}
VEGETATION_COLORS = {
    "#86ca9e", "#c1db84", "#bed882", "#bad27d", "#bbd480", "#b8d17e",
    "#a8c874", "#9dc468", "#b1cb7a", "#a2c66d"
}
SAND_COLORS = {
    "#eee393", "#e0d6b5", "#fbfcd4", "#f9f6c8", "#f6ecad", "#ebd89b"
}
BUILDING_COLORS = {
    "#c3c3c3", "#d5dad6"
}


def tf(x: float, y: float) -> tuple[float, float]:
    return (round(x - 17000.0, 2), round(11000.0 - y, 2))


def parse_svg_path_to_polygons(d_str: str, bezier_steps: int = 3) -> list[Polygon]:
    tokens = d_str.translate(CMD_TRANS).split()
    rings = []
    current_ring = []
    cur_x, cur_y = 0.0, 0.0
    start_x, start_y = 0.0, 0.0

    i = 0
    n = len(tokens)
    current_cmd = 'M'

    while i < n:
        tok = tokens[i]
        if tok in ('M', 'L', 'H', 'V', 'C', 'Z'):
            current_cmd = tok
            i += 1

        if current_cmd == 'M':
            if i + 1 < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                if len(current_ring) >= 3:
                    rings.append(current_ring)
                try:
                    cur_x, cur_y = float(tokens[i]), float(tokens[i+1])
                    start_x, start_y = cur_x, cur_y
                    current_ring = [(cur_x, cur_y)]
                    i += 2
                except ValueError:
                    pass
                current_cmd = 'L'
            else:
                break
        elif current_cmd == 'L':
            if i + 1 < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                try:
                    cur_x, cur_y = float(tokens[i]), float(tokens[i+1])
                    current_ring.append((cur_x, cur_y))
                    i += 2
                except ValueError:
                    break
            else:
                break
        elif current_cmd == 'H':
            if i < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                try:
                    cur_x = float(tokens[i])
                    current_ring.append((cur_x, cur_y))
                    i += 1
                except ValueError:
                    break
            else:
                break
        elif current_cmd == 'V':
            if i < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                try:
                    cur_y = float(tokens[i])
                    current_ring.append((cur_x, cur_y))
                    i += 1
                except ValueError:
                    break
            else:
                break
        elif current_cmd == 'C':
            if i + 5 < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                try:
                    x1, y1 = float(tokens[i]), float(tokens[i+1])
                    x2, y2 = float(tokens[i+2]), float(tokens[i+3])
                    x3, y3 = float(tokens[i+4]), float(tokens[i+5])
                    p0 = (cur_x, cur_y)
                    for step in range(1, bezier_steps + 1):
                        t = step / bezier_steps
                        u = 1.0 - t
                        bx = u**3 * p0[0] + 3 * u**2 * t * x1 + 3 * u * t**2 * x2 + t**3 * x3
                        by = u**3 * p0[1] + 3 * u**2 * t * y1 + 3 * u * t**2 * y2 + t**3 * y3
                        current_ring.append((bx, by))
                    cur_x, cur_y = x3, y3
                    i += 6
                except ValueError:
                    break
            else:
                break
        elif current_cmd == 'Z':
            if current_ring and current_ring[0] != (cur_x, cur_y):
                current_ring.append(current_ring[0])
            if len(current_ring) >= 3:
                rings.append(current_ring)
            current_ring = []
            cur_x, cur_y = start_x, start_y
        else:
            i += 1

    if len(current_ring) >= 3:
        rings.append(current_ring)

    polygons = []
    for ring in rings:
        geo_pts = [tf(px, py) for px, py in ring]
        if geo_pts[0] != geo_pts[-1]:
            geo_pts.append(geo_pts[0])
        if len(geo_pts) >= 4:
            try:
                poly = Polygon(geo_pts)
                if not poly.is_valid:
                    poly = make_valid(poly)
                if isinstance(poly, Polygon) and not poly.is_empty and poly.area > 0:
                    polygons.append(poly)
                elif isinstance(poly, MultiPolygon):
                    for sub in poly.geoms:
                        if not sub.is_empty and sub.area > 0:
                            polygons.append(sub)
            except Exception:
                pass
    return polygons


def save_geojson(features: list, out_path: str):
    fc = {
        "type": "FeatureCollection",
        "name": os.path.splitext(os.path.basename(out_path))[0],
        "crs": {
            "type": "name",
            "properties": {"name": "urn:ogc:def:crs:EPSG::4087"}
        },
        "features": features
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(fc, f)
    prj_path = os.path.splitext(out_path)[0] + ".prj"
    with open(prj_path, "w", encoding="utf-8") as f:
        f.write(CRS_WKT)


def extract_figma_layers():
    t0 = time.time()
    print("Extracting terrain and buildings from Figma vector map...")
    print(f"Source file: {FIGMA_SVG_SRC}")

    landmass_polys = []
    water_polys = []
    vegetation_polys = []
    sand_polys = []
    building_polys = []

    for event, elem in ET.iterparse(FIGMA_SVG_SRC, events=("end",)):
        tag = elem.tag.split("}")[-1]
        fill = (elem.get("fill") or "").strip().lower()

        if tag == "rect":
            x = float(elem.get("x", 0))
            y = float(elem.get("y", 0))
            w = float(elem.get("width", 0))
            h = float(elem.get("height", 0))
            if fill in BUILDING_COLORS and 1.0 <= (w * h) <= 50000.0:
                p1 = tf(x, y)
                p2 = tf(x + w, y)
                p3 = tf(x + w, y + h)
                p4 = tf(x, y + h)
                poly = Polygon([p1, p2, p3, p4, p1])
                if poly.is_valid and poly.bounds[2] >= -11500.0:
                    building_polys.append(poly)
        elif tag == "path":
            d = elem.get("d", "")
            if d and len(d) > 20:
                m_cnt = d.count('M')
                if m_cnt <= 100:
                    is_target = (
                        fill in COASTAL_BATHYMETRY or
                        fill in INLAND_WATER or
                        fill in VEGETATION_COLORS or
                        fill in SAND_COLORS or
                        fill in BUILDING_COLORS
                    )
                    if is_target:
                        polys = parse_svg_path_to_polygons(d)
                        if polys:
                            valid = [p for p in polys if p.bounds[2] >= -11500.0]
                            if fill in COASTAL_BATHYMETRY:
                                for p in valid:
                                    if p.area >= 100000.0:
                                        landmass_polys.append((p, fill))
                            elif fill in INLAND_WATER:
                                for p in valid:
                                    if p.area >= 50.0:
                                        water_polys.append((p, fill))
                            elif fill in VEGETATION_COLORS:
                                for p in valid:
                                    if p.area >= 50.0:
                                        vegetation_polys.append((p, fill))
                            elif fill in SAND_COLORS:
                                for p in valid:
                                    if p.area >= 50.0:
                                        sand_polys.append((p, fill))
                            elif fill in BUILDING_COLORS:
                                for p in valid:
                                    if 1.0 <= p.area <= 50000.0:
                                        building_polys.append(p)
        elem.clear()

    print(f"Extraction completed in {time.time() - t0:.2f}s.")
    print(f"  Landmass/Coast: {len(landmass_polys)}")
    print(f"  Water:          {len(water_polys)}")
    print(f"  Vegetation:     {len(vegetation_polys)}")
    print(f"  Sand/Beaches:   {len(sand_polys)}")
    print(f"  Buildings:      {len(building_polys)}")

    # 1. Coastal Shelf & Landmass
    landmass_features = []
    for idx, (poly, fill) in enumerate(landmass_polys, start=1):
        area_km2 = round(poly.area / 1e6, 4)
        landmass_features.append({
            "type": "Feature",
            "properties": {
                "id": idx,
                "type": "coastal_extent" if area_km2 > 50.0 else "shelf_boundary",
                "fill_color": fill,
                "area_km2": area_km2,
                "source": "Figma Community Map"
            },
            "geometry": mapping(poly)
        })
    save_geojson(landmass_features, DERIVED_COASTAL_SHELF_PATH)

    # 2. Water Bodies
    water_features = []
    for idx, (poly, fill) in enumerate(water_polys, start=1):
        area_km2 = round(poly.area / 1e6, 4)
        water_type = "lake" if area_km2 > 0.5 else "waterway"
        water_features.append({
            "type": "Feature",
            "properties": {
                "id": idx,
                "type": water_type,
                "fill_color": fill,
                "area_km2": area_km2,
                "source": "Figma Community Map"
            },
            "geometry": mapping(poly)
        })
    save_geojson(water_features, DERIVED_WATER_PATH)

    # 3. Vegetation
    veg_features = []
    for idx, (poly, fill) in enumerate(vegetation_polys, start=1):
        area_km2 = round(poly.area / 1e6, 4)
        veg_type = "forest" if area_km2 > 0.2 else "park"
        veg_features.append({
            "type": "Feature",
            "properties": {
                "id": idx,
                "type": veg_type,
                "fill_color": fill,
                "area_km2": area_km2,
                "source": "Figma Community Map"
            },
            "geometry": mapping(poly)
        })
    save_geojson(veg_features, DERIVED_VEGETATION_PATH)

    # 4. Sand & Beaches
    sand_features = []
    for idx, (poly, fill) in enumerate(sand_polys, start=1):
        area_km2 = round(poly.area / 1e6, 4)
        sand_features.append({
            "type": "Feature",
            "properties": {
                "id": idx,
                "type": "beach",
                "fill_color": fill,
                "area_km2": area_km2,
                "source": "Figma Community Map"
            },
            "geometry": mapping(poly)
        })
    save_geojson(sand_features, DERIVED_SAND_PATH)

    # 5. Buildings
    bldg_features = []
    for idx, poly in enumerate(building_polys, start=1):
        area_m2 = round(poly.area, 1)
        bldg_features.append({
            "type": "Feature",
            "properties": {
                "id": idx,
                "type": "building",
                "area_m2": area_m2,
                "source": "Figma Community Map"
            },
            "geometry": mapping(poly)
        })
    save_geojson(bldg_features, DERIVED_BUILDINGS_PATH)

    print("\nSaved landcover GeoJSON files:")
    for path in (DERIVED_COASTAL_SHELF_PATH, DERIVED_WATER_PATH, 
                 DERIVED_VEGETATION_PATH, DERIVED_SAND_PATH, 
                 DERIVED_BUILDINGS_PATH):
        mb = os.path.getsize(path) / (1024 * 1024)
        print(f"  {os.path.basename(path):<30}: {mb:.2f} MB")


if __name__ == "__main__":
    extract_figma_layers()
