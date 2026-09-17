#!/usr/bin/env python3
"""
scripts/extract_rail_network.py
Extracts heavy rail and light rail transit networks directly from the
Figma community vector map (sources/figma_vector_map.svg).

Coordinate transformation to in-game metric space:
    X_geo = x_svg - 17000.0  (meters)
    Y_geo = 11000.0 - y_svg  (meters)
"""

import os
import sys
import json
import xml.etree.ElementTree as ET
from shapely.geometry import LineString, mapping
import geopandas as gpd

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from config import FIGMA_SVG_SRC, WORK_RAIL_PATH, CRS_WKT, DERIVED_DIR

CMD_TRANS = str.maketrans({
    'M': ' M ', 'L': ' L ', 'H': ' H ', 'V': ' V ', 'C': ' C ', 'Z': ' Z ',
    'm': ' M ', 'l': ' L ', 'h': ' H ', 'v': ' V ', 'c': ' C ', 'z': ' Z ',
    ',': ' '
})

# County slug map (kept in sync with scripts/format.py)
COUNTY_SLUG_MAP = {
    "Vice-Dale County": "vice_dale",
    "Kelly County": "kelly",
    "Leonard County": "leonard",
    "Lummox County": "lummox",
    "Mariana County": "mariana"
}


def parse_rail_svg_path(d_str: str, bezier_steps: int = 4) -> list[list[tuple[float, float]]]:
    tokens = d_str.translate(CMD_TRANS).split()
    lines = []
    current_line = []
    cur_x, cur_y = 0.0, 0.0
    i, n = 0, len(tokens)
    current_cmd = 'M'

    while i < n:
        tok = tokens[i]
        if tok in ('M', 'L', 'H', 'V', 'C', 'Z'):
            current_cmd = tok
            i += 1

        if current_cmd == 'M':
            if i + 1 < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                if len(current_line) >= 2:
                    lines.append(current_line)
                cur_x, cur_y = float(tokens[i]), float(tokens[i+1])
                current_line = [(cur_x - 17000.0, 11000.0 - cur_y)]
                i += 2
                current_cmd = 'L'
            else:
                break
        elif current_cmd == 'L':
            if i + 1 < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                cur_x, cur_y = float(tokens[i]), float(tokens[i+1])
                current_line.append((cur_x - 17000.0, 11000.0 - cur_y))
                i += 2
            else:
                break
        elif current_cmd == 'H':
            if i < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                cur_x = float(tokens[i])
                current_line.append((cur_x - 17000.0, 11000.0 - cur_y))
                i += 1
            else:
                break
        elif current_cmd == 'V':
            if i < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                cur_y = float(tokens[i])
                current_line.append((cur_x - 17000.0, 11000.0 - cur_y))
                i += 1
            else:
                break
        elif current_cmd == 'C':
            if i + 5 < n and tokens[i] not in ('M', 'L', 'H', 'V', 'C', 'Z'):
                x1, y1 = float(tokens[i]), float(tokens[i+1])
                x2, y2 = float(tokens[i+2]), float(tokens[i+3])
                x3, y3 = float(tokens[i+4]), float(tokens[i+5])
                p0 = (cur_x, cur_y)
                p1 = (x1, y1)
                p2 = (x2, y2)
                p3 = (x3, y3)
                for step in range(1, bezier_steps + 1):
                    t = step / bezier_steps
                    omt = 1.0 - t
                    bx = omt**3 * p0[0] + 3*omt**2 * t * p1[0] + 3*omt * t**2 * p2[0] + t**3 * p3[0]
                    by = omt**3 * p0[1] + 3*omt**2 * t * p1[1] + 3*omt * t**2 * p2[1] + t**3 * p3[1]
                    current_line.append((bx - 17000.0, 11000.0 - by))
                cur_x, cur_y = x3, y3
                i += 6
            else:
                break
        elif current_cmd == 'Z':
            if len(current_line) >= 2:
                lines.append(current_line)
            current_line = []
        else:
            i += 1

    if len(current_line) >= 2:
        lines.append(current_line)

    return lines


