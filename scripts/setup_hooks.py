#!/usr/bin/env python3
"""
Setup Git Pre-Commit Hooks
==========================
Configures Git to automatically run `scripts/format.py` on `git commit`.
Usage:
    python scripts/setup_hooks.py
"""

import subprocess
import os

def setup_hooks():
    try:
        res = subprocess.run(["git", "config", "core.hooksPath", ".githooks"], capture_output=True, text=True)
        if res.returncode == 0:
            print("Git pre-commit hooks activated via '.githooks/'.")
            print("scripts/format.py will run automatically on git commit.")
        else:
            print(f"[ERROR] Failed to set core.hooksPath: {res.stderr}")
    except Exception as e:
        print(f"[ERROR] Could not run git config: {e}")

if __name__ == "__main__":
    setup_hooks()
