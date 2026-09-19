#!/usr/bin/env python3
"""
Generate Full-Scale OpenStreetMap-Carto Parametric Road Style for QGIS (Leonida GIS)
=============================================================================
Generates styles/roads.qml using native QGIS 3.x API based directly on the
canonical OpenStreetMap-Carto specification (roads.mss, road-colors-generated.mss),
at full 1x scale calibrated for Leonida's native metric space.

Key Architectural Features:
1. 3 Flat Parametric Physical Tiers (NO Nested Rule Trees):
   - Tier 1: Bridges (Elevated Decks) - Casing (Pass 4), Left & Right Railing Parapets (Pass 5), Fill (Pass 6)
   - Tier 2: Surface Roads (Ground Level) - Casing (Pass 2), Fill (Pass 3)
   - Tier 3: Tunnels (Subterranean) - Dashed Casing (Pass 0), Lightened Fill (Pass 1)

2. Link Ramp Hierarchy & Scale Calibration:
   - Dedicated link geometry handling ("highway" LIKE '%_link' OR "link" = 'yes').
   - Links are distinctly narrower than mainlines at all zooms, preventing ramp bloat.
   - Low-zoom scaling: Minor roads and link ramps cleanly fade/scale down at >= 1:35,000 / >= 1:50,000.
   - Full 1x road widths for clean, professional cartographic density.

3. OSM Carto 1:1 Bridge & Tunnel Casings:
   - Bridge casings are a solid black ring (@bridge-casing: black), drawn wider
     than the normal casing so a black structure edge shows around the fill.
   - Tunnel dashed casings dynamically match the underlying road class colors.
   - Every casing, underlay, and fill has matching, scale-dependent zoom curves.

4. 1:1 OSM Carto Oneway Chevrons (Pass 7):
   - Preserved 12:5 arrow aspect ratio via styles/oneway.svg.
   - Scale-adaptive and lane-width adaptive sizing (slimmer chevrons on narrow link ramps).
   - Dynamic direction (180° on oneway = '-1').

5. Seamless Junction Merging:
   - symbollevels="1" for clean casing/fill fusion across intersections.
   - enableorderby="1" ensuring mainline motorways cleanly prioritize over ramps.

6. Close-Zoom Width Tapering (below 1:3,000):
   - Ribbon, casing and chevron ladders thin out at 1:2,000, 1:1,500, 1:1,200 and
     below so the centre-line stays visible while digitizing.
   - Tiers at or above 1:3,000 are untouched, so distant views are unchanged.
"""

import sys
import os
import re
import subprocess

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
OUTPUT_QML = os.path.join(PROJECT_ROOT, "styles", "roads.qml")
ROADS_GEOJSON = os.path.join(PROJECT_ROOT, "layers", "roads.geojson")

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
    QgsApplication, QgsVectorLayer, QgsLineSymbol, QgsMarkerLineSymbolLayer,
    QgsSimpleLineSymbolLayer, QgsSvgMarkerSymbolLayer, QgsRuleBasedRenderer,
    QgsFeatureRequest, QgsSymbolLayer, QgsProperty, QgsUnitTypes,
    QgsDefaultValue, QgsEditorWidgetSetup
)
from PyQt5.QtGui import QColor
from PyQt5.QtCore import Qt


# =============================================================================
# 1:1 OSM Carto Parametric Expressions (roads.mss / road-colors-generated.mss)
# =============================================================================

FILL_COLOR_EXPR = """CASE
  WHEN "highway" IN ('motorway', 'motorway_link') THEN '#e892a2'
  WHEN "highway" IN ('trunk', 'trunk_link') THEN '#f9b29c'
  WHEN "highway" IN ('primary', 'primary_link') THEN '#fcd6a4'
  WHEN "highway" IN ('secondary', 'secondary_link') THEN '#f7fabf'
  WHEN "highway" IN ('tertiary', 'tertiary_link') THEN '#ffffff'
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN '#ffffff'
  WHEN "highway" = 'living_street' THEN '#ededed'
  WHEN "highway" = 'pedestrian' THEN '#dddde8'
  WHEN "highway" = 'service' THEN '#ffffff'
  WHEN "highway" = 'track' THEN '#996600'
  WHEN "highway" IN ('footway', 'path', 'steps') THEN '#fa8072'
  WHEN "highway" = 'cycleway' THEN '#0000ff'
  ELSE '#ffffff'
END"""

