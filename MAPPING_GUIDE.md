# Leonida GIS Mapping & Topology Guide

Comprehensive topological standards and digitizing specifications for the State of Leonida GIS project. These rules follow OpenStreetMap (OSM) topological conventions adapted for planar in-game metric space. For complete attribute definitions, tag values, and OSM Carto color codes, refer to [TAGGING_TAXONOMY.md](TAGGING_TAXONOMY.md).
---

## 1. Network Topology Invariants

A routable GIS network relies on a strict graph model composed of **edges** (road/rail/waterway `LineString` segments) and **nodes** (vertices where edges connect):

1. **At-Grade Connectivity**: Two roads that physically intersect on the ground must share an identical coordinate vertex at the intersection point.
2. **Grade Separation**: Roads crossing vertically at different levels (bridges, underpasses) must **not** share vertices.
3. **Graph Continuity**: Do not split continuous physical features at artificial boundaries (county lines, grid tiles). County-split networks (`derived/by_county/`) are generated downstream by the automated build pipeline.
4. **Directionality**: Directed lines (`oneway: "yes"`, downstream waterways) must be digitized in the true direction of physical or regulatory flow.

---

## 2. Reversing Line Direction

### Why Direction Matters
* **One-Way Streets (`oneway: "yes"`)**: Traffic routing engines read lines from the first vertex ($v_0$) to the last vertex ($v_n$). Digitizing a one-way road backwards causes routing engines to guide vehicles against oncoming traffic.
* **Waterways (`waterway: "river"`, `"stream"`, `"canal"`)**: Hydrological models flow downstream from source to mouth. Inverted waterways cause water to flow uphill.
* **Divided Highway Carriageways**: In right-hand drive traffic (US/Leonida), each carriageway must point in the forward direction of traffic.

### How to Check Line Direction in QGIS
1. Select the layer in the Layers panel.
2. Open **Layer Styling** (`F7`).
3. Under the line symbol, add a **Marker Line** component:
   * Marker placement: **on line** or **central point**.
   * Marker symbol: arrow head pointing forward.
   * This immediately displays directional arrows along every segment on the map canvas.

### How to Reverse a Line in QGIS
1. Select the layer and toggle editing (click the **Toggle Editing** pencil icon on the Digitizing toolbar, or press **`Ctrl + E`** if assigned).
2. Enable the **Advanced Digitizing Toolbar** (`View` -> `Toolbars` -> `Advanced Digitizing Toolbar`).
3. Click the **"Reverse Line"** tool (icon showing two opposing horizontal arrows), or press the vertex tool and right-click the line feature -> **Reverse line direction**.
4. Click on the line you wish to reverse. The directional arrows will flip instantly.
5. Save layer edits: click the **Save Layer Edits** icon on the Digitizing toolbar, or toggle off editing and confirm Save.

---

## 3. Practical Digitizing Workflows: Real-World Scenarios

### 3.1 The 5-Second Rapid Road Digitizing Workflow
Digitizing new road corridors from aerial basemap imagery is straightforward and fast:
1. **Select Layer**: In the Layers panel, click on **`roads`** (under `Active Work Layers`).
2. **Toggle Edit Mode**: Click the **Toggle Editing** pencil icon on the Digitizing toolbar.
3. **Start Drawing (`Ctrl + .`)**: Click the **Add Line Feature** icon.
4. **Place Nodes**: Left-click sequentially along the centerline of the roadway following the aerial basemap.
5. **Commit Geometry**: When you reach an intersection node or the end of the road, **Right-click**.
6. **Pre-Configured Attribute Form Template**: 
   * Instead of blank or raw free-form typing, QGIS opens the customized attribute form template.
   * You only need to pick your options from the dropdown selectors:
     * **Highway Class**: Pick the functional tier (e.g. `motorway`, `primary`, `secondary`, `residential`).
     * **One-Way Flow**: Pick `Two-Way`, `One-Way (Forward)`, or `One-Way (Reverse)`.
     * **Bridge / Tunnel**: Pick structure state (`No`, `Yes`, `Viaduct`, `Culvert`).
     * **Speed Limit** & **Surface**: Select posted speed and paving material.
   * `Road ID` and `Reference ID` (`R_####`) are calculated automatically. Click **OK** to save the feature.

