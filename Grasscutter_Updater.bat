@echo off
:ifexist
if exist ".\Grasscutter" (
  if exist ".\Grasscutter\grasscutter.jar" (
  echo 正在删除原来的grasscutter.jar
  del /q ".\Grasscutter\grasscutter.jar"
  echo 删除完毕
  goto gitpull
  ) else (
  goto gitpull
  )
) else (
  echo 正在克隆development分支
  git clone -b development https://github.com/Grasscutters/Grasscutter.git
  goto ifexist
)
:gitpull
echo 正在从development分支拉取更新 && (
cd ./Grasscutter
git pull origin development 
echo 正在编译grasscutter.jar
gradlew.bat 
gradlew jar
move grasscutter-*-dev.jar ./grasscutter.jar 
pause 
)

