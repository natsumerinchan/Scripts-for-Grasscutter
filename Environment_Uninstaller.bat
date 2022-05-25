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

echo This will delete all data from the Grasscutter server !!!! (Please back up in advance if you need to.)
echo This script only removes environment packages. Scoop, git, aria2, sudo are retained.

set /p Choose1=Do you want to continue?(Y/N):
set /p Choose2=Do you want to reboot your system immediately after the uninstallation is complete?(Y/N):
if %Choose1% == Y (
echo Uninstallation is starting now......
goto NEXT1
) else (
echo Canceled Uninstallation.
pause && exit
)
:NEXT1 && (
echo Setting up environment variables......
set path=C:\Users\jm1ts\scoop\shims;C:\ProgramData\scoop\shims;%path% ) && (
echo Stop and remove MongoDB service and terminate java.exe ) & (
taskkill /F /im java.exe ) & (
net stop MongoDB ) & (
mongod --remove ) & (
echo Uninstall Environment Packages ) & (
scoop uninstall oraclejdk mongodb mongodb-compass mitmproxy -p ) & (
if %Choose2% == Y (
echo Uninstallation completed.
echo You have chosen to reboot automatically, if you do not want to reboot please close the window directly in the upper right corner (do not use Ctrl + C or Ctrl + Z).
pause
shutdown -r -t 0
) else (
echo Uninstallation completed.
echo Please reboot the system yourself.
pause
)
)


