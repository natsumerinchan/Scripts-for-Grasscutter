@echo off
if exist ".\Grasscutter_Resources" (
  if exist ".\Grasscutter\Resources" (
    move ./Grasscutter/Resources ./Grasscutter_Resources/Resources
    cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo �������
  ) else (
    if exist ".\Grasscutter_Resources\Resources" (
      cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo �������
    ) else (
      rd /S /Q ".\Grasscutter_Resources"
      git clone https://github.com/Koko-boya/Grasscutter_Resources.git
      cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo �������
    )
  )
) else (
  if exist ".\Grasscutter\Resources" (
    echo ɾ����Resources
    rd /S /Q .\Grasscutter\Resources
  )
  git clone https://github.com/Koko-boya/Grasscutter_Resources.git
  cd ./Grasscutter_Resources && git pull origin main && move Resources ../Grasscutter/Resources && echo �������
)
pause

