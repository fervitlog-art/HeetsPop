@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title POP! - Avvio
set "URL=http://127.0.0.1:8000"
set "PYEXE="
if exist "%~dp0python\python.exe" set "PYEXE=%~dp0python\python.exe"
if not defined PYEXE where python >nul 2>nul && set "PYEXE=python"
if not defined PYEXE where py >nul 2>nul && set "PYEXE=py -3"
if not defined PYEXE (echo ERRORE: Python non trovato.& pause& exit /b 1)
start "POP server" /min %PYEXE% "%~dp0server.py"
for /l %%i in (1,1,20) do (
 powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -UseBasicParsing '%URL%' -TimeoutSec 1 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>nul
 if not errorlevel 1 goto open_browser
 timeout /t 1 /nobreak >nul
)
:open_browser
start "" "%URL%"
exit /b 0
