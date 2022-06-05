@chcp 65001 >nul
@echo off
cd /d %~dp0
setx MONGOPATH "%USERPROFILE%\scoop\apps\mongodb\current"
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

taskkill /F /im "WindowsTerminal.exe" >nul
taskkill /F /im "OpenConsole.exe" >nul
cls

echo [INFO] [EN] This script is for fixing the MongoDB Service after you have updated WINDOWS.
echo [INFO] [CN] 此脚本用于在Windows系统更新后修复MongoDB服务
set /p choose=Would you like to continue?(Y/N)
if %choose% == Y (
    goto NEXT
) else (
    echo [INFO] [EN] Cancel fix.
    echo [INFO] [CN] 已取消修复。
    pause
    exit
)

:NEXT
SC QUERY "MongoDB" >nul
if %errorlevel% == 0 (
    echo [INFO] MongoDB Service is exist/MongoDB服务已存在
    net start MongoDB
    echo [INFO] Finished.
    pause
) else (
    echo [INFO] Setting up MongoDB/正在设置MongoDB
    set "MONGOPATH=%USERPROFILE%\scoop\apps\mongodb\current"
    if not exist "%MONGOPATH%\log\mongodb.log" ( copy nul "%MONGOPATH%\log\mongodb.log" )
    if not exist "%MONGOPATH%\data\db" ( md "%MONGOPATH%\data\db" ) 
    if not exist "%MONGOPATH%\mongo.config" (
    echo dbpath=%MONGOPATH%\data\db>"%MONGOPATH%\mongo.config"
    echo logpath=%MONGOPATH%\log\mongodb.log>>"%MONGOPATH%\mongo.config" ) 
    "%MONGOPATH%\bin\mongod.exe" --bind_ip 0.0.0.0 --logpath "%MONGOPATH%\log\mongodb.log" --logappend --dbpath "%MONGOPATH%\data\db" --serviceName "MongoDB" --serviceDisplayName "MongoDB" --install 
    net start MongoDB
    echo [INFO] Finished.
    pause
)




