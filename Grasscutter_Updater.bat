@echo off
:ifexist
if exist ".\Grasscutter" (
  if exist ".\Grasscutter\grasscutter.jar" (
  echo ����ɾ��ԭ����grasscutter.jar
  del /q ".\Grasscutter\grasscutter.jar"
  echo ɾ�����
  goto gitpull
  ) else (
  goto gitpull
  )
) else (
  echo ���ڿ�¡development��֧
  git clone -b development https://github.com/Grasscutters/Grasscutter.git
  goto ifexist
)
:gitpull
echo ���ڴ�development��֧��ȡ���� && (
cd ./Grasscutter
git pull origin development 
echo ���ڱ���grasscutter.jar
gradlew.bat 
gradlew jar
move grasscutter-*-dev.jar ./grasscutter.jar 
pause 
)

