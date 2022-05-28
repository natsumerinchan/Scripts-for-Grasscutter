@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

echo [WARN] It will delete all data from the Grasscutter server !!!! (Please back up in advance if you need.)
echo [INFO] This script only removes environment packages. Scoop, git, aria2 and sudo will be retained.
set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path%
set /p Choose1=Would you like to continue?(Y/N):
set /p Choose2=Do you want to reboot your system immediately after the uninstallation completed?(Y/N):
if %Choose1% == Y (
  echo [INFO] Uninstallation is starting now......
  echo [INFO] Setting up environment variables......
  echo [INFO] Stop and remove MongoDB service and terminate java.exe
  taskkill /F /im java.exe
  net stop MongoDB
  mongod --remove
  echo [INFO] Uninstalling Environment Packages......
  scoop uninstall oraclejdk mongodb mongodb-compass mitmproxy -p
  if %Choose2% == Y (
    echo [INFO] Uninstallation completed.
    echo [WARN] You have chosen to reboot automatically.  
    echo [WARN] If you do not want to reboot,please close the window directly on the upper right corner.
    echo [WARN] Do not use "Ctrl + C" or "Ctrl + Z"
    pause
    shutdown -r -t 0
  ) else (
    echo [INFO] Uninstallation completed.
    echo [INFO] Please reboot by yourself.
    pause
  )
) else (
  echo [INFO] Canceled Uninstallation.
  pause && exit
) 







