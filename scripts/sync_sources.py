#!/usr/bin/env python3
"""
Sync Upstream Data Sources
==========================
Pulls latest data from external upstream GitHub repositories:
1. GTADB (rolux/gtadb.org) -> landmarks database
2. LeonidaHeightmap (MelonHell/LeonidaHeightmap) -> 16-bit DEM heightmap

Usage:
    python scripts/sync_sources.py            # Sync all sources
    python scripts/sync_sources.py --gtadb    # Sync GTADB landmarks only
    python scripts/sync_sources.py --heightmap # Sync heightmap DEM only
    python scripts/sync_sources.py --gtadb --local  # Re-derive landmarks from cached raw JSON (offline)
"""

import os
import sys
import json
import argparse
import urllib.request
from PIL import Image
import numpy as np
from scipy import ndimage
from config import (
    SOURCES_DIR, LAYERS_DIR, RASTERS_DIR, PROJECT_ROOT,
    HEIGHTMAP_16BIT_PNG, HEIGHTMAP_PREVIEW_PNG
)

GTADB_URL = "https://raw.githubusercontent.com/rolux/gtadb.org/main/map/data/6/landmarks.json"
HEIGHTMAP_URL = "https://raw.githubusercontent.com/MelonHell/LeonidaHeightmap/master/input/original_height.png"

# ---------------------------------------------------------------------------
# GTADB enrichment tables
# ---------------------------------------------------------------------------
# Raw record layout (index -> meaning):
#   0: "game_name?, district, city"   game-side label text
#   1: [x, y]                         in-game metric coordinates
#   2: [px, py]                       source-image pixel coordinates
#   3: real-world address string
#   4: [lat, lon]                     real-world WGS84 coordinates
#   5: [px, py]                       real-world reference image pixels
#   6: [...tags...]                   confidence tiers, status flags, class
#   7: gtadb feature id (hex)
#   8: [...timestamps...]             edit history
#
# Tag -> (osm_type, osm_value), aligned with TAGGING_TAXONOMY.md section 7.
# Only clean, one-to-one mappings get translated; everything else falls back
# to the coarse `category` field so manual refinement stays visible.
GTADB_OSM_MAP = {
    "hotel":             ("tourism", "hotel"),
    "restaurant":        ("amenity", "restaurant"),
    "retail":            ("shop", "convenience"),
    "transportation":    ("public_transport", "station"),
    "industrial":        ("landuse", "industrial"),
    "government":        ("office", "government"),
    "utilities":         ("man_made", "utility"),
    "leisure":           ("leisure", "park"),
    "natural":           ("natural", "wood"),
    "public":            ("amenity", "community_centre"),
    "residential":       ("landuse", "residential"),
    "redisential":       ("landuse", "residential"),
    "landmark":          ("tourism", "attraction"),
    "point-of-interest": ("tourism", "attraction"),
    "events":            ("amenity", "events_venue"),
    "agriculture":       ("landuse", "farmland"),
    "infrastructure":    ("man_made", "infrastructure"),
    "infr":              ("man_made", "infrastructure"),
    "office":            ("office", "company"),
    "service":           ("shop", "services"),
    "safehouse":         ("building", "residential"),
    "construction":      ("building", "construction"),
    "fuel":              ("amenity", "fuel"),
    "hospital":          ("amenity", "hospital"),
    "police":            ("amenity", "police"),
    "fire_station":      ("amenity", "fire_station"),
    "bank":              ("amenity", "bank"),
    "bar":               ("amenity", "bar"),
    "nightclub":         ("amenity", "nightclub"),
    "marina":            ("amenity", "marina"),
    "airport":           ("aeroway", "aerodrome"),
    "golf":              ("leisure", "golf_course"),
    "stadium":           ("leisure", "stadium"),
}
GTADB_CONFIDENCE_TIERS = ("l1", "l2", "l3", "l4", "l5")
GTADB_STATUS_FLAGS = ("demolished", "construction", "reused",
                      "may-not-exist", "todo", "unconfirmed", "uncomfirmed")


