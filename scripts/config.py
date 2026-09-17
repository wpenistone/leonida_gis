#!/usr/bin/env python3
"""
Central Configuration for State of Leonida GIS Project
======================================================
Defines all CRS definitions, coordinate boundaries, transformation formulas,
attribute defaults, and standard directories.
"""

import os

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

# Directories
LAYERS_DIR = os.path.join(PROJECT_ROOT, "layers")
SOURCES_DIR = os.path.join(PROJECT_ROOT, "sources")
SCRIPTS_DIR = os.path.join(PROJECT_ROOT, "scripts")
DERIVED_DIR = os.path.join(PROJECT_ROOT, "derived")
DERIVED_BY_COUNTY_DIR = os.path.join(DERIVED_DIR, "by_county")

PUBLICATION_DIR = os.path.join(PROJECT_ROOT, "publication")
PUB_GEOJSON_DIR = os.path.join(PUBLICATION_DIR, "geojson")
PUB_GEOJSON_BY_COUNTY_DIR = os.path.join(PUB_GEOJSON_DIR, "by_county")
PUB_SHAPEFILES_DIR = os.path.join(PUBLICATION_DIR, "shapefiles")
PUB_GEOPACKAGE_DIR = os.path.join(PUBLICATION_DIR, "geopackage")
PUB_STYLES_DIR = os.path.join(PUBLICATION_DIR, "styles")
PUB_QA_DIR = os.path.join(PUBLICATION_DIR, "qa_previews")

MASTER_GPKG_PATH = os.path.join(PUB_GEOPACKAGE_DIR, "leonida_map.gpkg")

# Canonical Work File Paths (in layers/)
WORK_ROADS_PATH = os.path.join(LAYERS_DIR, "roads.geojson")
WORK_RAIL_PATH = os.path.join(LAYERS_DIR, "rail.geojson")
WORK_SECTIONS_PATH = os.path.join(LAYERS_DIR, "sections.geojson")
WORK_RESTRICTIONS_PATH = os.path.join(LAYERS_DIR, "restrictions.geojson")
WORK_WATER_PATH = os.path.join(LAYERS_DIR, "water.geojson")
WORK_LANDMARKS_PATH = os.path.join(LAYERS_DIR, "landmarks.geojson")
WORK_WATERWAYS_PATH = os.path.join(LAYERS_DIR, "waterways.geojson")
WORK_AREAS_PATH = os.path.join(LAYERS_DIR, "areas.geojson")

DERIVED_CONTOURS_PATH = os.path.join(DERIVED_DIR, "contours.geojson")
DERIVED_BATHYMETRY_PATH = os.path.join(DERIVED_DIR, "bathymetry.geojson")
DERIVED_COASTLINE_PATH = os.path.join(DERIVED_DIR, "coastline.geojson")
DERIVED_PEAKS_PATH = os.path.join(DERIVED_DIR, "elevation_peaks.geojson")
DERIVED_BUILDINGS_PATH = os.path.join(DERIVED_DIR, "buildings.geojson")
DERIVED_WATER_PATH = os.path.join(DERIVED_DIR, "water_bodies.geojson")
DERIVED_VEGETATION_PATH = os.path.join(DERIVED_DIR, "vegetation.geojson")
DERIVED_SAND_PATH = os.path.join(DERIVED_DIR, "sand_beaches.geojson")
DERIVED_COASTAL_SHELF_PATH = os.path.join(DERIVED_DIR, "coastal_shelf.geojson")
DERIVED_LANDMASS_PATH = DERIVED_COASTAL_SHELF_PATH

RASTERS_DIR = os.path.join(PROJECT_ROOT, "rasters")
HEIGHTMAP_16BIT_PNG = os.path.join(RASTERS_DIR, "heightmap_16bit.png")
HEIGHTMAP_PREVIEW_PNG = os.path.join(RASTERS_DIR, "heightmap_preview.png")
# Raw Upstream Sources Paths (in sources/)
SECTIONS_JSON_SRC = os.path.join(SOURCES_DIR, "sections.json")
RAIL_SVG_SRC = os.path.join(SOURCES_DIR, "rail.svg")
BACKGROUND_PNG_SRC = os.path.join(SOURCES_DIR, "background_map.png")
FIGMA_SVG_SRC = os.path.join(SOURCES_DIR, "figma_vector_map.svg")

