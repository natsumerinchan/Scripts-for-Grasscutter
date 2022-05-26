@echo off
:ifexist
if exist ".\Grasscutter" (
  if exist ".\Grasscutter\grasscutter.jar" (
    echo Deleting the original grasscutter.jar ......
    del /q ".\Grasscutter\grasscutter.jar"
    echo Deleted.
    goto gitpull
  ) else (
    goto gitpull
  )
) else (
  echo Cloning the development branch ......
  git clone -b development https://github.com/Grasscutters/Grasscutter.git
  goto ifexist
)
:gitpull
echo Pulling updates from the development branch && (
cd ./Grasscutter
git pull origin development 
echo Finished.
gradlew.bat 
gradlew jar
move grasscutter-*-dev.jar ./grasscutter.jar 
pause 
)

