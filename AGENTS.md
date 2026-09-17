# State of Leonida GIS — Master Architecture & Agent Guidelines

This document is the authoritative, comprehensive technical specification and operational guide for the **State of Leonida GIS** project. All agents working on this codebase must adhere strictly to these conventions, architectures, and guidelines.

---

## 1. Project Overview & Vision

**State of Leonida GIS** is a collaborative, professional-grade Geographic Information System (GIS) project reconstructing the entire fictional state of Leonida (Grand Theft Auto VI) into an OpenStreetMap-compliant vector network and cartographic stack.

### Key Capabilities & Deliverables
* **Full Multi-Modal Transportation Network:** Routable road network, heavy passenger/freight rail, light rail transit, and navigable hydrological waterways.
* **Topography & Elevation Modeling:** Sub-meter accuracy derived from a 16-bit DEM heightmap (Mount Kalaga at $800\text{ m}$ to sea level at $0\text{ m}$).
* **Administrative Subdivisions:** 5 dissolved official counties and 92 administrative sections/localities across 4 OSM administrative tiers.
* **Points of Interest & Land Cover:** 2,318 curated GTADB landmarks and complete polygon landcover (building footprints, vegetation, beaches, water bodies, coastal shelves).
* **Multi-Format Distribution:** Master QGIS 3.x project (`.qgz`/`.qgs`), OGC GeoPackages (`.gpkg`) with SQLite R-Tree spatial indexing, ESRI Shapefiles with sidecar QML styles, and canonical GeoJSONs.

---

## 2. Global Environment & Tooling Rules

* **Package Manager:** **Always use `bun`**. Never use `npm` under any circumstance.
* **Shell Environment:** Windows PowerShell (`pwsh`). Never propose `cd` commands; execute all commands relative to the workspace root.
* **Markdown Formatting:** Format all file references with clickable links using the `file:///` scheme (e.g. `[roads.geojson](file:///C:/Users/kanal/Downloads/Projects/leonida_gis/layers/roads.geojson)`).
* **Coordinate Precision:** All geographic coordinates in GeoJSON work files are stored in in-game metric meters rounded to **2 decimal places** ($1\text{ cm}$ spatial precision).

---

## 3. Coordinate Reference System (CRS) & Spatial Bounds

The project operates in **native in-game metric planar coordinates** centered on the game world's coordinate origin $(0, 0)$.

### Spatial Specification
* **Projected CRS:** Equirectangular Planar Meter Grid (`EPSG:4087` / `Leonida_InGame_Metric`).
* **Origin:** $(0.00, 0.00)$ meters.
* **Project Bounding Extents:**
  * **South-West Corner:** $X = -10721.65\text{ m}, \quad Y = -8557.13\text{ m}$
  * **North-East Corner:** $X = +3876.15\text{ m}, \quad Y = +9704.21\text{ m}$
  * **Total Bounding Dimensions:** Width $\approx 14.60\text{ km}$, Height $\approx 18.26\text{ km}$
* **Aerial Raster Basemap Resolution:** Isotropic $5.6362\text{ m/pixel}$ ($2590 \times 3240\text{ px}$).
* **WGS 84 Reprojection (`EPSG:4326`):** Handled via standard PROJ/GDAL pipelines for GPS latitude/longitude cross-referencing:
  $$\text{Lon} = \frac{X}{R \cdot \cos(\text{lat\_ts})}, \quad \text{Lat} = \frac{Y}{R} \quad (R = 6,378,137\text{ m}, \; \text{lat\_ts} = 0^\circ)$$

---

## 4. Repository Architecture & Layer Purity

The repository enforces a strict separation between **canonical human-edited source layers** and **automatically generated derived layers**.

