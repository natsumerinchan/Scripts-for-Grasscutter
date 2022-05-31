@chcp 65001 >nul
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

echo [WARN] [EN] This script depends on Scoop, if it is not installed, it will install automatically and re-execute this script.
echo [WARN] [CN] 此脚本依赖Scoop，如果你还没有安装，它将自动进行安装并重启脚本。

set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path% 
set /p Choose1=Would you like to continue/是否要继续安装?(Y/N):
set /p Choose2=Do you want to reboot the system immediately after installation/安装完成后是否立即重启?(Y/N):

if %Choose1% == Y (
echo [INFO] [EN] Installation is starting now......
echo [INFO] [CN] 开始安装......
goto NEXT1
) else (
echo [INFO] [EN] Canceled installation.
echo [INFO] [CN] 已取消安装。
pause 
exit
)

:NEXT1
if exist "%USERPROFILE%\scoop\shims\scoop" (
  echo [INFO] Scoop is installed/已安装Scoop
  echo [INFO] Installing environment packages/正在安装环境包
  scoop update 
  scoop install aria2 sudo curl
  scoop install oraclejdk@17.0.3.1 
  scoop install mongodb mongodb-compass mitmproxy 
  echo [INFO] Setting up MongoDB/正在设置MongoDB
  echo [INFO] Setting up environment variables/正在设置环境变量
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
    echo [INFO] Installed successfully/安装成功
    echo [WARN] You have chosen to reboot automatically/你选择了自动重启系统
    echo [WARN] [EN] If you do not want to reboot,please close the window directly on the upper right corner.
    echo [WARN] [EN] Do not use "Ctrl + C" or "Ctrl + Z"
    echo [WARN] [CN] 如果你现在不想重启系统，请直接在右上角关闭窗口。
    echo [WARN] [CN] 勿使用 "Ctrl + C" or "Ctrl + Z"
    pause
    shutdown -r -t 0
  ) else (
    echo [INFO] Installed successfully/安装成功
    echo [INFO] Please reboot by yourself/请自行重启系统
    pause
  )
) else (
  echo [INFO] [EN] Scoop installation is starting.
  echo [INFO] [CN] 开始安装Scoop
  powershell "iwr -useb get.scoop.sh | iex"
  scoop install git
  scoop bucket rm main >nul
  scoop bucket rm extras >nul
  scoop bucket rm java >nul
  scoop bucket add main
  scoop bucket add extras
  scoop bucket add java
  scoop install aria2 sudo curl
  echo [INFO] Scoop is installed/Scoop已安装
  %0
)





