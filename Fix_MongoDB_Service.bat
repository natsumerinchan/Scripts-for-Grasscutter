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

echo [INFO] This script is for fixing the MongoDB Service when you have updated WINDOWS.
set /p choose=Would you like to continue?(Y/N)
if %choose% == Y (
    goto NEXT
) else (
    echo [INFO] Cancel fix.
    pause
    exit
)

:NEXT
SC QUERY "MongoDB" >nul
if %errorlevel% == 0 (
    echo [INFO] MongoDB Service is exist.
    echo [INFO] Turning on the MongoDB Service......
    net start MongoDB
    echo [INFO] Finished!
    pause
) else (
    set MONGOPATH=%USERPROFILE%\scoop\apps\mongodb\current >nul
    echo [INFO] MongoDB Service is not exist.
    echo [INFO] Adding MongoDB Service......
    "%MONGOPATH%\bin\mongod.exe" --bind_ip 0.0.0.0 --logpath "%MONGOPATH%\log\mongodb.log" --logappend --dbpath "%MONGOPATH%\data\db" --serviceName "MongoDB" --serviceDisplayName "MongoDB" --install
    echo [INFO] Turning on the MongoDB Service......
    net start MongoDB
    echo [INFO] Finished!
    pause
)