```
leonida_gis/
├── layers/                           # Canonical human-edited vector layers (SINGLE SOURCE OF TRUTH)
│   ├── roads.geojson                 # Active road network (OSM highway taxonomy)
│   ├── rail.geojson                  # Heavy and light rail transit network
│   ├── landmarks.geojson             # Points of interest & civic amenities (2,318 POIs)
│   ├── sections.geojson              # Administrative sections (92 regions)
│   ├── restrictions.geojson          # Turn restrictions (OSM via-point relation model)
│   ├── waterways.geojson             # Linear navigable streams, rivers, and canals
│   ├── water.geojson                 # Regional water names (seas, major lakes)
│   └── areas.geojson                 # Zoning, landuse, parks, and aerodromes
│
├── sources/                          # Raw upstream source files and georeferenced drops
│   ├── background_map.png (+.pgw)    # In-game satellite aerial basemap
│   ├── heightmap_16bit.png (+.pgw)   # 16-bit DEM elevation raster
│   ├── figma_vector_map.svg          # Upstream community Figma vector map
│   └── gtadb_landmarks_raw.json      # Raw GTADB POI markers
│
├── rasters/                          # Production georeferenced raster assets
│   ├── background_map.png            # In-game satellite aerial basemap in metric space
│   ├── heightmap_16bit.png           # 16-bit elevation heightmap (0m - 800m summit)
│   └── heightmap_preview.png         # Analytical hillshaded terrain relief
│
├── derived/                          # Auto-generated spatial intermediates & polygon joins
│   ├── counties_dissolved.geojson    # 5 dissolved official county boundary polygons
│   ├── by_county/roads_{slug}.geojson# Dynamically intersected county road networks
│   ├── roads_oneway.geojson          # Oneway road subset
│   ├── roads_bidi.geojson            # Bidirectional road subset
│   ├── contours.geojson & .gpkg      # 27-level quantile hypsometric contours
│   ├── elevation_peaks.geojson       # 37 mountain peaks and summits
│   ├── coastline.geojson             # High-definition sea level boundary
│   └── buildings, water_bodies,...   # Extracted vector landcover polygons
│
├── publication/                      # Production deliverables for end users
│   ├── geopackage/leonida_map.gpkg   # Master GeoPackage with spatial indices & embedded styles
│   ├── shapefiles/                   # 15 ESRI Shapefiles with sidecar .qml styles
│   ├── geojson/                      # Clean release GeoJSONs and county splits
│   └── styles/                       # Release QML styles
│
├── scripts/                          # Pipeline automation, formatters, and validators
├── styles/                           # Canonical QGIS 3.x QML styling definitions
├── qgis_plugin/                      # Custom in-QGIS tools (Leonida Turn Restrictions)
├── leonida_map_project.qgz           # Master double-click QGIS project bundle
└── leonida_map_project.qgs           # Master QGIS project XML
```

### Strict Layer Purity Guidelines (`layers/`)
1. **Single Source of Truth:** Files in `layers/*.geojson` are hand-edited in QGIS. They must remain pure OpenStreetMap schema.
2. **STRICT PROHIBITION ON AUTO-DERIVED ATTRIBUTES IN NETWORK & POI LAYERS:**
   * Do **NOT** inject auto-calculated fields into network and landmark layers (`roads.geojson`, `rail.geojson`, `landmarks.geojson`, `waterways.geojson`) such as `county`, `county_slug`, `length_m`, `bearing`, `cardinal`, `vert_cnt`, or `gta_flags`. Administrative sections (`sections.geojson`) represent human ground truth and explicitly retain `county` and `county_slug` to derive county boundaries.
   * `scripts/format.py` automatically purges stray keys from non-administrative work layers and formats GeoJSON to strict 1-line-per-feature serialization.
3. **Safety Protection:** Automated scripts must **NEVER** overwrite files in `layers/` unless an explicit `--overwrite-work` flag is supplied by the user.

---

## 5. Tagging Taxonomy & Data Schema

### 5.1 Administrative Boundaries (`layers/sections.geojson`, `derived/counties_dissolved.geojson`)
* `admin_level=4`: State of Leonida.
* `admin_level=6`: 5 Official Counties:
  * **Vice-Dale County** (`vice_dale`): Metropolitan core, Vice City, beaches, barrier islands.
  * **Kelly County** (`kelly`): Northern agrarian territories, Ambrosia hills, raceway.
  * **Leonard County** (`leonard`): Coastal barrier islands, eastern wetlands, zoo.
  * **Lummox County** (`lummox`): Northern mountainous highlands, Mount Kalaga, rugged coast.
  * **Mariana County** (`mariana`): Archipelago of subtropical keys, shallow flats, naval bases.
* `admin_level=10`: 92 Administrative Sections (`place=suburb`, `place=neighbourhood`, `place=locality`, `place=island`, `place=islet`).

### 5.2 Road Network (`layers/roads.geojson`)
* **Highway Classes (`highway=*`):** `motorway`, `motorway_link`, `trunk`, `trunk_link`, `primary`, `primary_link`, `secondary`, `secondary_link`, `tertiary`, `tertiary_link`, `unclassified`, `residential`, `living_street`, `service`, `track`, `pedestrian`, `footway`, `cycleway`.
* **Flow & Directionality:**
  * `oneway="yes"`: Digitizing direction ($v_0 \to v_n$). Forward chevrons rendered in QGIS.
  * `oneway="-1"`: Opposing digitizing direction ($v_n \to v_0$). Reverse chevrons rendered.
  * `oneway="no"` / `null`: Two-way bidirectional traffic.
  * `junction="roundabout"`: Counter-clockwise closed loop with `oneway=yes`.
