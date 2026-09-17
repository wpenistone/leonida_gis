# -*- coding: utf-8 -*-
"""Leonida Turn Restrictions - QGIS plugin entry point."""

def classFactory(iface):
    from .plugin import LeonidaTurnRestrictions
    return LeonidaTurnRestrictions(iface)