def parse_gtadb_name(text):
    """Extract a clean name from the GTADB v[0] field.

    The GTADB v[0] field is free-form and inconsistent:
      "? , Washington Beach, Vice Beach"  (unknown name + district + city)
      "Construction Site, Waning Sands"   (name + district)
      "Atlantic Ocean"                     (bare name)
      "?"                                  (completely unknown)

    We cannot reliably split this into name/district/city, so we return the
    best single name string plus the raw text for reference. District/city are
    left to spatial derivation (sections/counties) downstream.
    """
    text = (text or "").strip()
    if text in ("", "?"):
        return None
    # If it starts with "?," the real content after the comma is descriptive
    if text.startswith("?,"):
        rest = text[2:].strip()
        return rest if rest else None
    return text
def parse_gtadb_location(text):
    """Extract structured location context (neighborhood/district, city) from GTADB v[0].

    Returns (name, neighborhood, location_city, confidence) where:
      - name: the landmark name (None if unknown)
      - neighborhood: most specific location (district/suburb/area)
      - location_city: broader city/region (if present)
      - confidence: "high" (? prefix), "medium" (multi-part), "low" (single/unknown)

    Handles the inconsistent GTADB v[0] formats:
      "? , Washington Beach, Vice Beach"          -> (None, "Washington Beach", "Vice Beach", "high")
      "Construction Site, Waning Sands"           -> ("Construction Site", "Waning Sands", None, "medium")
      "Fleeca Field Metro Station, Rockridge, Vice City" -> (name, "Rockridge", "Vice City", "medium")
      "Atlantic Ocean"                            -> ("Atlantic Ocean", None, None, "low")
      "?"                                          -> (None, None, None, "low")
    """
    text = (text or "").strip()
    if text in ("", "?"):
        return None, None, None, "low"

    parts = [p.strip() for p in text.split(",") if p.strip() and p.strip() != "?"]

    if not parts:
        return None, None, None, "low"

    # High confidence: text starts with "?," so everything after is location context
    if text.startswith("?,"):
        name = None
        neighborhood = parts[0] if len(parts) >= 1 else None
        location_city = parts[1] if len(parts) >= 2 else None
        return name, neighborhood, location_city, "high"

    # Single part: it's a name, no location context to extract
    if len(parts) == 1:
        return parts[0], None, None, "low"

    # Multi-part without "?," prefix: first part is likely the name,
    # remaining parts are location context (district, city)
    # confidence is "medium" because the format isn't guaranteed
    name = parts[0]
    neighborhood = parts[1] if len(parts) >= 2 else None
    location_city = parts[2] if len(parts) >= 3 else None
    return name, neighborhood, location_city, "medium"


def enrich_gtadb_tags(tags):
    """Translate GTADB tag lists into (osm_type, osm_value, status, confidence)."""
    tags = [t.strip().lower() for t in (tags or [])]
    osm = next((GTADB_OSM_MAP[t] for t in tags if t in GTADB_OSM_MAP), None)
    status = next((s for s in GTADB_STATUS_FLAGS if s in tags), None)
    confidence = next((t for t in GTADB_CONFIDENCE_TIERS if t in tags), None)
    return (osm[0] if osm else None, osm[1] if osm else None, status, confidence)

def download_file(url, target_path, desc):
    print(f"  Fetching {desc} from {url}...")
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        content = resp.read()
    with open(target_path, "wb") as f:
        f.write(content)
    print(f"  Saved {target_path} ({len(content) / 1024:.1f} KB)")
    return content