* **Structural Attributes:** `lanes` (int), `bridge="yes"` (`layer=1`), `tunnel="yes"` (`layer=-1`), `surface` (`asphalt`, `concrete`, `gravel`, `dirt`), `maxspeed` (mph int), `name`, `ref`.
* **Identifiers:** Unique integer `id`, prefixed `ref_id` (`R_0001` .. `R_####`).

### 5.3 Railways (`layers/rail.geojson`)
* `railway="rail"`: Heavy passenger and freight mainline.
* `railway="light_rail"` / `"subway"` / `"monorail"`: Urban transit / Vice City Transit systems.
* `service`: `mainline`, `yard`, `siding`, `spur`, `crossover`.
* Identifiers: Unique integer `id`, prefixed `ref_id` (`T_0001` .. `T_####`).

### 5.4 Turn Restrictions (`layers/restrictions.geojson`)
* Modeled after OSM `type=restriction` relations, represented as GeoJSON Point features.
* **The Point geometry IS the via point**, snapped directly onto the incoming `from_way`.
* Attributes: `type="restriction"`, `restriction` (`no_left_turn`, `no_right_turn`, `no_u_turn`, `only_straight_on`, `only_left_turn`, `only_right_turn`), `from_way` (`R_####`), `to_way` (`R_####`), `except` (optional).
* **Validation:** The via point must sit within $25\text{ m}$ of the `from_way`, and both `from_way` and `to_way` must resolve to real road `ref_id`s.

### 5.5 Landmarks & POIs (`layers/landmarks.geojson`)
* 2,318 GTADB locations mapped to OSM tags: `amenity=fuel|hospital|police|fire_station|bank|restaurant|bar`, `tourism=hotel|attraction|viewpoint`, `shop=convenience|car_repair`.
* Identifiers: Unique integer or prefixed string `id` (`L1` .. `L2318`).

---

## 6. Topography & Elevation Contours Standards

### 16-Bit DEM Heightmap
* **File:** `rasters/heightmap_16bit.png`
* **Coordinate Transform:** $X0 = -13318.10$, $Y0 = 11265.42$, $DX = 12.0165$, $DY = -12.0165$.
* **Elevation Formula:** $Z_{\text{raw}} = 28150.0 + \text{elevation\_m} \times 46.51$. Sea level is $28150.0\text{ raw}$ ($0.0\text{ m}$); Mount Kalaga summit is $65358.0\text{ raw}$ ($800.0\text{ m}$).

### Non-Linear Hypsometric Quantile Distribution
* **Why Fixed Intervals Are Strictly Prohibited:**
  * $50\%$ of Leonida's land lies below $13.5\text{ m}$ (median elevation).
  * $75\%$ of land lies below $53.0\text{ m}$.
  * $90\%$ of land lies below $126.9\text{ m}$.
  * Fixed 50m intervals leave 75% of the island completely blank.
* **Quantile Contours:** Extracted across 27 empirical quantile levels across the land surface (`scripts/02_extract_contours.py`):
  * Lowland resolution: $0.47\text{ m}$, $0.92\text{ m}$, $1.31\text{ m}$, $1.55\text{ m}$, $2.09\text{ m}$, $2.56\text{ m}$, $3.29\text{ m}$, $4.21\text{ m}$, $5.07\text{ m}$, $5.89\text{ m}$, $7.50\text{ m}$, $9.95\text{ m}$, $13.52\text{ m}$.
  * Foothill/Highland resolution: $18.6\text{ m}$, $27.0\text{ m}$, $34.0\text{ m}$, $42.0\text{ m}$, $53.0\text{ m}$, $68.7\text{ m}$, $90.2\text{ m}$, $126.9\text{ m}$, $180.4\text{ m}$, $229.8\text{ m}$.
  * Mountain/Alpine resolution: $310.4\text{ m}$, $416.3\text{ m}$, $523.8\text{ m}$, $650.7\text{ m}$.
  * Index Contours (`is_index: true`): 0.9m, 1.6m, 4.2m, 13.5m, 53.0m, 126.9m, 229.8m, 416.3m.

### Contour Labeling Scale Constraints
* **Distance/Elevation Text Scale Limit:**
  * Elevation numbers (e.g. `13.5 m`) must **NOT** be displayed at regional scales such as 1:7,400 or zoomed-out views.
  * **Maximum scale threshold is 1:2,000** (`scaleMax="2000"`, `minScale="2000"`).
  * Contour labels must only appear when zoomed in to 1:2,000 or closer ($1:1500$, $1:1000$, etc.).
