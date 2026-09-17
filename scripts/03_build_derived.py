#!/usr/bin/env python3
"""
Step 02: Build Derived Layers from Work Files
=============================================
Consumes hand-edited layers from layers/:
- layers/roads.geojson
- layers/sections.geojson

Generates derived intermediates in derived/:
- derived/counties_dissolved.geojson
- derived/roads_oneway.geojson & derived/roads_bidi.geojson
- derived/by_county/roads_{county_slug}.geojson (dynamically split by spatial intersection)
"""

import os
import json
from shapely.geometry import shape, Point, mapping
from shapely.ops import unary_union
from config import (
    DERIVED_DIR, DERIVED_BY_COUNTY_DIR,
    WORK_ROADS_PATH, WORK_SECTIONS_PATH, WORK_WATER_PATH,
    COUNTIES
)

COUNTY_SLUG_MAP = {
    "Vice-Dale County": "vice_dale",
    "Kelly County": "kelly",
    "Leonard County": "leonard",
    "Lummox County": "lummox",
    "Mariana County": "mariana"
}

def build_derived():
    print(">>> [Step 02] Building derived datasets from work files...")
    os.makedirs(DERIVED_DIR, exist_ok=True)
    os.makedirs(DERIVED_BY_COUNTY_DIR, exist_ok=True)

    # 1. Process Sections and Dissolve Counties
    with open(WORK_SECTIONS_PATH, "r", encoding="utf-8") as f:
        sec_data = json.load(f)

    county_polys = {}
    for feat in sec_data.get("features", []):
        p = feat.get("properties", {})
        c_name = p.get("county")
        if not c_name:
            continue
        poly = shape(feat["geometry"])
        if not poly.is_valid:
            poly = poly.buffer(0)
        if c_name not in county_polys:
            county_polys[c_name] = []
        county_polys[c_name].append(poly)

    # County Dissolve
    county_features = []
    dissolved_county_shapes = {}
    for c_id, (c_name, polys) in enumerate(county_polys.items(), start=1):
        u_poly = unary_union(polys)
        dissolved_county_shapes[c_name] = u_poly
        county_features.append({
            "type": "Feature",
            "properties": {
                "id": c_id,
                "county": c_name,
                "state": "Leonida",
                "layer": 0,
                "sections_cnt": len(polys),
                "area_sqkm": round(u_poly.area / 1e6, 2),
                "area_sqm": round(u_poly.area, 2),
                "centroid_x": round(u_poly.centroid.x, 2),
                "centroid_y": round(u_poly.centroid.y, 2)
            },
            "geometry": mapping(u_poly)
        })

    with open(os.path.join(DERIVED_DIR, "counties_dissolved.geojson"), "w", encoding="utf-8") as f:
        json.dump({
            "type": "FeatureCollection",
            "name": "counties_dissolved",
            "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },
            "features": county_features
        }, f, indent=2)
    print(f"  Dissolved {len(county_features)} county administrative boundaries")

    # 2. Read roads from layers/roads.geojson
    with open(WORK_ROADS_PATH, "r", encoding="utf-8") as f:
        roads_data = json.load(f)
    canonical_roads = roads_data.get("features", [])

    # Helper function to find county for road via spatial intersection
    def find_county_slug_for_geom(sh_geom):
        best_c = None
        max_overlap = -1.0
        for c_name, c_poly in dissolved_county_shapes.items():
            if c_poly.intersects(sh_geom):
                inter = c_poly.intersection(sh_geom)
                length = inter.length if hasattr(inter, "length") else 0.0
                if length > max_overlap:
                    max_overlap = length
                    best_c = c_name
        if not best_c and dissolved_county_shapes:
            nearest = min(dissolved_county_shapes.items(), key=lambda cp: cp[1].distance(sh_geom))
            best_c = nearest[0]
        return COUNTY_SLUG_MAP.get(best_c, "vice_dale")

    # Dynamic spatial split into derived/by_county/
    by_county = {}
    for feat in canonical_roads:
        geom = feat.get("geometry")
        sh_geom = shape(geom) if geom else None
        c_slug = feat["properties"].get("county_slug")
        if not c_slug and sh_geom:
            c_slug = find_county_slug_for_geom(sh_geom)
        if not c_slug:
            c_slug = "vice_dale"

        if c_slug not in by_county:
            by_county[c_slug] = []
        by_county[c_slug].append(feat)

    for c_slug, c_feats in by_county.items():
        c_path = os.path.join(DERIVED_BY_COUNTY_DIR, f"roads_{c_slug}.geojson")
        with open(c_path, "w", encoding="utf-8") as f:
            json.dump({
                "type": "FeatureCollection",
                "name": f"roads_{c_slug}",
                "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },
                "features": c_feats
            }, f, indent=2)
    print(f"  Auto-derived county road subsets across {len(by_county)} counties in derived/by_county/")

    # Subsets: oneway, bidi
    oneway_roads = [f for f in canonical_roads if str(f["properties"].get("oneway", "no")).lower() in ["yes", "1", "true", "-1"]]
    bidi_roads = [f for f in canonical_roads if str(f["properties"].get("oneway", "no")).lower() not in ["yes", "1", "true", "-1"]]

    with open(os.path.join(DERIVED_DIR, "roads_oneway.geojson"), "w", encoding="utf-8") as f:
        json.dump({
            "type": "FeatureCollection",
            "name": "roads_oneway",
            "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },
            "features": oneway_roads
        }, f, indent=2)

    with open(os.path.join(DERIVED_DIR, "roads_bidi.geojson"), "w", encoding="utf-8") as f:
        json.dump({
            "type": "FeatureCollection",
            "name": "roads_bidi",
            "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },
            "features": bidi_roads
        }, f, indent=2)
    print(f"  Generated road subsets: {len(oneway_roads)} one-way, {len(bidi_roads)} bidirectional")

if __name__ == "__main__":
    build_derived()
