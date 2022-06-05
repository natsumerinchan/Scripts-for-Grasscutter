@chcp 65001 >nul
@echo off
cd /d %~dp0
echo [WARN] [EN] This script depends on Scoop, if it is not installed, it will install automatically and re-execute this script.
echo [WARN] [CN] 此脚本依赖Scoop，如果你还没有安装，它将自动进行安装并重启脚本

set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path% 
set /p Choose1=Would you like to continue/是否要继续安装?(Y/N):

if %Choose1% == Y (
  echo [INFO] [EN] Installation is starting now......
  echo [INFO] [CN] 开始安装......
  goto NEXT1
) else (
  echo [INFO] [EN] Canceled installation.
  echo [INFO] [CN] 已取消安装
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
  setx MONGOPATH "%USERPROFILE%\scoop\apps\mongodb\current"
  start .\Fix_MongoDB_Service.bat
) else (
  cls
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
  pause
  cls
  %0
)





