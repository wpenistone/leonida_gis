#!/usr/bin/env python3
"""
State of Leonida GIS - Interactive Launcher & Upstream Sync
===========================================================
CLI tool to inspect Git state, sync upstream changes safely with
OpenStreetMap 1-line-per-feature GeoJSON merging, validate work layers,
and launch the master QGIS project.

Usage:
    python launch.py [--gui] [--launch] [--sync] [--validate]
"""

import os
import sys
import argparse

# Add scripts directory to path
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "scripts"))
import launcher_core


def print_banner():
    print("""
========================================================================
             STATE OF LEONIDA GIS - MASTER LAUNCHER
========================================================================
 Native In-Game Metric Equirectangular Grid (EPSG:4087)
 Vice City, Leonida - OpenStreetMap Geodatabase Stack
========================================================================""")


def run_cli():
    print_banner()
    print("Checking repository and upstream status...")
    status = launcher_core.check_repo_status()

    if not status["is_git"]:
        print("[WARNING] Current folder does not appear to be a valid Git repository.")
    else:
        print(f"  Branch:          {status['branch']}")
        if status["remote_ok"]:
            if status["behind"] == 0 and status["ahead"] == 0:
                print("  Upstream Status: Up to date with origin/master")
            else:
                msg = []
                if status["behind"] > 0:
                    msg.append(f"{status['behind']} commit(s) behind upstream")
                if status["ahead"] > 0:
                    msg.append(f"{status['ahead']} commit(s) ahead of upstream")
                print(f"  Upstream Status: {', '.join(msg)}")
        else:
            print(f"  Upstream Status: Offline / Remote check skipped ({status.get('remote_msg')})")

        # Local Changes
        if status["clean"]:
            print("  Working Tree:    Clean (no unstaged changes)")
        else:
            if status["modified_layers"]:
                print(f"  Work Layers:     {len(status['modified_layers'])} layer(s) modified:")
                for lyr in status["modified_layers"]:
                    print(f"                   - {lyr}")
            if status["modified_other"]:
                print(f"  Other Files:     {len(status['modified_other'])} file(s) modified")
            if status["untracked"]:
                print(f"  Untracked:       {len(status['untracked'])} new file(s)")

    print("------------------------------------------------------------------------")

    # If completely clean and up to date
    ready_to_launch = status["clean"] and status.get("behind", 0) == 0

    if ready_to_launch:
        print("  \033[92mEverything is up to date. You can now launch QGIS!\033[0m")
    elif status.get("behind", 0) > 0:
        print("  \033[93mNotice: Upstream has new updates available.\033[0m")
        print("  In Leonida GIS, road, rail, and landuse layers use 1-line-per-feature")
        print("  serialization, allowing Git to cleanly 3-way merge remote updates")
        print("  without overwriting your digitized roads.")
    elif not status["clean"]:
        print("  \033[93mNotice: You have uncommitted local changes.\033[0m")

    print("------------------------------------------------------------------------")
    print("Options:")
    print("  [1] Launch QGIS Project (Default: press Enter)")
    print("  [2] Pull / Sync Latest from Upstream (git pull --rebase + validate)")
    print("  [3] Format & Validate Work Layers (format.py + validate.py)")
    print("  [4] Install / Link QGIS Turn Restrictions Plugin (live sync)")
    print("  [5] Run Full GIS Build Pipeline (derived, geopackage, shapefiles)")
    print("  [6] Open Graphical Launcher GUI (launch.pyw)")
    print("  [0] Exit")
    print("------------------------------------------------------------------------")

    try:
        choice = input("Enter choice [1]: ").strip()
    except (KeyboardInterrupt, EOFError):
        print("\nExiting.")
        sys.exit(0)

    if choice in ("", "1"):
        print("\nLaunching QGIS project...")
        ok, msg = launcher_core.launch_qgis()
        print(f"  {msg}")
    elif choice == "2":
        print("\nPulling latest changes from upstream...")
        rc, out, err = launcher_core.pull_upstream()
        if out:
            print(out)
        if err:
            print(err)
        print("\nFormatting and validating layers...")
        launcher_core.format_layers()
        rc_v, out_v, _ = launcher_core.validate_layers(strict=False)
        if out_v:
            print(out_v)
        print("\nUpstream sync complete. You can now launch QGIS!")
    elif choice == "3":
        print("\nFormatting work layers...")
        rc_f, out_f, _ = launcher_core.format_layers()
        if out_f:
            print(out_f)
        print("\nValidating work layers (strict mode)...")
        rc_v, out_v, _ = launcher_core.validate_layers(strict=True)
        if out_v:
            print(out_v)
        if rc_v == 0:
            print("\n[PASS] All layers are cleanly formatted and valid!")
    elif choice == "4":
        print("\nInstalling / linking Turn Restrictions plugin into QGIS...")
        rc_p, out_p, _ = launcher_core.install_plugin()
        if out_p:
            print(out_p)
    elif choice == "5":
        print("\nRunning full GIS build pipeline (this may take 30-60 seconds)...")
        rc_pipe, out_pipe, err_pipe = launcher_core.run_pipeline()
        if out_pipe:
            print(out_pipe)
        if err_pipe:
            print(err_pipe)
        if rc_pipe == 0:
            print("\n[SUCCESS] Pipeline finished cleanly.")
    elif choice == "6":
        pyw_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "launch.pyw")
        if os.path.exists(pyw_path):
            import subprocess
            subprocess.Popen([sys.executable, pyw_path])
        else:
            print(f"[ERROR] Could not find {pyw_path}")
    elif choice == "0":
        sys.exit(0)
    else:
        print(f"Unknown option '{choice}'. Exiting.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="State of Leonida GIS Launcher")
    parser.add_argument("--gui", action="store_true", help="Launch the GUI version (launch.pyw)")
    parser.add_argument("--launch", action="store_true", help="Launch QGIS directly without interactive prompt")
    parser.add_argument("--sync", action="store_true", help="Sync from upstream directly and exit")
    parser.add_argument("--validate", action="store_true", help="Format and validate layers directly and exit")
    args = parser.parse_args()

    if args.gui:
        pyw_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "launch.pyw")
        import subprocess
        subprocess.Popen([sys.executable, pyw_path])
        sys.exit(0)
    elif args.launch:
        ok, msg = launcher_core.launch_qgis()
        print(msg)
        sys.exit(0 if ok else 1)
    elif args.sync:
        launcher_core.pull_upstream()
        launcher_core.format_layers()
        launcher_core.validate_layers()
        sys.exit(0)
    elif args.validate:
        launcher_core.format_layers()
        rc, out, _ = launcher_core.validate_layers(strict=True)
        if out:
            print(out)
        sys.exit(rc)
    else:
        run_cli()