TUNNEL_FILL_COLOR_EXPR = """CASE
  WHEN "highway" IN ('motorway', 'motorway_link') THEN '#f1b6c0'
  WHEN "highway" IN ('trunk', 'trunk_link') THEN '#fcd2c4'
  WHEN "highway" IN ('primary', 'primary_link') THEN '#fde5c4'
  WHEN "highway" IN ('secondary', 'secondary_link') THEN '#fafcd4'
  WHEN "highway" IN ('tertiary', 'tertiary_link') THEN '#ffffff'
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN '#f2f2f2'
  WHEN "highway" = 'living_street' THEN '#f5f5f5'
  WHEN "highway" = 'pedestrian' THEN '#e8e8ef'
  WHEN "highway" = 'service' THEN '#f5f5f5'
  WHEN "highway" = 'track' THEN '#996600'
  WHEN "highway" IN ('footway', 'path', 'steps') THEN '#fa8072'
  WHEN "highway" = 'cycleway' THEN '#0000ff'
  ELSE '#f2f2f2'
END"""

CASING_COLOR_EXPR = """CASE
  WHEN "highway" IN ('motorway', 'motorway_link') THEN '#dc2a67'
  WHEN "highway" IN ('trunk', 'trunk_link') THEN '#c84e2f'
  WHEN "highway" IN ('primary', 'primary_link') THEN '#a06b00'
  WHEN "highway" IN ('secondary', 'secondary_link') THEN '#707d05'
  WHEN "highway" IN ('tertiary', 'tertiary_link') THEN '#8f8f8f'
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN '#bbbbbb'
  WHEN "highway" = 'living_street' THEN '#bbbbbb'
  WHEN "highway" = 'pedestrian' THEN '#999999'
  WHEN "highway" = 'service' THEN '#cfcfcf'
  ELSE '#00000000'
END"""

TUNNEL_CASING_COLOR_EXPR = """CASE
  WHEN "highway" IN ('motorway', 'motorway_link') THEN '#dc2a67'
  WHEN "highway" IN ('trunk', 'trunk_link') THEN '#c84e2f'
  WHEN "highway" IN ('primary', 'primary_link') THEN '#a06b00'
  WHEN "highway" IN ('secondary', 'secondary_link') THEN '#707d05'
  WHEN "highway" IN ('tertiary', 'tertiary_link') THEN '#8f8f8f'
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN '#999999'
  WHEN "highway" IN ('living_street', 'pedestrian') THEN '#999999'
  WHEN "highway" = 'service' THEN '#aaaaaa'
  WHEN "highway" = 'track' THEN '#996600'
  ELSE '#999999'
END"""

ARROW_COLOR_EXPR = """CASE
  WHEN "highway" IN ('motorway', 'motorway_link') THEN '#741334'
  WHEN "highway" IN ('trunk', 'trunk_link') THEN '#612617'
  WHEN "highway" IN ('primary', 'primary_link') THEN '#543800'
  WHEN "highway" IN ('secondary', 'secondary_link') THEN '#444c03'
  WHEN "highway" IN ('tertiary', 'tertiary_link') THEN '#424242'
  WHEN "highway" IN ('residential', 'unclassified', 'road', 'service') THEN '#555555'
  WHEN "highway" = 'living_street' THEN '#6e6e6e'
  WHEN "highway" = 'pedestrian' THEN '#4b4b4b'
  WHEN "highway" = 'track' THEN '#664400'
  WHEN "highway" IN ('footway', 'path', 'steps') THEN '#b31806'
  WHEN "highway" = 'cycleway' THEN '#000080'
  ELSE '#555555'
END"""

# =============================================================================
# Full-Scale Parametric Width Expressions with Dedicated Link Ramp Hierarchy
# =============================================================================

