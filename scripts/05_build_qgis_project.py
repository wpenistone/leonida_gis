#!/usr/bin/env python3
"""
Leonida GIS - Build Master QGIS Project (.qgs and .qgz)
Generates the master QGIS project file structure.
Removes legacy/obsolete layers and organizes the workspace into:
  1. Editable Work Layers (Restrictions, Landmarks, Roads, Rail, Waterways, Landuse)
  2. Administrative Boundaries (County Boundaries, Administrative Sections)
  3. Base Cartography (Buildings, Vegetation, Sand, Water Canals, Named Sea/Lakes, Shelf)
  4. Topography & Elevation (Mountain Peaks, 50m Contours, Coastline)
  5. Basemaps & Rasters (Hillshade Drape, GTA 6 Satellite, 16-bit DEM)
"""

import os
import shutil
import zipfile
import xml.etree.ElementTree as ET
from xml.dom import minidom
from config import (
    PROJECT_ROOT, QGS_PROJECT, QGZ_PROJECT,
    SW_X, SW_Y, NE_X, NE_Y, CRS_WKT
)

# ============================================================================
# Zoom-Level (Scale Visibility) & Labeling Configuration
# ---------------------------------------------------------------------------
# Scale denominators. Full canvas extent renders at roughly 1:35,000, so:
#   min_scale = 0        -> visible at every zoom level
#   min_scale = N        -> visible ONLY when zoomed in past 1:N (denominator < N)
# Labels additionally carry their own per-layer scale range and render as
# proper QGIS 3 "simple labeling" (the legacy 2.x blocks inside the QMLs are
# stripped and replaced at build time).
# ============================================================================
LAYER_CONFIG = {
    # --- 1. Editable Work Layers ---
    "work_restrictions":    {"min_scale": 20000,   "opacity": 1.0,  "label": {"field": "restriction", "placement": "point", "min_scale": 10000,  "size": 8.0, "bold": True,  "color": "170,0,0,255",       "priority": 9}},
    "work_landmarks":       {"min_scale": 250000,  "opacity": 1.0,  "label": {"expr": "coalesce(\"name\", \"real_name\")", "placement": "point",   "min_scale": 25000, "size": 9.5, "bold": True,  "color": "80,40,0,255",       "priority": 4, "limit": 500}},
    "work_roads_network":   {"min_scale": 0,       "opacity": 1.0,  "label": {"field": "name", "placement": "line",    "min_scale": 100000, "size": 8.5, "bold": True,  "color": "50,50,50,255",      "priority": 8}},
    "work_rail_network":    {"min_scale": 0,       "opacity": 1.0,  "label": {"field": "name", "placement": "line",    "min_scale": 100000, "size": 8.0, "bold": True,  "color": "30,30,30,255",      "priority": 6}},
    "work_waterways":       {"min_scale": 100000,  "opacity": 1.0,  "label": {"field": "name", "placement": "line",    "min_scale": 100000, "size": 8.0, "bold": False, "color": "20,60,120,255",     "priority": 3}},
    "work_areas_landuse":   {"min_scale": 100000,  "opacity": 0.55, "label": {"field": "name", "placement": "polygon", "min_scale": 100000, "size": 8.0, "bold": False, "color": "70,90,60,255",      "priority": 2}},

    # --- 2. Administrative Boundaries ---
    "carto_counties":       {"min_scale": 0,       "opacity": 1.0,  "label": {"field": "county", "placement": "polygon", "min_scale": 7500, "size": 12.0, "bold": True, "color": "0,0,0,255",      "priority": 1, "buffer": "255,255,255,200"}},
    "admin_sections":       {"min_scale": 150000,  "opacity": 0.35, "label": {"field": "name", "placement": "polygon", "min_scale": 7500, "size": 9.0, "bold": True,  "color": "25,25,25,255",      "priority": 2}},

    # --- 3. Base Cartography ---
    "carto_buildings":      {"min_scale": 80000,   "opacity": 0.85, "label": None},
    "carto_vegetation":     {"min_scale": 120000,  "opacity": 0.50, "label": None},
    "carto_sand_beaches":   {"min_scale": 120000,  "opacity": 0.60, "label": None},
    "carto_water":          {"min_scale": 0,       "opacity": 0.70, "label": None},
    "carto_sea_lakes":      {"min_scale": 0,       "opacity": 0.35, "label": {"field": "name", "placement": "polygon", "min_scale": 400000, "size": 10.0, "bold": True, "color": "20,60,120,255",     "priority": 3}},
    "carto_coastal_shelf":  {"min_scale": 200000, "opacity": 0.30, "label": None},

    # --- 4. Topography ---
    "topo_peaks_summits":   {"min_scale": 0,       "opacity": 1.0,  "label": {"expr": "concat(\"name\", ' (', \"elevation_m\", ' m)')", "placement": "point", "min_scale": 50000, "size": 8.5, "bold": True, "color": "74,44,20,255", "priority": 5}},
    "topo_contours":        {"min_scale": 150000,  "opacity": 0.75, "label": {"expr": "format_number(\"elevation_m\", 1) || ' m'", "placement": "line", "min_scale": 1000,  "size": 7.5, "bold": True,  "color": "130,85,60,255",     "priority": 4}},
    "topo_bathymetry":      {"min_scale": 150000,  "opacity": 0.75, "label": {"expr": "format_number(\"depth_m\", 1) || ' m'", "placement": "line", "min_scale": 1000,  "size": 7.0, "bold": True,  "color": "15,65,105,255",     "priority": 3}},
    "topo_coastline":       {"min_scale": 0,       "opacity": 1.0,  "label": None},

    # --- 5. Rasters ---
    "raster_relief":        {"min_scale": 0,       "opacity": 0.60, "label": None, "blend": 5},  # 5 = QgsBlendMode.Multiply drape over satellite
    "raster_background":    {"min_scale": 0,       "opacity": 1.0,  "label": None, "blend": 0},
    "raster_dem_elevation": {"min_scale": 0,       "opacity": 1.0,  "label": None},
}