def sync_gtadb(use_local=False, overwrite_work=False):
    print("\n--- Syncing GTADB Landmarks (rolux/gtadb.org) ---")
    raw_path = os.path.join(SOURCES_DIR, "gtadb_landmarks_raw.json")
    if use_local and os.path.exists(raw_path):
        print(f"  Using cached raw dataset: {raw_path}")
        with open(raw_path, "rb") as f:
            content = f.read()
    else:
        content = download_file(GTADB_URL, raw_path, "GTADB landmarks")

    raw_data = json.loads(content.decode("utf-8"))
    print(f"  Parsed {len(raw_data)} total entries from GTADB.")

    features = []
    stats = {"has_real_name": 0, "has_game_name": 0, "fallback_id": 0}
    for k, v in raw_data.items():
        coords = v[1] if len(v) > 1 else None
        if not coords or len(coords) != 2:
            continue

        gx = round(float(coords[0]), 2)
        gy = round(float(coords[1]), 2)

        raw_name = v[0] if len(v) > 0 else None
        game_name, neighborhood, location_city, parse_confidence = parse_gtadb_location(raw_name)
        real_name = v[3] if len(v) > 3 and v[3] else None
        real_coords = v[4] if len(v) > 4 and v[4] else None
        tags = v[6] if len(v) > 6 and v[6] else []
        osm_type, osm_value, status, confidence = enrich_gtadb_tags(tags)

        # Name priority: real-world property name > GTADB game name > stable id.
        # GTADB uses "?" in v[3] to mean "unknown" — treat as absent.
        # Also strips a leading "?" prefix when real content follows
        # (GTADB convention: "?1528 FL-5 #112" is a valid address).
        real_name_clean = real_name.strip() if real_name else None
        if real_name_clean == "?":
            real_name_clean = None
        elif real_name_clean and real_name_clean.startswith("?") and len(real_name_clean) > 1:
            real_name_clean = real_name_clean[1:].lstrip()
        name_assigned = False
        if real_name_clean:
            name = real_name_clean.split(",")[0].strip()
            name_source = "real_name"
            stats["has_real_name"] += 1
            name_assigned = True
        if not name_assigned and game_name:
            name = game_name
            name_source = "gtadb"
            stats["has_game_name"] += 1
            name_assigned = True
        if not name_assigned:
            name = f"Landmark {k}"
            name_source = "fallback"
            stats["fallback_id"] += 1

        # Backwards-compatible coarse category (drives the categorized QML
        # fallback); OSM-type tags win where a clean mapping exists.
        category = "landmark"
        for t in ["hotel", "residential", "restaurant", "retail", "public",
                  "service", "transportation", "construction"]:
            if t in [x.strip().lower() for x in tags]:
                category = t
                break
        if osm_type == "building" and osm_value == "construction":
            category = "construction"

        props = {
            "id": k,
            "name": name,
            "name_source": name_source,
            "category": category,
            "osm_type": osm_type,
            "osm_value": osm_value,
            "status": status,
            "confidence": confidence,
            "neighborhood": neighborhood,
            "location_city": location_city,
            "parse_confidence": parse_confidence,
            "real_name": real_name,
            "real_lat": real_coords[0] if real_coords else None,
            "real_lon": real_coords[1] if real_coords else None,
            "tags": ", ".join(tags) if tags else None,
            "address_raw": raw_name,
            "layer": 0,
            "source": "gtadb.org"
        }

        features.append({
            "type": "Feature",
            "id": k,
            "properties": props,
            "geometry": {
                "type": "Point",
                "coordinates": [gx, gy]
            }
        })

    stats["has_neighborhood"] = sum(1 for ft in features if ft["properties"].get("neighborhood"))
    print(f"  Name sources: real_name={stats['has_real_name']}, "
          f"gtadb={stats['has_game_name']}, fallback={stats['fallback_id']}")
    print(f"  Location context: neighborhood={stats['has_neighborhood']}")

    # Sort deterministically
    def sort_key(feat):
        sid = feat["id"].lstrip("L")
        return int(sid) if sid.isdigit() else 99999

    import shutil
    from config import DERIVED_DIR

    if overwrite_work:
        out_geojson = os.path.join(LAYERS_DIR, "landmarks.geojson")
        if os.path.exists(out_geojson):
            shutil.copyfile(out_geojson, out_geojson + "~")
    else:
        os.makedirs(DERIVED_DIR, exist_ok=True)
        out_geojson = os.path.join(DERIVED_DIR, "landmarks_synced.geojson")

    fc = {
        "type": "FeatureCollection",
        "name": "landmarks",
        "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },
        "features": features
    }

    # Write 1 feature per line
    lines = [
        '{\n',
        '  "type": "FeatureCollection",\n',
        '  "name": "landmarks",\n',
        '  "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:EPSG::4087" } },\n',
        '  "features": [\n'
    ]
    f_strs = [f"    {json.dumps(f, separators=(',', ': '), ensure_ascii=False)}" for f in features]
    lines.append(',\n'.join(f_strs))
    lines.append('\n  ]\n}\n')

    with open(out_geojson, "w", encoding="utf-8") as f:
        f.writelines(lines)
    if overwrite_work:
        print(f"  Updated {out_geojson} ({len(features)} georeferenced landmarks, backup saved to landmarks.geojson~).")
    else:
        print(f"  Saved to {out_geojson} ({len(features)} georeferenced landmarks). Pass --overwrite-work to update layers/landmarks.geojson directly.")

