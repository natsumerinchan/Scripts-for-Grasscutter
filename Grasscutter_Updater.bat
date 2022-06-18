@chcp 65001 >nul
@echo off
@rem If you wnat to change to dev-world-scripts branch,please change "set BRANCH=development" to "set BRANCH=dev-world-scripts".
@rem 如果你想更换分支为dev-world-scripts，请将"set BRANCH=development"改为"set BRANCH=dev-world-scripts"
@rem Branches List(分支列表):
@rem stable
@rem development
@rem dev-world-scripts
cd /d %~dp0
set BRANCH=development
set GRADLE_OPTS=-Dfile.encoding=utf-8
set JAVA_HOME=%USERPROFILE%\scoop\apps\openjdk17\current

@rem Check network(检查网络)
set url=https://github.com/
for /f %%z in ('curl -so /dev/null -w %%{http_code} %url%') do (
set "NETWORK=%%z"
)
if %NETWORK% NEQ 200 (
echo [ERROR] Unable to access https://github.com.
pause && exit
) else (
echo [INFO] https://github.com is connected.
goto ifexist
)

@rem Clone or update Grasscutter(克隆或拉取更新)
:ifexist
if exist ".\Grasscutter" (
  if exist ".\Grasscutter\lib\grasscutter.jar" (
    echo [INFO] [EN] Deleting the original grasscutter.jar......
    echo [INFO] [CN] 正在删除原来的grasscutter.jar......
    del /q ".\Grasscutter\lib\grasscutter.jar"
    echo [INFO] Deleted.
    goto gitpull
  ) else (
    goto gitpull
  )
) else (
  echo [INFO] [EN] Cloning the %BRANCH% branch......
  echo [INFO] [CN] 正在克隆 %BRANCH% 分支......
  git clone -b %BRANCH% https://github.com/Grasscutters/Grasscutter.git
  goto ifexist
)
:gitpull
cd .\Grasscutter
for /F "delims=" %%n in ('git branch --show-current') do set "CURRENT=%%n"
echo [INFO] Current Branch/当前分支: %CURRENT%
if not %CURRENT% == %BRANCH% (
  echo [INFO] [EN] Changing branch to %BRANCH%
  echo [INFO] [CN] 切换本地分支为%BRANCH%
  if exist ".\config.json" ( del /q ".\config.json" )
  if exist ".\data" ( rd /S /Q ".\data" )
  git checkout %BRANCH% >nul || git checkout -b %BRANCH% origin/%BRANCH% >nul
  git reset --hard HEAD
) 
(
echo [INFO] [EN] Pulling updates from the %BRANCH% branch......
echo [INFO] [CN] 从 %BRANCH% 分支拉取更新......
git pull origin %BRANCH%:%BRANCH% 
echo [INFO] Finished.
gradlew.bat 
gradlew jar 
choice /t 5 /d y /n >nul 
move .\grasscutter*.jar .\lib\grasscutter.jar 
echo [INFO] Finished.
pause
)
