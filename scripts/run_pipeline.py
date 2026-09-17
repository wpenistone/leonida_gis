#!/usr/bin/env python3
"""
Master Pipeline Runner: State of Leonida GIS
============================================
Consumes human-edited work layers from layers/ and updates:
- derived/ (merged intermediates and topology)
- publication/ (master GeoPackage, GeoJSONs, Shapefiles)
- publication/qa_previews/ (High-res composite verification renders)

Note: The master QGIS project (leonida_map_project.qgz) is preserved and edited
directly in QGIS to protect user symbology and view settings. Pass --rebuild-project
only if you explicitly wish to regenerate the QGIS project bundle from templates.

Usage:
    python scripts/run_pipeline.py [--rebuild-project]
"""

import os
import sys
import argparse
import subprocess
import time
from config import SCRIPTS_DIR, PROJECT_ROOT

PIPELINE_STEPS = [
    ("01_georeference_base.py", "Georeference base raster in in-game metric space"),
    ("03_build_derived.py", "Build derived intermediates and topology from canonical work files"),
    ("02_extract_contours.py", "Extract elevation contours and coastline from 16-bit DEM"),
    ("extract_figma_terrain.py", "Extract Figma community map terrain & buildings"),
    ("04_build_publication.py", "Package final GeoJSON, GeoPackage, and Shapefiles"),
    ("06_generate_qa.py", "Generate master visual QA verification composite render"),
]

def run_pipeline():
    parser = argparse.ArgumentParser(description="State of Leonida GIS Pipeline Runner")
    parser.add_argument("--rebuild-project", action="store_true", help="Rebuild the QGIS project bundle")
    args = parser.parse_args()

    steps = list(PIPELINE_STEPS)
    if args.rebuild_project:
        # Insert project builder before the QA composite render
        steps.insert(-1, ("05_build_qgis_project.py", "Rebuild QGIS project and bundle"))

    print("Running State of Leonida GIS pipeline...")
    t0 = time.time()

    for script_name, desc in steps:
        script_path = os.path.join(SCRIPTS_DIR, script_name)
        print(f"\n--- Running {script_name}: {desc} ---")
        res = subprocess.run([sys.executable, script_path], cwd=PROJECT_ROOT, capture_output=True, text=True)
        if res.stdout:
            print(res.stdout.strip())
        if res.returncode != 0:
            print(f"[ERROR] Step {script_name} failed with exit code {res.returncode}")
            if res.stderr:
                print(res.stderr.strip())
            sys.exit(res.returncode)

    elapsed = time.time() - t0
    print(f"\nPipeline completed in {elapsed:.2f} seconds.")

if __name__ == "__main__":
    run_pipeline()
