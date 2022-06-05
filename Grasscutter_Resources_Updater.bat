@chcp 65001 >nul
@echo off
cd /d %~dp0

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
if exist ".\Grasscutter_Resources" (
  if exist ".\Grasscutter\Resources" (
    move .\Grasscutter\Resources .\Grasscutter_Resources\Resources
    cd .\Grasscutter_Resources
    git pull origin main
    choice /t 5 /d y /n >nul
    move .\Resources ..\Grasscutter\Resources
    echo [INFO] Update completed.
  ) else (
    if exist ".\Grasscutter_Resources\Resources" (
      cd .\Grasscutter_Resources
      git pull origin main
      choice /t 5 /d y /n >nul
      move .\Resources ..\Grasscutter\Resources
      echo [INFO] Update completed.
    ) else (
      rd /S /Q ".\Grasscutter_Resources"
      git clone https://github.com/Koko-boya/Grasscutter_Resources.git
      cd .\Grasscutter_Resources
      git pull origin main
      choice /t 5 /d y /n >nul
      move .\Resources ..\Grasscutter\Resources
      echo [INFO] Update completed.
    )
  )
) else (
  if exist ".\Grasscutter\Resources" (
    echo [INFO] [EN] Deleting the original Resources folder......
    echo [INFO] [CN] 删除旧的Resources文件夹......
    rd /S /Q .\Grasscutter\Resources
    echo [INFO] Finished.
  )
  git clone https://github.com/Koko-boya/Grasscutter_Resources.git
  cd .\Grasscutter_Resources
  git pull origin main
  choice /t 5 /d y /n >nul
  move .\Resources ..\Grasscutter\Resources
  echo [INFO] Update completed.
)
pause

