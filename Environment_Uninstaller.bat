@chcp 65001 >nul
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
cd /d %~dp0
echo [WARN] [EN] It will delete all data from the server !!!! (Please back up in advance if you need.)
echo [INFO] [EN] This script only removes environment packages. Scoop, git, aria2，curl and sudo will be retained.
echo [WARN] [CN] 这将会把服务器所有的数据全部删除!!!!(有需要的请自行提前备份)
echo [INFO] [CN] 此脚本只删除环境包. Scoop, git, aria2 , curl和sudo将会被保留
set path=%USERPROFILE%\scoop\shims;C:\ProgramData\scoop\shims;%path%
set /p Choose1=Would you like to continue/是否要继续卸载?(Y/N):
set /p Choose2=Do you want to reboot your system immediately after the uninstallation completed/卸载完毕后是否立即重启?(Y/N):
if %Choose1% == Y (
  echo [INFO] [EN] Uninstallation is starting now......
  echo [INFO] [CN] 开始卸载......
  echo [INFO] [EN] Stop and remove MongoDB service and terminate java.exe
  echo [INFO] [CN] 关闭、移除MongoDB服务并终结java.exe
  taskkill /F /im java.exe
  net stop MongoDB
  mongod --remove
  powershell "[Environment]::SetEnvironmentVariable('MONGOPATH', $null, 'User')"
  echo [INFO] [EN] Uninstalling Environment Packages......
  echo [INFO] [CN] 正在卸载环境包......
  scoop uninstall openjdk17 mongodb mongodb-compass mitmproxy -p
  if %Choose2% == Y (
    echo [INFO] Uninstallation completed/卸载完毕
    echo [WARN] You have chosen to reboot automatically/你选择了自动重启系统
    echo [WARN] [EN] If you do not want to reboot,please close the window directly on the upper right corner.
    echo [WARN] [CN] 如果你现在不想重启系统，请直接在右上角关闭窗口
    echo [WARN] [EN] Do not use "Ctrl + C" or "Ctrl + Z"
    pause
    shutdown -r -t 0
  ) else (
    echo [INFO] Uninstallation completed/卸载完毕
    echo [INFO] Please reboot by yourself/请自行重启系统
    pause
  )
) else (
  echo [INFO] [EN] Canceled Uninstallation.
  echo [INFO] [CN] 已取消卸载。
  pause && exit
) 







