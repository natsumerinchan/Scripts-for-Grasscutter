@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

echo �˾ٽ�ɾ����������������!!!!(����Ҫ������ǰ����)
echo ���ű���ɾ������������δɾ��Scoop��git��aria2��sudo

set /p Choose1=�Ƿ����ж��(Y/N):
set /p Choose2=ж����Ϻ��Ƿ���������ϵͳ(Y/N):
if %Choose1% == Y (
echo ���ڿ�ʼж��
goto NEXT1
) else (
echo ��ȡ��ж��
pause && exit
)
:NEXT1 && (
echo ���û�������......
set path=C:\Users\jm1ts\scoop\shims;C:\ProgramData\scoop\shims;%path% ) && (
echo ֹͣ��ɾ��MongoDB������ֹjava.exe ) & (
taskkill /F /im java.exe ) & (
net stop MongoDB ) & (
mongod --remove ) & (
echo ж�ػ����� ) & (
scoop uninstall oraclejdk mongodb mongodb-compass mitmproxy -p ) & (
if %Choose2% == Y (
echo ж�����
echo ���Ѿ�ѡ���Զ������������������������Ͻ�ֱ�ӹرմ��ڣ���ʹ��Ctrl + C��Ctrl + Z��
pause
shutdown -r -t 0
) else (
echo ж�����
echo ����������ϵͳ
pause
)
)


