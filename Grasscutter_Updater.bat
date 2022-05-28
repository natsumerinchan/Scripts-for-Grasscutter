@echo off
@rem If you wnat to change to dev-world-scripts branch,please "set BRANCH=dev-world-scripts" 
@rem Branches List:
@rem stable
@rem development
@rem dev-world-scripts

set BRANCH=development

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
cd ./Grasscutter
for /F "delims=" %%n in ('git branch --show-current') do set "CURRENT=%%n"
echo [INFO] Current Branch: %CURRENT%
if not %CURRENT% == %BRANCH% (
  echo [INFO] Changing branch to %BRANCH%
  if exist ".\config.json" ( del /q ".\config.json" )
  if exist ".\data" ( rd /S /Q ".\data" )
  git checkout %BRANCH% >nul || git checkout -b %BRANCH% origin/%BRANCH% >nul
  git reset --hard HEAD
)
echo [INFO] Pulling updates from the %BRANCH% branch && ^
git pull origin %BRANCH%:%BRANCH% && ^
echo [INFO] Finished. && ^
echo [INFO] Buliding jar...... && ^
gradlew.bat && ^
gradlew jar && ^
move ./grasscutter-*-dev.jar ./grasscutter.jar && ^
echo [INFO] Finished. && ^
pause