# Predefined project zoom scales (snaps Leonida scale bar in QGIS)
PREDEFINED_SCALES = [500, 1000, 2500, 5000, 10000, 20000, 35000, 75000, 100000]

EPSG_4087_WKT = (
    'PROJCRS["WGS 84 / World Equidistant Cylindrical",'
    'BASEGEOGCRS["WGS 84",'
    'ENSEMBLE["World Geodetic System 1984 ensemble",'
    'MEMBER["World Geodetic System 1984 (Transit)"],'
    'MEMBER["World Geodetic System 1984 (G730)"],'
    'MEMBER["World Geodetic System 1984 (G873)"],'
    'MEMBER["World Geodetic System 1984 (G1150)"],'
    'MEMBER["World Geodetic System 1984 (G1674)"],'
    'MEMBER["World Geodetic System 1984 (G1762)"],'
    'MEMBER["World Geodetic System 1984 (G2139)"],'
    'MEMBER["World Geodetic System 1984 (G2296)"],'
    'ELLIPSOID["WGS 84",6378137,298.257223563,LENGTHUNIT["metre",1]],'
    'ENSEMBLEACCURACY[2.0]],'
    'PRIMEM["Greenwich",0,ANGLEUNIT["degree",0.0174532925199433]],'
    'ID["EPSG",4326]],'
    'CONVERSION["World Equidistant Cylindrical",'
    'METHOD["Equidistant Cylindrical",ID["EPSG",1028]],'
    'PARAMETER["Latitude of 1st standard parallel",0,ANGLEUNIT["degree",0.0174532925199433],ID["EPSG",8823]],'
    'PARAMETER["Longitude of natural origin",0,ANGLEUNIT["degree",0.0174532925199433],ID["EPSG",8802]],'
    'PARAMETER["False easting",0,LENGTHUNIT["metre",1],ID["EPSG",8806]],'
    'PARAMETER["False northing",0,LENGTHUNIT["metre",1],ID["EPSG",8807]]],'
    'CS[Cartesian,2],'
    'AXIS["easting (X)",east,ORDER[1],LENGTHUNIT["metre",1]],'
    'AXIS["northing (Y)",north,ORDER[2],LENGTHUNIT["metre",1]],'
    'USAGE[SCOPE["Graticule coordinates expressed in simple Cartesian form."],'
    'AREA["World."],BBOX[-90,-180,90,180]],ID["EPSG",4087]]'
)