---

### 3.2 Normal Vertex Editing & Curvature Refinement
To refine curves, adjust street alignments, or realign intersections:
1. Activate the **Vertex Tool (`V`)** on the Digitizing toolbar.
2. Hover the cursor over any existing road line:
   * **Move a Node**: Click directly on a vertex (red circular crosshair appears), move it to match the imagery, and click again to set the new position.
   * **Insert a Node**: Hover over the small **`+`** icon at the midpoint between two vertices, click and drag outward to create a new intermediate bend node for smooth curvature.
   * **Delete a Node**: Click once on an unnecessary vertex (it turns blue/selected), then press **`Delete`** or **`Backspace`**.
   * **Move Multiple Nodes**: Click and drag a selection rectangle with the Vertex Tool across a cluster of nodes, then drag any of the selected nodes to move the whole group together.

---

### 3.3 Cutting / Splitting Ways for Bridges, Tunnels, and Grade Transitions
A continuous road line must be cut into separate features when part of it becomes an overpass, bridge, or tunnel:
1. Make sure **`roads`** is editable (pencil icon active).
2. Activate the **Split Features** tool on the Advanced Digitizing Toolbar (`Edit → Split Features`).
3. **Draw the Cut Line Across the Road**:
   * Click once on one side of the road line where the bridge abutment begins.
   * Drag the cursor across the road line (a red dashed cutting line will extend across the feature).
   * **Right-click** to commit the cut.
   * Repeat at the opposite end of the bridge span where the road returns to ground grade.
4. The road is now split into three independent physical segments: the approach road, the elevated bridge span, and the departure road.

| Split Condition | Trigger Location | Target Attribute Change on Bridge/Tunnel Segment |
|---|---|---|
| **Bridge Overpass** | Abutments where road elevates | `bridge: "yes"`, `layer: 1` |
| **Tunnel Bore** | Portals where road goes underground | `tunnel: "yes"`, `layer: -1` |
| **Speed Limit Zone** | City limit or posted speed sign | `maxspeed: 35` (or posted value) |
| **Surface Change** | Pavement ends onto dirt/gravel | `surface: "dirt"` or `"gravel"` |
| **Lane Drop / Add** | Road expands or drops a lane | `lanes: 4` -> `lanes: 2` |

---

### 3.4 Selecting Features & Deleting Unwanted Geometry
When cleaning up network cuts, trimming overshoots, or removing erroneous ways:
1. Activate the **Select Features by Area or Single Click** tool (`Ctrl + Alt + A` to clear any existing selection).
2. Click directly on the unwanted road segment, or drag a selection box across it (selected lines turn bright yellow).
3. Press **`Delete`** on your keyboard to instantly remove the feature.
4. Click **Save Layer Edits** to persist the deletion.

---

### 3.5 Batch Multi-Feature Attribute Editing (Simultaneous Bridge Tagging)
When cutting multiple lanes or spans (e.g. both directions of a divided highway crossing a river):
1. Use the **Select Features** tool to select all the newly cut bridge segments together (drag a box over them or hold `Shift` while clicking each one).
2. Open the **Attribute Table (`F6`)**.
3. Click the **Toggle Multi-Edit Mode** icon at the top of the attribute table window (icon showing a pencil over stacked rows).
4. Select the **Bridge** field and choose **`Yes`**.
5. Select the **Layer** field and choose **`1`**.
6. Click **Apply Changes**. All selected road segments are updated simultaneously in one click, without needing to open separate dialog forms for each segment.

---

