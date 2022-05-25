@echo off
echo 本脚本依赖Scoop，未安装的将自动进行安装并重新执行脚本
echo 此脚本会提示获取管理员权限两次，第一次是将MongoDB设置为系统服务，第二次是启动MongoDB服务

set /p Choose1=是否继续安装(Y/N):
set /p Choose2=安装完毕后是否立即重启系统(Y/N):
if %Choose1% == Y (
echo 正在开始安装
goto NEXT1
) else (
echo 已取消安装
pause 
exit
)
:NEXT1 && (
set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path% ) && (
if exist "%USERPROFILE%\scoop\shims\scoop" (
echo scoop已安装
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
echo Scoop已安装完毕，将重新运行脚本
pause && %0
)
)
:NEXT2 && (
echo 正在安装环境包...... ) && (
scoop update ) && (
scoop install oraclejdk@17.0.3.1 ) && (
scoop install mongodb mongodb-compass mitmproxy ) && (
echo 正在设置mongodb...... ) && (
echo 正在设置环境变量 ) && (
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
echo 安装成功
echo 你已经选择自动重启，若不想重启请在右上角直接关闭窗口（勿使用Ctrl + C或Ctrl + Z）
pause
shutdown -r -t 0
) else (
echo 安装成功
echo 请自行重启系统
pause
)
)




