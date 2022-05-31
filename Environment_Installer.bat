@echo off
if not exist "%USERPROFILE%\scoop\shims\scoop" ( goto gotAdmin )
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

echo [WARN] This script depends on Scoop, if it is not installed, it will install automatically and re-execute this script.

set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path% 
set /p Choose1=Would you like to continue?(Y/N):
set /p Choose2=Do you want to reboot the system immediately after installation?(Y/N):

if %Choose1% == Y (
echo [INFO] Installation is starting now......
goto NEXT1
) else (
echo [INFO] Canceled installation.
pause 
exit
)

:NEXT1
if exist "%USERPROFILE%\scoop\shims\scoop" (
  echo [INFO] Scoop is installed.
  echo [INFO] Installing environment packages...... 
  scoop update 
  scoop install aria2 sudo curl
  scoop install oraclejdk@17.0.3.1 
  scoop install mongodb mongodb-compass mitmproxy 
  echo [INFO] Setting up mongodb...... 
  echo [INFO] Setting up environment variables...... 
  setx MONGOPATH "%USERPROFILE%\scoop\apps\mongodb\current" 
  set MONGOPATH=%USERPROFILE%\scoop\apps\mongodb\current 
  copy nul "%MONGOPATH%\log\mongodb.log" 
  if not exist "%MONGOPATH%\data\db" ( md "%MONGOPATH%\data\db" ) 
  if not exist "%MONGOPATH%\mongo.config" (
  echo dbpath=%MONGOPATH%\data\db>>"%MONGOPATH%\mongo.config"
  echo logpath=%MONGOPATH%\log\mongodb.log>>"%MONGOPATH%\mongo.config" ) 
  "%MONGOPATH%\bin\mongod.exe" --bind_ip 0.0.0.0 --logpath "%MONGOPATH%\log\mongodb.log" --logappend --dbpath "%MONGOPATH%\data\db" --serviceName "MongoDB" --serviceDisplayName "MongoDB" --install 
  net start MongoDB 
  if %Choose2% == Y (
    echo [INFO] Installed successfully
    echo [WARN] You have chosen to reboot automatically.  
    echo [WARN] If you do not want to reboot,please close the window directly on the upper right corner.
    echo [WARN] Do not use "Ctrl + C" or "Ctrl + Z"
    pause
    shutdown -r -t 0
  ) else (
    echo [INFO] Installed successfully
    echo [INFO] Please reboot by yourself.
    pause
  )
) else (
  echo [INFO] Scoop installation is starting.
  powershell "iwr -useb get.scoop.sh | iex"
  scoop install git
  scoop bucket rm main >nul
  scoop bucket rm extras >nul
  scoop bucket rm java >nul
  scoop bucket add main
  scoop bucket add extras
  scoop bucket add java
  scoop install aria2 sudo curl
  echo [INFO] Scoop is installed.
  %0
)





