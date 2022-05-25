@echo off
start .\Server_Start.bat
:LOOP
tasklist|find /i "mitmdump.exe" >nul
if %errorlevel%==0 (
choice /t 5 /d y /n >nul
start Genshin.lnk
) else (
goto LOOP
)