#!/usr/bin/env python3
"""
Step 01: Georeference Base Raster in In-Game Metric Space
=========================================================
Generates spatial world files (.pgw, .wld) and projection file (.prj)
for background_map.png so that QGIS and GDAL open the base raster directly
in native in-game metric coordinates:
- Upper-Left Corner: (-10721.650, +9704.211)
- Lower-Right Corner: (+3876.150, -8557.129)
- Pixel Resolution: 5.636216 m/px isotropic
"""

import os
from config import (
    BACKGROUND_PGW, BACKGROUND_WLD, BACKGROUND_PRJ,
    PIXEL_DX, PIXEL_DY, PIXEL_X0, PIXEL_Y0, CRS_WKT,
    SOURCES_DIR
)

def georeference_raster():
    print(">>> [Step 01] Georeferencing base map raster into in-game metric space...")
    
    world_content = (
        f"{PIXEL_DX:.10f}\n"
        f"0.0000000000\n"
        f"0.0000000000\n"
        f"{PIXEL_DY:.10f}\n"
        f"{PIXEL_X0:.10f}\n"
        f"{PIXEL_Y0:.10f}\n"
    )
    
    # Write to root
    for p in [BACKGROUND_PGW, BACKGROUND_WLD]:
        with open(p, "w", encoding="utf-8") as f:
            f.write(world_content)
            
    with open(BACKGROUND_PRJ, "w", encoding="utf-8") as f:
        f.write(CRS_WKT)
        
    # Write to sources
    src_pgw = os.path.join(SOURCES_DIR, "background_map.pgw")
    src_prj = os.path.join(SOURCES_DIR, "background_map.prj")
    with open(src_pgw, "w", encoding="utf-8") as f:
        f.write(world_content)
    with open(src_prj, "w", encoding="utf-8") as f:
        f.write(CRS_WKT)
        
    print(f"  Generated world files (.pgw, .wld) at {PIXEL_DX:.4f} m/px")
    print(f"  Generated projection file (.prj) with in-game metric WKT")
    print(f"  Raster extent mapped to: SW=(-10721.65, -8557.13), NE=(3876.15, 9704.21)")

if __name__ == "__main__":
    georeference_raster()
