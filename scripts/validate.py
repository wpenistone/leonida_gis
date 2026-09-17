#!/usr/bin/env python3
"""
scripts/validate.py
Semantic validator for work layers (layers/*.geojson).

Validates content schema and topological consistency:
  - strict JSON (rejects NaN/Infinity literals)
  - unique ids / correctly prefixed ref_ids (R_ roads, T_ rail, A_ areas)
  - taxonomy value domains (highway, railway, service, admin_level, place,
    restriction, waterway, natural/water)
  - county <-> county_slug consistency
  - turn restrictions: resolvable from_way/to_way (road ref_ids) and via
    point placed on/near the from-way
  - coordinates inside the project extent

Exit codes: 0 = OK (warnings allowed), 1 = errors found.
Use --strict to also fail on warnings.

Usage:
    python scripts/validate.py [--strict]
"""

import os
import sys
import json
import argparse

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from config import LAYERS_DIR, SW_X, NE_X, SW_Y, NE_Y

COUNTY_SLUG_MAP = {
    "Vice-Dale County": "vice_dale",
    "Kelly County": "kelly",
    "Leonard County": "leonard",
    "Lummox County": "lummox",
    "Mariana County": "mariana"
}

HIGHWAY_VALUES = {
    "motorway", "motorway_link", "trunk", "trunk_link", "primary", "primary_link",
    "secondary", "secondary_link", "tertiary", "tertiary_link", "unclassified",
    "residential", "living_street", "service", "track", "pedestrian",
    "footway", "cycleway"
}

RAILWAY_VALUES = {"rail", "light_rail", "subway", "tram", "monorail"}
RAIL_SERVICE_VALUES = {"mainline", "branch", "yard", "siding", "spur", "crossover"}

ADMIN_LEVELS = {4, 6, 8, 10}
PLACE_VALUES = {"state", "county", "city", "town", "suburb", "neighbourhood",
                "locality", "island", "islet"}

RESTRICTION_TYPES = {"no_left_turn", "no_right_turn", "no_u_turn",
                     "only_straight_on", "only_left_turn", "only_right_turn"}

WATERWAY_VALUES = {"river", "canal", "stream", "drain"}
WATER_AREA_VALUES = {"lake", "pond", "river", "canal", "sea", "bay"}

REF_PREFIX_BY_LAYER = {"roads": "R", "rail": "T", "areas": "A"}

VIA_WARN_ABOVE_M = 25.0   # via point beyond this distance from the from-way is considered an error

PLACEHOLDER_NAMES = []    # aggregated: one summary warning instead of N lines


def _reject_constant(const):
    raise ValueError(f"non-strict JSON literal: {const}")


class Report:
    def __init__(self):
        self.errors = []
        self.warnings = []

    def error(self, layer, msg):
        self.errors.append(f"[{layer}] {msg}")

    def warn(self, layer, msg):
        self.warnings.append(f"[{layer}] {msg}")

    def finish(self, strict):
        if self.warnings:
            print(f"\nWarnings ({len(self.warnings)}):")
            for w in self.warnings:
                print(f"  ! {w}")
        if self.errors:
            print(f"\nErrors ({len(self.errors)}):")
            for e in self.errors:
                print(f"  X {e}")
            print("\n[FAIL] Validation failed.")
            return 1
        if strict and self.warnings:
            print("\n[FAIL] --strict mode: warnings are errors.")
            return 1
        print("\n[PASS] All layers valid."
              + (f" ({len(self.warnings)} warnings)" if self.warnings else ""))
        return 0


def load_layer(path, report, layer_name):
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f, parse_constant=_reject_constant)
    except ValueError as exc:
        report.error(layer_name, f"not strict JSON: {exc}")
    except FileNotFoundError:
        report.warn(layer_name, "file missing, skipped")
    return None