def build_labeling_xml(cfg):
    """Generate QGIS 3.x native simple-labeling XML for a layer's label config."""
    placement = cfg["placement"]
    layer_type = {"line": "LineString", "point": "Point", "polygon": "Polygon"}[placement]
    field = cfg.get("expr")
    is_expr = 1 if field is not None else 0
    if field is None:
        field = cfg["field"]

    labeling = ET.Element("labeling", {"type": "simple"})
    settings = ET.SubElement(labeling, "settings", {"calloutType": "simpleRect"})
    text_style = ET.SubElement(settings, "text-style", {
        "fontFamily": "Segoe UI", "fontSize": str(cfg.get("size", 8.5)),
        "fontSizeUnit": "Point", "fontBold": "1" if cfg.get("bold") else "0",
        "fontItalic": "0", "fontUnderline": "0", "fontStrikeout": "0",
        "textColor": cfg.get("color", "25,25,25,255"),
        "fieldName": field, "isExpression": str(is_expr),
        "textOrientation": "horizontal", "blendMode": "0",
        "multilineHeight": "1", "useSubstitutions": "0", "fontCapitals": "0",
        "previewBkgrdColor": "255,255,255,255",
    })
    ET.SubElement(text_style, "text-buffer", {
        "bufferDraw": "1", "bufferSize": str(cfg.get("buffer_size", 1.0)),
        "bufferSizeUnits": "MM", "bufferColor": cfg.get("buffer", "255,255,255,230"),
        "bufferOpacity": "1", "bufferJoinStyle": "128", "bufferNoFill": "1",
        "bufferBlendMode": "0",
    })
    ET.SubElement(settings, "text-format", {
        "plussign": "0", "wrapChar": "", "multilineAlign": "3",
        "addDirectionSymbol": "0", "autoWrapLength": "0",
        "useMaxLineLengthForAutoWrap": "1", "reverseDirectionLine": "0",
        "formatNumbers": "0", "decimals": "3",
    })
    pl_code = "2" if placement == "line" else "0"
    pl_flags = "9" if placement == "line" else "10"
    repeat_val = str(cfg.get("repeat", 120)) if placement == "line" else "0"

    ET.SubElement(settings, "placement", {
        "placement": pl_code,
        "layerType": "LineGeometry" if placement == "line" else ("PointGeometry" if placement == "point" else "PolygonGeometry"),
        "placementFlags": pl_flags,
        "dist": "1" if placement == "point" else "0", "distUnits": "MM",
        "xOffset": "0", "yOffset": "0", "rotationAngle": "0",
        "quadOffset": "4", "offsetType": "0", "preserveRotation": "1",
        "maxCurvedCharAngleIn": "25", "maxCurvedCharAngleOut": "25",
        "priority": str(cfg.get("priority", 5)), "centroidWhole": "0",
        "centroidInside": "1" if placement == "polygon" else "0",
        "fitInPolygonOnly": "0", "repeatDistance": repeat_val,
        "repeatDistanceUnits": "MM", "overrunDistance": "0",
        "overrunDistanceUnit": "MM", "labelOffsetMapUnitScale": "3x:0,0,0,0,0,0",
        "distMapUnitScale": "3x:0,0,0,0,0,0",
    })
    ET.SubElement(settings, "rendering", {
        "drawLabels": "1", "scaleVisibility": "1" if cfg.get("min_scale") else "0",
        "scaleMax": str(cfg.get("min_scale", 0)), "scaleMin": "0",
        "minScale": str(cfg.get("min_scale", 0)), "maxScale": "0",
        "limit": str(cfg.get("limit", 500)), "displayAll": "0",
        "obstacle": "1", "obstacleType": "1", "obstacleFactor": "1",
        "mergeLines": "1" if placement == "line" else "0",
        "labelPerPart": "0", "upsidedownLabels": "0", "zIndex": "0",
        "fontLimitPixel": "0", "fontMinPixel": "2",
    })
    return labeling


