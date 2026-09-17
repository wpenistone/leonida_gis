## Summary

<!-- Brief summary of what was added, modified, or aligned (e.g. Added residential street grid in Ambrosia, adjusted railway siding alignment in Vice City). -->

## Layer(s) Modified

- [ ] `layers/roads.geojson`
- [ ] `layers/rail.geojson`
- [ ] `layers/landmarks.geojson`
- [ ] `layers/restrictions.geojson`
- [ ] `layers/waterways.geojson`
- [ ] `layers/areas.geojson`
- [ ] `layers/sections.geojson`
- [ ] `layers/water.geojson`

## County / Region Affected

- [ ] Vice-Dale County
- [ ] Kelly County
- [ ] Leonard County
- [ ] Lummox County
- [ ] Mariana County

## Pre-Submission Checklist

- [ ] **Saved Layer Edits**: Layer edits committed to disk in QGIS (`Ctrl + E` -> Save, not only Project Save).
- [ ] **Formatted Layers**: Ran `python scripts/format.py` (coordinates clamped to 1 cm, 1 line per feature, clean sequential IDs, pure OSM schema).
- [ ] **Strict Semantic Validation**: Ran `python scripts/validate.py --strict` with **0 errors and 0 warnings**.
- [ ] **Headless Plugin Verification**: Ran `python qgis_plugin/test_store_headless.py` (all tests passed).
- [ ] **Topology Verified**: Followed rules in `MAPPING_GUIDE.md` (at-grade junctions snapped, bridges vertically separated, no lines cut at county lines).
- [ ] **Clean Git Diff**: Checked `git diff` to ensure only intended features and attributes are modified.
- [ ] **Scope Limited**: Pure source layers in `layers/` only. No auto-derived attributes or build binaries committed.