def check_county(props, layer_name, label, report):
    county = props.get("county")
    slug = props.get("county_slug")
    if county is None:
        if slug is not None:
            report.error(layer_name, f"{label}: county_slug '{slug}' set but county is null")
        return
    if county not in COUNTY_SLUG_MAP:
        report.error(layer_name, f"{label}: unknown county '{county}'")
        return
    if slug != COUNTY_SLUG_MAP[county]:
        report.error(layer_name,
                     f"{label}: county_slug '{slug}' does not match county '{county}' "
                     f"(expected '{COUNTY_SLUG_MAP[county]}')")


def check_bounds(geom, layer_name, label, report, skip=False):
    """Coordinate-extent check; `skip=True` for canvas-covering background features."""
    if skip or not geom or "coordinates" not in geom:
        return

    def walk(c):
        if isinstance(c[0], (int, float)):
            x, y = c[0], c[1]
            if not (SW_X - 1 <= x <= NE_X + 1 and SW_Y - 1 <= y <= NE_Y + 1):
                report.error(layer_name, f"{label}: coordinate ({x}, {y}) outside project extent")
        else:
            for sub in c:
                walk(sub)

    walk(geom["coordinates"])


def validate_roads(props, layer_name, label, report):
    hw = props.get("highway")
    if hw not in HIGHWAY_VALUES:
        report.error(layer_name, f"{label}: invalid highway value '{hw}'")
    oneway = props.get("oneway")
    if oneway not in (None, "yes", "no", "-1", "1", "0", "true", "false", "reversible"):
        report.error(layer_name, f"{label}: invalid oneway value '{oneway}'")
    junction = props.get("junction")
    if junction not in (None, "roundabout"):
        report.error(layer_name, f"{label}: invalid junction value '{junction}'")
    if junction == "roundabout" and oneway not in ("yes", "1", "true"):
        report.warn(layer_name, f"{label}: roundabout without oneway=yes")
    surface = props.get("surface")
    if surface not in (None, "asphalt", "concrete", "paved", "unpaved", "gravel", "dirt"):
        report.error(layer_name, f"{label}: invalid surface value '{surface}'")
    name = props.get("name") or ""
    if name.startswith(("Residential Road", "Road ", "Street ")):
        PLACEHOLDER_NAMES.append(f"{layer_name} {props.get('id')}: '{name}'")


def validate_rail(props, layer_name, label, report):
    if props.get("railway") not in RAILWAY_VALUES:
        report.error(layer_name, f"{label}: invalid railway value '{props.get('railway')}'")
        return
    if props.get("railway") == "rail":
        service = props.get("service")
        if service not in RAIL_SERVICE_VALUES:
            report.error(layer_name,
                         f"{label}: invalid service value '{service}' "
                         f"(expected one of {sorted(RAIL_SERVICE_VALUES)})")


def validate_sections(props, layer_name, label, report):
    if props.get("boundary") != "administrative":
        report.error(layer_name, f"{label}: boundary must be 'administrative'")
    if props.get("admin_level") not in ADMIN_LEVELS:
        report.error(layer_name, f"{label}: invalid admin_level {props.get('admin_level')!r}")
    if props.get("place") not in PLACE_VALUES:
        report.error(layer_name, f"{label}: invalid place value {props.get('place')!r}")
    county = props.get("county")
    is_in_county = props.get("is_in:county")
    if county and is_in_county and county != is_in_county:
        report.error(layer_name,
                     f"{label}: county '{county}' disagrees with is_in:county '{is_in_county}'")
    check_county(props, layer_name, label, report)


def validate_water(props, layer_name, label, report):
    if props.get("natural") != "water":
        report.error(layer_name, f"{label}: natural must be 'water' (got {props.get('natural')!r})")
    if props.get("water") not in WATER_AREA_VALUES:
        report.error(layer_name, f"{label}: invalid water value {props.get('water')!r}")