def build_qgis_project():
    print(">>> Building master QGIS project with layer hierarchy...")

    # Layer specifications
    # (id, name, datasource, style_qml, checked, group, provider)
    layer_specs = [
        # --- 1. Editable Work Layers (Active Digitizing) ---
        ("work_restrictions", "Turn Restrictions", "./layers/restrictions.geojson", "./styles/restrictions.qml", "0", "Editable Work Layers", "ogr"),
        ("work_landmarks", "GTADB Landmarks and POIs", "./layers/landmarks.geojson", "./styles/landmarks.qml", "0", "Editable Work Layers", "ogr"),
        ("work_roads_network", "Road Network", "./layers/roads.geojson", "./styles/roads.qml", "1", "Editable Work Layers", "ogr"),
        ("work_rail_network", "Rail Network", "./layers/rail.geojson", "./styles/rail.qml", "1", "Editable Work Layers", "ogr"),
        ("work_waterways", "Waterways & Hydrology", "./layers/waterways.geojson|geometrytype=LineString", "./styles/waterways.qml", "1", "Editable Work Layers", "ogr"),
        ("work_areas_landuse", "OSM Areas & Landuse", "./layers/areas.geojson|geometrytype=Polygon", "./styles/areas.qml", "0", "Editable Work Layers", "ogr"),

        # --- 2. Administrative Boundaries ---
        ("carto_counties", "County Boundaries", "./derived/counties_dissolved.geojson", "./styles/counties.qml", "1", "Administrative Boundaries", "ogr"),
        ("admin_sections", "Administrative Sections", "./layers/sections.geojson", "./styles/sections.qml", "0", "Administrative Boundaries", "ogr"),

        # --- 3. Base Cartography (Vector Reference) ---
        ("carto_buildings", "Buildings", "./derived/buildings.geojson", "./styles/buildings.qml", "1", "Base Cartography", "ogr"),
        ("carto_vegetation", "Parks & Vegetation", "./derived/vegetation.geojson", "./styles/vegetation.qml", "1", "Base Cartography", "ogr"),
        ("carto_sand_beaches", "Beaches & Coastal Sand", "./derived/sand_beaches.geojson", "./styles/sand_beaches.qml", "1", "Base Cartography", "ogr"),
        ("carto_water", "Water Bodies & Canals", "./derived/water_bodies.geojson", "./styles/water_bodies.qml", "1", "Base Cartography", "ogr"),
        ("carto_sea_lakes", "Named Sea & Lakes", "./layers/water.geojson", "./styles/water.qml", "0", "Base Cartography", "ogr"),
        ("carto_coastal_shelf", "Coastal Shelf Extent", "./derived/coastal_shelf.geojson", "./styles/coastal_shelf.qml", "0", "Base Cartography", "ogr"),

        # --- 4. Topography & Elevation (Vector) ---
        ("topo_peaks_summits", "Mountain Peaks & Summits", "./derived/elevation_peaks.geojson", "./styles/elevation_peaks.qml", "1", "Topography & Elevation", "ogr"),
        ("topo_contours", "Elevation Contours", "./derived/contours.gpkg|layername=contours", "./styles/contours.qml", "1", "Topography & Elevation", "ogr"),
        ("topo_bathymetry", "Bathymetry Contours", "./derived/bathymetry.gpkg|layername=bathymetry", "./styles/bathymetry.qml", "0", "Topography & Elevation", "ogr"),
        ("topo_coastline", "Coastline", "./derived/coastline.geojson", "./styles/coastline.qml", "0", "Topography & Elevation", "ogr"),

        # --- 5. Basemaps & Rasters ---
        ("raster_relief", "Hillshade Relief", "./rasters/heightmap_preview.png", "./styles/relief.qml", "1", "Basemaps & Rasters", "gdal"),
        ("raster_background", "GTA 6 Satellite Map", "./rasters/background_map.png", "", "1", "Basemaps & Rasters", "gdal"),
        ("raster_dem_elevation", "Elevation DEM", "./rasters/heightmap_16bit.png", "./styles/dem_elevation.qml", "0", "Basemaps & Rasters", "gdal"),
    ]

    qgis_elem = ET.Element("qgis", {
        "projectname": "Leonida GIS",
        "version": "3.34.0"
    })

    home = ET.SubElement(qgis_elem, "homePath")
    home.set("path", "")

    title = ET.SubElement(qgis_elem, "title")
    title.text = "Leonida GIS"

    autotx = ET.SubElement(qgis_elem, "autotransaction")
    autotx.set("active", "0")

    pcrs = ET.SubElement(qgis_elem, "projectCrs")
    srs = ET.SubElement(pcrs, "spatialrefsys", {"nativeFormat": "Wkt"})
    ET.SubElement(srs, "wkt").text = EPSG_4087_WKT
    ET.SubElement(srs, "proj4").text = "+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
    ET.SubElement(srs, "srsid").text = "60036"
    ET.SubElement(srs, "srid").text = "520000036"
    ET.SubElement(srs, "authid").text = "EPSG:4087"
    ET.SubElement(srs, "description").text = "WGS 84 / World Equidistant Cylindrical"
    ET.SubElement(srs, "projectionacronym").text = "eqc"
    ET.SubElement(srs, "ellipsoidacronym").text = "EPSG:7030"
    ET.SubElement(srs, "geographicflag").text = "false"

    # Layer Tree Root
    tree_root = ET.SubElement(qgis_elem, "layer-tree-group")
    ET.SubElement(tree_root, "customproperties")

    # Read existing map canvas viewport and layer visibility if available to preserve user's state
    cur_extent = None
    prev_checked = {}
    if os.path.exists(QGS_PROJECT):
        try:
            prev_tree = ET.parse(QGS_PROJECT)
            prev_mc = prev_tree.find(".//mapcanvas[@name='theMapCanvas']/extent")
            if prev_mc is not None and prev_mc.findtext("xmin"):
                cur_extent = {
                    "xmin": prev_mc.findtext("xmin"),
                    "ymin": prev_mc.findtext("ymin"),
                    "xmax": prev_mc.findtext("xmax"),
                    "ymax": prev_mc.findtext("ymax"),
                }
            for ltl in prev_tree.findall(".//layer-tree-layer"):
                ltl_id = ltl.get("id")
                ltl_chk = ltl.get("checked")
                if ltl_id and ltl_chk:
                    prev_checked[ltl_id] = ltl_chk
        except Exception:
            pass

    # Groups in order of display: Work Layers at top, Rasters at bottom
    groups = {
        "Editable Work Layers": ET.SubElement(tree_root, "layer-tree-group", {"name": "Editable Work Layers", "checked": "Qt::Checked", "expanded": "1"}),
        "Administrative Boundaries": ET.SubElement(tree_root, "layer-tree-group", {"name": "Administrative Boundaries", "checked": "Qt::Checked", "expanded": "1"}),
        "Base Cartography": ET.SubElement(tree_root, "layer-tree-group", {"name": "Base Cartography", "checked": "Qt::Checked", "expanded": "1"}),
        "Topography & Elevation": ET.SubElement(tree_root, "layer-tree-group", {"name": "Topography & Elevation", "checked": "Qt::Checked", "expanded": "1"}),
        "Basemaps & Rasters": ET.SubElement(tree_root, "layer-tree-group", {"name": "Basemaps & Rasters", "checked": "Qt::Checked", "expanded": "1"}),
    }

    # Map Canvas Settings
    canvas = ET.SubElement(qgis_elem, "mapcanvas", {"name": "theMapCanvas"})
    ET.SubElement(canvas, "units").text = "meters"
    extent = ET.SubElement(canvas, "extent")
    ET.SubElement(extent, "xmin").text = cur_extent["xmin"] if cur_extent else str(SW_X)
    ET.SubElement(extent, "ymin").text = cur_extent["ymin"] if cur_extent else str(SW_Y)
    ET.SubElement(extent, "xmax").text = cur_extent["xmax"] if cur_extent else str(NE_X)
    ET.SubElement(extent, "ymax").text = cur_extent["ymax"] if cur_extent else str(NE_Y)

    # Project Properties (Pure Black Canvas Background Color #000000)
    # NOTE: This must be the ONLY <properties> element in the project file.
    # QGIS 3.x reads project settings from a single <properties> block; a second
    # duplicate block breaks the project-CRS parse (canvas falls back to unknown
    # units and scale readouts render as billions). All later property groups
    # (Scales, SpatialRefSys) are appended to this same element.
    props_elem = ET.SubElement(qgis_elem, "properties")
    gui_elem = ET.SubElement(props_elem, "Gui")
    ET.SubElement(gui_elem, "CanvasColorRedPart", {"type": "int"}).text = "0"
    ET.SubElement(gui_elem, "CanvasColorGreenPart", {"type": "int"}).text = "0"
    ET.SubElement(gui_elem, "CanvasColorBluePart", {"type": "int"}).text = "0"
    ET.SubElement(gui_elem, "SelectionColorRedPart", {"type": "int"}).text = "255"
    ET.SubElement(gui_elem, "SelectionColorGreenPart", {"type": "int"}).text = "255"
    ET.SubElement(gui_elem, "SelectionColorBluePart", {"type": "int"}).text = "0"
    ET.SubElement(gui_elem, "SelectionColorAlphaPart", {"type": "int"}).text = "255"

    # Project View Settings (Sets default extent to full Leonida map & predefined scales)
    pview = ET.SubElement(qgis_elem, "ProjectViewSettings", {"UseProjectScales": "1", "rotation": "0"})
    scales_elem = ET.SubElement(pview, "Scales")
    for s in PREDEFINED_SCALES:
        ET.SubElement(scales_elem, "Scale", {"Value": str(s)})
    dextent = ET.SubElement(pview, "DefaultViewExtent", {
        "xmin": str(SW_X), "ymin": str(SW_Y), "xmax": str(NE_X), "ymax": str(NE_Y)
    })
    desrs = ET.SubElement(dextent, "spatialrefsys", {"nativeFormat": "Wkt"})
    ET.SubElement(desrs, "wkt").text = EPSG_4087_WKT
    ET.SubElement(desrs, "proj4").text = "+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
    ET.SubElement(desrs, "srsid").text = "60036"
    ET.SubElement(desrs, "srid").text = "520000036"
    ET.SubElement(desrs, "authid").text = "EPSG:4087"
    ET.SubElement(desrs, "description").text = "WGS 84 / World Equidistant Cylindrical"
    ET.SubElement(desrs, "projectionacronym").text = "eqc"
    ET.SubElement(desrs, "ellipsoidacronym").text = "EPSG:7030"
    ET.SubElement(desrs, "geographicflag").text = "false"

    # Snapping Settings - Advanced per-layer snapping:
    # Snaps ONLY to active human work layers (roads, rail, restrictions, waterways, landmarks).
    # Snapping to topological/cartographic layers (contours, bathymetry, buildings, vegetation) is strictly disabled.
    snap_elem = ET.SubElement(qgis_elem, "snapping-settings", {
        "enabled": "1",
        "mode": "3", # Advanced Configuration (snaps only to checked work layers)
        "type": "3", # VertexAndSegment
        "tolerance": "15.0",
        "unit": "1", # ProjectUnits (meters)
        "intersection-snapping": "1",
        "topological-editing": "0"
    })
    indiv_snap = ET.SubElement(snap_elem, "individual-layer-settings")
    work_layer_ids = {
        "work_roads_network", "work_rail_network", "work_restrictions",
        "work_waterways", "work_landmarks", "work_areas_landuse"
    }
    for spec_id, _, _, _, _, _, prov in layer_specs:
        if prov != "gdal":
            is_work = spec_id in work_layer_ids
            ET.SubElement(indiv_snap, "layer-setting", {
                "id": spec_id,
                "enabled": "1" if is_work else "0",
                "type": "3" if is_work else "0",
                "tolerance": "15.0" if is_work else "0.0",
                "units": "1",
                "minScale": "0",
                "maxScale": "0"
            })

    # Maplayers container
    maplayers = ET.SubElement(qgis_elem, "projectlayers")

    # Project-wide predefined scales (Project Properties -> General -> Project scales;
    # shown in the map canvas scale selector dropdown). Appended to the single
    # <properties> block created above (do NOT create a second block here).
    props = props_elem
    scales_root = ET.SubElement(props, "Scales")
    scales_list = ET.SubElement(scales_root, "Scales", {"type": "QStringList"})
    for s in PREDEFINED_SCALES:
        ET.SubElement(scales_list, "value").text = f"1:{s}"
    srs_prop = ET.SubElement(props, "SpatialRefSys")
    ET.SubElement(srs_prop, "ProjectionsEnabled", {"type": "int"}).text = "1"

    for lid, lname, datasource, qml_rel, checked, grp_name, provider in layer_specs:
        grp_elem = groups[grp_name]
        ET.SubElement(grp_elem, "layer-tree-layer", {
            "id": lid,
            "name": lname,
            "providerKey": provider,
            "source": datasource,
            "checked": prev_checked.get(lid, "Qt::Checked" if checked == "1" else "Qt::Unchecked"),
            "expanded": "0",
            "patch_size": "0,0",
            "legend_split_behavior": "0",
            "legend_exp": ""
        })

        is_raster = (provider == "gdal")
        cfg = LAYER_CONFIG.get(lid, {})
        mlyr = ET.SubElement(maplayers, "maplayer", {
            "type": "raster" if is_raster else "vector",
            "wkt": EPSG_4087_WKT,
            "readOnly": "0" if not is_raster and "work_" in lid else "1",
            "hasScaleBasedVisibilityFlag": "1" if cfg.get("min_scale") else "0",
            "minScale": str(cfg.get("min_scale") or 100000000),
            "maxScale": "0",
            "labelsEnabled": "1" if cfg.get("label") else "0",
        })
        if not is_raster:
            if any(k in lid for k in ["road", "rail", "contour", "coastline", "waterway"]):
                geom_type = "Line"
            elif any(k in lid for k in ["restriction", "landmark", "peak", "node", "point"]):
                geom_type = "Point"
            else:
                geom_type = "Polygon"
            mlyr.set("geometry", geom_type)

        ET.SubElement(mlyr, "id").text = lid
        ET.SubElement(mlyr, "datasource").text = datasource
        ET.SubElement(mlyr, "layername").text = lname
        # QGS canonical token is <provider> (QgsProject reads it to construct the
        # layer); <providerKey> in the maplayer body makes raster readers fall back
        # to a GDAL file-path guess. Layer-tree <providerKey> above is correct.
        ET.SubElement(mlyr, "provider").text = provider

        lyr_srs = ET.SubElement(mlyr, "srs")
        srs_clone = ET.SubElement(lyr_srs, "spatialrefsys", {"nativeFormat": "Wkt"})
        ET.SubElement(srs_clone, "wkt").text = EPSG_4087_WKT
        ET.SubElement(srs_clone, "proj4").text = "+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
        ET.SubElement(srs_clone, "srsid").text = "60036"
        ET.SubElement(srs_clone, "srid").text = "520000036"
        ET.SubElement(srs_clone, "authid").text = "EPSG:4087"
        ET.SubElement(srs_clone, "description").text = "WGS 84 / World Equidistant Cylindrical"
        ET.SubElement(srs_clone, "projectionacronym").text = "eqc"
        ET.SubElement(srs_clone, "ellipsoidacronym").text = "EPSG:7030"
        ET.SubElement(srs_clone, "geographicflag").text = "false"
        lyr_extent = ET.SubElement(mlyr, "extent")
        ET.SubElement(lyr_extent, "xmin").text = str(SW_X)
        ET.SubElement(lyr_extent, "ymin").text = str(SW_Y)
        ET.SubElement(lyr_extent, "xmax").text = str(NE_X)
        ET.SubElement(lyr_extent, "ymax").text = str(NE_Y)

        # Inject Style XML if present
        if qml_rel:
            qml_abs = os.path.join(PROJECT_ROOT, qml_rel.lstrip("./"))
            if os.path.exists(qml_abs):
                try:
                    qml_tree = ET.parse(qml_abs)
                    qml_root = qml_tree.getroot()
                    for child in qml_root:
                        mlyr.append(child)
                except Exception as e:
                    print(f"    Notice: could not embed {qml_rel}: {e}")

        # Replace legacy QGIS 2.x labeling blocks with QGIS 3 native labeling
        for legacy in mlyr.findall("labeling"):
            mlyr.remove(legacy)
        if cfg.get("label"):
            mlyr.append(build_labeling_xml(cfg["label"]))

        # Opacity & blend modes (vector layerOpacity and raster blend/opacity)
        for elem in mlyr.findall("layerOpacity"):
            mlyr.remove(elem)
        for elem in mlyr.findall("blendMode"):
            mlyr.remove(elem)

        opacity_val = cfg.get("opacity", 1.0)
        blend_val = cfg.get("blend", 0)
        ET.SubElement(mlyr, "layerOpacity").text = str(opacity_val)
        ET.SubElement(mlyr, "blendMode").text = str(blend_val)
        if is_raster:
            mlyr.set("opacity", str(opacity_val))

    # Format XML nicely
    xml_str = ET.tostring(qgis_elem, encoding="utf-8")
    dom = minidom.parseString(xml_str)
    pretty_xml = dom.toprettyxml(indent="  ", encoding="utf-8")

    # Preserve backup of existing project
    if os.path.exists(QGS_PROJECT):
        try:
            shutil.copyfile(QGS_PROJECT, QGS_PROJECT + "~")
        except Exception:
            pass

    with open(QGS_PROJECT, "wb") as f:
        f.write(pretty_xml)
    print(f"  Saved master QGIS project: {QGS_PROJECT}")

    # Pack into .qgz
    with zipfile.ZipFile(QGZ_PROJECT, "w", zipfile.ZIP_DEFLATED) as zf:
        zf.write(QGS_PROJECT, os.path.basename(QGS_PROJECT))
    print(f"  Created QGIS project bundle: {QGZ_PROJECT}")

if __name__ == "__main__":
    build_qgis_project()