# =============================================================================
# Close-Zoom Width Tapering (applies below 1:3,000 only)
# =============================================================================
# Every ladder below stops at a 1:3,000 tier and then falls through to a single
# ELSE catch-all, so all deeper scales - 1:1,863 and 1:931 included - rendered at
# the full 1:3,000 weight. At mapping zooms that ribbon covers the centre-line and
# the vertex handles, which makes precise digitizing awkward.
#
# CLOSE_ZOOM_TAPER subdivides that catch-all into close-zoom tiers: each entry is
# a scale denominator and the factor applied to the original sub-1:3,000 width.
# Nothing at or above 1:3,000 is touched, so distant views render exactly as
# before; only closer scales thin out. Tune the factors here to change how fast
# the network narrows when zooming in.
CLOSE_ZOOM_TAPER = (
    (2000, 0.86),
    (1500, 0.74),
    (1200, 0.64),
    (None, 0.55),
)

CLOSE_ZOOM_TIER_RE = re.compile(
    r"(?P<head>WHEN coalesce\(@map_scale, 1000\) >= 3000 THEN [\d.]+)"
    r"\n(?P<indent>[ \t]*)ELSE (?P<base>[\d.]+)"
)


def add_close_zoom_tiers(expr):
    """Turn every sub-1:3,000 catch-all in a width ladder into tapered tiers.

    ``>= 3000 ... ELSE w`` becomes
    ``>= 3000 ... >= 2000 ... >= 1500 ... >= 1200 ... ELSE w * factor``.
    """
    def _expand(match):
        indent = match.group("indent")
        base = float(match.group("base"))
        tiers = []
        for denominator, factor in CLOSE_ZOOM_TAPER:
            value = f"{round(base * factor, 2):.2f}"
            if denominator is None:
                tiers.append(f"{indent}ELSE {value}")
            else:
                tiers.append(f"{indent}WHEN coalesce(@map_scale, 1000) >= {denominator} THEN {value}")
        return "{}\n{}".format(match.group("head"), "\n".join(tiers))

    return CLOSE_ZOOM_TIER_RE.sub(_expand, expr)


FILL_WIDTH_EXPR = add_close_zoom_tiers("""CASE
  -- LINKS & RAMPS ("highway" ends with _link OR "link" = 'yes')
  WHEN ("highway" LIKE '%_link' OR coalesce(to_string("link"), '') IN ('yes', '1', 'true')) THEN
    CASE
      WHEN "highway" IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.70
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.15
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.70
          ELSE 2.55
        END
      WHEN "highway" IN ('primary', 'primary_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.60
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.00
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.60
          ELSE 2.30
        END
      WHEN "highway" IN ('secondary', 'secondary_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.55
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.90
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.45
          ELSE 2.10
        END
      WHEN "highway" IN ('tertiary', 'tertiary_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.75
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.20
          ELSE 1.90
        END
      ELSE
        CASE
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.60
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.00
          ELSE 1.60
        END
    END

  -- MAINLINE ROADS
  WHEN "highway" IN ('motorway', 'trunk') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.70
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.15
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.80
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.70
      ELSE 4.20
    END
  WHEN "highway" = 'primary' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.55
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.60
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.40
      ELSE 3.80
    END
  WHEN "highway" = 'secondary' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.45
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.85
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.45
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.20
      ELSE 3.40
    END
  WHEN "highway" = 'tertiary' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.70
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.30
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.90
      ELSE 3.00
    END
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.45
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.90
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.45
      ELSE 2.30
    END
  WHEN "highway" IN ('living_street', 'pedestrian') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.80
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.30
      ELSE 2.10
    END
  WHEN "highway" = 'service' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.60
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.00
      ELSE 1.60
    END
  WHEN "highway" IN ('track', 'footway', 'cycleway', 'path', 'steps') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.45
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 0.70
      ELSE 1.00
    END
  ELSE
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.45
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 0.85
      ELSE 1.30
    END
END""")