def extract_rail_network():
    print(">>> Extracting rail and light rail networks from Figma community vector map...")
    if not os.path.exists(FIGMA_SVG_SRC):
        raise FileNotFoundError(f"Missing source SVG: {FIGMA_SVG_SRC}")

    counties_path = os.path.join(DERIVED_DIR, "counties_dissolved.geojson")
    gdf_counties = gpd.read_file(counties_path) if os.path.exists(counties_path) else None

    heavy_rail_lines = []
    light_rail_lines = []
    for event, elem in ET.iterparse(FIGMA_SVG_SRC, events=("end",)):
        tag = elem.tag.split("}")[-1]
        if tag == "path":
            stroke = elem.get("stroke", "").lower().strip()
            d = elem.get("d", "")
            if stroke == "#93268f":  # Heavy rail
                for l in parse_rail_svg_path(d):
                    if any(pt[0] >= -11500.0 for pt in l):
                        heavy_rail_lines.append(l)
            elif stroke == "#c4342b":  # Light rail / metro
                for l in parse_rail_svg_path(d):
                    if any(pt[0] >= -11500.0 for pt in l):
                        light_rail_lines.append(l)
        elem.clear()

    print(f"  Extracted: {len(heavy_rail_lines)} heavy rail segments, {len(light_rail_lines)} light rail segments")

    features = []
    feat_id = 1

    # Heavy rail features
    for coords in heavy_rail_lines:
        ls = LineString(coords)
        length_m = round(ls.length, 2)
        midpoint = ls.interpolate(0.5, normalized=True)
        county_name = None
        county_slug = None
        if gdf_counties is not None:
            for _, c_row in gdf_counties.iterrows():
                if c_row["geometry"].contains(midpoint):
                    county_name = c_row.get("county")
                    county_slug = COUNTY_SLUG_MAP.get(county_name)
                    break

        if length_m > 3000.0:
            service = "mainline"
        elif length_m > 800.0:
            service = "branch"
        elif length_m > 200.0:
            service = "siding"
        else:
            service = "yard"

        features.append({
            "type": "Feature",
            "properties": {
                "id": feat_id,
                "ref_id": f"T_{feat_id:04d}",
                "railway": "rail",
                "service": service,
                "length_m": length_m,
                "county": county_name,
                "county_slug": county_slug,
                "bridge": "no",
                "tunnel": "no",
                "layer": 0,
                "source": "Figma Community Map"
            },
            "geometry": mapping(ls)
        })
        feat_id += 1

    # Light rail features
    for coords in light_rail_lines:
        ls = LineString(coords)
        length_m = round(ls.length, 2)
        midpoint = ls.interpolate(0.5, normalized=True)
        county_name = "Vice-Dale County"
        county_slug = "vice_dale"
        if gdf_counties is not None:
            for _, c_row in gdf_counties.iterrows():
                if c_row["geometry"].contains(midpoint):
                    county_name = c_row.get("county", "Vice-Dale County")
                    county_slug = c_row.get("county_slug", "vice_dale")
                    break

        features.append({
            "type": "Feature",
            "properties": {
                "id": feat_id,
                "ref_id": f"T_{feat_id:04d}",
                "railway": "light_rail",
                "service": "metro",
                "length_m": length_m,
                "county": county_name,
                "county_slug": county_slug,
                "bridge": "no",
                "tunnel": "no",
                "layer": 0,
                "source": "Figma Community Map"
            },
            "geometry": mapping(ls)
        })
        feat_id += 1

    fc = {
        "type": "FeatureCollection",
        "name": "rail",
        "crs": {
            "type": "name",
            "properties": {"name": "urn:ogc:def:crs:EPSG::4087"}
        },
        "features": features
    }

    out_rail = os.path.join(DERIVED_DIR, "rail_extracted.geojson")
    if "--overwrite-work" in sys.argv:
        out_rail = WORK_RAIL_PATH

    with open(out_rail, "w", encoding="utf-8") as f:
        json.dump(fc, f, indent=2)

    prj_path = os.path.splitext(out_rail)[0] + ".prj"
    with open(prj_path, "w", encoding="utf-8") as f:
        f.write(CRS_WKT)

    # Also save separate subsets in derived/
    lr_features = [f for f in features if f["properties"]["railway"] == "light_rail"]
    hr_features = [f for f in features if f["properties"]["railway"] == "rail"]

    lr_path = os.path.join(DERIVED_DIR, "light_rail.geojson")
    with open(lr_path, "w", encoding="utf-8") as f:
        json.dump({"type": "FeatureCollection", "name": "light_rail", "features": lr_features}, f, indent=2)
    with open(os.path.splitext(lr_path)[0] + ".prj", "w", encoding="utf-8") as f:
        f.write(CRS_WKT)

    total_km = sum(f["properties"]["length_m"] for f in features) / 1000.0
    print(f"  Extracted {len(features)} total rail segments ({total_km:.2f} km) -> {WORK_RAIL_PATH}")
    print(f"            Heavy rail: {len(hr_features)} segments | Light rail: {len(lr_features)} segments")


if __name__ == "__main__":
    extract_rail_network()