def sync_heightmap():
    print("\n--- Syncing Heightmap (MelonHell/LeonidaHeightmap) ---")
    raw_path = os.path.join(SOURCES_DIR, "original_height.png")
    download_file(HEIGHTMAP_URL, raw_path, "16-bit DEM heightmap")

    # Copy to rasters/
    import shutil
    shutil.copyfile(raw_path, HEIGHTMAP_16BIT_PNG)
    print(f"  Updated {HEIGHTMAP_16BIT_PNG}")

    # Re-generate hillshaded preview
    print("  Generating hillshaded terrain and bathymetry preview...")
    h_arr = np.array(Image.open(HEIGHTMAP_16BIT_PNG))
    SEA_LEVEL = 28150.0
    OCEAN_FLOOR = 184.0

    water_levels = np.asarray([OCEAN_FLOOR, 7000.0, 15000.0, 22000.0, 27000.0, SEA_LEVEL - 1.0], dtype=np.float32)
    water_colours = np.asarray([
        [18, 38, 70], [24, 52, 92], [32, 72, 116], [48, 104, 148], [80, 148, 184], [130, 192, 216]
    ], dtype=np.float32) / 255.0

    land_levels = np.asarray([SEA_LEVEL, 31000.0, 37000.0, 43000.0, 50000.0, 57000.0, 65535.0], dtype=np.float32)
    land_colours = np.asarray([
        [76, 112, 68], [104, 138, 82], [138, 158, 98], [172, 168, 116], [160, 142, 108], [148, 126, 104], [170, 156, 144]
    ], dtype=np.float32) / 255.0

    h_f = h_arr.astype(np.float32)
    land = h_f >= SEA_LEVEL

    water_rgb = np.zeros(h_f.shape + (3,), dtype=np.float32)
    for c in range(3):
        water_rgb[..., c] = np.interp(h_f, water_levels, water_colours[:, c])

    land_rgb = np.zeros(h_f.shape + (3,), dtype=np.float32)
    for c in range(3):
        land_rgb[..., c] = np.interp(h_f, land_levels, land_colours[:, c])

    base_rgb = np.where(land[..., None], land_rgb, water_rgb)

    surface = ndimage.gaussian_filter(h_f, 0.8)
    grad_y, grad_x = np.gradient(surface)
    z_factor = 0.0032
    norm_x = -grad_x * z_factor
    norm_y = -grad_y * z_factor
    norm_z = np.ones_like(surface)
    length = np.sqrt(norm_x**2 + norm_y**2 + norm_z**2)
    norm_x /= length
    norm_y /= length
    norm_z /= length

    sun_azimuth = np.radians(315.0)
    sun_elevation = np.radians(45.0)
    sun_x = np.cos(sun_elevation) * np.sin(sun_azimuth)
    sun_y = np.cos(sun_elevation) * np.cos(sun_azimuth)
    sun_z = np.sin(sun_elevation)

    intensity = np.clip(norm_x * sun_x + norm_y * sun_y + norm_z * sun_z, 0.0, 1.0)
    shaded = base_rgb * (0.4 + 0.6 * intensity[..., None])
    shaded[h_arr == 0] = [0.1, 0.12, 0.16]

    out_u8 = (np.clip(shaded, 0.0, 1.0) * 255.0).astype(np.uint8)
    Image.fromarray(out_u8).save(HEIGHTMAP_PREVIEW_PNG)
    print(f"  Updated {HEIGHTMAP_PREVIEW_PNG}")

def main():
    parser = argparse.ArgumentParser(description="Sync external upstream data sources.")
    parser.add_argument("--gtadb", action="store_true", help="Sync GTADB landmarks only")
    parser.add_argument("--heightmap", action="store_true", help="Sync heightmap only")
    parser.add_argument("--local", action="store_true",
                        help="Use cached source files instead of downloading (offline regen)")
    parser.add_argument("--overwrite-work", action="store_true",
                        help="Overwrite canonical layers/landmarks.geojson directly (creates backup)")
    args = parser.parse_args()

    sync_all = not args.gtadb and not args.heightmap

    if sync_all or args.gtadb:
        sync_gtadb(use_local=args.local, overwrite_work=args.overwrite_work)
    if sync_all or args.heightmap:
        sync_heightmap()

    # Format layers after sync
    import subprocess
    print("\n--- Running format.py on synchronized data ---")
    subprocess.run([sys.executable, os.path.join(PROJECT_ROOT, "scripts", "format.py")], check=True)
    print("\nUpstream sync complete.")

if __name__ == "__main__":
    main()
