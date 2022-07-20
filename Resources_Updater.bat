@chcp 65001 >nul
@echo off
@rem If you wnat to change to 2.7 branch,please change "set RESOURCES_BRANCH=2.8" to "set RESOURCES_BRANCH=2.7".
@rem 如果你想更换分支为2.7，请将"set RESOURCES_BRANCH=2.8"改为"set RESOURCES_BRANCH=2.7"
@rem Branches List(分支列表):
@rem 2.7
@rem 2.8

title Resources Updater
cd /d %~dp0
set RESOURCES_BRANCH=2.8

echo ##########################################################################
echo ..........................................................................
echo                    Grasscutter Resources Updater
echo                    Author:natsumerinchan@Github
echo ..........................................................................
echo ##########################################################################

echo [INFO] Update Resources
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

@rem Clone or update Resources(克隆或拉取更新)
:ifexist
if exist ".\.Grasscutter_Resources" (
  if exist ".\Grasscutter\Resources" (
    move .\Grasscutter\Resources .\.Grasscutter_Resources\Resources
    if '%errorlevel%' NEQ '0' ( goto ifexist )
    cd .\.Grasscutter_Resources
    git checkout %RESOURCES_BRANCH% >nul || git checkout -b %RESOURCES_BRANCH% origin/%RESOURCES_BRANCH% >nul
    git pull origin %RESOURCES_BRANCH%
    goto MOVE
  ) else (
    if exist ".\.Grasscutter_Resources\Resources" (
      cd .\.Grasscutter_Resources
      git checkout %RESOURCES_BRANCH% >nul || git checkout -b %RESOURCES_BRANCH% origin/%RESOURCES_BRANCH% >nul
      git pull origin %RESOURCES_BRANCH%
      goto MOVE
    ) else (
      rd /S /Q ".\.Grasscutter_Resources"
      git clone -b %RESOURCES_BRANCH% https://github.com/Koko-boya/Grasscutter_Resources.git .Grasscutter_Resources
      attrib +h .\.Grasscutter_Resources /d
      cd .\.Grasscutter_Resources
      git pull origin %RESOURCES_BRANCH%
      goto MOVE
    )
  )
) else (
  if exist ".\Grasscutter\Resources" (
    echo [INFO] [EN] Deleting the original Resources folder......
    echo [INFO] [CN] 删除旧的Resources文件夹......
    rd /S /Q .\Grasscutter\Resources
    echo [INFO] Finished.
  )
  git clone -b %RESOURCES_BRANCH% https://github.com/Koko-boya/Grasscutter_Resources.git .Grasscutter_Resources
  attrib +h .\.Grasscutter_Resources /d
  cd .\.Grasscutter_Resources
  git pull origin %RESOURCES_BRANCH%
  goto MOVE
)

:MOVE
choice /t 1 /d y /n >nul
move .\Resources ..\Grasscutter\Resources
if '%errorlevel%' NEQ '0' ( goto MOVE )
echo [INFO] Update completed.
pause

