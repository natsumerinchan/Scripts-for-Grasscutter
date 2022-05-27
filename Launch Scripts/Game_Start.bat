@echo off

echo [INFO] Setting proxy......
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "127.0.0.1:23121" /f >nul
echo [INFO] Proxy settings is completed!

start .\Grasscutter_Start.bat 

:LOOP1
tasklist|find /i "mitmdump.exe" >nul
if %errorlevel%==0 (
choice /t 5 /d y /n >nul
start .\Genshin.lnk 
echo [INFO] Game is started!
goto NEXT1
) else (
goto LOOP1
)

:NEXT1
choice /t 15 /d y /n >nul
tasklist|find /i "GenshinImpact.exe" >nul
if %errorlevel%==0 (
   set GAMEEXE=GenshinImpact.exe >nul
   goto LOOP2
) else (
   set GAMEEXE=YuanShen.exe >nul
   goto LOOP2
)

:LOOP2
choice /t 5 /d y /n >nul
tasklist|find /i "%GAMEEXE%" >nul
if %errorlevel%==0 (
   goto LOOP2
) else (
   echo [INFO] Game is exited!
   echo [INFO] Clearing proxy settings......
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul 
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f >nul
   echo [INFO] Proxy settings is cleared!
   taskkill /F /im mitmdump.exe >nul
   echo [INFO] Proxy server is killed!
   taskkill /F /im "java.exe" >nul
   echo [INFO] Grasscutter server is stoped!
   echo Please press any key to stop the terminal windows......
   pause >nul
   taskkill /F /im "WindowsTerminal.exe" >nul & taskkill /F /im "cmd.exe" >nul
)