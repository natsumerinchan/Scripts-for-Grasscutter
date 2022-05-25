@echo off
if exist ".\Grasscutter_Resources" (
  if exist ".\Grasscutter\Resources" (
    move ./Grasscutter/Resources ./Grasscutter_Resources/Resources
    cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo Update completed
  ) else (
    if exist ".\Grasscutter_Resources\Resources" (
      cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo Update completed
    ) else (
      rd /S /Q ".\Grasscutter_Resources"
      git clone https://github.com/Koko-boya/Grasscutter_Resources.git
      cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo Update completed
    )
  )
) else (
  if exist ".\Grasscutter\Resources" (
    echo Delete the original Resources folder
    rd /S /Q .\Grasscutter\Resources
    echo Finished.
  )
  git clone https://github.com/Koko-boya/Grasscutter_Resources.git
  cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo Update completed
)
pause

