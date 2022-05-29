@echo off
cd /d %~dp0
if exist ".\Grasscutter_Resources" (
  if exist ".\Grasscutter\Resources" (
    move ./Grasscutter/Resources ./Grasscutter_Resources/Resources
    cd ./Grasscutter_Resources
    git pull origin main
    choice /t 5 /d y /n >nul
    move Resources ../Grasscutter/Resources
    echo [INFO] Update completed
  ) else (
    if exist ".\Grasscutter_Resources\Resources" (
      cd ./Grasscutter_Resources
      git pull origin main
      choice /t 5 /d y /n >nul
      move Resources ../Grasscutter/Resources
      echo [INFO] Update completed
    ) else (
      rd /S /Q ".\Grasscutter_Resources"
      git clone https://github.com/Koko-boya/Grasscutter_Resources.git
      cd ./Grasscutter_Resources
      git pull origin main
      choice /t 5 /d y /n >nul
      move Resources ../Grasscutter/Resources
      echo [INFO] Update completed
    )
  )
) else (
  if exist ".\Grasscutter\Resources" (
    echo [INFO] Deleting the original Resources folder......
    rd /S /Q .\Grasscutter\Resources
    echo [INFO] Finished.
  )
  git clone https://github.com/Koko-boya/Grasscutter_Resources.git
  cd ./Grasscutter_Resources
  git pull origin main
  choice /t 5 /d y /n >nul
  move Resources ../Grasscutter/Resources
  echo [INFO] Update completed
)
pause