CASING_WIDTH_EXPR = add_close_zoom_tiers("""CASE
  WHEN "highway" IN ('track', 'footway', 'cycleway', 'path', 'steps') THEN 0.00

  -- LINKS & RAMPS
  WHEN ("highway" LIKE '%_link' OR coalesce(to_string("link"), '') IN ('yes', '1', 'true')) THEN
    CASE
      WHEN "highway" IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.05
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.60
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.25
          ELSE 3.15
        END
      WHEN "highway" IN ('primary', 'primary_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.00
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.45
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.10
          ELSE 2.90
        END
      WHEN "highway" IN ('secondary', 'secondary_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 35000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.85
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.30
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.90
          ELSE 2.65
        END
      WHEN "highway" IN ('tertiary', 'tertiary_link') THEN
        CASE
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.15
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.65
          ELSE 2.35
        END
      ELSE
        CASE
          WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
          WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.90
          WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.35
          ELSE 2.05
        END
    END

  -- MAINLINE ROADS
  WHEN "highway" IN ('motorway', 'trunk') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 1.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.55
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 2.30
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 3.35
      ELSE 5.00
    END
  WHEN "highway" = 'primary' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.85
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.35
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 2.10
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 3.05
      ELSE 4.60
    END
  WHEN "highway" = 'secondary' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.75
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.20
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.95
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.80
      ELSE 4.10
    END
  WHEN "highway" = 'tertiary' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 1.05
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.70
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 2.50
      ELSE 3.70
    END
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 50000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.75
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.30
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.90
      ELSE 2.90
    END
  WHEN "highway" IN ('living_street', 'pedestrian') THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 1.10
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.70
      ELSE 2.60
    END
  WHEN "highway" = 'service' THEN
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.90
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.35
      ELSE 2.00
    END
  ELSE
    CASE
      WHEN coalesce(@map_scale, 1000) >= 20000 THEN 0.00
      WHEN coalesce(@map_scale, 1000) >= 8000 THEN 0.75
      WHEN coalesce(@map_scale, 1000) >= 3000 THEN 1.20
      ELSE 1.70
    END
END""")

# (Bridge parapet width constant removed: bridges now use the OSM Carto black
# casing ring formula instead of dual railing lines.)

# Hierarchical road drawing order: Mainlines render on top of ramps; freeways render on top of minor roads
ORDER_BY_EXPR = """CASE
  WHEN "highway" = 'motorway' AND coalesce(to_string("link"), '') NOT IN ('yes', '1') THEN 12
  WHEN "highway" = 'motorway' THEN 11
  WHEN "highway" = 'trunk' AND coalesce(to_string("link"), '') NOT IN ('yes', '1') THEN 10
  WHEN "highway" = 'trunk' THEN 9
  WHEN "highway" = 'primary' AND coalesce(to_string("link"), '') NOT IN ('yes', '1') THEN 8
  WHEN "highway" = 'primary' THEN 7
  WHEN "highway" = 'secondary' THEN 6
  WHEN "highway" = 'tertiary' THEN 5
  WHEN "highway" IN ('residential', 'unclassified', 'road') THEN 4
  WHEN "highway" IN ('living_street', 'pedestrian') THEN 3
  WHEN "highway" = 'service' THEN 2
  ELSE 1
END"""

CHEVRON_TIER_RE = re.compile(
    r"(?P<indent>[ \t]*)WHEN coalesce\(@map_scale, 1000\) <= 2500 THEN (?P<base>[\d.]+)"
)


def apply_close_zoom_chevrons(expr):
    """Subdivide the ``<= 2500`` chevron tier so far zoom sits inside the ribbon.

    The ribbon ladders are macro-first with an ``ELSE`` floor, while chevrons are
    sized micro-first with ``<=``, so each chevron threshold takes the taper
    factor of the band just inside it (and 1:2,500 keeps the widest band).
    """
    entries = list(CLOSE_ZOOM_TAPER)

    def _expand(match):
        indent = match.group("indent")
        base = float(match.group("base"))
        bands = []
        for index, (denominator, _) in enumerate(entries):
            if denominator is None:
                continue
            factor = entries[min(index + 1, len(entries) - 1)][1]
            bands.append((denominator, factor))
        bands.reverse()
        lines = [
            f"{indent}WHEN coalesce(@map_scale, 1000) <= {denominator} THEN {round(base * factor, 2):.1f}"
            for denominator, factor in bands
        ]
        widest = round(base * entries[0][1], 2)
        lines.append(f"{indent}WHEN coalesce(@map_scale, 1000) <= 2500 THEN {widest:.1f}")
        return "\n".join(lines)

    return CHEVRON_TIER_RE.sub(_expand, expr)


