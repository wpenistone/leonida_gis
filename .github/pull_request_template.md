## Summary

<!-- Brief summary of what was added, modified, or aligned (e.g. Added residential street grid in Ambrosia, adjusted railway siding alignment in Vice City). -->

## Layer(s) Modified

- [ ] `layers/roads.geojson`
- [ ] `layers/rail.geojson`
- [ ] `layers/landmarks.geojson`
- [ ] `layers/water.geojson`
- [ ] `layers/sections.geojson`
- [ ] `layers/restrictions.geojson`

## County / Region Affected

- [ ] Vice-Dale County
- [ ] Kelly County
- [ ] Leonard County
- [ ] Lummox County
- [ ] Mariana County

## Pre-Submission Checklist

- [ ] **Saved Layer Edits**: Layer edits committed to disk in QGIS (`Ctrl + E` -> Save, not only Project Save).
- [ ] **Formatted Layers**: Ran `python scripts/format.py` (coordinates clamped to 1 cm, 1 line per feature, dynamic county tags derived).
- [ ] **Topology Verified**: Followed rules in `MAPPING_GUIDE.md` (at-grade junctions snapped, bridges vertically separated, no lines cut at county lines).
- [ ] **Clean Git Diff**: Checked `git diff` to ensure only intended features are modified.
- [ ] **Scope Limited**: No generated release files (`publication/`, `derived/`) or binary files (`.gpkg`, `.shp`) committed.
