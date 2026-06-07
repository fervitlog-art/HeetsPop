@echo off
setlocal EnableExtensions
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -UseBasicParsing 'http://127.0.0.1:8000/__shutdown' -TimeoutSec 2 | Out-Null; Write-Host 'Server chiuso.' } catch { Write-Host 'Server non raggiungibile o gia chiuso.' }"
timeout /t 2 /nobreak >nul
exit /b 0