def validate_restrictions(features, layer_name, report, road_geoms):
    from shapely.geometry import shape, Point

    for feat in features:
        props = feat.get("properties", {})
        label = f"restriction {props.get('id')}"
        if props.get("type") != "restriction":
            report.error(layer_name, f"{label}: type must be 'restriction'")
        if props.get("restriction") not in RESTRICTION_TYPES:
            report.error(layer_name,
                         f"{label}: invalid restriction value '{props.get('restriction')}'")
        for key in ("from_way", "to_way"):
            ref = props.get(key)
            if ref not in road_geoms:
                report.error(layer_name, f"{label}: {key} '{ref}' does not resolve to a road ref_id")
        geom = feat.get("geometry", {})
        check_bounds(geom, layer_name, label, report)
        # OSM via model: the Point geometry IS the via; it must sit on/near the from-way
        if geom.get("type") == "Point" and props.get("from_way") in road_geoms:
            dist = Point(geom["coordinates"]).distance(shape(road_geoms[props["from_way"]]))
            if dist > VIA_WARN_ABOVE_M:
                report.error(layer_name,
                             f"{label}: via point is {dist:.0f} m from from-way "
                             f"{props['from_way']} (must be snapped onto the way)")


def main():
    parser = argparse.ArgumentParser(description="Leonida GIS semantic layer validator")
    parser.add_argument("--strict", action="store_true", help="fail on warnings too")
    args = parser.parse_args()

    report = Report()
    layers = {}

    for fname in sorted(os.listdir(LAYERS_DIR)):
        if not fname.endswith(".geojson"):
            continue
        layer_name = fname[:-len(".geojson")]
        data = load_layer(os.path.join(LAYERS_DIR, fname), report, layer_name)
        if data is not None:
            layers[layer_name] = data.get("features", [])
        print(f"  checked layers/{fname}")

    # ---- per-feature checks ----
    road_geoms = {}
    for layer_name, features in layers.items():
        seen_ids = set()
        seen_refs = set()
        prefix_expected = REF_PREFIX_BY_LAYER.get(layer_name)

        for feat in features:
            props = feat.get("properties", {})
            fid = props.get("id", feat.get("id"))
            label = f"{layer_name} {fid}"

            if fid is None:
                report.error(layer_name, f"{label}: missing id")
            elif fid in seen_ids:
                report.error(layer_name, f"{label}: duplicate id {fid}")
            seen_ids.add(fid)

            ref = props.get("ref_id")
            if prefix_expected:
                if not ref:
                    report.error(layer_name, f"{label}: missing ref_id (expected {prefix_expected}_####)")
                elif not str(ref).startswith(prefix_expected + "_"):
                    report.error(layer_name,
                                 f"{label}: ref_id '{ref}' has wrong prefix (expected '{prefix_expected}_')")
                elif ref in seen_refs:
                    report.error(layer_name, f"{label}: duplicate ref_id {ref}")
                seen_refs.add(ref)

            check_bounds(feat.get("geometry"), layer_name, label, report,
                         skip=(props.get("water") == "sea"))  # marine background polygons cover the canvas

            if layer_name == "roads":
                validate_roads(props, layer_name, label, report)
                if ref:
                    road_geoms[ref] = feat.get("geometry")
            elif layer_name == "rail":
                validate_rail(props, layer_name, label, report)
            elif layer_name == "sections":
                validate_sections(props, layer_name, label, report)
            elif layer_name == "water":
                validate_water(props, layer_name, label, report)
            elif layer_name == "waterways":
                ww = props.get("waterway")
                if ww not in WATERWAY_VALUES:
                    report.error(layer_name, f"{label}: invalid waterway value {ww!r}")

    if "restrictions" in layers:
        validate_restrictions(layers["restrictions"], "restrictions", report, road_geoms)

    if PLACEHOLDER_NAMES:
        report.warn("roads",
                    f"{len(PLACEHOLDER_NAMES)} roads carry placeholder names needing real "
                    f"street names (first: {PLACEHOLDER_NAMES[0]})")

    for layer_name in sorted(layers):
        print(f"  {layer_name}: {len(layers[layer_name])} features")

    return report.finish(args.strict)


if __name__ == "__main__":
    sys.exit(main())