# Dynamic oneway chevron size (proportional for mainlines and narrow link ramps)
SIZE_EXPR = apply_close_zoom_chevrons("""CASE
  WHEN coalesce(to_string("oneway"), '') IN ('yes', '1', 'true', '-1') THEN
    CASE
      WHEN ("highway" LIKE '%_link' OR coalesce(to_string("link"), '') IN ('yes', '1', 'true')) THEN
        CASE
          WHEN coalesce(@map_scale, 1000) <= 2500 THEN 3.3
          WHEN coalesce(@map_scale, 1000) <= 8000 THEN 2.4
          WHEN coalesce(@map_scale, 1000) <= 20000 THEN 1.8
          ELSE 0.0
        END
      ELSE
        CASE
          WHEN coalesce(@map_scale, 1000) <= 2500 THEN 4.2
          WHEN coalesce(@map_scale, 1000) <= 8000 THEN 3.0
          WHEN coalesce(@map_scale, 1000) <= 20000 THEN 2.2
          ELSE 0.0
        END
    END
  ELSE 0.0
END""")


def make_oneway_marker_layer(pass_num=7):
    """Creates a 1:1 OSM Carto oneway arrow marker line layer."""
    ml = QgsMarkerLineSymbolLayer()
    ml.setInterval(18.0)
    ml.setIntervalUnit(QgsUnitTypes.RenderMillimeters)
    ml.setPlacements(QgsMarkerLineSymbolLayer.Placement.Interval)
    ml.setRenderingPass(pass_num)

    svg = QgsSvgMarkerSymbolLayer("styles/oneway.svg")
    svg.setSize(2.8)
    svg.setSizeUnit(QgsUnitTypes.RenderMillimeters)
    svg.setFillColor(QColor(85, 85, 85))
    svg.setStrokeColor(QColor(85, 85, 85))
    svg.setPreservedAspectRatio(True)

    svg.setDataDefinedProperty(QgsSymbolLayer.PropertySize, QgsProperty.fromExpression(SIZE_EXPR))
    svg.setDataDefinedProperty(QgsSymbolLayer.PropertyAngle, QgsProperty.fromExpression('CASE WHEN coalesce(to_string("oneway"), \'\') = \'-1\' THEN 180 ELSE 0 END'))
    svg.setDataDefinedProperty(QgsSymbolLayer.PropertyFillColor, QgsProperty.fromExpression(ARROW_COLOR_EXPR))
    svg.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(ARROW_COLOR_EXPR))

    ml.subSymbol().changeSymbolLayer(0, svg)
    return ml


