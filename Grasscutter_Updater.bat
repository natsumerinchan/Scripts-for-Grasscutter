@echo off
@rem If you wnat to change to dev-world-scripts branch,please "set BRANCH=dev-world-scripts" 
@rem Branches List:
@rem stable
@rem development
@rem dev-world-scripts
cd /d %~dp0
set BRANCH=development

@rem Check network
set url=https://github.com/
for /f %%z in ('curl -so /dev/null -w %%{http_code} %url%') do (
set "NETWORK=%%z"
)
if %NETWORK% NEQ 200 (
echo [ERROR] Unable to access https://github.com. && pause && exit
) else (
echo [INFO] https://github.com is connected. && goto ifexist
)

@rem Clone or update Grasscutter
:ifexist
if exist ".\Grasscutter" (
  if exist ".\Grasscutter\grasscutter.jar" (
    echo [INFO] Deleting the original grasscutter.jar......
    del /q ".\Grasscutter\grasscutter.jar"
    echo [INFO] Deleted.
    goto gitpull
  ) else (
    goto gitpull
  )
) else (
  echo [INFO] Cloning the %BRANCH% branch......
  git clone -b %BRANCH% https://github.com/Grasscutters/Grasscutter.git
  goto ifexist
)
:gitpull
cd .\Grasscutter
for /F "delims=" %%n in ('git branch --show-current') do set "CURRENT=%%n"
echo [INFO] Current Branch: %CURRENT%
if not %CURRENT% == %BRANCH% (
  echo [INFO] Changing branch to %BRANCH%
  if exist ".\config.json" ( del /q ".\config.json" )
  if exist ".\data" ( rd /S /Q ".\data" )
  git checkout %BRANCH% >nul || git checkout -b %BRANCH% origin/%BRANCH% >nul
) 
(
echo [INFO] Pulling updates from the %BRANCH% branch
git reset --hard HEAD
git pull origin %BRANCH%:%BRANCH% 
echo [INFO] Finished. 
echo [INFO] Buliding jar...... 
gradlew.bat 
gradlew jar 
choice /t 5 /d y /n >nul 
move .\grasscutter-*-dev.jar .\grasscutter.jar 
echo [INFO] Finished. 
pause
)
