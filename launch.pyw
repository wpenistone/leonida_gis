#!/usr/bin/env pythonw
"""
State of Leonida GIS - Desktop Graphical Launcher (GUI)
======================================================
Zero-console GUI launcher for Windows and desktop environments.
Provides live status, upstream sync, layer formatting/validation,
plugin installation, and one-click project launch.

Launch by double-clicking 'launch.pyw' in File Explorer.
"""

import os
import sys
import threading
import tkinter as tk
from tkinter import ttk, messagebox

# Add scripts directory to path
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "scripts"))
import launcher_core


class LeonidaLauncherGUI(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("State of Leonida GIS — Launcher")
        self.geometry("700x580")
        self.minsize(620, 500)

        # Style configuration
        self.configure(bg="#1a1b22")
        self._setup_styles()
        self._build_ui()

        # Initial status check in background thread
        self.refresh_status()

    def _setup_styles(self):
        self.style = ttk.Style(self)
        try:
            self.style.theme_use("clam")
        except Exception:
            pass

        # Configure generic colors
        self.style.configure(".", background="#1a1b22", foreground="#e2e8f0", font=("Segoe UI", 9))
        self.style.configure("TFrame", background="#1a1b22")
        self.style.configure("Card.TFrame", background="#23242e", relief="flat")
        self.style.configure("Header.TLabel", font=("Segoe UI", 14, "bold"), foreground="#00e5ff", background="#1a1b22")
        self.style.configure("SubHeader.TLabel", font=("Segoe UI", 9), foreground="#94a3b8", background="#1a1b22")
        self.style.configure("StatusText.TLabel", font=("Segoe UI", 10, "bold"), background="#23242e")

    def _build_ui(self):
        # 1. Header Frame
        header_frame = ttk.Frame(self, padding=(16, 12, 16, 8))
        header_frame.pack(fill="x")

        ttk.Label(header_frame, text="STATE OF LEONIDA GIS", style="Header.TLabel").pack(anchor="w")
        ttk.Label(
            header_frame,
            text="OpenStreetMap Cartographic Stack • Equirectangular Metric Grid (EPSG:4087)",
            style="SubHeader.TLabel"
        ).pack(anchor="w", pady=(2, 0))

        # 2. Status Card
        self.card_frame = ttk.Frame(self, style="Card.TFrame", padding=(16, 12, 16, 12))
        self.card_frame.pack(fill="x", padx=16, pady=8)

        self.lbl_status_badge = tk.Label(
            self.card_frame,
            text="● Checking repository status...",
            font=("Segoe UI", 11, "bold"),
            bg="#23242e",
            fg="#94a3b8",
            anchor="w"
        )
        self.lbl_status_badge.pack(fill="x")

        self.lbl_status_details = tk.Label(
            self.card_frame,
            text="Branch: detecting... • Upstream: checking...",
            font=("Segoe UI", 9),
            bg="#23242e",
            fg="#cbd5e1",
            anchor="w"
        )
        self.lbl_status_details.pack(fill="x", pady=(4, 0))

        # 3. Main Launch Button (Primary CTA)
        btn_frame = ttk.Frame(self, padding=(16, 4, 16, 8))
        btn_frame.pack(fill="x")

        self.btn_launch = tk.Button(
            btn_frame,
            text="🚀  LAUNCH QGIS PROJECT (leonida_map_project.qgz)",
            font=("Segoe UI", 11, "bold"),
            bg="#059669",
            fg="#ffffff",
            activebackground="#10b981",
            activeforeground="#ffffff",
            relief="flat",
            cursor="hand2",
            padx=12,
            pady=10,
            command=self.action_launch_qgis
        )
        self.btn_launch.pack(fill="x")

        # 4. Action Buttons Grid
        actions_frame = ttk.Frame(self, padding=(16, 4, 16, 4))
        actions_frame.pack(fill="x")

        # Row 1
        btn_row1 = ttk.Frame(actions_frame)
        btn_row1.pack(fill="x", pady=2)

        self.btn_sync = tk.Button(
            btn_row1,
            text="🔄  Pull Upstream (Rebase)",
            font=("Segoe UI", 9, "bold"),
            bg="#334155",
            fg="#f8fafc",
            activebackground="#475569",
            relief="flat",
            cursor="hand2",
            pady=6,
            command=lambda: self._run_async("Pulling from upstream...", self._do_sync)
        )
        self.btn_sync.pack(side="left", fill="x", expand=True, padx=(0, 4))

        self.btn_format = tk.Button(
            btn_row1,
            text="🧹  Format & Validate Layers",
            font=("Segoe UI", 9, "bold"),
            bg="#334155",
            fg="#f8fafc",
            activebackground="#475569",
            relief="flat",
            cursor="hand2",
            pady=6,
            command=lambda: self._run_async("Formatting and validating layers...", self._do_format_validate)
        )
        self.btn_format.pack(side="left", fill="x", expand=True, padx=(4, 0))

        # Row 2
        btn_row2 = ttk.Frame(actions_frame)
        btn_row2.pack(fill="x", pady=4)

        self.btn_plugin = tk.Button(
            btn_row2,
            text="🔌  Install / Link QGIS Plugin",
            font=("Segoe UI", 9, "bold"),
            bg="#334155",
            fg="#f8fafc",
            activebackground="#475569",
            relief="flat",
            cursor="hand2",
            pady=6,
            command=lambda: self._run_async("Installing QGIS plugin...", self._do_install_plugin)
        )
        self.btn_plugin.pack(side="left", fill="x", expand=True, padx=(0, 4))

        self.btn_pipeline = tk.Button(
            btn_row2,
            text="⚙️  Rebuild Full GIS Pipeline",
            font=("Segoe UI", 9, "bold"),
            bg="#334155",
            fg="#f8fafc",
            activebackground="#475569",
            relief="flat",
            cursor="hand2",
            pady=6,
            command=lambda: self._run_async("Running full GIS build pipeline...", self._do_pipeline)
        )
        self.btn_pipeline.pack(side="left", fill="x", expand=True, padx=(4, 0))

        # 5. Output Console
        log_frame = ttk.Frame(self, padding=(16, 8, 16, 12))
        log_frame.pack(fill="both", expand=True)

        lbl_console = ttk.Label(log_frame, text="Activity & Output Log:", font=("Segoe UI", 8, "bold"), foreground="#64748b")
        lbl_console.pack(anchor="w", pady=(0, 2))

        self.txt_log = tk.Text(
            log_frame,
            bg="#111217",
            fg="#a7f3d0",
            insertbackground="#ffffff",
            font=("Consolas", 8),
            wrap="word",
            relief="flat",
            padx=8,
            pady=6
        )
        scrollbar = ttk.Scrollbar(log_frame, orient="vertical", command=self.txt_log.yview)
        self.txt_log.configure(yscrollcommand=scrollbar.set)
        scrollbar.pack(side="right", fill="y")
        self.txt_log.pack(side="left", fill="both", expand=True)

    def log(self, text):
        """Append text to output log safely from any thread."""
        def _append():
            self.txt_log.insert("end", text + "\n")
            self.txt_log.see("end")
        self.after(0, _append)

    def _run_async(self, label, target_fn):
        """Execute a task in a background daemon thread to keep UI reactive."""
        self.log(f"\n>>> {label}")
        def worker():
            try:
                target_fn()
            except Exception as e:
                self.log(f"[ERROR] {e}")
            finally:
                self.refresh_status()
        t = threading.Thread(target=worker, daemon=True)
        t.start()

    def refresh_status(self):
        """Check repository status in background."""
        def check():
            status = launcher_core.check_repo_status()
            def update_ui():
                branch = status.get("branch", "unknown")
                behind = status.get("behind", 0)
                ahead = status.get("ahead", 0)
                clean = status.get("clean", False)
                modified = status.get("modified_layers", [])

                if clean and behind == 0:
                    self.lbl_status_badge.config(
                        text="✨  Everything is up to date. You can now launch QGIS!",
                        fg="#22c55e"
                    )
                    self.btn_launch.config(bg="#059669", activebackground="#10b981")
                elif behind > 0:
                    self.lbl_status_badge.config(
                        text=f"⚠️  Upstream has {behind} new commit(s). Pull to sync before editing.",
                        fg="#f59e0b"
                    )
                    self.btn_launch.config(bg="#d97706", activebackground="#f59e0b")
                elif not clean:
                    self.lbl_status_badge.config(
                        text=f"✏️  Local changes detected in {len(modified)} layer(s).",
                        fg="#38bdf8"
                    )
                else:
                    self.lbl_status_badge.config(
                        text="Ready to launch.",
                        fg="#22c55e"
                    )

                details = f"Branch: {branch}  •  "
                if behind > 0:
                    details += f"{behind} behind  •  "
                if ahead > 0:
                    details += f"{ahead} ahead  •  "
                details += "Working tree: " + ("Clean" if clean else "Modified")
                self.lbl_status_details.config(text=details)

            self.after(0, update_ui)

        threading.Thread(target=check, daemon=True).start()

    def action_launch_qgis(self):
        ok, msg = launcher_core.launch_qgis()
        self.log(f"\n[LAUNCH] {msg}")

    def _do_sync(self):
        self.log("Running git pull --rebase origin master...")
        rc, out, err = launcher_core.pull_upstream()
        if out: self.log(out)
        if err: self.log(err)

        self.log("Formatting work layers...")
        launcher_core.format_layers()

        self.log("Validating layer semantics...")
        rc_v, out_v, _ = launcher_core.validate_layers(strict=False)
        if out_v: self.log(out_v)
        self.log("Upstream sync complete. Ready to launch QGIS.")

    def _do_format_validate(self):
        rc_f, out_f, _ = launcher_core.format_layers()
        if out_f: self.log(out_f)
        rc_v, out_v, _ = launcher_core.validate_layers(strict=True)
        if out_v: self.log(out_v)
        if rc_v == 0:
            self.log("[PASS] Strict layer validation passed with 0 errors.")

    def _do_install_plugin(self):
        rc, out, err = launcher_core.install_plugin()
        if out: self.log(out)
        if err: self.log(err)

    def _do_pipeline(self):
        rc, out, err = launcher_core.run_pipeline()
        if out: self.log(out)
        if err: self.log(err)


def main():
    app = LeonidaLauncherGUI()
    app.mainloop()


if __name__ == "__main__":
    main()