def build_parametric_renderer():
    """Builds the 3-Tier Parametric RuleRenderer without nesting."""
    root = QgsRuleBasedRenderer.Rule(None)

    # -------------------------------------------------------------------------
    # TIER 1: BRIDGES (Pass 4-6) - Elevated Overpass Decks
    # -------------------------------------------------------------------------
    bridge_sym = QgsLineSymbol()

    # Pass 4: Black Bridge Casing (@bridge-casing: black)
    # OSM Carto 1:1: the bridge casing REPLACES the class-colored casing and is
    # drawn WIDER by 2 x casing-band, so a solid black ring shows around the
    # unchanged fill. width = CASING + 2 * band = CASING + (CASING - FILL).
    l_b_casing = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 1.5)
    l_b_casing.setRenderingPass(4)
    l_b_casing.setPenJoinStyle(Qt.RoundJoin)
    l_b_casing.setPenCapStyle(Qt.FlatCap)
    l_b_casing.setDataDefinedProperty(
        QgsSymbolLayer.PropertyStrokeWidth,
        QgsProperty.fromExpression(f'({CASING_WIDTH_EXPR}) + (({CASING_WIDTH_EXPR}) - ({FILL_WIDTH_EXPR}))')
    )

    # Pass 6: Fill
    l_b_fill = QgsSimpleLineSymbolLayer(QColor(255, 255, 255), 1.15)
    l_b_fill.setRenderingPass(6)
    l_b_fill.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(FILL_COLOR_EXPR))
    l_b_fill.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(FILL_WIDTH_EXPR))
    l_b_fill.setDataDefinedProperty(QgsSymbolLayer.PropertyCustomDash, QgsProperty.fromExpression("CASE WHEN \"highway\" IN ('track', 'footway', 'cycleway') THEN '2;1.5' ELSE '1;0' END"))

    bridge_sym.changeSymbolLayer(0, l_b_casing)
    bridge_sym.appendSymbolLayer(l_b_fill)
    bridge_sym.appendSymbolLayer(make_oneway_marker_layer(pass_num=7))

    bridge_filter = 'coalesce(to_string("bridge"), \'\') IN (\'yes\', \'1\', \'true\', \'viaduct\')'
    r_bridges = QgsRuleBasedRenderer.Rule(bridge_sym, 0, 0, bridge_filter, "Bridges (Elevated Decks)")
    root.appendChild(r_bridges)

    # -------------------------------------------------------------------------
    # TIER 2: SURFACE ROADS (Pass 2-3) - Ground Level
    # -------------------------------------------------------------------------
    surface_sym = QgsLineSymbol()

    # Pass 2: Casing
    l_s0 = QgsSimpleLineSymbolLayer(QColor(187, 187, 187), 1.5)
    l_s0.setRenderingPass(2)
    l_s0.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(CASING_COLOR_EXPR))
    l_s0.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(CASING_WIDTH_EXPR))

    # Pass 3: Fill
    l_s1 = QgsSimpleLineSymbolLayer(QColor(255, 255, 255), 1.15)
    l_s1.setRenderingPass(3)
    l_s1.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(FILL_COLOR_EXPR))
    l_s1.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(FILL_WIDTH_EXPR))
    l_s1.setDataDefinedProperty(QgsSymbolLayer.PropertyCustomDash, QgsProperty.fromExpression("CASE WHEN \"highway\" IN ('track', 'footway', 'cycleway') THEN '2;1.5' ELSE '1;0' END"))

    surface_sym.changeSymbolLayer(0, l_s0)
    surface_sym.appendSymbolLayer(l_s1)
    surface_sym.appendSymbolLayer(make_oneway_marker_layer(pass_num=7))

    surface_filter = 'coalesce(to_string("bridge"), \'\') NOT IN (\'yes\', \'1\', \'true\', \'viaduct\') AND coalesce(to_string("tunnel"), \'\') NOT IN (\'yes\', \'1\', \'true\', \'culvert\')'
    r_surface = QgsRuleBasedRenderer.Rule(surface_sym, 0, 0, surface_filter, "Surface Roads (Ground Level)")
    root.appendChild(r_surface)

    # -------------------------------------------------------------------------
    # TIER 3: TUNNELS (Pass 0-1) - Subterranean
    # -------------------------------------------------------------------------
    tunnel_sym = QgsLineSymbol()

    # Pass 0: Dashed casing matching road class color
    l_t0 = QgsSimpleLineSymbolLayer(QColor(128, 128, 128), 1.5)
    l_t0.setRenderingPass(0)
    l_t0.setCustomDashVector([2.5, 1.5])
    l_t0.setUseCustomDashPattern(True)
    l_t0.setCustomDashPatternUnit(QgsUnitTypes.RenderMillimeters)
    l_t0.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(TUNNEL_CASING_COLOR_EXPR))
    l_t0.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(CASING_WIDTH_EXPR))

    # Pass 1: Lightened fill
    l_t1 = QgsSimpleLineSymbolLayer(QColor(242, 242, 242), 1.15)
    l_t1.setRenderingPass(1)
    l_t1.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeColor, QgsProperty.fromExpression(TUNNEL_FILL_COLOR_EXPR))
    l_t1.setDataDefinedProperty(QgsSymbolLayer.PropertyStrokeWidth, QgsProperty.fromExpression(FILL_WIDTH_EXPR))
    l_t1.setDataDefinedProperty(QgsSymbolLayer.PropertyCustomDash, QgsProperty.fromExpression("CASE WHEN \"highway\" IN ('track', 'footway', 'cycleway') THEN '2;1.5' ELSE '1;0' END"))

    tunnel_sym.changeSymbolLayer(0, l_t0)
    tunnel_sym.appendSymbolLayer(l_t1)
    tunnel_sym.appendSymbolLayer(make_oneway_marker_layer(pass_num=7))

    tunnel_filter = 'coalesce(to_string("tunnel"), \'\') IN (\'yes\', \'1\', \'true\', \'culvert\')'
    r_tunnels = QgsRuleBasedRenderer.Rule(tunnel_sym, 0, 0, tunnel_filter, "Tunnels (Subterranean)")
    root.appendChild(r_tunnels)

    renderer = QgsRuleBasedRenderer(root)
    renderer.setUsingSymbolLevels(True)
    clause = QgsFeatureRequest.OrderByClause(ORDER_BY_EXPR, True)
    renderer.setOrderBy(QgsFeatureRequest.OrderBy([clause]))
    renderer.setOrderByEnabled(True)

    return renderer


