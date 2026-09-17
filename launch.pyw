#!/usr/bin/env python
"""
State of Leonida GIS - PyQt6 Graphical Launcher
===============================================
Native Windows interface built with PyQt6 without custom styling.
Provides repository status inspection, upstream synchronization,
layer formatting and validation, plugin installation, and QGIS project launch.

Launch by double-clicking 'launch.pyw' in Windows Explorer.
"""

import os
import sys
import threading
import traceback

# Ensure working directory is always the project root
PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
os.chdir(PROJECT_ROOT)
sys.path.insert(0, os.path.join(PROJECT_ROOT, "scripts"))

try:
    from PyQt6.QtWidgets import (
        QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
        QLabel, QPushButton, QTextEdit, QGroupBox, QMessageBox
    )
    from PyQt6.QtCore import Qt, pyqtSignal, QObject
    import launcher_core
except Exception as import_err:
    # If anything fails during startup, show native Windows MessageBox so it does not fail silently
    err_msg = f"Failed to initialize State of Leonida GIS Launcher:\n\n{traceback.format_exc()}"
    try:
        import ctypes
        ctypes.windll.user32.MessageBoxW(0, err_msg, "Leonida GIS Launcher - Error", 0x10)
    except Exception:
        print(err_msg, file=sys.stderr)
    sys.exit(1)


class LogSignaler(QObject):
    log_signal = pyqtSignal(str)
    status_signal = pyqtSignal(dict)


class LeonidaLauncherWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("State of Leonida GIS Launcher")
        self.resize(650, 520)

        self.signaler = LogSignaler()
        self.signaler.log_signal.connect(self.append_log)
        self.signaler.status_signal.connect(self.update_status_ui)

        self._init_ui()
        self.refresh_status()

    def _init_ui(self):
        central_widget = QWidget(self)
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)
        main_layout.setContentsMargins(12, 12, 12, 12)
        main_layout.setSpacing(8)

        # 1. Status Group
        grp_status = QGroupBox("Repository Status", self)
        status_layout = QVBoxLayout(grp_status)

        self.lbl_status_main = QLabel("Checking status...", grp_status)
        self.lbl_status_details = QLabel("Branch: checking... | Upstream: checking...", grp_status)

        status_layout.addWidget(self.lbl_status_main)
        status_layout.addWidget(self.lbl_status_details)
        main_layout.addWidget(grp_status)

        # 2. Actions Group
        grp_actions = QGroupBox("Actions", self)
        actions_layout = QVBoxLayout(grp_actions)

        # Primary Launch Button
        self.btn_launch = QPushButton("Launch QGIS Project (leonida_map_project.qgz)", grp_actions)
        self.btn_launch.clicked.connect(self.action_launch_qgis)
        actions_layout.addWidget(self.btn_launch)

        # Secondary Actions
        row1_layout = QHBoxLayout()
        self.btn_sync = QPushButton("Pull Upstream (Rebase)", grp_actions)
        self.btn_sync.clicked.connect(lambda: self._run_async("Pulling upstream...", self._do_sync))
        row1_layout.addWidget(self.btn_sync)

        self.btn_format = QPushButton("Format and Validate Layers", grp_actions)
        self.btn_format.clicked.connect(lambda: self._run_async("Formatting and validating...", self._do_format_validate))
        row1_layout.addWidget(self.btn_format)
        actions_layout.addLayout(row1_layout)

        row2_layout = QHBoxLayout()
        self.btn_plugin = QPushButton("Install or Link QGIS Plugin", grp_actions)
        self.btn_plugin.clicked.connect(lambda: self._run_async("Installing plugin...", self._do_install_plugin))
        row2_layout.addWidget(self.btn_plugin)

        self.btn_pipeline = QPushButton("Run Build Pipeline", grp_actions)
        self.btn_pipeline.clicked.connect(lambda: self._run_async("Running pipeline...", self._do_pipeline))
        row2_layout.addWidget(self.btn_pipeline)

        self.btn_refresh = QPushButton("Refresh Status", grp_actions)
        self.btn_refresh.clicked.connect(self.refresh_status)
        row2_layout.addWidget(self.btn_refresh)
        actions_layout.addLayout(row2_layout)

        main_layout.addWidget(grp_actions)

        # 3. Console Output Group
        grp_log = QGroupBox("Output Log", self)
        log_layout = QVBoxLayout(grp_log)
        self.txt_log = QTextEdit(grp_log)
        self.txt_log.setReadOnly(True)
        log_layout.addWidget(self.txt_log)
        main_layout.addWidget(grp_log)

    def append_log(self, text):
        self.txt_log.append(text)
        self.txt_log.ensureCursorVisible()

    def _run_async(self, label, func):
        self.append_log(f">>> {label}")
        self._set_buttons_enabled(False)

        def worker():
            try:
                func()
            except Exception as e:
                self.signaler.log_signal.emit(f"Error: {e}")
            finally:
                self.refresh_status()

        threading.Thread(target=worker, daemon=True).start()

    def _set_buttons_enabled(self, enabled):
        self.btn_launch.setEnabled(enabled)
        self.btn_sync.setEnabled(enabled)
        self.btn_format.setEnabled(enabled)
        self.btn_plugin.setEnabled(enabled)
        self.btn_pipeline.setEnabled(enabled)
        self.btn_refresh.setEnabled(enabled)

    def refresh_status(self):
        def worker():
            status = launcher_core.check_repo_status()
            self.signaler.status_signal.emit(status)

        threading.Thread(target=worker, daemon=True).start()

    def update_status_ui(self, status):
        self._set_buttons_enabled(True)

        branch = status.get("branch", "unknown")
        behind = status.get("behind", 0)
        ahead = status.get("ahead", 0)
        clean = status.get("clean", False)
        modified = status.get("modified_layers", [])

        if clean and behind == 0:
            self.lbl_status_main.setText("Status: Up to date. Ready to launch QGIS.")
        elif behind > 0:
            self.lbl_status_main.setText(f"Status: Upstream has {behind} new commit(s). Pull to sync before editing.")
        elif not clean:
            self.lbl_status_main.setText(f"Status: Local changes detected in {len(modified)} layer(s).")
        else:
            self.lbl_status_main.setText("Status: Ready.")

        details = f"Branch: {branch} | "
        if behind > 0:
            details += f"{behind} behind | "
        if ahead > 0:
            details += f"{ahead} ahead | "
        details += "Working tree: " + ("Clean" if clean else "Modified")
        self.lbl_status_details.setText(details)

    def action_launch_qgis(self):
        ok, msg = launcher_core.launch_qgis()
        self.append_log(f"[Launch] {msg}")

    def _do_sync(self):
        rc, out, err = launcher_core.pull_upstream()
        if out: self.signaler.log_signal.emit(out)
        if err: self.signaler.log_signal.emit(err)
        launcher_core.format_layers()
        rc_v, out_v, _ = launcher_core.validate_layers(strict=False)
        if out_v: self.signaler.log_signal.emit(out_v)
        self.signaler.log_signal.emit("Upstream synchronization complete.")

    def _do_format_validate(self):
        rc_f, out_f, _ = launcher_core.format_layers()
        if out_f: self.signaler.log_signal.emit(out_f)
        rc_v, out_v, _ = launcher_core.validate_layers(strict=True)
        if out_v: self.signaler.log_signal.emit(out_v)
        if rc_v == 0:
            self.signaler.log_signal.emit("Validation passed.")

    def _do_install_plugin(self):
        rc, out, err = launcher_core.install_plugin()
        if out: self.signaler.log_signal.emit(out)
        if err: self.signaler.log_signal.emit(err)

    def _do_pipeline(self):
        rc, out, err = launcher_core.run_pipeline()
        if out: self.signaler.log_signal.emit(out)
        if err: self.signaler.log_signal.emit(err)


def main():
    try:
        app = QApplication(sys.argv)
        window = LeonidaLauncherWindow()
        window.show()
        sys.exit(app.exec())
    except Exception as e:
        err_msg = f"Application error:\n\n{traceback.format_exc()}"
        try:
            import ctypes
            ctypes.windll.user32.MessageBoxW(0, err_msg, "Leonida GIS Launcher - Error", 0x10)
        except Exception:
            print(err_msg, file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
