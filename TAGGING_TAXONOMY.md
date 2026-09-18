# State of Leonida GIS — Tagging Taxonomy & OSM Schema Reference

---

## Table of Contents
1. [Administrative Boundaries & Sections](#1-administrative-boundaries--sections-layerssectionsgeojson)
2. [OSM Areas & Landuse](#2-osm-areas--landuse-layersareasgeojson)
3. [Road Network & Highways](#3-road-network--highways-layersroadsgeojson)
4. [Waterways & Hydrology](#4-waterways--hydrology-layerswaterwaysgeojson)
5. [Railways & Public Transit](#5-railways--public-transit-layersrailgeojson)
6. [Turn Restrictions & Routing Relations](#6-turn-restrictions--routing-relations-layersrestrictionsgeojson)
7. [Landmarks & Points of Interest](#7-landmarks--points-of-interest-layerslandmarksgeojson)
8. [Topography & Coastlines](#8-topography--coastlines-derivedcontoursgeojson--gpkg-derivedcoastlinegeojson)
9. [JOSM Presets & OpenStreetMap Porting Workflow](#9-josm-presets--openstreetmap-porting-workflow)

---

## 1. Administrative Boundaries & Sections (`layers/sections.geojson`)

The administrative hierarchy in Leonida is structured across four standard OSM administrative levels:

```
State of Leonida (admin_level=4)
 ├── Counties (admin_level=6: Vice-Dale, Kelly, Leonard, Lummox, Mariana)
 │    ├── Municipalities / Cities (admin_level=8: Vice City, Port Gellhorn, Ambrosia, etc.)
 │    │    └── Sections / Suburbs / Neighbourhoods / Localities (admin_level=10: 92 sections)
```

### 1.1 Administrative Hierarchy Attributes

| Tag Key | Type | Allowed Values | Description & Leonida Context |
|---|---|---|---|
| `boundary` | String | `"administrative"` | Mandatory OSM tag identifying an administrative entity. |
| `admin_level` | Integer | `4`, `6`, `8`, `10` | Administrative level: `4` = State, `6` = County, `8` = City/Municipality, `10` = Section/Suburb/Locality. |
| `place` | String | `state`, `county`, `city`, `town`, `suburb`, `neighbourhood`, `locality`, `island`, `islet` | Geographic place classification. |
| `name` | String | Text | Official geographic name (e.g. `"Vice City"`, `"Ambrosia Hills"`). |
| `is_in:country`| String | `"United States"` | Sovereign nation. |
| `is_in:state` | String | `"Leonida"` | State jurisdiction. |
| `is_in:county`| String | County Name | Parent county (`"Vice-Dale County"`, `"Kelly County"`, `"Leonard County"`, `"Lummox County"`, `"Mariana County"`). |
| `is_in:municipality` | String | City Name | Parent municipality when applicable (e.g. `"Vice City"`, `"Port Gellhorn"`). |

### 1.2 County Classifications (`derived/counties_dissolved.geojson`)

| County Name | `admin_level` | `place` | `county_slug` | FIPS Equiv | Primary Characteristics |
|---|---|---|---|---|---|
| **Vice-Dale County** | `6` | `county` | `vice_dale` | `12086` | Dense metropolitan center, Vice City urban core, beaches, barrier islands. |
| **Kelly County** | `6` | `county` | `kelly` | `12099` | Northern agrarian territory, Ambrosia hills, raceway, suburban settlements. |
| **Leonard County** | `6` | `county` | `leonard` | `12011` | Coastal barrier islands, eastern wetlands, industrial recycling, zoo. |
| **Lummox County** | `6` | `county` | `lummox` | `12095` | Mountainous northern highlands, Mount Kalaga, state park, rugged coastal ridges. |
| **Mariana County** | `6` | `county` | `mariana` | `12087` | Archipelago of subtropical keys, shallow flats, barrier reefs, naval installations. |

### 1.3 Section Breakdown per County (`layers/sections.geojson`)

* **Vice-Dale County (37 Sections)**:
  * *Urban Suburbs & Districts (`place=suburb`)*: Downtown Vice City, Vice Beach, Little Haiti, Port Gellhorn, Starfish Island, Vice Point, Washington Beach, South Beach.
  * *Neighbourhoods (`place=neighbourhood`)*: Bluegrass, Peregrine Bay, Ocean Drive, Venetian Islands.
  * *Islands & Keys (`place=island` / `place=islet`)*: Catalan Key, Dalton Island, Ferry Island, Flagler Island, Gloriana Key, Picnic Islands.
* **Kelly County (15 Sections)**:
  * *Agrarian Towns & Suburbs (`place=suburb`)*: Ambrosia, North Ambrosia, North Gellhorn Hills.
  * *Rural Localities & Hills (`place=locality`)*: Ambrosia Hills, Buckskin, Emerald Springs, Mount Waffles.
  * *Specialized Venues (`place=locality`)*: Gellhorn International Raceway.
  * *Islands (`place=islet`)*: Kelly County Barrier Islands.
* **Leonard County (10 Sections)**:
  * *Coastal Localities (`place=locality`)*: Black Beach, North Beaches, Oceanside, Riverside.
  * *Suburbs (`place=suburb`)*: East Ambrosia.
  * *Specialized Facilities (`place=locality`)*: Leonida Zoo, Landfill.
* **Lummox County (11 Sections)**:
  * *Highlands & Mountains (`place=locality`)*: Mount Kalaga, Mount Leonida, Domed Hills, North Cape, North Coast.
  * *Protected Sanctuaries (`leisure=nature_reserve`)*: Mount Kalaga National Park.
  * *Islands (`place=islet`)*: Lummox County Barrier Islands, Northern Islands.
* **Mariana County (19 Sections)**:
  * *Named Keys & Barrier Islets (`place=island` / `place=islet`)*: Airward Key, East Key, Eastern Keys, Goliath, Goose Key, Inner Keys, Key West.
  * *Wetland Localities (`place=locality`)*: Grassrivers.

---

## 2. OSM Areas & Landuse (`layers/areas.geojson`)

Polygons defining zoning, natural landcover, sports amenities, public institutions, and aerodromes.

### 2.1 Landuse (`landuse=*`)

| Tag Key & Value | Description | OSM Carto Hex | Fill RGB | Leonida Mapping Example |
|---|---|---|---|---|
| `landuse=residential` | Residential neighborhoods and housing tracts | `#dfd1c6` | `223, 209, 198` | Subdivisions in Ambrosia, residential flats in Little Haiti |
| `landuse=commercial` | Corporate towers, financial centers, business parks | `#ffd0cb` | `255, 208, 203` | Downtown Vice City financial district, office parks |
| `landuse=retail` | Strip malls, regional shopping centers, car dealerships | `#ffd0cb` | `255, 208, 203` | Ocean Drive retail corridors, suburban commercial plazas |
| `landuse=industrial` | Warehouses, manufacturing plants, port cargo terminals | `#dfd1d6` | `223, 209, 214` | Port Gellhorn shipping docks, industrial warehouses |
| `landuse=construction` | Active construction sites and groundworks | `#c7c7b4` | `199, 199, 180` | High-rise construction sites in Vice City |
| `landuse=military` | Military bases, naval air stations, army depots | `#f5d5d5` | `245, 213, 213` | Naval Air Station in Mariana Keys, restricted bases |
| `landuse=railway` | Train depots, switching yards, transit maintenance hubs | `#dfd1d6` | `223, 209, 214` | Vice City rail transit maintenance yard |
| `landuse=farmland` | Cultivated croplands, orchards, agricultural fields | `#eef0d5` | `238, 240, 213` | Sugar cane and fruit plantations in Kelly County |
| `landuse=farmyard` | Barns, farm outbuildings, silo clusters | `#edd4c2` | `237, 212, 194` | Farmsteads in Kelly County countryside |
| `landuse=grass` | Maintained lawns, roadway medians, civic greens | `#cdebb0` | `205, 235, 176` | Civic parkway medians, manicured city lawns |
| `landuse=meadow` | Pasture land, wildflower meadows | `#cdebb0` | `205, 235, 176` | Open pastures surrounding Ambrosia |
| `landuse=forest` | Managed woodlands, timber reserves | `#add19e` | `173, 209, 158` | Pine forests of Lummox County |
| `landuse=cemetery` | Cemeteries, memorial parks, mausoleums | `#aacbaf` | `170, 203, 175` | Vice City Memorial Park Cemetery |
| `landuse=recreation_ground` | Municipal recreation grounds, public open space | `#c8facc` | `200, 250, 204` | Community athletic grounds |
| `landuse=quarry` | Rock quarries, surface gravel pits | `#c4c2c2` | `196, 194, 194` | Limestone quarry pits in Kelly County |

### 2.2 Natural & Environmental Features (`natural=*`)

| Tag Key & Value | Description | OSM Carto Hex | Fill RGB | Leonida Mapping Example |
|---|---|---|---|---|
| `natural=wood` | Natural undisturbed forest and mangrove canopies | `#add19e` | `173, 209, 158` | Dense hardwood hammocks, coastal mangroves |
| `natural=scrub` | Low shrubby vegetation, palmetto thickets | `#b5e3b5` | `181, 227, 181` | Sawgrass prairies, pine rockland scrub |
| `natural=wetland` | Marshes, swamps, Everglades sloughs | `#b5d0d0` | `181, 208, 208` | Grassrivers wetland floodplains |
| `natural=water` | Lakes, bays, major retention ponds | `#aad3df` | `170, 211, 223` | Lake Leonida, Peregrine Bay, coastal lagoons |
| `natural=beach` | Sandy ocean beaches, barrier island shoreline | `#fff1ba` | `255, 241, 186` | Vice Beach oceanfront, Black Beach shoreline |
| `natural=sand` | Coastal sand dunes, sand bars, dry sandbanks | `#fff1ba` | `255, 241, 186` | Dune ridges along barrier islands |
| `natural=bare_rock` | Exposed rocky peaks, cliffs, limestone shelves | `#dedede` | `222, 222, 222` | Mount Kalaga peak, rocky coastal cliffs |

### 2.3 Leisure & Sports (`leisure=*`)

| Tag Key & Value | Description | OSM Carto Hex | Fill RGB | Leonida Mapping Example |
|---|---|---|---|---|
| `leisure=park` | Landscaped city parks, beachfront promenades | `#c8facc` | `200, 250, 204` | Vice Beach Oceanfront Park |
| `leisure=golf_course` | Golf fairways, greens, driving ranges | `#b5e3b5` | `181, 227, 181` | Leafy Links Country Club, Vice Point Golf Club |
| `leisure=pitch` | Football, baseball, soccer fields, tennis courts | `#8ad3a6` | `138, 211, 166` | High school sports diamonds, public tennis courts |
| `leisure=stadium` | Major professional sports stadiums, racetracks | `#33cc99` | `51, 204, 153` | Vice City Arena, Gellhorn International Raceway |
| `leisure=marina` | Yacht marinas, recreational boat basins | `#b5d6e6` | `181, 214, 230` | Vice City Yacht Club, Ocean Drive Marina |
| `leisure=nature_reserve` | State parks, national nature sanctuaries | `#abde96` | `171, 222, 150` | Mount Kalaga National Park |

### 2.4 Civic Amenities & Public Services (`amenity=*`)

| Tag Key & Value | Description | OSM Carto Hex | Fill RGB | Leonida Mapping Example |
|---|---|---|---|---|
| `amenity=parking` | Surface parking lots, park-and-ride facilities | `#f7ebd2` | `247, 235, 210` | Beachfront public parking lots, mall parking |
| `amenity=university` | University and college campuses | `#f0f0d8` | `240, 240, 216` | University of Leonida main campus |
| `amenity=hospital` | Regional medical centers, hospital complexes | `#ffdad8` | `255, 218, 216` | Vice City General Hospital, Mount Sinai Health |
| `amenity=prison` | State correctional institutions, penitentiaries | `#eae0d0` | `234, 224, 208` | Leonida State Penitentiary |
| `amenity=ferry_terminal` | Ferry docks, water taxi stations | `#b5d6e6` | `181, 214, 230` | Vice City Ferry Terminal to Mariana Keys |

### 2.5 Aeroways (`aeroway=*`)

| Tag Key & Value | Description | OSM Carto Hex | Fill RGB | Leonida Mapping Example |
|---|---|---|---|---|
| `aeroway=aerodrome` | Overall airport property boundary | `#e9e7e2` | `233, 231, 226` | Vice City International Airport (VCIA) perimeter |
| `aeroway=apron` | Aircraft parking apron, cargo ramps | `#dadae0` | `218, 218, 224` | Passenger terminal gate aprons, cargo stands |
| `aeroway=runway` | Concrete/asphalt runway polygon footprint | `#bbbbbb` | `187, 187, 187` | Runway 09L/27R, Runway 12/30 |
| `aeroway=taxiway` | Concrete/asphalt taxiway polygon footprint | `#bbbbbb` | `187, 187, 187` | Parallel taxiways A, B, high-speed turnoffs |
| `aeroway=terminal` | Airport passenger terminal buildings | `#cc99ff` | `204, 153, 255` | VCIA Concourse A, B, C main terminals |
| `aeroway=hangar` | Aircraft maintenance and storage hangars | `#dadae0` | `218, 218, 224` | General aviation hangars, cargo hangars |
| `aeroway=helipad` | Dedicated helicopter landing pads | `#e9e7e2` | `233, 231, 226` | Hospital rooftop helipads, marina helipads |

---

## 3. Road Network & Highways (`layers/roads.geojson`)

### 3.1 Highway Hierarchy (`highway=*`)

| Highway Value | Functional Class | Casing Hex | Fill Hex | Casing Width | Fill Width |
|---|---|---|---|---|---|
| `highway=motorway` | Interstate Freeways | `#dc2a67` | `#e892a2` | `2.00 mm` | `1.40 mm` |
| `highway=motorway_link` | Freeway Ramps & Slip Roads | `#dc2a67` | `#e892a2` | `1.50 mm` | `1.00 mm` |
| `highway=trunk` | High-Speed Expressways | `#c84e2f` | `#f9b29c` | `1.80 mm` | `1.30 mm` |
| `highway=trunk_link` | Expressway Ramps | `#c84e2f` | `#f9b29c` | `1.30 mm` | `0.90 mm` |
| `highway=primary` | Major Arterials (Ocean Dr) | `#a06b00` | `#fcd6a4` | `1.60 mm` | `1.15 mm` |
| `highway=primary_link` | Arterial Slip Turns | `#a06b00` | `#fcd6a4` | `1.20 mm` | `0.80 mm` |
| `highway=secondary` | City Collector Streets | `#707d05` | `#f7fabf` | `1.40 mm` | `0.95 mm` |
| `highway=secondary_link` | Collector Slip Lanes | `#707d05` | `#f7fabf` | `1.05 mm` | `0.70 mm` |
| `highway=tertiary` | Neighborhood Connectors | `#8f8f8f` | `#ffffff` | `1.20 mm` | `0.80 mm` |
| `highway=tertiary_link` | Sub-collector Links | `#8f8f8f` | `#ffffff` | `0.90 mm` | `0.60 mm` |
| `highway=unclassified` | Rural Through-Roads | `#c6c6c6` | `#ffffff` | `1.05 mm` | `0.70 mm` |
| `highway=residential` | Neighborhood Streets | `#c6c6c6` | `#ffffff` | `1.05 mm` | `0.70 mm` |
| `highway=living_street` | Pedestrian-Priority Streets | `#c6c6c6` | `#ededed` | `0.95 mm` | `0.60 mm` |
| `highway=service` | Driveways & Parking Aisles | `#cfcfcf` | `#ffffff` | `0.80 mm` | `0.50 mm` |
| `highway=track` | Unpaved Dirt / Farm Roads | None | `#996600` (dash)| — | `0.55 mm` |
| `highway=pedestrian` | Pedestrian Plazas | `#999999` | `#dddde8` | `0.95 mm` | `0.60 mm` |
| `highway=footway` | Walkways & Sidewalks | None | `#fa8072` (dash)| — | `0.45 mm` |
| `highway=cycleway` | Dedicated Bike Paths | None | `#0088cc` (dash)| — | `0.45 mm` |

### 3.2 Directionality & Flow Tags

| Tag Key | Allowed Values | Rendering & Behavioral Effect |
|---|---|---|
| `oneway` | `"yes"`, `"1"`, `"true"` | Forward one-way flow ($v_0 \to v_n$). QGIS displays forward chevron arrows along the road center line at $20\text{ mm}$ intervals. |
| `oneway` | `"-1"` | Reverse one-way flow ($v_n \to v_0$). QGIS displays reverse chevron arrows pointing backward ($180^\circ$). |
| `oneway` | `"no"`, `"0"`, `"false"`, `NULL` | Bidirectional two-way traffic. No arrows. |
| `oneway` | `"reversible"` | Reversible lanes (e.g. tidal flow or hurricane evacuation routes). |
| `junction` | `"roundabout"` | Roundabout ring. Must be digitized counter-clockwise as a closed loop. Implies `oneway=yes`. |

### 3.3 Lane & Capacity Attributes

* **`lanes`**: Total physical travel lanes (e.g. `1`, `2`, `3`, `4`, `6`, `8`).
* **`lanes:forward`**: Lanes designated for travel in the digitizing direction.
* **`lanes:backward`**: Lanes designated for travel opposing the digitizing direction.
* **`turn:lanes`**: Lane-by-lane turn guidance from leftmost to rightmost lane separated by pipes (e.g. `"left|through|right"`).

### 3.4 Physical & Structural Tags

* **`bridge=yes`**: Elevated bridge deck. Renders black `#000000` abutment deck underlays ($+0.5\text{ mm}$ width, square capstyle).
* **`tunnel=yes`**: Subterranean vehicular tunnel. Renders dashed road casings (`customdash="4;2.5"`).
* **`layer`**: Relative vertical Z-level hierarchy. Ground level is `0`; overpass bridges use `1` or `2`; underpass tunnels use `-1` or `-2`.
* **`surface`**: Physical pavement: `"asphalt"`, `"concrete"`, `"paved"`, `"unpaved"`, `"gravel"`, `"dirt"`.
* **`maxspeed`**: Speed limit in miles per hour (mph): `"70"`, `"65"`, `"55"`, `"45"`, `"35"`, `"25"`.
* **`ref`**: Route reference shield: `"I-97"`, `"US-1"`, `"FL-A1A"`.
* **`name`**: Street name: `"Ocean Drive"`, `"Vice Freeway"`, `"Biscayne Boulevard"`.

---

## 4. Waterways & Hydrology (`layers/waterways.geojson`)

Navigable channels, rivers, bayous, and drainage networks.

| Tag Key | Allowed Values | Default | Description |
|---|---|---|---|
| `waterway` | `"river"`, `"canal"`, `"stream"`, `"drain"` | `"river"` | Functional hydrology classification. |
| `flow_direction` | `"no"`, `"forward"`, `"backward"`, `"either"` | `"no"` | Physical water current direction: `"no"` for stagnant retention canals/lakes; `"forward"` for downstream current; `"either"` for reversible tidal sloughs. |
| `oneway` | `"no"`, `"yes"`, `"-1"` | `"no"` | Navigability constraint for aquatic pathfinding engines. |
| `boat` | `"yes"`, `"no"` | `"yes"` | Navigable watercraft access flag. |
| `tunnel` | `"culvert"`, `"yes"` | — | Waterway passing through a culvert beneath a road or railway embankment. |
| `layer` | `0`, `-1` | `0` | Vertical level (`-1` for culverts). |

---

## 5. Railways & Public Transit (`layers/rail.geojson`)

Heavy rail, commuter rail, and automated people movers (Vice City Transit).

| Tag Key | Allowed Values | Description |
|---|---|---|
| `railway` | `"rail"`, `"light_rail"`, `"subway"`, `"tram"`, `"monorail"` | Rail transit technology. |
| `service` | `"mainline"`, `"yard"`, `"siding"`, `"spur"`, `"crossover"` | Track role within rail network. |
| `highspeed` | `"yes"`, `"no"` | Dedicated high-speed passenger rail corridor. |
| `gauge` | `"1435"` | Standard gauge ($1435\text{ mm}$ / $4\text{ ft } 8.5\text{ in}$). |
| `electrified` | `"contact_line"`, `"third_rail"`, `"no"` | Traction electrification system. |
| `bridge` | `"yes"`, `"viaduct"` | Rail bridge structure. |
| `tunnel` | `"yes"` | Rail tunnel structure. |
| `layer` | `-1`, `0`, `1` | Vertical level. |

---

## 6. Turn Restrictions & Routing Relations (`layers/restrictions.geojson`)

Enforces legal vehicular navigation at intersections, modeled on the OSM
`type=restriction` relation. One GeoJSON Point feature = one restriction; the
**Point geometry IS the via** (snapped onto the from-way), replacing OSM's
separate via-node.

| Tag Key | Allowed Values | Description |
|---|---|---|
| `type` | `"restriction"` | Mandatory OSM relation type tag. |
| `restriction` | `"no_left_turn"`, `"no_right_turn"`, `"no_u_turn"`, `"only_straight_on"`, `"only_left_turn"`, `"only_right_turn"` | Regulatory turning constraint. |
| `from_way` | Road `ref_id` (`R_####`) | Way on which the vehicle approaches the intersection. |
| `to_way` | Road `ref_id` (`R_####`) | Way into which the vehicle is forbidden (or required) to turn. |
| `except` | `emergency`, `police`, ... (optional) | Vehicle classes exempt from the restriction. |

* **Via model**: the feature's Point geometry must sit on (or within 25 m of) the
  from-way — `scripts/validate.py` enforces this, along with resolvability of
  `from_way`/`to_way`.
* **Editing workflow**: use the **Leonida Turn Restrictions** QGIS plugin
  (`qgis_plugin/leonida_turn_restrictions`, see README) which implements the
  click-from → click-via → click-to flow and writes canonical GeoJSON directly.
  Hand-editing the file is supported; `format.py` + `validate.py` will verify it.

---

## 7. Landmarks & Points of Interest (`layers/landmarks.geojson`)

Direct translation between GTADB POI types and OpenStreetMap feature tags:

| GTADB POI Category | Standard OSM Tag | Example Leonida POI |
|---|---|---|
| **Gas Station** | `amenity=fuel` | Xero Gas, Globe Oil, RON Gas |
| **Hospital / Medical** | `amenity=hospital` or `amenity=clinic` | Vice City General Emergency |
| **Police Station** | `amenity=police` | Vice City Police Department (VCPD) HQ |
| **Fire Station** | `amenity=fire_station` | Vice-Dale County Fire Rescue Station 1 |
| **Bank / ATM** | `amenity=bank` / `amenity=atm` | Fleeca Bank, Maze Bank Branch |
| **Restaurant / Diner** | `amenity=restaurant` or `amenity=fast_food` | Cluckin' Bell, Up-n-Atom, Burger Shot |
| **Bar / Nightclub** | `amenity=bar` or `amenity=nightclub` | Malibu Club, Ocean Drive Lounges |
| **Hotel / Resort** | `tourism=hotel` | Ocean View Hotel, Vice Point Grand Resort |
| **Attraction / Viewpoint** | `tourism=attraction` or `tourism=viewpoint` | Mount Kalaga Scenic Overlook |
| **Car Dealership / Repair**| `shop=car` or `shop=car_repair` | Premium Deluxe Motorsport, Pay 'n' Spray |
| **Convenience Store** | `shop=convenience` | 24/7 Supermarket, Rob's Liquor |

---

## 8. Topography & Coastlines (`derived/contours.geojson` / `.gpkg`, `derived/coastline.geojson`)

* **`contour=elevation`**: Topographic elevation isolines derived via 27-level empirical hypsometric quantile distribution from the 16-bit DEM heightmap.
  * `ele`: Elevation in meters from sea level ($0.0\text{ m}$ to $+800.0\text{ m}$).
  * `is_index`: Boolean flag (`true` / `false`) indicating primary index contours (e.g. $0.9\text{ m}, 1.6\text{ m}, 4.2\text{ m}, 13.5\text{ m}, 53.0\text{ m}, 126.9\text{ m}, 229.8\text{ m}, 416.3\text{ m}$).
* **`natural=coastline`**: Mean high-water shoreline separating land from ocean. Land lies to the left of the line when following its vertex direction.

---

## 9. JOSM Presets & OpenStreetMap Porting Workflow

### 9.1 Using `josm_presets_leonida.xml` in JOSM
1. Open **JOSM** -> **Preferences** (`F12`).
2. Navigate to **Map Settings** -> **Tagging Presets**.
3. Click **+** (Add Preset) -> select **From File** -> browse to `josm_presets_leonida.xml` in this repository.
4. Click **OK**. The **Leonida Roads**, **Leonida Administrative**, **Leonida Landuse**, and **Leonida Waterways** toolbars and menus will appear automatically with pre-configured tagging buttons.

### 9.2 Coordinate Reprojection (In-Game Meters $\leftrightarrow$ WGS 84)
* **Projection**: Equirectangular (`EPSG:4087`).
* Reprojection to WGS 84 (`EPSG:4326` Latitude / Longitude) is performed automatically by `scripts/04_build_publication.py` and QGIS via standard PROJ transformation pipelines:
  $$\text{Lon} = \frac{X}{R \cdot \cos(\text{lat\_ts})}, \quad \text{Lat} = \frac{Y}{R}$$
  where $R = 6,378,137\text{ m}$ and $\text{lat\_ts} = 0^\circ$.
