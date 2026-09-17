#!/usr/bin/env python3
"""
State of Leonida GIS - Launcher Core Engine
===========================================
Shared utility module providing Git repository inspection,
safe upstream synchronization, local work protection,
automated layer formatting, validation, and QGIS launching.
"""

import os
import sys
import glob
import shutil
import datetime
import platform
import subprocess

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
QGZ_PATH = os.path.join(PROJECT_ROOT, "leonida_map_project.qgz")
QGS_PATH = os.path.join(PROJECT_ROOT, "leonida_map_project.qgs")
LAYERS_DIR = os.path.join(PROJECT_ROOT, "layers")
BACKUPS_DIR = os.path.join(PROJECT_ROOT, ".backups")


def run_git(args, timeout=25):
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


def backup_layers():
    """
    Create a timestamped safety backup of all files in layers/.
    Preserves up to 10 most recent backups, pruning older ones.
    Returns the backup directory path.
    """
    os.makedirs(BACKUPS_DIR, exist_ok=True)
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    target_dir = os.path.join(BACKUPS_DIR, f"layers_{timestamp}")
    os.makedirs(target_dir, exist_ok=True)

    geojson_files = glob.glob(os.path.join(LAYERS_DIR, "*.geojson"))
    for file_path in geojson_files:
        shutil.copy2(file_path, target_dir)

    # Prune older backups, keeping most recent 10
    existing = sorted(glob.glob(os.path.join(BACKUPS_DIR, "layers_*")), key=os.path.getmtime)
    if len(existing) > 10:
        for old_dir in existing[:-10]:
            try:
                shutil.rmtree(old_dir)
            except Exception:
                pass

    return target_dir


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
        raw_lines = [line for line in stdout.splitlines() if line.strip()]
        if not raw_lines:
            status["clean"] = True
        else:
            for line in raw_lines:
                parts = line.split(None, 1)
                if len(parts) != 2:
                    continue
                prefix, filepath = parts[0], parts[1]
                if prefix == "??":
                    status["untracked"].append(filepath)
                elif filepath.startswith("layers/") or filepath.startswith("layers\\"):
                    status["modified_layers"].append(filepath)
                else:
                    status["modified_other"].append(filepath)

    # 3. Check remote status (6s timeout to prevent hanging when offline)
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
        status["remote_msg"] = "Could not reach remote repository (offline or unreachable)."

    return status


def pull_upstream(rebase=True):
    """Pull latest changes from upstream using rebase."""
    args = ["pull"]
    if rebase:
        args.append("--rebase")
    args += ["origin", "master"]
    return run_git(args, timeout=30)


def update_background_data(log_fn=None):
    """
    Safely updates basemaps, sources, rasters, and styles from upstream
    while guaranteeing that human-edited files in layers/ are never overwritten.
    """
    def log(msg):
        if log_fn:
            log_fn(msg)

    # 1. Safety snapshot of current layers
    backup_path = backup_layers()
    log(f"Created safety backup of work layers: {os.path.basename(backup_path)}")

    # 2. Inspect git status
    status = check_repo_status()
    if not status["is_git"]:
        return False, "Current directory is not a Git repository."

    if not status["remote_ok"]:
        return False, f"Remote unreachable: {status['remote_msg']}"

    # 3. Stash local changes if any uncommitted work exists
    stashed = False
    has_local_changes = bool(status["modified_layers"] or status["modified_other"])
    if has_local_changes:
        log("Preserving local edits before updating background files...")
        rc, out, err = run_git(["stash", "push", "-m", "launcher_safe_sync"])
        if rc == 0 and "No local changes" not in out:
            stashed = True

    # 4. Pull upstream updates with rebase
    log("Fetching latest background maps, rasters, and project files...")
    rc_pull, out_pull, err_pull = pull_upstream(rebase=True)
    if out_pull:
        log(out_pull)
    if err_pull:
        log(err_pull)

    if rc_pull != 0:
        if stashed:
            run_git(["stash", "pop"])
        return False, f"Failed to pull upstream updates: {err_pull or out_pull}"

    # 5. Restore stashed local edits
    if stashed:
        log("Re-applying your local edits...")
        rc_pop, out_pop, err_pop = run_git(["stash", "pop"])
        if rc_pop != 0:
            log("Notice: Merge conflict detected during re-application.")
            log(f"Your edits are completely preserved in safety backup: {backup_path}")

    # 6. Format layers to resolve any ID collisions cleanly
    log("Normalizing layer formatting and checking ID sequences...")
    format_layers()

    # 7. Ensure QGIS plugin link is live
    install_plugin()

    log("Background data updated successfully.")
    return True, "Background data and project files updated. Your local work in layers/ is protected."


