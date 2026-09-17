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
1. Select the layer and press **`Ctrl + E`** (Toggle Editing).
2. Enable the **Advanced Digitizing Toolbar** (`View` -> `Toolbars` -> `Advanced Digitizing Toolbar`).
3. Click the **"Reverse Line"** tool (icon showing two opposing horizontal arrows), or press the vertex tool and right-click the line feature -> **Reverse line direction**.
4. Click on the line you wish to reverse. The directional arrows will flip instantly.
5. Save layer edits: click the **Save Layer Edits** icon on the Digitizing toolbar, or press **`Ctrl + E`** and confirm Save.

---

## 3. Splitting Lines

A single road or railway segment must be split into two separate features when attributes change along its length.

### When to Split
| Condition | Trigger | Action |
|---|---|---|
| **Lane Drop / Addition** | Road widens or narrows | Split at transition node; update `lanes` on the wider/narrower segment |
| **Bridge Transition** | Surface road elevates onto an overpass | Split at abutments; tag bridge segment with `layer: 1`, `bridge: "yes"` |
| **Tunnel Transition** | Surface road enters subterranean bore | Split at portals; tag tunnel segment with `layer: -1`, `tunnel: "yes"` |
| **One-Way Start / End** | Two-way street becomes one-way | Split at junction; set `oneway: "yes"` on the one-way segment |
| **Speed Limit Change** | Highway enters urban zone | Split at posted sign location; update `maxspeed` |
| **Surface Change** | Pavement ends | Split at transition; set `surface: "dirt"` or `"gravel"` |

**Do NOT split for**:
* Crossing a county boundary or municipality line.
* Arbitrary distance limits.

### Step-by-Step: How to Split in QGIS
1. Enable editing on the layer (**`Ctrl + E`**).
2. Select the line feature using the **Select Features** tool (`V` or selection box).
3. Activate the **"Split Features"** tool (located on the Advanced Digitizing Toolbar, or menu: `Edit` -> `Split Features`).
4. Click once on one side of the road line.
5. Move the cursor across the road to the other side (a red split line will appear across the segment).
6. **Right-click** to commit the split.
7. The line is now two independent features:
   * Both segments initially inherit the original attributes.
   * Open the Attribute Table or Feature Form for the segment that changed and update its specific attributes (`layer`, `bridge`, `lanes`, etc.).
8. Save layer edits: click the **Save Layer Edits** icon on the Digitizing toolbar, or press **`Ctrl + E`** and confirm Save.

---

## 4. Disconnecting / Unlinking Nodes (Fixing Accidental Snaps)

### The Problem
When drawing an elevated bridge, flyover ramp, or overpass, QGIS snapping may accidentally snap to the surface road passing underneath, binding both roads to a shared vertex. This creates a false at-grade intersection where cars could illegally turn from a freeway bridge onto a local street below.

### How to Disconnect in QGIS
1. Enable editing on the layer (**`Ctrl + E`**).
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

1. **Save Layer Edits to Disk**: Click the **Save Layer Edits** icon on the Digitizing toolbar, or toggle off editing (**`Ctrl + E`**) and click **Save** when prompted. *(Do not rely solely on Project -> Save / `Ctrl + S`, which only saves `.qgz` project display settings rather than committing vector edits to `.geojson` files on disk).*
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
