#!/usr/bin/env python3
"""
State of Leonida GIS - Repository Launcher and Synchronization Tool
===================================================================
Command-line interface to inspect Git status, safely synchronize upstream
background data, validate layer schema, contribute edits, and launch QGIS.

Usage:
    python launch.py [--gui] [--launch] [--sync] [--contribute] [--validate]
"""

import os
import sys
import argparse

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "scripts"))
import launcher_core


def run_cli():
    print("============================================================")
    print("State of Leonida GIS - Repository Status")
    print("============================================================")
    status = launcher_core.check_repo_status()

    if not status["is_git"]:
        print("Notice: Current directory is not a Git repository.")
    else:
        branch = status["branch"]
        clean = status["clean"]
        modified_layers = status.get("modified_layers", [])
        behind = status.get("behind", 0)
        ahead = status.get("ahead", 0)

        status_line = "Status: Ready to work. Local layers are protected."
        if len(modified_layers) > 0:
            status_line = f"Status: {len(modified_layers)} layer(s) modified locally (ready to contribute)."
        elif behind > 0:
            status_line = f"Status: Upstream has {behind} new update(s). Update recommended."
        print(status_line)

        details = [f"Branch: {branch}"]
        if status.get("remote_ok", False):
            if behind == 0 and ahead == 0:
                details.append("Upstream: Up to date")
            else:
                if behind > 0:
                    details.append(f"{behind} behind")
                if ahead > 0:
                    details.append(f"{ahead} ahead")
        else:
            details.append("Upstream: Remote check skipped")

        if modified_layers:
            details.append(f"Work layers: {len(modified_layers)} modified")
        elif clean:
            details.append("Work layers: Clean")
        print(" | ".join(details))

        if modified_layers:
            print("\nModified work layers:")
            for lyr in modified_layers:
                print(f"  - {lyr}")

    print("============================================================")
    print("Work Locally:")
    print("  1. Launch QGIS Project (Default: press Enter)")
    print("  2. Update background data and sources (Safe pull, preserves your work)")
    print("\nContribute:")
    print("  3. Contribute my edits upstream (Format, validate, commit and push)")
    print("\nAdvanced:")
    print("  4. Format and validate layers")
    print("  5. Install or link QGIS plugin")
    print("  6. Run full build pipeline")
    print("  7. Open graphical launcher (launch_gui.pyw)")
    print("  0. Exit")
    print("============================================================")

    try:
        choice = input("Enter choice [1]: ").strip()
    except (KeyboardInterrupt, EOFError):
        print("\nExiting.")
        sys.exit(0)

    if choice in ("", "1"):
        print("Launching QGIS project...")
        ok, msg = launcher_core.launch_qgis()
        print(msg)
    elif choice == "2":
        print("Safely updating background data and sources...")
        ok, msg = launcher_core.update_background_data(log_fn=print)
        print(msg)
    elif choice == "3":
        note = input("Summary of changes (optional, press Enter to skip): ").strip()
        print("Preparing contribution...")
        ok, msg = launcher_core.contribute_edits(commit_note=note if note else None, log_fn=print)
        print(msg)
    elif choice == "4":
        print("Formatting work layers...")
        rc_f, out_f, _ = launcher_core.format_layers()
        if out_f:
            print(out_f)
        print("Validating layers (strict mode)...")
        rc_v, out_v, _ = launcher_core.validate_layers(strict=True)
        if out_v:
            print(out_v)
        if rc_v == 0:
            print("Validation passed: All layers strictly valid.")
    elif choice == "5":
        print("Installing QGIS plugin...")
        rc_p, out_p, _ = launcher_core.install_plugin()
        if out_p:
            print(out_p)
    elif choice == "6":
        print("Running build pipeline...")
        rc_pipe, out_pipe, err_pipe = launcher_core.run_pipeline()
        if out_pipe:
            print(out_pipe)
        if err_pipe:
            print(err_pipe)
        if rc_pipe == 0:
            print("Pipeline completed successfully.")
    elif choice == "7":
        pyw_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "launch_gui.pyw")
        if os.path.exists(pyw_path):
            import subprocess
            subprocess.Popen([sys.executable, pyw_path])
        else:
            print(f"Error: {pyw_path} not found.")
    elif choice == "0":
        sys.exit(0)
    else:
        print(f"Unknown option: {choice}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="State of Leonida GIS Launcher")
    parser.add_argument("--gui", action="store_true", help="Launch the PyQt6 graphical interface")
    parser.add_argument("--launch", action="store_true", help="Launch QGIS directly")
    parser.add_argument("--sync", action="store_true", help="Update background data safely and exit")
    parser.add_argument("--contribute", action="store_true", help="Format, validate, and push edits upstream")
    parser.add_argument("--validate", action="store_true", help="Format and validate layers and exit")
    args = parser.parse_args()

    if args.gui:
        pyw_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "launch_gui.pyw")
        import subprocess
        subprocess.Popen([sys.executable, pyw_path])
        sys.exit(0)
    elif args.launch:
        ok, msg = launcher_core.launch_qgis()
        print(msg)
        sys.exit(0 if ok else 1)
    elif args.sync:
        ok, msg = launcher_core.update_background_data(log_fn=print)
        print(msg)
        sys.exit(0 if ok else 1)
    elif args.contribute:
        ok, msg = launcher_core.contribute_edits(log_fn=print)
        print(msg)
        sys.exit(0 if ok else 1)
    elif args.validate:
        launcher_core.format_layers()
        rc, out, _ = launcher_core.validate_layers(strict=True)
        if out:
            print(out)
        sys.exit(rc)
    else:
        run_cli()
