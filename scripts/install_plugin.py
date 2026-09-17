#!/usr/bin/env python3
"""
Install Leonida Turn Restrictions QGIS Plugin
=============================================
Installs or symlinks the in-repo QGIS plugin into the local user's
QGIS 3 plugins directory.

On Windows, creates an NTFS directory junction so changes to the repo's
plugin files are immediately live in QGIS without re-copying.

Usage:
    python scripts/install_plugin.py [--copy] [--profile PROFILE_NAME]
"""

import os
import sys
import shutil
import platform
import subprocess
import argparse

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
PLUGIN_SRC_DIR = os.path.join(PROJECT_ROOT, "qgis_plugin", "leonida_turn_restrictions")
PLUGIN_NAME = "leonida_turn_restrictions"


def find_qgis_plugins_dir(profile="default"):
    """Locate the QGIS 3 plugins directory across Windows, macOS, and Linux."""
    system = platform.system()
    if system == "Windows":
        app_data = os.environ.get("APPDATA")
        if not app_data:
            return None
        return os.path.join(app_data, "QGIS", "QGIS3", "profiles", profile, "python", "plugins")
    elif system == "Darwin":
        home = os.path.expanduser("~")
        return os.path.join(home, "Library", "Application Support", "QGIS", "QGIS3", "profiles", profile, "python", "plugins")
    else:  # Linux / Unix
        home = os.path.expanduser("~")
        return os.path.join(home, ".local", "share", "QGIS", "QGIS3", "profiles", profile, "python", "plugins")


def install_plugin(use_copy=False, profile="default"):
    print(">>> State of Leonida GIS — Plugin Installer")
    print(f"Source: {PLUGIN_SRC_DIR}")

    if not os.path.exists(PLUGIN_SRC_DIR):
        print(f"[ERROR] Source plugin directory not found: {PLUGIN_SRC_DIR}")
        return False

    plugins_dir = find_qgis_plugins_dir(profile)
    if not plugins_dir:
        print(f"[ERROR] Could not determine QGIS plugins directory for profile '{profile}'.")
        return False

    print(f"Target Directory: {plugins_dir}")

    # Ensure parent plugins directory exists
    try:
        os.makedirs(plugins_dir, exist_ok=True)
    except Exception as e:
        print(f"[ERROR] Could not create target directory: {e}")
        return False

    dest_path = os.path.join(plugins_dir, PLUGIN_NAME)

    # Remove existing link or copy if present
    if os.path.exists(dest_path) or os.path.islink(dest_path):
        print(f"Removing previous plugin link/installation at: {dest_path}")
        try:
            if os.path.islink(dest_path) or os.path.isdir(dest_path):
                if platform.system() == "Windows":
                    # Check if it's a junction or symlink
                    try:
                        os.rmdir(dest_path)
                    except OSError:
                        shutil.rmtree(dest_path)
                else:
                    if os.path.islink(dest_path):
                        os.unlink(dest_path)
                    else:
                        shutil.rmtree(dest_path)
        except Exception as e:
            print(f"[WARNING] Error removing old installation: {e}")

    installed_via = None

    if not use_copy:
        # Try creating a junction on Windows or symlink on Unix
        if platform.system() == "Windows":
            try:
                # Use mklink /J for NTFS directory junction (does not require admin privileges)
                cmd = ["cmd", "/c", "mklink", "/J", dest_path, PLUGIN_SRC_DIR]
                res = subprocess.run(cmd, capture_output=True, text=True)
                if res.returncode == 0:
                    installed_via = "NTFS Directory Junction (live sync)"
                else:
                    print(f"Junction creation note: {res.stderr.strip()}")
            except Exception as e:
                print(f"Junction exception: {e}")
        else:
            try:
                os.symlink(PLUGIN_SRC_DIR, dest_path, target_is_directory=True)
                installed_via = "Symbolic Link (live sync)"
            except Exception as e:
                print(f"Symlink exception: {e}")

    # Fallback to direct directory copy
    if not installed_via:
        print("Copying plugin files directly...")
        try:
            shutil.copytree(PLUGIN_SRC_DIR, dest_path)
            installed_via = "File Copy"
        except Exception as e:
            print(f"[ERROR] Failed to copy plugin files: {e}")
            return False

    print(f"\n[SUCCESS] Installed '{PLUGIN_NAME}' successfully via {installed_via}.")
    print(f"Destination: {dest_path}")
    print("\nNext Steps:")
    print("  1. Open QGIS 3.")
    print("  2. Go to: Plugins -> Manage and Install Plugins... -> Installed")
    print("  3. Check the box next to 'Leonida Turn Restrictions'.")
    print("  4. The tool icon will appear in your toolbar and under the 'Leonida GIS' menu.")
    return True


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Install Leonida Turn Restrictions QGIS Plugin")
    parser.add_argument("--copy", action="store_true", help="Force file copy instead of junction/symlink")
    parser.add_argument("--profile", default="default", help="QGIS user profile name (default: 'default')")
    args = parser.parse_args()

    success = install_plugin(use_copy=args.copy, profile=args.profile)
    sys.exit(0 if success else 1)