def contribute_edits(commit_note=None, log_fn=None):
    """
    Prepares, formats, validates, and pushes digitized layers upstream.
    Guarantees strict OSM schema compliance before pushing.
    """
    def log(msg):
        if log_fn:
            log_fn(msg)

    # 1. Safety snapshot
    backup_path = backup_layers()
    log(f"Created safety backup: {os.path.basename(backup_path)}")

    # 2. Format layers (normalize coordinates, resolve duplicate IDs)
    log("Formatting work layers and verifying ID sequences...")
    rc_f, out_f, err_f = format_layers()
    if out_f:
        log(out_f)

    # 3. Strict schema validation
    log("Running strict schema validation...")
    rc_v, out_v, err_v = validate_layers(strict=True)
    if out_v:
        log(out_v)
    if rc_v != 0:
        err_details = err_v or out_v
        return False, f"Validation failed. Edits were not uploaded:\n\n{err_details}"

    # 4. Check if there are changes in layers/ or unpushed commits
    status = check_repo_status()
    has_layer_changes = bool(status["modified_layers"])
    has_unpushed = status.get("ahead", 0) > 0

    if not has_layer_changes and not has_unpushed:
        return True, "No changes detected in layers/. Everything is already up to date."

    # 5. Stage layers/*.geojson if modified
    if has_layer_changes:
        log("Staging modified layers...")
        rc_add, out_add, err_add = run_git(["add", "layers/*.geojson"])
        if rc_add != 0:
            return False, f"Failed to stage layers: {err_add}"

        # 6. Prepare commit message
        if commit_note and commit_note.strip():
            msg = f"Contribute layers: {commit_note.strip()}"
        else:
            now_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
            msg = f"Contribute digitized layers: updates as of {now_str}"

        # Check if git user name is configured; supply fallback if missing
        rc_name, name_out, _ = run_git(["config", "user.name"])
        git_cmd = ["commit", "-m", msg]
        if rc_name != 0 or not name_out.strip():
            git_cmd = ["-c", "user.name=Leonida Contributor", "-c", "user.email=contributor@leonida.state"] + git_cmd

        log(f"Committing changes: '{msg}'...")
        rc_c, out_c, err_c = run_git(git_cmd)
        if rc_c != 0:
            return False, f"Failed to commit changes: {err_c or out_c}"
        if out_c:
            log(out_c)

    # 7. Pull upstream with rebase to incorporate any concurrent upstream work
    log("Checking for upstream changes before upload...")
    rc_p, out_p, err_p = pull_upstream(rebase=True)
    if rc_p != 0:
        return False, f"Upstream synchronization conflict before push:\n{err_p or out_p}"

    # 8. Push to upstream
    log("Uploading changes to community repository (git push)...")
    branch = status.get("branch", "master")
    rc_push, out_push, err_push = run_git(["push", "origin", branch])
    if rc_push != 0:
        return False, (
            f"Commit created locally, but upload to remote failed:\n{err_push or out_push}\n\n"
            "Your edits are safely saved on your computer."
        )
    if out_push:
        log(out_push)

    log("Upload complete.")
    return True, "Successfully contributed your digitized edits upstream."


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
