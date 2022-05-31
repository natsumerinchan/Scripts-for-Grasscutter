@chcp 65001 >nul
@echo off
cd /d %~dp0
set SERVER_JAR=.\grasscutter.jar
set JAVA_HOME=%USERPROFILE%\scoop\apps\oraclejdk\current
set JAVA_PATH=%JAVA_HOME%\bin
set MITMPROXY_PATH=%USERPROFILE%\scoop\apps\mitmproxy\current

@rem Check Java 
%JAVA_PATH%\java.exe --version >nul
if %errorlevel% == 0 (
  goto CHECKJAR
) else (
  echo [WARN] [EN] It seems that you have not installed Java! 
  echo [WARN] [CN] 你好像还没有安装Java!
  pause && exit
)

:CHECKJAR
if not exist "%SERVER_JAR%" ( 
  echo [WARN] [EN] "grasscutter.jar" is not exist!
  echo [WARN] [CN] "grasscutter.jar"不存在!
  pause && exit 
) else (
  goto PROXY
)

:PROXY
if not exist ".\proxy_server.bat" (
  echo [WARN] [EN] proxy_server.bat is not exist!
  echo [WARN] [CN] proxy_server.bat不存在!
  pause && exit
) else (
  start .\proxy_server.bat
  goto Gserver
)

:Gserver
"%JAVA_PATH%\java.exe" -jar "%SERVER_JAR%"
pause




