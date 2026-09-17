#!/usr/bin/env python
"""
State of Leonida GIS - Graphical Launcher
=========================================
Plain native Windows interface built with PyQt6.
Provides safe local mapping workflows, background asset updates,
automated validation, upstream contributions, and QGIS project launching.

Launch by double-clicking 'launch_gui.pyw' in Windows Explorer.
"""

import os
import sys
import threading
import traceback

PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
os.chdir(PROJECT_ROOT)
sys.path.insert(0, os.path.join(PROJECT_ROOT, "scripts"))

try:
    from PyQt6.QtWidgets import (
        QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
        QLabel, QPushButton, QLineEdit, QTextEdit, QGroupBox, QMessageBox
    )
    from PyQt6.QtCore import Qt, pyqtSignal, QObject
    import launcher_core
except Exception as import_err:
    err_msg = f"Failed to initialize State of Leonida GIS Launcher:\n\n{traceback.format_exc()}"
    try:
        import ctypes
        ctypes.windll.user32.MessageBoxW(0, err_msg, "Leonida GIS Launcher - Startup Error", 0x10)
    except Exception:
        print(err_msg, file=sys.stderr)
    sys.exit(1)


class Signaler(QObject):
    log_signal = pyqtSignal(str)
    status_signal = pyqtSignal(dict)
    finished_signal = pyqtSignal()


class LeonidaLauncherWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("State of Leonida GIS Launcher")
        self.resize(660, 640)

        self.signaler = Signaler()
        self.signaler.log_signal.connect(self.append_log)
        self.signaler.status_signal.connect(self.update_status_ui)
        self.signaler.finished_signal.connect(self.on_task_finished)

        self._init_ui()
        self.refresh_status()

    def _init_ui(self):
        central_widget = QWidget(self)
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)
        main_layout.setContentsMargins(14, 14, 14, 14)
        main_layout.setSpacing(10)

        # --- 1. Repository Status ---
        grp_status = QGroupBox("Repository Status", self)
        status_layout = QVBoxLayout(grp_status)

        self.lbl_status_main = QLabel("Checking repository status...", grp_status)
        font = self.lbl_status_main.font()
        font.setBold(True)
        self.lbl_status_main.setFont(font)

        self.lbl_status_details = QLabel("Branch: checking... | Upstream: checking...", grp_status)

        status_btn_row = QHBoxLayout()
        status_btn_row.addWidget(self.lbl_status_details)
        status_btn_row.addStretch()
        self.btn_refresh = QPushButton("Check for Updates", grp_status)
        self.btn_refresh.clicked.connect(self.refresh_status)
        status_btn_row.addWidget(self.btn_refresh)

        status_layout.addWidget(self.lbl_status_main)
        status_layout.addLayout(status_btn_row)
        main_layout.addWidget(grp_status)

        # --- 2. Work Locally ---
        grp_local = QGroupBox("Work Locally", self)
        local_layout = QVBoxLayout(grp_local)

        lbl_local_desc = QLabel(
            "Your digitized edits in layers/ are safe and will never be overwritten.\n"
            "Updating background data refreshes rasters, heightmaps, sources, and project styles "
            "from upstream while leaving your work intact.",
            grp_local
        )
        lbl_local_desc.setWordWrap(True)
        local_layout.addWidget(lbl_local_desc)

        local_btn_row = QHBoxLayout()
        self.btn_launch = QPushButton("Launch QGIS Project (leonida_map_project.qgz)", grp_local)
        self.btn_launch.clicked.connect(self.action_launch_qgis)
        local_btn_row.addWidget(self.btn_launch, 2)

        self.btn_update_bg = QPushButton("Update Background Data & Sources", grp_local)
        self.btn_update_bg.clicked.connect(
            lambda: self._run_async("Updating background data...", self._do_update_bg)
        )
        local_btn_row.addWidget(self.btn_update_bg, 2)

        local_layout.addLayout(local_btn_row)
        main_layout.addWidget(grp_local)

        # --- 3. Contribute Upstream ---
        grp_contrib = QGroupBox("Contribute to Project", self)
        contrib_layout = QVBoxLayout(grp_contrib)

        lbl_contrib_desc = QLabel(
            "Clean, format, strictly validate, and upload your digitized layers "
            "to the shared community repository.",
            grp_contrib
        )
        lbl_contrib_desc.setWordWrap(True)
        contrib_layout.addWidget(lbl_contrib_desc)

        note_row = QHBoxLayout()
        lbl_note = QLabel("Summary of changes (optional):", grp_contrib)
        self.txt_note = QLineEdit(grp_contrib)
        self.txt_note.setPlaceholderText("e.g., Added Vice Beach street alignments and POIs")
        note_row.addWidget(lbl_note)
        note_row.addWidget(self.txt_note)
        contrib_layout.addLayout(note_row)

        self.btn_contribute = QPushButton("Contribute My Edits Upstream", grp_contrib)
        self.btn_contribute.clicked.connect(
            lambda: self._run_async("Uploading contributions...", self._do_contribute)
        )
        contrib_layout.addWidget(self.btn_contribute)

        main_layout.addWidget(grp_contrib)

        # --- 4. Activity Log ---
        grp_log = QGroupBox("Activity Log", self)
        log_layout = QVBoxLayout(grp_log)
        self.txt_log = QTextEdit(grp_log)
        self.txt_log.setReadOnly(True)
        log_layout.addWidget(self.txt_log)
        main_layout.addWidget(grp_log)

        # --- 5. Advanced Utilities ---
        grp_adv = QGroupBox("Advanced Utilities", self)
        adv_layout = QHBoxLayout(grp_adv)

        self.btn_format = QPushButton("Format & Validate Only", grp_adv)
        self.btn_format.clicked.connect(
            lambda: self._run_async("Validating layers...", self._do_format_validate)
        )
        adv_layout.addWidget(self.btn_format)

        self.btn_plugin = QPushButton("Install or Link QGIS Plugin", grp_adv)
        self.btn_plugin.clicked.connect(
            lambda: self._run_async("Installing plugin...", self._do_install_plugin)
        )
        adv_layout.addWidget(self.btn_plugin)

        self.btn_pipeline = QPushButton("Run Full Build Pipeline", grp_adv)
        self.btn_pipeline.clicked.connect(
            lambda: self._run_async("Running full pipeline...", self._do_pipeline)
        )
        adv_layout.addWidget(self.btn_pipeline)

        main_layout.addWidget(grp_adv)

    def append_log(self, text):
        self.txt_log.append(text)
        self.txt_log.ensureCursorVisible()

    def _set_buttons_enabled(self, enabled):
        self.btn_launch.setEnabled(enabled)
        self.btn_update_bg.setEnabled(enabled)
        self.btn_contribute.setEnabled(enabled)
        self.btn_refresh.setEnabled(enabled)
        self.btn_format.setEnabled(enabled)
        self.btn_plugin.setEnabled(enabled)
        self.btn_pipeline.setEnabled(enabled)

    def _run_async(self, label, func):
        self.append_log(f"--- {label} ---")
        self._set_buttons_enabled(False)

        def worker():
            try:
                func()
            except Exception as e:
                self.signaler.log_signal.emit(f"Error: {e}")
            finally:
                self.signaler.finished_signal.emit()

        threading.Thread(target=worker, daemon=True).start()

    def on_task_finished(self):
        self._set_buttons_enabled(True)
        self.refresh_status()

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
        modified_layers = status.get("modified_layers", [])

        if not status.get("is_git", False):
            self.lbl_status_main.setText("Status: Not a Git repository.")
            self.lbl_status_details.setText("Running in standalone directory.")
            return

        if len(modified_layers) > 0:
            self.lbl_status_main.setText(
                f"Status: {len(modified_layers)} layer(s) modified locally. Ready to contribute."
            )
        elif behind > 0:
            self.lbl_status_main.setText(
                f"Status: Upstream has {behind} new update(s). Update Background Data recommended."
            )
        elif clean and behind == 0:
            self.lbl_status_main.setText("Status: Ready to work. Local layers are protected and up to date.")
        else:
            self.lbl_status_main.setText("Status: Ready.")

        details_parts = [f"Branch: {branch}"]
        if status.get("remote_ok", False):
            if behind == 0 and ahead == 0:
                details_parts.append("Upstream: Up to date")
            else:
                if behind > 0:
                    details_parts.append(f"{behind} behind")
                if ahead > 0:
                    details_parts.append(f"{ahead} ahead")
        else:
            details_parts.append("Upstream: Offline / Remote check skipped")

        if modified_layers:
            details_parts.append(f"Work layers: {len(modified_layers)} modified")
        elif clean:
            details_parts.append("Work layers: Clean")
        else:
            details_parts.append("Work layers: Unmodified")

        self.lbl_status_details.setText(" | ".join(details_parts))

    def action_launch_qgis(self):
        ok, msg = launcher_core.launch_qgis()
        self.append_log(f"[Launch] {msg}")

    def _do_update_bg(self):
        ok, msg = launcher_core.update_background_data(log_fn=self.signaler.log_signal.emit)
        self.signaler.log_signal.emit(msg)

    def _do_contribute(self):
        note = self.txt_note.text().strip()
        ok, msg = launcher_core.contribute_edits(
            commit_note=note if note else None,
            log_fn=self.signaler.log_signal.emit
        )
        self.signaler.log_signal.emit(msg)
        if ok and "No changes" not in msg:
            self.txt_note.clear()

    def _do_format_validate(self):
        rc_f, out_f, _ = launcher_core.format_layers()
        if out_f:
            self.signaler.log_signal.emit(out_f)
        rc_v, out_v, _ = launcher_core.validate_layers(strict=True)
        if out_v:
            self.signaler.log_signal.emit(out_v)
        if rc_v == 0:
            self.signaler.log_signal.emit("Validation passed: All layers strictly valid.")

    def _do_install_plugin(self):
        rc, out, err = launcher_core.install_plugin()
        if out:
            self.signaler.log_signal.emit(out)
        if err:
            self.signaler.log_signal.emit(err)

    def _do_pipeline(self):
        rc, out, err = launcher_core.run_pipeline()
        if out:
            self.signaler.log_signal.emit(out)
        if err:
            self.signaler.log_signal.emit(err)


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
