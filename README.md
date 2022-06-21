# Scripts-for-Grasscutter

[**简体中文**](README_zh-CN.md) || **English**
### 1、Environment_Installer.bat
Install Grasscutter environment packages by Scoop.
Packages list:
- [Scoop](https://github.com/ScoopInstaller/Scoop)
- git
- sudo
- aria2
- openjdk17
- mongodb
- mongodb-compass
- mitmproxy

### 2、Grasscutter_Updater.bat
Functions:
- 1、Clone Grasscutter
- 2、Update files and build grasscutter.jar
- 3、You can switch branches on "set BRANCH=" (Default value:development)

### 3、Resources_Updater.bat
Clone and update Resources files.(It will run by Grasscutter_Updater.bat. You don't need to run Resources_Updater.bat separately, unless you just want to upgrade resources.)

### 4、Fix_MongoDB_Service.bat
Fix MongoDB service after you have updated WINDOWS.

### 5、Environment_Uninstaller.bat

- This script only removes environment packages. Scoop, git, aria2 and sudo will be retained.

If you want to uninstall another packages 

```
usage: scoop uninstall package_name1 package_name2 package_name3 ......

scoop uninstall git aria2 sudo

```
- [Uninstall Scoop](https://github.com/ScoopInstaller/Scoop/wiki/Uninstalling-Scoop)

# Launch Scripts

### 1、Grasscutter_Start.bat
Only run the Grasscutter server and proxy server (Game will not be started).

### 2、proxy_server.bat
Run proxy server.It will be started automatically by Grasscutter_Start.bat.

### 3、Game_Start.bat
Run the Grasscutter server and proxy server,turn on the proxy settings and start the game automatically.
You should create a shortcut of "Genshin Impact game\GenshinImpact.exe(or YuanShen.exe)",put in the batch files folder and rename it to "Genshin".