* **Placement & Rendering:**
  * Must use native `LineGeometry` parallel on-line placement (`placement="2"`, `placementFlags="9"`).
  * Repeat distance must be set to $120\text{ mm}$ on screen (`repeatDistance="120"`).
  * Must include a $0.75\text{ mm}$ white text halo buffer (`255,255,255,230`) for legibility over satellite imagery.

### Performance & Packaging
* For production rendering in QGIS, prioritize **GeoPackage (`.gpkg`) with SQLite R-Tree spatial indexing**:
  * `derived/contours.gpkg`
  * `publication/geopackage/leonida_map.gpkg`
* Always register default QML styles into the GeoPackage's `layer_styles` table so opening the layer in QGIS automatically applies rule-based styling and the 1:2000 label scale threshold.

---

## 7. QGIS Project File Safety (`leonida_map_project.qgs` / `.qgz`)

* **Never Blind-Overwrite Project Files:** When the user is actively working in QGIS, do NOT run procedural scripts that regenerate `.qgs` from scratch. Doing so resets user layer visibility toggles, active edit sessions, and canvas extents.
* **Preserve Viewport:** If rebuilding the project file, always read and preserve the existing map canvas extent (`<mapcanvas><extent>`) and user layer states.
* **User Project Backups:** Any automated project rebuild must preserve a backup (`leonida_map_project.qgs~` or `.bak`).

---

## 8. In-QGIS Tooling: Turn Restrictions Plugin

The project includes an interactive QGIS plugin in [`qgis_plugin/leonida_turn_restrictions/`](file:///C:/Users/kanal/Downloads/Projects/leonida_gis/qgis_plugin/leonida_turn_restrictions) replicating the **OpenStreetMap iD Editor** visual turn restriction workflow.

### Behavioral Requirements
* **Visual Canvas Turn Arrows Overlay:** Renders circular turn arrows radiating directly from the junction node into each connected outgoing way ($R = 42\text{ px}$):
  * 🟢 **Green:** Allowed Turn (default, no restriction stored).
  * 🔴 **Red (with 🚫 slash):** Prohibited Turn (`no_left_turn`, `no_right_turn`, `no_u_turn`, `no_straight_on`).
  * 🔵 **Blue (with ➡ arrow):** Mandatory Turn (`only_straight_on`, `only_left_turn`, `only_right_turn`).
* **Interactive Toggling:** Clicking an arrow on the canvas cycles $\text{Allowed} \to \text{Prohibited} \to \text{Only} \to \text{Allowed}$, saving directly to [`layers/restrictions.geojson`](file:///C:/Users/kanal/Downloads/Projects/leonida_gis/layers/restrictions.geojson).
* **STRICT ON-DEMAND DISPLAY ONLY (NOT Always On):**
  * Visual turn arrows must **ONLY** render on the canvas when an intersection is actively selected.
  * Deselecting, clicking empty canvas space, right-clicking, pressing `Esc`, changing tools, or closing the dock must immediately clear and hide all canvas arrows and highlights.
* **Headless Verification:** Verified via [`qgis_plugin/test_store_headless.py`](file:///C:/Users/kanal/Downloads/Projects/leonida_gis/qgis_plugin/test_store_headless.py).

---

## 9. Automated Pipeline & Execution Order

All pipeline scripts reside in `scripts/` and must be executed relative to the project root:

```bash
# 1. Georeference base raster
python scripts/01_georeference_base.py

# 2. Build derived spatial intersections (dissolve counties, dynamic county road splits, oneway subsets)
python scripts/03_build_derived.py

# 3. Extract quantile contours, mountain peaks (with county joins), and coastline from 16-bit DEM
python scripts/02_extract_contours.py

# 4. Extract Figma community terrain polygons (buildings, water, vegetation, sand, shelf)
python scripts/extract_figma_terrain.py

# 5. Build publication deliverables (Master GeoPackage with spatial indices & layer_styles, Shapefiles, GeoJSONs)
python scripts/04_build_publication.py

# 6. Synchronize master QGIS project bundle (preserving user viewport)
python scripts/05_build_qgis_project.py

# 7. Generate high-resolution visual QA composite verification renders
python scripts/06_generate_qa.py

# 8. Semantic validation across all work layers (MUST exit 0)
python scripts/validate.py --strict
```

### Pre-Commit Code Quality
* `python scripts/format.py`: Formats GeoJSON to 1 feature per line, 2-decimal coordinates, sorted keys, and strips stray derived keys.
* `python scripts/validate.py`: Validates ID prefixes, tag domains, bounds, and turn-restriction topology. Must pass with **0 errors**.
