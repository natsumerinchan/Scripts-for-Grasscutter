@echo off
echo ���ű�����Scoop��δ��װ�Ľ��Զ����а�װ������ִ�нű�
echo �˽ű�����ʾ��ȡ����ԱȨ�����Σ���һ���ǽ�MongoDB����Ϊϵͳ���񣬵ڶ���������MongoDB����

set /p Choose1=�Ƿ������װ(Y/N):
set /p Choose2=��װ��Ϻ��Ƿ���������ϵͳ(Y/N):
if %Choose1% == Y (
echo ���ڿ�ʼ��װ
goto NEXT1
) else (
echo ��ȡ����װ
pause 
exit
)
:NEXT1 && (
set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path% ) && (
if exist "%USERPROFILE%\scoop\shims\scoop" (
echo scoop�Ѱ�װ
goto NEXT2
) else (
powershell "iwr -useb get.scoop.sh | iex"
scoop install git
scoop bucket rm main
scoop bucket rm extras
scoop bucket rm java
scoop bucket add main
scoop bucket add extras
scoop bucket add java
scoop install aria2 sudo
echo Scoop�Ѱ�װ��ϣ����������нű�
pause && %0
)
)
:NEXT2 && (
echo ���ڰ�װ������...... ) && (
scoop update ) && (
scoop install oraclejdk@17.0.3.1 ) && (
scoop install mongodb mongodb-compass mitmproxy ) && (
echo ��������mongodb...... ) && (
echo �������û������� ) && (
setx MONGOPATH "%USERPROFILE%\scoop\apps\mongodb\current" ) && (
set MONGOPATH=%USERPROFILE%\scoop\apps\mongodb\current ) && (
copy nul "%MONGOPATH%\log\mongodb.log" ) & (
if not exist "%MONGOPATH%\data\db" ( 
md "%MONGOPATH%\data\db" ) ) && (
if not exist "%MONGOPATH%\mongo.config" (
echo dbpath=%MONGOPATH%\data\db>>"%MONGOPATH%\mongo.config"
echo logpath=%MONGOPATH%\log\mongodb.log>>"%MONGOPATH%\mongo.config" ) ) && (
sudo "%MONGOPATH%\bin\mongod.exe" --bind_ip 0.0.0.0 --logpath "%MONGOPATH%\log\mongodb.log" --logappend --dbpath "%MONGOPATH%\data\db" --serviceName "MongoDB" --serviceDisplayName "MongoDB" --install ) && (
sudo net start MongoDB ) && (
if %Choose2% == Y (
echo ��װ�ɹ�
echo ���Ѿ�ѡ���Զ������������������������Ͻ�ֱ�ӹرմ��ڣ���ʹ��Ctrl + C��Ctrl + Z��
pause
shutdown -r -t 0
) else (
echo ��װ�ɹ�
echo ����������ϵͳ
pause
)
)




