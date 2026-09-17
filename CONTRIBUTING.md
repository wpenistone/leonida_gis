# Contributing to Leonida GIS

Thank you for contributing to the Leonida GIS project. This guide outlines the contribution process, repository rules, and submission options.

---

## Contribution Channels

You can submit mapping data through either of two channels:

1. **GitHub Pull Request**: Recommended for contributors familiar with Git.
2. **Discord Submission**: For contributors who use QGIS but prefer not to use Git. Send modified `.geojson` files from the `layers/` directory directly to **`@wpenistone`** on Discord.

---

## Repository Boundary Rules

To maintain an unpolluted Git history:

* **Edit ONLY files in `layers/`**:
  * `layers/roads.geojson`
  * `layers/rail.geojson`
  * `layers/landmarks.geojson`
  * `layers/sections.geojson`
  * `layers/restrictions.geojson`
  * `layers/waterways.geojson`
  * `layers/water.geojson`
  * `layers/areas.geojson`
* **Do NOT commit generated files**:
  * `derived/` (automatically built by pipeline)
  * `publication/` (compiled GeoPackage, Shapefiles, and GeoJSON releases)
  * `rasters/` (base satellite and elevation rasters)
  * `leonida_map_project.qgz` or `leonida_map_project.qgs` (unless explicitly updating project-wide styling)

---

## Step-by-Step GitHub PR Workflow

### 1. Environment Setup
```bash
git clone https://github.com/<your-username>/leonida_gis.git
cd leonida_gis
pip install -r requirements.txt
python scripts/setup_hooks.py
```
`setup_hooks.py` enables the Git pre-commit hook (`.githooks/pre-commit`), which runs `scripts/format.py` automatically before every commit.

### 2. Create a Branch
```bash
git checkout -b feat/describe-your-change
```

### 3. Digitize in QGIS
1. Open `leonida_map_project.qgz` in QGIS 3.x.
2. Select your target layer under **📁 Active Work Layers (Editable `layers/`)**.
3. Toggle edit mode (**`Ctrl + E`**).
4. Follow the topological standards in **[MAPPING_GUIDE.md](MAPPING_GUIDE.md)**:
   * Snap at-grade intersections (key **`S`**, $15\text{ m}$ tolerance).
   * Do not snap grade-separated overpasses (hold **`Ctrl`** to suspend snapping).
   * Do not split lines at county borders.
   * Digitize one-way roads and rivers in the direction of flow.
5. Enter required semantic tags (`highway`, `name`, `lanes`, `layer`, `bridge`, `tunnel`). Do not add auto-calculated fields like `county` or `length_m`—canonical work layers must remain pure OpenStreetMap schema.

### 4. Save Layer Edits to Disk
* Click the **Save Layer Edits** icon on the Digitizing toolbar, **OR**
* Press **`Ctrl + E`** (Toggle Editing) and click **Save** when prompted.
* *Note*: Standard `Ctrl + S` only saves QGIS project display settings to `.qgz`, not your vector edits to disk.

### 5. Format and Lint
If you did not enable Git hooks, run the formatter manually:
```bash
python scripts/format.py
```
This performs:
* Quantization of coordinates to 2 decimal places ($1\text{ cm}$ precision).
* Purging of any stray auto-derived attributes (`county`, `county_slug`, `length_m`, etc.) to enforce strict layer purity.
* Assignment and normalization of prefixed `ref_id`s (`R_####`, `T_####`, `A_####`).
* Serialization of each feature onto exactly one single line with sorted keys.

### 6. Inspect Your Diff
```bash
git diff layers/
```
Verify that only the exact features you created or modified appear in the diff.

### 7. Push and Submit Pull Request
```bash
git add layers/
git commit -m "feat(roads): add industrial connector in Port Gellhorn"
git push origin feat/describe-your-change
```
Open a PR against the `main` branch on GitHub. Fill out the provided pull request template. GitHub Actions CI will validate your formatting and test the pipeline build automatically.
