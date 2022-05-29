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
  echo [WARN] It seems that you have not installed Java! && pause && exit
)

:CHECKJAR
if not exist "%SERVER_JAR%" ( 
  echo [WARN] "grasscutter.jar" is not exist! && pause && exit 
) else (
  goto PROXY
)

:PROXY
if not exist ".\proxy_server.bat" (
  echo [WARN] proxy_server.bat is not exist! && pause && exit
) else (
  start .\proxy_server.bat
  goto Gserver
)

:Gserver
"%JAVA_PATH%\java.exe" -jar "%SERVER_JAR%"
pause




