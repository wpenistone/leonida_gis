#!/usr/bin/env python3
"""
scripts/render_all_layers.py
Visualization script rendering active and derived layers
in the Leonida GIS project, with a full-state overview and an
urban zoom showing building footprints, street grid, and transit.
"""

import os
import sys
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Patch
from matplotlib.lines import Line2D
import geopandas as gpd
from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from config import (
    BACKGROUND_PNG, SW_X, NE_X, SW_Y, NE_Y,
    PUB_QA_DIR, DERIVED_DIR, LAYERS_DIR,
    COUNTIES
)

MASTER_OUTPUT = os.path.join(PUB_QA_DIR, "all_layers_master.png")
ZOOM_OUTPUT = os.path.join(PUB_QA_DIR, "all_layers_buildings_zoom.png")


def load_gdf(path: str) -> gpd.GeoDataFrame | None:
    if not os.path.exists(path):
        return None
    try:
        gdf = gpd.read_file(path)
        if gdf.empty:
            return None
        return gdf.set_crs(None, allow_override=True)
    except Exception as e:
        print(f"  [WARN] Failed to load {path}: {e}")
        return None


def main():
    print("Rendering layer visualizations...")
    os.makedirs(PUB_QA_DIR, exist_ok=True)

    # 1. Inventory & Load all layers
    layers = {
        "shelf": ("derived/coastal_shelf.geojson", "Coastal Shelf & Reefs", "#247ab1", "polygon"),
        "water": ("derived/water_bodies.geojson", "Water Bodies & Canals", "#159ac8", "polygon"),
        "sand": ("derived/sand_beaches.geojson", "Beaches & Coastal Sand", "#eee393", "polygon"),
        "veg": ("derived/vegetation.geojson", "Parks & Vegetation", "#86ca9e", "polygon"),
        "buildings": ("derived/buildings.geojson", "Building Footprints", "#c3c3c3", "polygon"),
        "counties": ("derived/counties_dissolved.geojson", "County Boundaries", "#000000", "line"),
        "sections": ("layers/sections.geojson", "Administrative Sections", "#333333", "polygon"),
        "roads": ("layers/roads.geojson", "Road Network", "#ffee00", "line"),
        "rail": ("layers/rail.geojson", "Rail Network (Heavy & Light)", "#111111", "line"),
        "contours": ("derived/contours.geojson", "Elevation Contours (Amber Quantile)", "#ffb000", "line"),
        "landmarks": ("layers/landmarks.geojson", "GTADB Landmarks (POIs)", "#ff7f00", "point"),
        "elevation_peaks": ("derived/elevation_peaks.geojson", "Mountain Summits & Peaks (DEM)", "#8b4513", "point"),
    }

    gdfs = {}
    print("\nLoading layer inventory:")
    for key, (rel_path, label, color, geom_type) in layers.items():
        gdf = load_gdf(rel_path)
        gdfs[key] = gdf
        cnt = len(gdf) if gdf is not None else 0
        status = f"{cnt:>6} features" if gdf is not None else "NOT FOUND"
        print(f"  {label:<38}: {status} ({rel_path})")

    # Base raster
    print(f"\nLoading base map raster: {BACKGROUND_PNG}")
    base_img = Image.open(BACKGROUND_PNG)

    # -------------------------------------------------------------------------
    # RENDER 1: MASTER FULL-STATE OVERVIEW
    # -------------------------------------------------------------------------
    print(f"\nRendering Master Full-State Map -> {MASTER_OUTPUT}...")
    fig, ax = plt.subplots(figsize=(16, 20), dpi=150)
    ax.set_aspect('equal')

    # Base raster
    ax.imshow(base_img, extent=[SW_X, NE_X, SW_Y, NE_Y], origin='upper', alpha=0.90)

    # 1. Coastal shelf
    if gdfs["shelf"] is not None:
        gdfs["shelf"].plot(ax=ax, facecolor="#247ab1", edgecolor="#1a5a85", linewidth=0.4, alpha=0.25)

    # 2. Water bodies
    if gdfs["water"] is not None:
        gdfs["water"].plot(ax=ax, facecolor="#159ac8", edgecolor="#0f7a9e", linewidth=0.3, alpha=0.65)

    # 3. Sand & Beaches
    if gdfs["sand"] is not None:
        gdfs["sand"].plot(ax=ax, facecolor="#eee393", edgecolor="#c4ba70", linewidth=0.3, alpha=0.75)

    # 4. Vegetation & Forests
    if gdfs["veg"] is not None:
        gdfs["veg"].plot(ax=ax, facecolor="#86ca9e", edgecolor="#63a078", linewidth=0.2, alpha=0.60)
    # 5. Contours
    if gdfs["contours"] is not None:
        gdfs["contours"].plot(ax=ax, color="#b17158", linewidth=0.26, alpha=0.75)

    # 6. Administrative Sections
    if gdfs["sections"] is not None:
        for c_name, meta in COUNTIES.items():
            sub = gdfs["sections"][gdfs["sections"]["county"] == c_name]
            if not sub.empty:
                sub.plot(ax=ax, color=meta["color"], alpha=0.18, edgecolor="#222222", linewidth=0.3)

    # 7. County Boundaries
    if gdfs["counties"] is not None:
        gdfs["counties"].plot(ax=ax, facecolor="none", edgecolor="#000000", linewidth=1.8, linestyle="--")

    # 8. Building Footprints
    if gdfs["buildings"] is not None:
        gdfs["buildings"].plot(ax=ax, facecolor="#c3c3c3", edgecolor="#444444", linewidth=0.25, alpha=0.85)

    # 9. Roads
    if gdfs["roads"] is not None:
        gdfs["roads"].plot(ax=ax, color="#ffee00", linewidth=0.85, alpha=0.92)

    # 10. Heavy Rail & Light Rail
    if gdfs["rail"] is not None:
        heavy = gdfs["rail"][gdfs["rail"]["railway"] != "light_rail"]
        light = gdfs["rail"][gdfs["rail"]["railway"] == "light_rail"]
        if not heavy.empty:
            heavy.plot(ax=ax, color="#111111", linewidth=1.6)
            heavy.plot(ax=ax, color="#ffffff", linewidth=0.8, linestyle=":")
        if not light.empty:
            light.plot(ax=ax, color="#c4342b", linewidth=1.8, alpha=0.95)

    # 11. Landmarks
    if gdfs["landmarks"] is not None:
        gdfs["landmarks"].plot(ax=ax, color="#ff7f00", edgecolor="#222222", linewidth=0.3, markersize=7, alpha=0.7)

    # 12. Mountain Summits & Peaks
    if gdfs["elevation_peaks"] is not None:
        gdfs["elevation_peaks"].plot(ax=ax, color="#8b4513", edgecolor="#000000", linewidth=0.5, marker="^", markersize=35, alpha=0.9)

    ax.set_xlim(SW_X, NE_X)
    ax.set_ylim(SW_Y, NE_Y)
    ax.set_title(
        "State of Leonida GIS - All Layers Master Overview\n"
        "(In-Game Metric Coordinate Space | 1 Unit = 1 Meter | Origin 0,0)",
        fontsize=14, fontweight='bold', pad=14
    )

    # Legend
    legend_elements = [
        Patch(facecolor="#247ab1", edgecolor="#1a5a85", alpha=0.5, label="Coastal Shelf & Reefs (7 bands)"),
        Patch(facecolor="#159ac8", edgecolor="#0f7a9e", alpha=0.7, label="Water Bodies & Canals (1,869)"),
        Patch(facecolor="#86ca9e", edgecolor="#63a078", alpha=0.7, label="Parks & Vegetation (1,752)"),
        Patch(facecolor="#eee393", edgecolor="#c4ba70", alpha=0.8, label="Beaches & Coastal Sand (350)"),
        Patch(facecolor="#c3c3c3", edgecolor="#444444", alpha=0.9, label="Building Footprints (2,152)"),
        Line2D([0], [0], color="#ffee00", lw=2, label="Road Network (185 roads)"),
        Line2D([0], [0], color="#111111", lw=2.5, ls="--", label="Heavy Rail Network (190 segments, 135.8 km)"),
        Line2D([0], [0], color="#c4342b", lw=2.5, label="Light Rail / Metro Transit (29 segments, 24.6 km)"),
        Line2D([0], [0], color="#000000", lw=1.5, ls="--", label="County Boundaries (5 Counties)"),
        Line2D([0], [0], color="#c49882", lw=1.5, label="Elevation Contours (Warm Brown Quantiles)"),
        Line2D([0], [0], marker='o', color='w', markerfacecolor='#ff7f00', markersize=7, label="GTADB Landmarks (2,318 POIs)"),
        Line2D([0], [0], marker='^', color='w', markerfacecolor='#8b4513', markersize=8, label="Mountain Summits & Peaks (37 Summits)"),
    ]
    ax.legend(handles=legend_elements, loc="lower left", framealpha=0.92, fontsize=9.5, title="Base Cartography & Infrastructure", title_fontsize=10.5)

    with open(MASTER_OUTPUT, "wb") as f:
        plt.savefig(f, format="png", bbox_inches="tight", dpi=150)
    plt.close()
    print(f"  Saved: {MASTER_OUTPUT}")

    # -------------------------------------------------------------------------
    # RENDER 2: HIGH-RESOLUTION URBAN ZOOM (VICE CITY BUILDINGS & TRANSIT)
    # -------------------------------------------------------------------------
    print(f"\nRendering Vice City Buildings & Transit Zoom -> {ZOOM_OUTPUT}...")
    fig, ax = plt.subplots(figsize=(14, 12), dpi=180)
    ax.set_aspect('equal')

    # Zoom window on Vice City urban core
    zoom_extent = [-3000, 500, -1500, 1500]
    ax.imshow(base_img, extent=[SW_X, NE_X, SW_Y, NE_Y], origin='upper', alpha=0.88)

    # Water & Coast in zoom
    if gdfs["water"] is not None:
        gdfs["water"].plot(ax=ax, facecolor="#159ac8", edgecolor="#0f7a9e", linewidth=0.5, alpha=0.7)
    if gdfs["sand"] is not None:
        gdfs["sand"].plot(ax=ax, facecolor="#eee393", edgecolor="#c4ba70", linewidth=0.5, alpha=0.8)
    if gdfs["veg"] is not None:
        gdfs["veg"].plot(ax=ax, facecolor="#86ca9e", edgecolor="#63a078", linewidth=0.4, alpha=0.7)

    # Building Footprints (sharpest contrast)
    if gdfs["buildings"] is not None:
        gdfs["buildings"].plot(ax=ax, facecolor="#d0d0d0", edgecolor="#303030", linewidth=0.6, alpha=0.95)
    # Roads
    if gdfs["roads"] is not None:
        gdfs["roads"].plot(ax=ax, color="#ffee00", linewidth=1.5, alpha=0.95)

    # Rail: Heavy & Light
    if gdfs["rail"] is not None:
        heavy = gdfs["rail"][gdfs["rail"]["railway"] != "light_rail"]
        light = gdfs["rail"][gdfs["rail"]["railway"] == "light_rail"]
        if not heavy.empty:
            heavy.plot(ax=ax, color="#111111", linewidth=2.4)
            heavy.plot(ax=ax, color="#ffffff", linewidth=1.2, linestyle=":")
        if not light.empty:
            light.plot(ax=ax, color="#c4342b", linewidth=2.6, alpha=0.98)

    # Landmarks in urban core
    if gdfs["landmarks"] is not None:
        gdfs["landmarks"].plot(ax=ax, color="#ff7f00", edgecolor="#111111", linewidth=0.5, markersize=14, alpha=0.85)

    ax.set_xlim(zoom_extent[0], zoom_extent[1])
    ax.set_ylim(zoom_extent[2], zoom_extent[3])
    ax.set_title(
        "Vice City Urban Core - Derived Buildings & Transit Detail\n"
        "(Buildings: 2,152 Footprints | Crimson: Light Rail / Metro | Black/White: Heavy Rail & Yard)",
        fontsize=13, fontweight='bold', pad=12
    )

    zoom_legends = [
        Patch(facecolor="#d0d0d0", edgecolor="#303030", label="Building Footprints (2,152 Footprints)"),
        Line2D([0], [0], color="#ffee00", lw=2.5, label="Road Centerlines"),
        Line2D([0], [0], color="#c4342b", lw=3.0, label="Light Rail / Metro Line"),
        Line2D([0], [0], color="#111111", lw=3.0, ls="--", label="Heavy Rail Freight Corridors & Terminal Yard"),
        Patch(facecolor="#159ac8", edgecolor="#0f7a9e", alpha=0.7, label="Waterways, Slips & Basins"),
        Patch(facecolor="#86ca9e", edgecolor="#63a078", alpha=0.7, label="Urban Parks & Vegetation"),
        Line2D([0], [0], marker='o', color='w', markerfacecolor='#ff7f00', markersize=8, label="Landmark POIs"),
    ]
    ax.legend(handles=zoom_legends, loc="upper left", framealpha=0.92, fontsize=10)

    with open(ZOOM_OUTPUT, "wb") as f:
        plt.savefig(f, format="png", bbox_inches="tight", dpi=180)
    plt.close()
    print(f"  Saved: {ZOOM_OUTPUT}")

    print("Layer rendering complete.")


if __name__ == "__main__":
    main()