def configure_form_settings(layer):
    """Configures digitizing form aliases, default expressions, and field widgets."""
    aliases = [
        ("id", "Road ID"),
        ("ref_id", "Reference ID"),
        ("highway", "Highway Class"),
        ("name", "Street Name"),
        ("ref", "Route Reference"),
        ("link", "Link Ramp"),
        ("oneway", "One-Way Flow"),
        ("lanes", "Lanes"),
        ("bridge", "Bridge"),
        ("tunnel", "Tunnel"),
        ("surface", "Surface"),
        ("maxspeed", "Speed Limit"),
        ("layer", "Layer"),
        ("junction", "Junction"),
        ("turn_lanes", "Turn Lanes"),
    ]
    for f_name, a_name in aliases:
        idx = layer.fields().indexOf(f_name)
        if idx != -1:
            layer.setFieldAlias(idx, a_name)

    defaults = [
        ("id", 'coalesce(maximum("id") + 1, count(1) + 1)', False),
        ("ref_id", "'R_' || lpad(coalesce(maximum(to_int(replace(\"ref_id\", 'R_', ''))) + 1, count(1) + 1), 4, '0')", False),
        ("layer", 'CASE WHEN "bridge" IN (\'yes\', \'viaduct\') THEN 1 WHEN "tunnel" IN (\'yes\', \'culvert\') THEN -1 ELSE NULL END', True),
    ]
    for f_name, expr, on_upd in defaults:
        idx = layer.fields().indexOf(f_name)
        if idx != -1:
            layer.setDefaultValueDefinition(idx, QgsDefaultValue(expr, on_upd))

    widgets = {
        "highway": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"Motorway": "motorway"},
                {"Motorway Link": "motorway_link"},
                {"Trunk": "trunk"},
                {"Trunk Link": "trunk_link"},
                {"Primary": "primary"},
                {"Primary Link": "primary_link"},
                {"Secondary": "secondary"},
                {"Secondary Link": "secondary_link"},
                {"Tertiary": "tertiary"},
                {"Tertiary Link": "tertiary_link"},
                {"Unclassified": "unclassified"},
                {"Residential": "residential"},
                {"Living Street": "living_street"},
                {"Service": "service"},
                {"Track": "track"},
                {"Pedestrian": "pedestrian"},
                {"Footway": "footway"},
                {"Cycleway": "cycleway"},
            ]
        }),
        "bridge": QgsEditorWidgetSetup("CheckBox", {
            "CheckedState": "yes",
            "UncheckedState": "no",
        }),
        "tunnel": QgsEditorWidgetSetup("CheckBox", {
            "CheckedState": "yes",
            "UncheckedState": "no",
        }),
        "link": QgsEditorWidgetSetup("CheckBox", {
            "CheckedState": "yes",
            "UncheckedState": "no",
        }),
        "oneway": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"Two-Way": "no"},
                {"One-Way (Forward)": "yes"},
                {"One-Way (Reverse)": "-1"},
            ]
        }),
        "surface": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"Asphalt": "asphalt"},
                {"Concrete": "concrete"},
                {"Paved": "paved"},
                {"Paving Stones": "paving_stones"},
                {"Gravel": "gravel"},
                {"Compacted": "compacted"},
                {"Dirt": "dirt"},
                {"Ground": "ground"},
                {"Sand": "sand"},
            ]
        }),
        "maxspeed": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"15 mph": "15"},
                {"20 mph": "20"},
                {"25 mph": "25"},
                {"30 mph": "30"},
                {"35 mph": "35"},
                {"40 mph": "40"},
                {"45 mph": "45"},
                {"50 mph": "50"},
                {"55 mph": "55"},
                {"60 mph": "60"},
                {"65 mph": "65"},
                {"70 mph": "70"},
                {"75 mph": "75"},
            ]
        }),
        "layer": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"-2 (Deep Subterranean)": "-2"},
                {"-1 (Subterranean / Underpass)": "-1"},
                {"0 (Ground Level)": "0"},
                {"1 (Overpass / Bridge)": "1"},
                {"2 (High-Level Flyover)": "2"},
                {"3 (Multi-Tier Interchange)": "3"},
            ]
        }),
        "lanes": QgsEditorWidgetSetup("Range", {
            "Min": 1,
            "Max": 16,
            "Step": 1,
            "AllowNull": True,
        }),
        "junction": QgsEditorWidgetSetup("ValueMap", {
            "map": [
                {"None": ""},
                {"Roundabout": "roundabout"},
                {"Circular": "circular"},
            ]
        }),
        "id": QgsEditorWidgetSetup("Range", {
            "Min": 1,
            "Max": 2147483647,
            "Step": 1,
            "AllowNull": False,
        }),
    }
    for f_name, setup in widgets.items():
        idx = layer.fields().indexOf(f_name)
        if idx != -1:
            layer.setEditorWidgetSetup(idx, setup)