### 3.6 Canvas Visibility Tip: Managing Contour Interference
Dense elevation contours (`contours` / `Elevation Contours`) provide valuable terrain context, but their dense polylines can get in the way during fast network digitizing by capturing cursor snaps or obscuring road centerlines:
* **Temporarily Hide Contours While Digitizing**: In the Layers panel, uncheck `Elevation Contours` and `Bathymetry Contours` so the map canvas displays only the satellite basemap and active roads.
* **Lock Snapping to Active Layer**: On the Snapping Toolbar, set snapping mode to **"Active Layer"** rather than "All Layers". This forces QGIS to snap only to other roads, completely ignoring contour and landcover lines even if they are visible.

---

## 4. Disconnecting / Unlinking Nodes (Fixing Accidental Snaps)

### The Problem
When drawing an elevated bridge, flyover ramp, or overpass, QGIS snapping may accidentally snap to the surface road passing underneath, binding both roads to a shared vertex. This creates a false at-grade intersection where cars could illegally turn from a freeway bridge onto a local street below.

### How to Disconnect in QGIS
1. Enable editing on the layer (**Toggle Editing** pencil icon, or `Ctrl + E` if assigned).
2. On the Snapping Toolbar, **uncheck "Topological Editing"** temporarily. (If topological editing is active, moving a vertex moves all snapped features together).
3. Activate the **Vertex Tool (`V`)**.
4. Hover over the shared junction node. QGIS displays vertex markers for all lines connected at that point.
5. Click specifically on the vertex belonging to the bridge line.
6. Drag the vertex slightly away, or if it is an unnecessary redundant vertex, click it and press **`Delete`** to remove it.
7. Verify that the bridge line passes continuously overhead while the ground line passes underneath with separate coordinates.
8. Set the bridge segment properties: `layer: 1`, `bridge: "yes"`.
9. Re-enable **"Topological Editing"** on the Snapping Toolbar for normal intersection work.

---

## 5. Managing Snapping: When to Snap vs. When NOT to Snap

Snapping is controlled via the Snapping Toolbar or by pressing **`S`** on the keyboard.

### Mandatory Snapping Scenarios (Must Snap)
* **At-Grade Intersections**: T-junctions, cross streets, dead-end turns, and cul-de-sacs connecting to road networks.
* **Highway Ramps & Slip Roads**: Ramps (`highway: "*_link"`) must snap tangentially to the mainline at both the divergence (exit) and convergence (entrance) nodes.
* **Roundabouts**: Ingress and egress roads must snap directly onto the perimeter ring of the roundabout.
* **Railway Switches & Turnouts**: Branching tracks must connect at a shared vertex with the mainline track.
* **Rail / Road Level Crossings**: Where a railway intersects a surface road at grade, the road and track must share an intersection node.
* **Waterway Confluences**: Tributary streams must snap to the downstream river centerline.

### Prohibited Snapping Scenarios (Must NOT Snap)
* **Grade-Separated Overpasses & Tunnels**: Bridges crossing over ground roads or railways must pass cleanly overhead without shared vertices.
* **Parallel Divided Carriageways**: Dual-carriageway one-way lines running side by side must not snap across the median to each other. Accidental cross-median vertex snapping causes pathfinding algorithms to generate illegal U-turns across grass medians.
* **Building Perimeters & Section Boundaries**: Roads should not snap to unrelated polygon boundaries unless explicitly sharing an aligned easement.

### On-the-Fly Snapping Controls
* **Toggle Snapping (`S`)**: Instantly enables or disables snapping while moving the cursor.
* **Temporary Snapping Suspension (`Ctrl`)**: While placing a vertex, **hold the `Ctrl` key** to temporarily disable snapping. This allows placing a vertex directly over or next to an underlying feature without snapping to it.
* **Snapping Mode**:
  * Set to **"Active Layer"** when working in dense urban environments to prevent the cursor from snapping to background boundary polygons or landmarks.
  * Set to **"All Layers"** when connecting roads to railways or waterway culverts.
* **Tolerance**: Default is set to **`15.0 map units`** (meters).

