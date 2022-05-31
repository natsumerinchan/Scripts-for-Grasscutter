@chcp 65001 >nul
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
    echo [INFO] Turning on the MongoDB Service/正在启动MongoDB服务
    net start MongoDB
    echo [INFO] Finished/已完成
    pause
) else (
    set MONGOPATH=%USERPROFILE%\scoop\apps\mongodb\current >nul
    echo [INFO] MongoDB Service is not exist/MongoDB服务不存在
    echo [INFO] Adding MongoDB Service/正在添加MongoDB服务
    "%MONGOPATH%\bin\mongod.exe" --bind_ip 0.0.0.0 --logpath "%MONGOPATH%\log\mongodb.log" --logappend --dbpath "%MONGOPATH%\data\db" --serviceName "MongoDB" --serviceDisplayName "MongoDB" --install
    echo [INFO] Turning on the MongoDB Service/正在启动MongoDB服务
    net start MongoDB
    echo [INFO] Finished/已完成
    pause
)




