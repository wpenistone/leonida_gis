@echo off
setlocal
call "C:\Program Files\QGIS 3.44.7\bin\o4w_env.bat" >nul 2>&1
path C:\PROGRA~1\QGIS34~1.7\apps\qgis\bin;%PATH%
set QGIS_PREFIX_PATH=C:/PROGRA~1/QGIS34~1.7/apps/qgis
set PYTHONPATH=C:\PROGRA~1\QGIS34~1.7\apps\qgis\python;%PYTHONPATH%
"C:\Program Files\QGIS 3.44.7\apps\Python312\python.exe" %*
exit /b %ERRORLEVEL%