# Active map raster assets
BACKGROUND_PNG = os.path.join(RASTERS_DIR, "background_map.png")
BACKGROUND_PGW = os.path.join(RASTERS_DIR, "background_map.pgw")
BACKGROUND_WLD = os.path.join(RASTERS_DIR, "background_map.wld")
BACKGROUND_PRJ = os.path.join(RASTERS_DIR, "background_map.prj")
QGS_PROJECT = os.path.join(PROJECT_ROOT, "leonida_map_project.qgs")
QGZ_PROJECT = os.path.join(PROJECT_ROOT, "leonida_map_project.qgz")

# In-Game Coordinate System & Transformation Parameters
SCALE = 0.177424
OLD_ZERO_X = 1902.278
OLD_ZERO_Y_GIS = 1518.240

# In-Game Bounds (Meters from Origin (0, 0))
SW_X = -10721.650
SW_Y = -8557.129
NE_X = 3876.150
NE_Y = 9704.211

MAP_WIDTH_M = NE_X - SW_X    # 14597.80 m
MAP_HEIGHT_M = NE_Y - SW_Y   # 18261.34 m

RASTER_WIDTH_PX = 2590
RASTER_HEIGHT_PX = 3240

# World File Parameters for in-game metric coordinates
PIXEL_DX = 1.0 / SCALE       # +5.63621607 m/px
PIXEL_DY = -1.0 / SCALE      # -5.63621607 m/px
PIXEL_X0 = SW_X + 0.5 * PIXEL_DX  # -10718.831891965 m
PIXEL_Y0 = NE_Y + 0.5 * PIXEL_DY  # +9701.392891965 m

# In-Game CRS WKT Definition (Equirectangular planar meter grid centered at 0, 0)
CRS_WKT = (
    'PROJCS["Leonida_InGame_Metric",'
    'GEOGCS["WGS 84",'
    'DATUM["WGS_1984",'
    'SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],'
    'AUTHORITY["EPSG","6326"]],'
    'PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],'
    'UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]]],'
    'PROJECTION["Equirectangular"],'
    'PARAMETER["standard_parallel_1",0],'
    'PARAMETER["central_meridian",0],'
    'PARAMETER["false_easting",0],'
    'PARAMETER["false_northing",0],'
    'UNIT["metre",1,AUTHORITY["EPSG","9001"]],'
    'AXIS["Easting",EAST],'
    'AXIS["Northing",NORTH]]'
)

CRS_PROJ4 = "+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"

# County Taxonomy & Color Palette
COUNTIES = {
    "Vice-Dale County": {
        "color": "#e78ac3",
        "outline": "#b42878",
        "slug": "sections_vice_dale",
        "name_clean": "Vice-Dale County"
    },
    "Kelly County": {
        "color": "#f3c37b",
        "outline": "#b47828",
        "slug": "sections_kelly",
        "name_clean": "Kelly County"
    },
    "Leonard County": {
        "color": "#99c882",
        "outline": "#3c8228",
        "slug": "sections_leonard",
        "name_clean": "Leonard County"
    },
    "Lummox County": {
        "color": "#cc9966",
        "outline": "#8c461e",
        "slug": "sections_lummox",
        "name_clean": "Lummox County"
    },
    "Mariana County": {
        "color": "#66c2a5",
        "outline": "#147864",
        "slug": "sections_mariana",
        "name_clean": "Mariana County"
    },
    "Water Body": {
        "color": "#80b1d3",
        "outline": "#5078a0",
        "slug": "sections_water",
        "name_clean": "Marine Boundaries"
    }
}
