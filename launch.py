#!/usr/bin/env python3
"""
State of Leonida GIS - Repository Launcher and Synchronization Tool
===================================================================
Command-line interface to inspect Git status, synchronize upstream
changes, validate layer schema, and launch the QGIS project.

Usage:
    python launch.py [--gui] [--launch] [--sync] [--validate]
"""

import os
import sys
import argparse

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "scripts"))
import launcher_core


def run_cli():
    print("State of Leonida GIS - Repository Status")
    print("----------------------------------------")
    status = launcher_core.check_repo_status()

    if not status["is_git"]:
        print("Notice: Current directory is not a Git repository.")
    else:
        print(f"Branch: {status['branch']}")
        if status["remote_ok"]:
            if status["behind"] == 0 and status["ahead"] == 0:
                print("Upstream: Up to date with origin/master")
            else:
                details = []
                if status["behind"] > 0:
                    details.append(f"{status['behind']} commit(s) behind upstream")
                if status["ahead"] > 0:
                    details.append(f"{status['ahead']} commit(s) ahead of upstream")
                print(f"Upstream: {', '.join(details)}")
        else:
            print(f"Upstream: Remote check skipped ({status.get('remote_msg', 'unreachable')})")

        if status["clean"]:
            print("Working tree: Clean")
        else:
            if status["modified_layers"]:
                print(f"Modified layers ({len(status['modified_layers'])}):")
                for lyr in status["modified_layers"]:
                    print(f"  - {lyr}")
            if status["modified_other"]:
                print(f"Other modified files: {len(status['modified_other'])}")
            if status["untracked"]:
                print(f"Untracked files: {len(status['untracked'])}")

    print("----------------------------------------")

    ready_to_launch = status["clean"] and status.get("behind", 0) == 0

    if ready_to_launch:
        print("Status: Up to date. Ready to launch QGIS.")
    elif status.get("behind", 0) > 0:
        print("Status: Upstream updates available. Rebase recommended before editing.")
    elif not status["clean"]:
        print("Status: Uncommitted local changes present.")

    print("----------------------------------------")
    print("Options:")
    print("  1. Launch QGIS Project (Default: press Enter)")
    print("  2. Pull and rebase from upstream")
    print("  3. Format and validate layers")
    print("  4. Install or link QGIS plugin")
    print("  5. Run build pipeline")
    print("  6. Open graphical interface (PyQt6)")
    print("  0. Exit")
    print("----------------------------------------")

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
        print("Pulling upstream changes...")
        rc, out, err = launcher_core.pull_upstream()
        if out:
            print(out)
        if err:
            print(err)
        print("Formatting and validating layers...")
        launcher_core.format_layers()
        rc_v, out_v, _ = launcher_core.validate_layers(strict=False)
        if out_v:
            print(out_v)
        print("Synchronization complete.")
    elif choice == "3":
        print("Formatting work layers...")
        rc_f, out_f, _ = launcher_core.format_layers()
        if out_f:
            print(out_f)
        print("Validating layers (strict mode)...")
        rc_v, out_v, _ = launcher_core.validate_layers(strict=True)
        if out_v:
            print(out_v)
        if rc_v == 0:
            print("Validation passed.")
    elif choice == "4":
        print("Installing QGIS plugin...")
        rc_p, out_p, _ = launcher_core.install_plugin()
        if out_p:
            print(out_p)
    elif choice == "5":
        print("Running build pipeline...")
        rc_pipe, out_pipe, err_pipe = launcher_core.run_pipeline()
        if out_pipe:
            print(out_pipe)
        if err_pipe:
            print(err_pipe)
        if rc_pipe == 0:
            print("Pipeline completed successfully.")
    elif choice == "6":
        pyw_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "launch.pyw")
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
    parser.add_argument("--sync", action="store_true", help="Synchronize from upstream and exit")
    parser.add_argument("--validate", action="store_true", help="Format and validate layers and exit")
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
