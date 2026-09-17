#!/usr/bin/env python3
"""
scripts/06_generate_qa.py
Generates visual QA verification composite render
combining the georeferenced satellite base map with all active and derived vector layers.
"""

import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import geopandas as gpd
from PIL import Image

from config import (
    PUB_GEOJSON_DIR,
    PUB_QA_DIR,
    BACKGROUND_PNG,
    SW_X, NE_X, SW_Y, NE_Y,
    COUNTIES
)

OUTPUT_FILE = os.path.join(PUB_QA_DIR, "qa_master_in_game_map.png")


def load_plot_gdf(filepath: str) -> gpd.GeoDataFrame:
    """Load a vector layer and ensure planar coordinates for direct Matplotlib rendering."""
    gdf = gpd.read_file(filepath)
    return gdf.set_crs(None, allow_override=True)


def generate_qa():
    print(">>> [Step 04] Rendering verification map in in-game metric coordinates...")
    img = Image.open(BACKGROUND_PNG)

    fig, ax = plt.subplots(figsize=(14, 17.5), dpi=150)
    ax.set_aspect('equal')

    # Base raster
    ax.imshow(img, extent=[SW_X, NE_X, SW_Y, NE_Y], origin='upper', alpha=0.92)

    # 0.5 Coastline / Landmass Outline
    coastline_path = os.path.join(PUB_GEOJSON_DIR, "coastline.geojson")
    if os.path.exists(coastline_path):
        gdf_lm_poly = load_plot_gdf(coastline_path)
        gdf_lm_poly.plot(ax=ax, facecolor="none", edgecolor="#2d5a27", linewidth=0.5, alpha=0.7)

    # 1. Water
    water_path = os.path.join(PUB_GEOJSON_DIR, "water.geojson")
    if os.path.exists(water_path):
        gdf_water = load_plot_gdf(water_path)
        gdf_water.plot(ax=ax, color="#80b1d3", alpha=0.35, edgecolor="#5078a0", linewidth=0.5, linestyle="--")

    # 2. Sections
    sections_path = os.path.join(PUB_GEOJSON_DIR, "sections.geojson")
    if os.path.exists(sections_path):
        gdf_sec = load_plot_gdf(sections_path)
        for c_name, meta in COUNTIES.items():
            subset = gdf_sec[gdf_sec["county"] == c_name]
            if not subset.empty:
                subset.plot(ax=ax, color=meta["color"], alpha=0.25, edgecolor="#222222", linewidth=0.35)

    # 2.5 OSM Areas & Landuse
    areas_path = os.path.join(PUB_GEOJSON_DIR, "areas.geojson")
    if os.path.exists(areas_path):
        gdf_areas = load_plot_gdf(areas_path)
        if not gdf_areas.empty:
            gdf_areas.plot(ax=ax, color="#c8facc", alpha=0.35, edgecolor="#8ad3a6", linewidth=0.5)

    # 2.8 Buildings Footprints
    bldg_path = os.path.join(PUB_GEOJSON_DIR, "buildings.geojson")
    if os.path.exists(bldg_path):
        gdf_bldg = load_plot_gdf(bldg_path)
        if not gdf_bldg.empty:
            gdf_bldg.plot(ax=ax, facecolor="#c3c3c3", edgecolor="#444444", linewidth=0.25, alpha=0.85)

    # 3. County Boundaries
    counties_path = os.path.join(PUB_GEOJSON_DIR, "counties.geojson")
    if os.path.exists(counties_path):
        gdf_cnt = load_plot_gdf(counties_path)
        gdf_cnt.plot(ax=ax, facecolor="none", edgecolor="#000000", linewidth=1.6, linestyle="--")

    # 3.5 Elevation Contours
    contours_path = os.path.join(PUB_GEOJSON_DIR, "contours.geojson")
    if os.path.exists(contours_path):
        gdf_ct = load_plot_gdf(contours_path)
        if not gdf_ct.empty:
            gdf_ct.plot(ax=ax, color="#b17158", linewidth=0.26, alpha=0.75)

    # 4. Roads
    roads_path = os.path.join(PUB_GEOJSON_DIR, "roads.geojson")
    if os.path.exists(roads_path):
        gdf_roads = load_plot_gdf(roads_path)
        gdf_roads.plot(ax=ax, color="#ffee00", linewidth=0.85, alpha=0.9)

    # 5. Railways (Heavy Rail & Light Rail)
    rail_path = os.path.join(PUB_GEOJSON_DIR, "rail.geojson")
    if os.path.exists(rail_path):
        gdf_rail = load_plot_gdf(rail_path)
        heavy = gdf_rail[gdf_rail["railway"] != "light_rail"]
        light = gdf_rail[gdf_rail["railway"] == "light_rail"]
        if not heavy.empty:
            heavy.plot(ax=ax, color="#111111", linewidth=1.6)
            heavy.plot(ax=ax, color="#ffffff", linewidth=0.8, linestyle=":")
        if not light.empty:
            light.plot(ax=ax, color="#c4342b", linewidth=1.8, alpha=0.95)

    # 5.5 Waterways
    waterways_path = os.path.join(PUB_GEOJSON_DIR, "waterways.geojson")
    if os.path.exists(waterways_path):
        gdf_ww = load_plot_gdf(waterways_path)
        if not gdf_ww.empty:
            gdf_ww.plot(ax=ax, color="#1e90ff", linewidth=1.2, alpha=0.9)

    # 6. Turn Restrictions
    restr_path = os.path.join(PUB_GEOJSON_DIR, "restrictions.geojson")
    if os.path.exists(restr_path):
        gdf_restr = load_plot_gdf(restr_path)
        if not gdf_restr.empty:
            gdf_restr.plot(ax=ax, color="#e61e1e", edgecolor="#ffffff", linewidth=1.0, markersize=45)

    # 7. GTADB Landmarks
    landmarks_path = os.path.join(PUB_GEOJSON_DIR, "landmarks.geojson")
    if os.path.exists(landmarks_path):
        gdf_lm = load_plot_gdf(landmarks_path)
        if not gdf_lm.empty:
            gdf_lm.plot(ax=ax, color="#ff7f00", edgecolor="#333333", linewidth=0.4, markersize=8, alpha=0.75)

    # 8. Mountain Summits & Peaks (DEM)
    peaks_path = os.path.join(PUB_GEOJSON_DIR, "elevation_peaks.geojson")
    if os.path.exists(peaks_path):
        gdf_pk = load_plot_gdf(peaks_path)
        if not gdf_pk.empty:
            gdf_pk.plot(ax=ax, color="#8b4513", edgecolor="#000000", linewidth=0.5, marker="^", markersize=36, alpha=0.9)

    ax.set_xlim(SW_X, NE_X)
    ax.set_ylim(SW_Y, NE_Y)
    ax.set_title("State of Leonida GIS - In-Game Metric Coordinate Frame\n(SW: -10721.65, -8557.13 | NE: +3876.15, +9704.21 | 1 Unit = 1 Meter)", 
                 fontsize=13, fontweight='bold', pad=12)

    os.makedirs(PUB_QA_DIR, exist_ok=True)
    with open(OUTPUT_FILE, "wb") as f:
        plt.savefig(f, format="png", bbox_inches="tight", dpi=150)
    plt.close()
    print(f"  Saved QA verification render: {OUTPUT_FILE}")


if __name__ == "__main__":
    generate_qa()
