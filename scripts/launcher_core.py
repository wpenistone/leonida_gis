#!/usr/bin/env python3
"""
State of Leonida GIS - Launcher Core Engine
===========================================
Shared utility module providing Git repository inspection,
upstream status synchronization, layer formatting, validation,
and QGIS project launching for launch.py and launch_gui.pyw.
"""

import os
import sys
import shutil
import platform
import subprocess

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
QGZ_PATH = os.path.join(PROJECT_ROOT, "leonida_map_project.qgz")
QGS_PATH = os.path.join(PROJECT_ROOT, "leonida_map_project.qgs")
LAYERS_DIR = os.path.join(PROJECT_ROOT, "layers")


def run_git(args, timeout=15):
    """Run a git command and return (returncode, stdout, stderr)."""
    try:
        res = subprocess.run(
            ["git"] + args,
            cwd=PROJECT_ROOT,
            capture_output=True,
            text=True,
            timeout=timeout
        )
        return res.returncode, res.stdout.strip(), res.stderr.strip()
    except subprocess.TimeoutExpired:
        return -1, "", "Command timed out."
    except FileNotFoundError:
        return -1, "", "Git executable not found in PATH."
    except Exception as e:
        return -1, "", str(e)


def check_repo_status():
    """
    Inspect the Git repository status:
    - Current branch
    - Modified / untracked files
    - Remote fetch & ahead / behind count
    """
    status = {
        "is_git": False,
        "branch": "unknown",
        "clean": False,
        "modified_layers": [],
        "modified_other": [],
        "untracked": [],
        "ahead": 0,
        "behind": 0,
        "remote_ok": False,
        "remote_msg": "",
    }

    # 1. Check branch
    rc, stdout, stderr = run_git(["rev-parse", "--abbrev-ref", "HEAD"])
    if rc != 0:
        return status
    status["is_git"] = True
    status["branch"] = stdout

    # 2. Check local porcelain status
    rc, stdout, _ = run_git(["status", "--porcelain"])
    if rc == 0:
        lines = [line.strip() for line in stdout.splitlines() if line.strip()]
        if not lines:
            status["clean"] = True
        else:
            for line in lines:
                prefix = line[:2]
                filepath = line[3:].strip()
                if prefix == "??":
                    status["untracked"].append(filepath)
                elif "layers/" in filepath:
                    status["modified_layers"].append(filepath)
                else:
                    status["modified_other"].append(filepath)

    # 3. Check remote status (5s timeout to prevent hanging when offline)
    rc, _, err = run_git(["fetch", "origin", "--quiet"], timeout=6)
    if rc == 0:
        status["remote_ok"] = True
        # Check ahead / behind
        rc_b, out_b, _ = run_git(["rev-list", "--count", f"HEAD..origin/{status['branch']}"])
        if rc_b == 0 and out_b.isdigit():
            status["behind"] = int(out_b)

        rc_a, out_a, _ = run_git(["rev-list", "--count", f"origin/{status['branch']}..HEAD"])
        if rc_a == 0 and out_a.isdigit():
            status["ahead"] = int(out_a)
    else:
        status["remote_msg"] = "Could not reach remote repository (offline or remote unreachable)."

    return status


def pull_upstream(rebase=True):
    """Pull latest changes from upstream using rebase."""
    args = ["pull"]
    if rebase:
        args.append("--rebase")
    args += ["origin", "master"]
    return run_git(args, timeout=30)


def format_layers():
    """Run format.py."""
    script = os.path.join(PROJECT_ROOT, "scripts", "format.py")
    res = subprocess.run([sys.executable, script], cwd=PROJECT_ROOT, capture_output=True, text=True)
    return res.returncode, res.stdout, res.stderr


def validate_layers(strict=True):
    """Run validate.py."""
    script = os.path.join(PROJECT_ROOT, "scripts", "validate.py")
    cmd = [sys.executable, script]
    if strict:
        cmd.append("--strict")
    res = subprocess.run(cmd, cwd=PROJECT_ROOT, capture_output=True, text=True)
    return res.returncode, res.stdout, res.stderr


def install_plugin():
    """Run install_plugin.py."""
    script = os.path.join(PROJECT_ROOT, "scripts", "install_plugin.py")
    res = subprocess.run([sys.executable, script], cwd=PROJECT_ROOT, capture_output=True, text=True)
    return res.returncode, res.stdout, res.stderr


def run_pipeline():
    """Run run_pipeline.py."""
    script = os.path.join(PROJECT_ROOT, "scripts", "run_pipeline.py")
    res = subprocess.run([sys.executable, script], cwd=PROJECT_ROOT, capture_output=True, text=True)
    return res.returncode, res.stdout, res.stderr


def launch_qgis():
    """Open leonida_map_project.qgz in QGIS."""
    target_project = QGZ_PATH if os.path.exists(QGZ_PATH) else QGS_PATH
    if not os.path.exists(target_project):
        return False, f"Project file not found: {target_project}"

    system = platform.system()
    try:
        if system == "Windows":
            os.startfile(target_project)
            return True, f"Launched {os.path.basename(target_project)} in QGIS."
        elif system == "Darwin":
            subprocess.Popen(["open", target_project])
            return True, f"Launched {os.path.basename(target_project)} in QGIS."
        else:
            subprocess.Popen(["xdg-open", target_project])
            return True, f"Launched {os.path.basename(target_project)} in QGIS."
    except Exception as e:
        return False, f"Failed to open project in QGIS: {e}"
