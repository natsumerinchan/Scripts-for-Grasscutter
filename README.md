# Scripts-for-Grasscutter

Put scripts into Grasscutter's parent directory.
### 1、Environment_Installer.bat
Install Grasscutter environment packages by Scoop.
Packages list:
- [Scoop](https://github.com/ScoopInstaller/Scoop)
- git
- sudo
- aria2
- oraclejdk@17.0.3.1
- mongodb
- mongodb-compass
- mitmproxy

### 2、Grasscutter_Updater.bat
Functions:
- 1、Clone Grasscutter development branch
- 2、Update files and build grasscutter.jar automatically.

### 3、Grasscutter_Resources_Updater.bat
Clone and update Resources files automatically.

### 4、Environment_Uninstaller.bat

This script only removes environment packages. Scoop, git, aria2 and sudo will be retained.

If you want to uninstall Scoop,git,aria2 and sudo 

- [Uninstall Scoop](https://github.com/ScoopInstaller/Scoop/wiki/Uninstalling-Scoop)

- Else:
```
usage: scoop uninstall package_name
scoop uninstall git aria2 sudo

```
# Launch Scripts

Put Scripts into Grasscutter folder.
### 1、Server_Start.bat
Only run the server and turn on the proxy (without start the game).

### 2、proxy.bat
Turn on the proxy.It will be started automatically by Server_Start.bat.

### 3、Game_Start.bat
Run the server and turn on the proxy (with start the game).
You should create a shortcut of "Genshin Impact game\GenshinImpact.exe(or YuanShen.exe)",put in Grasscutter folder and rename it to "Genshin".