---

## 6. Divided Carriageways & Roundabouts

### Divided Highways
* When a highway has a physical barrier (concrete wall, guard rail, or grass median $\ge 2\text{ m}$ wide), digitize as **two separate parallel lines**.
* Tag each line:
  * `oneway: "yes"`
  * `highway: "motorway"` or `"primary"`
  * `lanes: <lanes per direction>`
* When the divided highway ends and merges into an undivided two-way road:
  * Bring the two lines together into a single shared vertex where the median ends.
  * Continue forward as a single line tagged `oneway: "no"` with combined total lanes.

### Roundabouts
* Always digitize in the **counter-clockwise direction** (standard right-hand drive traffic).
* Form a closed loop where the final vertex snaps onto the initial vertex.
* Tag: `junction: "roundabout"`, `oneway: "yes"`.
* Connect incoming and outgoing lanes as separate branches snapped directly to the ring.

---

## 7. Waterways & Hydrological Flow (`layers/waterways.geojson`)

Linear waterways represent navigable channels, river centerlines, bayous, and drainage canals.

### Waterway Routing and Direction Tags
| Attribute | Allowed Values | Description |
|---|---|---|
| `oneway` | `"no"` (default), `"yes"`, `"-1"` | Navigability constraint for aquatic pathfinding engines |
| `flow_direction` | `"no"` (default), `"forward"`, `"backward"`, `"either"` | Physical water current direction |
| `waterway` | `"river"`, `"canal"`, `"stream"` | Functional waterway classification |
| `boat` | `"yes"`, `"no"` | Watercraft access flag |
| `layer` | `0` (surface), `-1` (culvert under road/rail) | Vertical Z-level |

### Flow Direction Rules
* **`flow_direction: "no"`** (Default): Stagnant channels, retention ponds, dead-end canals, or calm lake channels with no observable current.
* **`flow_direction: "forward"`**: Physical current moves in the digitizing direction (from vertex $0$ to vertex $n$).
* **`flow_direction: "backward"`**: Physical current moves against the digitizing direction.
* **`flow_direction: "either"`**: Reversible tidal flow (estuaries, tidal sloughs, and coastal inlets subject to ebb and flood tides).

### Continuity Across Lakes & Bayous
* Draw waterway centerlines continuously through lake polygons (`layers/water.geojson`) from inlet to outlet to maintain an unbroken aquatic routing graph.
* Where waterways pass under highways or railway embankments, split at the portals and tag with `tunnel: "culvert"`, `layer: -1`.

---

## 8. Quality Assurance & Pre-Commit Verification
Before committing edits:

1. **Save Layer Edits to Disk**: Click the **Save Layer Edits** icon on the Digitizing toolbar, or toggle off editing (pencil icon / `Ctrl + E` if assigned) and click **Save** when prompted. *(Do not rely solely on Project -> Save / `Ctrl + S`, which only saves `.qgz` project display settings rather than committing vector edits to `.geojson` files on disk).*
2. **Run the Formatter**:
   ```bash
   python scripts/format.py
   ```
   * Verifies coordinate precision (rounded to $1\text{ cm}$).
   * Purges stray auto-derived attributes (`county`, `county_slug`, `length_m`) to enforce layer purity.
   * Formats features onto single lines to guarantee clean Git diffs.
3. **Verify Git Diff**:
   ```bash
   git diff layers/
   ```
   Confirm that only the exact features you edited appear in the diff.
4. **Execute Full Pipeline Build (Optional)**:
   ```bash
   python scripts/run_pipeline.py
   ```
   Rebuilds the Master GeoPackage and renders the verification composite preview (`publication/qa_previews/qa_master_in_game_map.png`) in ~10 seconds.

### Submitting Your Edits
* **GitHub PR**: Open a pull request containing only the modified files under `layers/`.
* **Discord**: If you do not use Git, DM the modified `.geojson` file from `layers/` directly to **`@wpenistone`** on Discord.