def generate_style():
    print(">>> Generating Full-Scale OSM Carto Parametric Road Style (styles/roads.qml)...", flush=True)
    QgsApplication.setPrefixPath(r"C:\Program Files\QGIS 3.44.7\apps\qgis", True)
    qgs_app = QgsApplication([], False)
    qgs_app.initQgis()

    def _work():
        layer = QgsVectorLayer(ROADS_GEOJSON, "roads", "ogr")
        if not layer.isValid():
            print(f"ERROR: Could not load {ROADS_GEOJSON}")
            return False

        renderer = build_parametric_renderer()
        layer.setRenderer(renderer)
        configure_form_settings(layer)

        msg, ok = layer.saveNamedStyle(OUTPUT_QML)
        if not ok:
            print(f"ERROR: Failed to save style: {msg}")
            return False

        print(f"  Successfully wrote Full-Scale OSM Carto Parametric style to {OUTPUT_QML}")
        print("  3 Canonical Tiers: Bridges, Surface Roads, Tunnels")
        print("  Full 1x scale, dedicated link ramp scaling, OSM Carto black bridge casings")
        print("  Symbol levels enabled, Feature OrderBy active")

        # Verify reloading
        retest_layer = QgsVectorLayer(ROADS_GEOJSON, "roads", "ogr")
        load_msg, load_ok = retest_layer.loadNamedStyle(OUTPUT_QML)
        if load_ok:
            print("  Verified: QGIS loaded generated style cleanly with 0 errors.")
        else:
            print(f"  Warning: Reload test returned: {load_msg}")
        return True

    success = _work()
    qgs_app.exitQgis()
    return success


if __name__ == "__main__":
    success = generate_style()
    sys.exit(0 if success else 1)
