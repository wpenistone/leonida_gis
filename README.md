# State of Leonida GIS

Collaborative GIS mapping project for the State of Leonida (GTA 6). 
Includes vector networks for roads, railways, waterways, administrative sections, and landmarks.

---

## Setup & Installation

### Prerequisites
* **QGIS 3.28 LTR or newer**: [Download QGIS](https://qgis.org/download/) (free, open source).
* **Python 3.10+**: Used for data formatting and pipeline build scripts.

### 1. Clone the Repository
```bash
git clone https://github.com/<your-username>/leonida_gis.git
cd leonida_gis
```

### 2. Install Python Dependencies
```bash
pip install -r requirements.txt
```

### 3. Open the Project in QGIS
Double-click **`leonida_map_project.qgz`** in the project root. All vector layers, aerial rasters, and styling load automatically.

### 4. Enable Git Pre-Commit Formatting
Run this once to configure Git to automatically format layers, strip derived fields, and validate semantics on every commit:
```bash
python scripts/setup_hooks.py
```

---

## Recommended QGIS Settings

To digitize features efficiently and maintain topological integrity, configure these settings in QGIS:

### Digitizing Options
Go to **Settings** -> **Options** -> **Digitizing**:

1. **Feature Creation**:
   * Check **"Reuse last entered attribute values"**: Automatically carries over tags (such as `highway: residential`, `lanes: 2`, `surface: asphalt`) to each new feature you draw. You do not need to re-type attributes on every segment.
2. **Snapping**:
   * Default snapping mode: **All layers**
   * Default snapping type: **Vertex and segment**
   * Default snapping tolerance: **15.0 map units** (or 15 pixels)
   * Check **"Enable snapping on intersection"**
   * Check **"Enable topological editing"** (adjusting a shared vertex moves all connecting roads simultaneously)

### Snapping & Tracing Toolbar
While editing on the map canvas:
* Press **`S`** to toggle snapping on/off.
* Press **`T`** to toggle **Tracing** (automatically traces along existing roads, coastlines, or county borders without placing individual vertices).

---

## Editing Controls & Keybinds Cheat Sheet

| Action | Shortcut / Control | Notes |
| --- | --- | --- |
| **Toggle Editing** | `Ctrl + E` | Enables/disables edit mode on active layer (prompts to save layer edits when turning off) |
| **Save Layer Edits** | Digitizing toolbar icon / `Layer -> Save Layer Edits` | Writes in-memory geometry edits from RAM buffer down to `.geojson` file on disk |
| **Save Project** | `Ctrl + S` | Saves QGIS project state, layer tree, and styles (`.qgz` file only) |
| **Add Line / Point Feature** | `Ctrl + .` | Starts drawing a new road, track, or landmark |
| **Place Vertex** | `Left Click` | Adds a node along the line |
| **Undo Last Vertex** | `Backspace` or `Delete` | Removes the most recent vertex while drawing |
| **Finish Feature** | `Right Click` | Completes the geometry and opens the attribute form |
| **Vertex Tool** | `V` | Move, insert, or delete vertices on existing geometries |
| **Toggle Snapping** | `S` | Turns snapping to nearby vertices/edges on and off |
| **Toggle Tracing** | `T` | Snaps line drawing along an existing edge |
| **Pan Canvas** | `Space + Click & Drag` (or Middle Mouse) | Moves map view |
| **Zoom Canvas** | `Mouse Wheel` (or `Ctrl +` / `Ctrl -`) | Zooms in/out |
| **Refresh Canvas** | `F5` | Forces QGIS to reload layer data from disk |
| **Undo / Redo** | `Ctrl + Z` / `Ctrl + Y` | Standard undo/redo buffer |

---

## Data Quality & Validation Workflow

Two automated gates protect the layers. Both run in the pre-commit hook and in CI:

1. **`python scripts/format.py`** — *formatting & schema enforcement*. Enforces canonical one-feature-per-line serialization, sorted keys, quantized coordinates ($1\text{ cm}$ precision), per-layer `ref_id` prefixes (`R_` roads, `T_` rail, `A_` areas), strict JSON (no `NaN` literals — they become `null`), and purges any stray auto-derived fields (`county`, `length_m`, etc.) to keep canonical work layers pure OpenStreetMap schema.
2. **`python scripts/validate.py`** — *semantic correctness*. Checks tag values against the taxonomy (highway, railway, admin_level, place, restriction, natural/water, waterway), unique ids & correctly prefixed ref_ids, county ↔ county_slug consistency, strict JSON, coordinate extents, and turn-restriction integrity (`from_way`/`to_way` must resolve to real road ref_ids; the via Point must sit on the from-way). Add `--strict` to fail on warnings too.

Run them any time:
```bash
python scripts/format.py
python scripts/validate.py --strict
```

**Typical mapping workflow:** edit in QGIS → save layer edits → `python scripts/format.py` → `python scripts/validate.py` → commit (the pre-commit hook repeats both checks automatically).

---

## Turn Restrictions Plugin

`qgis_plugin/leonida_turn_restrictions` adds OSM's turn-restriction relation model directly to the QGIS canvas.

### Installation
1. In QGIS: **Settings → User Profiles → Open Active Profile Folder**, then copy `qgis_plugin/leonida_turn_restrictions` into the `python/plugins` subfolder (create it if missing).
2. Restart QGIS and enable **Leonida Turn Restrictions** in **Plugins → Manage and Install Plugins → Installed**.
3. A new toolbar icon (red prohibition circle) and a **Leonida** menu entry appear.

### Usage (OpenStreetMap iD Editor Visual Workflow)
1. Click the toolbar icon to open the **Turn Restrictions** dock and activate the map tool.
2. Click ON a road line on the canvas to select the incoming **FROM** way (highlighted in cyan).
3. Click near the intersection junction node to place the **VIA** point (auto-snaps to the approach line).
4. Visual turn arrows radiating into every connected outgoing road appear directly on the map canvas:
   * 🟢 **Green (Allowed)**: Normal traffic flow (no restriction stored).
   * 🔴 **Red with 🚫 Slash (Prohibited)**: Clicking turns the arrow red (`no_left_turn`, `no_right_turn`, `no_u_turn`).
   * 🔵 **Blue with ➡ Arrow (Only)**: Clicking again sets a mandatory turn (`only_straight_on`, `only_left_turn`, `only_right_turn`).
   * Clicking once more removes the restriction and returns the arrow to green (Allowed).
5. Saved restrictions write directly to `layers/restrictions.geojson`, immediately updating the QGIS layer cache. Pressing `Esc`, right-clicking, or clicking empty space clears all visual arrows.

---

## Project Structure

```
leonida_gis/
├── sources/                          # Raw upstream georeferenced source files
│   ├── background_map.png (+.pgw/.prj) # In-game satellite basemap raster
│   ├── original_height.png (+.pgw/.prj)# 16-bit DEM heightmap
│   ├── figma_vector_map.svg          # Community Figma vector map (terrain, buildings, rail)
│   ├── rail.svg                      # Extracted rail vector source
│   ├── sections.json                 # Administrative sections source
│   └── gtadb_landmarks_raw.json      # 2,318 GTADB POI markers
│
├── layers/                           # Canonical human-edited vector layers
│   ├── roads.geojson                 # Active road network (OSM highway taxonomy)
│   ├── rail.geojson                  # Railway lines (heavy and light rail)
│   ├── landmarks.geojson             # Points of interest / amenities (from GTADB)
│   ├── sections.geojson              # Administrative sections (92 regions)
│   ├── restrictions.geojson          # Turn restrictions
│   ├── waterways.geojson             # Linear navigable streams, rivers, and canals
│   ├── water.geojson                 # Regional water names (seas, major lakes)
│   └── areas.geojson                 # Zoning, landuse, parks, and aerodromes
│
├── rasters/                          # Georeferenced raster assets in metric space
│   ├── background_map.png            # In-game satellite aerial basemap (5.6362 m/px)
│   ├── heightmap_16bit.png           # 16-bit DEM elevation raster (0m - 800m summit)
│   └── heightmap_preview.png         # Analytical hillshaded terrain relief
│
├── derived/                          # Auto-generated intermediate layers & Figma cartography
│   ├── buildings.geojson             # 2,152 vector building footprints
│   ├── water_bodies.geojson          # 1,869 water bodies, canals, and slips
│   ├── vegetation.geojson            # 1,752 parks, forests, and golf courses
│   ├── sand_beaches.geojson          # 350 barrier beaches and sandbars
│   ├── coastal_shelf.geojson         # 7 bathymetric depth bands
│   ├── elevation_peaks.geojson       # 37 mountain summits (including Mt. Kalaga at 800m)
│   ├── contours.geojson & .gpkg      # 27-level quantile hypsometric contours with R-Tree index
│   ├── coastline.geojson             # High-definition sea level boundary
│   ├── counties_dissolved.geojson    # 5 dissolved official county boundaries
│   ├── roads_oneway.geojson          # Oneway road subset
│   ├── roads_bidi.geojson            # Bidirectional road subset
│   └── by_county/                    # Auto-derived county road subsets
│
├── publication/                      # Compiled release packages for users
│   ├── geopackage/leonida_map.gpkg   # Master GeoPackage with all 15 vector layers
│   ├── shapefiles/                   # 15 ESRI Shapefiles with sidecar .qml styles
│   ├── geojson/                      # Standalone GeoJSON files and county splits
│   ├── styles/                       # Master QGIS .qml style definitions
│   └── qa_previews/                  # Visual verification renders (master and urban zoom)
│
├── scripts/                          # Automated pipeline and maintenance scripts
│   ├── run_pipeline.py               # Master pipeline runner (executes all steps in ~25s)
│   ├── render_all_layers.py          # Comprehensive multi-layer visualization renderer
│   ├── sync_sources.py               # Pulls latest GTADB & upstream drops
│   ├── format.py                     # Deterministic formatter, float rounding & schema purger
│   ├── validate.py                   # Semantic validator (tag domains, ids, bounds, restrictions)
│   └── setup_hooks.py                # Installs Git pre-commit hook
│
├── qgis_plugin/                        # In-QGIS tooling
│   ├── leonida_turn_restrictions/     # OSM-style turn restriction mapping plugin
│   └── test_store_headless.py         # Headless smoke test for the plugin's GeoJSON store
│
├── leonida_map_project.qgz           # Master double-click QGIS 3.x project bundle
└── leonida_map_project.qgs           # Master QGIS project XML
```

---

## Tooling Commands

### Sync External Upstream Repositories
Pulls latest data from GTADB (`rolux/gtadb.org`) and LeonidaHeightmap (`MelonHell/LeonidaHeightmap`):
```bash
python scripts/sync_sources.py             # Sync all upstream sources
python scripts/sync_sources.py --gtadb     # Sync GTADB landmarks only
python scripts/sync_sources.py --heightmap # Sync heightmap DEM only
```

### Format and Lint Layers
Formats canonical layers:
```bash
python scripts/format.py
```

### Build Deliverables
Rebuilds derived datasets, master GeoPackage, shapefiles, QGIS project, and QA verification composite:
```bash
python scripts/run_pipeline.py
```
---

## Contributing

Edits to roads, railways, water bodies, or landmarks can be submitted via GitHub or Discord:

### Option A: GitHub Pull Request
1. Fork the repository and create a branch (`git checkout -b feat/my-edits`).
2. Edit the target layer in QGIS under `layers/` (e.g. `layers/roads.geojson`).
3. Save **Layer Edits** to disk: toggle off editing (`Ctrl + E` and click **Save**), or click the **Save Layer Edits** icon on the Digitizing toolbar. *(Note: `Ctrl + S` only saves the QGIS project file, not the underlying `.geojson` vector data).*
4. Run the formatting tool:
   ```bash
   python scripts/format.py
   ```
5. Commit only the modified files in `layers/` and open a Pull Request. GitHub Actions CI tests the build and generates a verification preview automatically.

### Option B: Discord Submission (No Git Required)
If you do not use Git:
1. Open `leonida_map_project.qgz` in QGIS, digitize your changes, and save **layer edits** to disk (toggle off `Ctrl + E` and click **Save**).
2. Send the modified `.geojson` file from your local `layers/` folder directly to **`@wpenistone`** on Discord. The maintainer will run the formatting linter, validate the changes, and commit them to the project.
---

## Technical Reference

* **Coordinate System**: Planar Equirectangular projection (`+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs`).
* **Units**: Meters ($1\text{ unit} = 1.0\text{ meter}$, origin $(0, 0)$ at map center).
* **Bounds**: Southwest $(-10721.65, -8557.13)\text{ m}$, Northeast $(+3876.15, +9704.21)\text{ m}$.
* **Strict Layer Purity**: Work layers under `layers/` are kept as pure OpenStreetMap schemas without auto-derived attributes (no `county`, `county_slug`, or `length_m` bloat). `scripts/format.py` automatically purges any stray derived keys. County-split networks and spatial metrics are generated downstream into `derived/` by the build pipeline. Contributors only need to fill in semantic tags (`highway`, `name`, `lanes`, `layer`, `bridge`, `tunnel`).

---

## Documentation

* [DATA_SOURCES.md](DATA_SOURCES.md): Technical provenance, upstream source datasets, georeferencing parameters, transformation formulas, and symbology specifications.
* [CONTRIBUTING.md](CONTRIBUTING.md): GitHub PR workflow, branch naming, formatting checks, and Discord submission rules.
* [MAPPING_GUIDE.md](MAPPING_GUIDE.md): Topological standards, way splitting, line direction, junction connectivity, snapping rules, and QGIS editing procedures.
* [TAGGING_TAXONOMY.md](TAGGING_TAXONOMY.md): OpenStreetMap (OSM) tagging taxonomy, area landuse rules, road hierarchy, and OSM Carto colour specifications.
