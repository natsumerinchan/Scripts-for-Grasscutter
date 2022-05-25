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

echo 此举将删除服务器所有数据!!!!(有需要的请提前备份)
echo 本脚本仅删除环境包，并未删除Scoop、git、aria2、sudo

set /p Choose1=是否继续卸载(Y/N):
set /p Choose2=卸载完毕后是否立即重启系统(Y/N):
if %Choose1% == Y (
echo 正在开始卸载
goto NEXT1
) else (
echo 已取消卸载
pause && exit
)
:NEXT1 && (
echo 设置环境变量......
set path=C:\Users\jm1ts\scoop\shims;C:\ProgramData\scoop\shims;%path% ) && (
echo 停止并删除MongoDB服务，终止java.exe ) & (
taskkill /F /im java.exe ) & (
net stop MongoDB ) & (
mongod --remove ) & (
echo 卸载环境包 ) & (
scoop uninstall oraclejdk mongodb mongodb-compass mitmproxy -p ) & (
if %Choose2% == Y (
echo 卸载完毕
echo 你已经选择自动重启，若不想重启请在右上角直接关闭窗口（勿使用Ctrl + C或Ctrl + Z）
pause
shutdown -r -t 0
) else (
echo 卸载完毕
echo 请自行重启系统
pause
)
)


