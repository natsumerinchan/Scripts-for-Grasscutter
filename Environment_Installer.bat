@echo off
echo This script depends on Scoop, if it is not installed, it will install automatically and re-execute the script.
echo This script will prompt for administrator privileges twice, the first time to set up MongoDB as a system service, and the second time to start the MongoDB service.

set /p Choose1=Do you want to continue?(Y/N):
set /p Choose2=Do you want to reboot the system immediately after installation?(Y/N):
if %Choose1% == Y (
echo Installation is starting now......
goto NEXT1
) else (
echo Canceled installation.
pause 
exit
)
:NEXT1 && (
set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path% ) && (
if exist "%USERPROFILE%\scoop\shims\scoop" (
echo Scoop is installed.
goto NEXT2
) else (
powershell "iwr -useb get.scoop.sh | iex"
scoop install git
scoop bucket rm main
scoop bucket rm extras
scoop bucket rm java
scoop bucket add main
scoop bucket add extras
scoop bucket add java
scoop install aria2 sudo
echo Scoop has been installed and will re-run this script.
pause && %0
)
)
:NEXT2 && (
echo Installing environment packages...... ) && (
scoop update ) && (
scoop install oraclejdk@17.0.3.1 ) && (
scoop install mongodb mongodb-compass mitmproxy ) && (
echo Setting up mongodb...... ) && (
echo Setting up environment variables...... ) && (
setx MONGOPATH "%USERPROFILE%\scoop\apps\mongodb\current" ) && (
set MONGOPATH=%USERPROFILE%\scoop\apps\mongodb\current ) && (
copy nul "%MONGOPATH%\log\mongodb.log" ) & (
if not exist "%MONGOPATH%\data\db" ( 
md "%MONGOPATH%\data\db" ) ) && (
if not exist "%MONGOPATH%\mongo.config" (
echo dbpath=%MONGOPATH%\data\db>>"%MONGOPATH%\mongo.config"
echo logpath=%MONGOPATH%\log\mongodb.log>>"%MONGOPATH%\mongo.config" ) ) && (
sudo "%MONGOPATH%\bin\mongod.exe" --bind_ip 0.0.0.0 --logpath "%MONGOPATH%\log\mongodb.log" --logappend --dbpath "%MONGOPATH%\data\db" --serviceName "MongoDB" --serviceDisplayName "MongoDB" --install ) && (
sudo net start MongoDB ) && (
if %Choose2% == Y (
echo Installed successfully
echo You have chosen to reboot automatically, if you do not want to reboot please close the window directly in the upper right corner (do not use Ctrl + C or Ctrl + Z).
pause
shutdown -r -t 0
) else (
echo Installed successfully
echo Please reboot the system by yourself.
pause
)
)




