# Scripts-for-Grasscutter

Put scripts into Grasscutter's parent directory.
把脚本放入Grasscutter的上级文件夹
### 1、Environment_Installer.bat
Install Grasscutter environment packages by Scoop.
利用Scoop安装环境包
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
- 1、Clone Grasscutter
- 2、Update files and build grasscutter.jar automatically.（自动更新和构建）
- 3、You can switch branches on "set BRANCH=" (Default value:development)   （可更换分支）

### 3、Grasscutter_Resources_Updater.bat
Clone and update Resources files automatically.（自动克隆或更新Resources文件）

### 4、Fix_MongoDB_Service.bat
Fix MongoDB service after you have updated WINDOWS.（用于更新Windows系统后修复MongoDB服务）

### 5、Environment_Uninstaller.bat

- This script only removes environment packages. Scoop, git, aria2 and sudo will be retained.
- 此脚本只删除环境包. Scoop, git, aria2 , curl和sudo将会被保留

If you want to uninstall another packages 

- [Uninstall Scoop](https://github.com/ScoopInstaller/Scoop/wiki/Uninstalling-Scoop)

- Else:
```
usage: scoop uninstall package_name1 package_name2 package_name3 ......

scoop uninstall git aria2 sudo

```
# Launch Scripts

Put Scripts into Grasscutter folder.
复制到Grasscutter文件夹
### 1、Grasscutter_Start.bat
Only run the Grasscutter server and proxy server (Game will not be started).
只运行Grasscutter服务器和代理服务器（不自动启动游戏）

### 2、proxy_server.bat
Run proxy server.It will be started automatically by Grasscutter_Start.bat.
启动代理服务器。该脚本会自动被Grasscutter_Start.bat启动

### 3、Game_Start.bat
Run the Grasscutter server and proxy server,turn on the proxy settings and start the game automatically.
You should create a shortcut of "Genshin Impact game\GenshinImpact.exe(or YuanShen.exe)",put in Grasscutter folder and rename it to "Genshin".
运行Grasscutter服务器和代理服务器，并自动设置代理和启动游戏。你需要给"Genshin Impact game\GenshinImpact.exe(或YuanShen.exe)"创建一个快捷方式，放入Grasscutter文件夹并将其重命名为"Genshin"。
