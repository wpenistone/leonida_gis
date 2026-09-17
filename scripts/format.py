#!/usr/bin/env python3
"""
Format and Lint Work Layers
===========================
Formatting tool for layers.
- Formats 1 feature per line in GeoJSON
- Strips derived attributes (length, county, bearing) from work layers
- Rounds coordinates to 2 decimal places (1 cm precision)
- Normalizes and sorts dictionary keys deterministically
- Sorts features by stable ID
- Reduces Git merge conflicts across concurrent edits

Usage:
    python scripts/format.py
"""

import os
import json
import re
from shapely.geometry import shape

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
LAYERS_DIR = os.path.join(PROJECT_ROOT, "layers")

DERIVED_KEYS_TO_STRIP = {
    "county", "county_slug", "length_m", "bearing", "cardinal", "vert_cnt", "gta_flags"
}

def round_coords(coords, precision=2):
    if isinstance(coords, (float, int)):
        return round(float(coords), precision)
    elif isinstance(coords, (list, tuple)):
        return [round_coords(c, precision) for c in coords]
    return coords

def dedup_consecutive_coords(coords, geom_type):
    """Remove consecutive duplicate vertices resulting from coordinate rounding."""
    if not coords:
        return coords

    if geom_type == "LineString":
        if len(coords) < 2:
            return coords
        deduped = [coords[0]]
        for pt in coords[1:]:
            if pt != deduped[-1]:
                deduped.append(pt)
        return deduped if len(deduped) >= 2 else coords

    elif geom_type == "MultiLineString":
        return [dedup_consecutive_coords(line, "LineString") for line in coords]

    elif geom_type == "Polygon":
        rings = []
        for ring in coords:
            if not ring or len(ring) < 4:
                rings.append(ring)
                continue
            deduped = [ring[0]]
            for pt in ring[1:]:
                if pt != deduped[-1]:
                    deduped.append(pt)
            if len(deduped) >= 3:
                if deduped[-1] != deduped[0]:
                    deduped.append(deduped[0])
                rings.append(deduped if len(deduped) >= 4 else ring)
            else:
                rings.append(ring)
        return rings

    elif geom_type == "MultiPolygon":
        return [dedup_consecutive_coords(poly, "Polygon") for poly in coords]

    return coords

def sort_dict_keys(obj):
    """Recursively sort dictionary keys for deterministic serialization."""
    if isinstance(obj, dict):
        return {k: sort_dict_keys(v) for k, v in sorted(obj.items())}
    elif isinstance(obj, list):
        return [sort_dict_keys(elem) for elem in obj]
    return obj

def extract_sort_key(feat):
    """Extract a stable sort key (preserves existing IDs; sorts new features deterministically by spatial centroid)."""
    fid = feat.get("id") or feat.get("properties", {}).get("id") or feat.get("properties", {}).get("ref_id", "")
    if isinstance(fid, int) and fid > 0:
        return (0, fid, 0.0, 0.0)
    s = str(fid)
    nums = re.findall(r'\d+', s)
    if nums and int(nums[0]) > 0:
        return (0, int(nums[0]), 0.0, 0.0)
    
    # New feature without pre-assigned ID: sort deterministically by spatial centroid
    geom = feat.get("geometry")
    if geom:
        try:
            sh = shape(geom)
            c = sh.centroid
            return (1, 0, round(float(c.x), -1), round(float(c.y), -1))
        except Exception:
            pass
    return (2, 0, 0.0, 0.0)

def _nan_to_none(constant):
    """Normalize non-standard JSON constants (NaN/Infinity) to None on load."""
    return None

def format_geojson_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        data = json.load(f, parse_constant=_nan_to_none)

    if data.get("type") != "FeatureCollection":
        return

    file_slug = os.path.splitext(os.path.basename(filepath))[0].lower()
    fc_name = data.get("name", file_slug)
    features = data.get("features", [])
    
    # Sort features deterministically by stable ID
    features.sort(key=extract_sort_key)

    is_admin_layer = "section" in file_slug or "admin" in file_slug

    formatted_features = []
    for idx, feat in enumerate(features, start=1):
        geom = feat.get("geometry")
        props = dict(feat.get("properties", {}))
        
        # Round coordinates and deduplicate consecutive identical vertices
        if geom and "coordinates" in geom:
            rounded = round_coords(geom["coordinates"], precision=2)
            geom["coordinates"] = dedup_consecutive_coords(rounded, geom.get("type"))

        # Strip derived attributes from non-administrative work layers
        if not is_admin_layer:
            for k in DERIVED_KEYS_TO_STRIP:
                props.pop(k, None)

        # Standard ref_id (prefix enforced per layer: roads R_, rail T_, areas A_)
        ref_prefix = None
        if "road" in file_slug or "road" in fc_name.lower():
            ref_prefix = "R"
        elif "rail" in file_slug or "rail" in fc_name.lower():
            ref_prefix = "T"
        elif "area" in file_slug or "area" in fc_name.lower():
            ref_prefix = "A"

        if "id" not in props:
            props["id"] = idx

        if ref_prefix:
            existing_ref = props.get("ref_id")
            num_match = re.search(r"(\d+)", str(existing_ref)) if existing_ref else None
            if num_match:
                props["ref_id"] = f"{ref_prefix}_{int(num_match.group(1)):04d}"
            else:
                props["ref_id"] = f"{ref_prefix}_{idx:04d}"

        # Deterministically sort keys
        feat_id = feat.get("id") or props.get("ref_id") or props.get("id")
        sorted_feat = {
            "type": feat.get("type", "Feature"),
            "id": feat_id,
            "properties": sort_dict_keys(props),
            "geometry": sort_dict_keys(geom)
        }
        if sorted_feat["id"] is None:
            del sorted_feat["id"]
            
        formatted_features.append(sorted_feat)

    # Write with FeatureCollection envelope and exactly ONE LINE PER FEATURE
    lines = [
        '{\n',
        '  "type": "FeatureCollection",\n',
        f'  "name": "{fc_name}",\n',
        '  "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },\n',
        '  "features": [\n'
    ]

    feature_strings = []
    for f in formatted_features:
        f_line = json.dumps(f, separators=(',', ': '), ensure_ascii=False, allow_nan=False)
        feature_strings.append(f"    {f_line}")

    lines.append(',\n'.join(feature_strings))
    lines.append('\n  ]\n}\n')

    with open(filepath, "w", encoding="utf-8") as f:
        f.writelines(lines)

def main():
    print(">>> Formatting work layers...")
    count = 0
    for root, _, files in os.walk(LAYERS_DIR):
        for file in sorted(files):
            if file.endswith(".geojson"):
                path = os.path.join(root, file)
                format_geojson_file(path)
                relpath = os.path.relpath(path, LAYERS_DIR)
                print(f"  Formatted layers/{relpath}")
                count += 1
    print(f"Formatted and verified {count} GeoJSON work files.")

if __name__ == "__main__":
    main()
