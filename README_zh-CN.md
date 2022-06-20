# Scripts-for-Grasscutter

[**简体中文**] | [**English**](README.md)
### 1、Environment_Installer.bat
通过Scoop安装Grasscutter环境包。
软件包列表。
- [Scoop](https://github.com/ScoopInstaller/Scoop)
- git
- sudo
- aria2
- openjdk17
- mongodb
- mongodb-compass
- mitmproxy

### 2、Grasscutter_Updater.bat
功能。
- 1、克隆Grasscutter
- 2、更新文件并建立grasscutter.jar
- 3、你可以修改 "set BRANCH="（默认值：development）切换分支。

### 3、Grasscutter_Resources_Updater.bat
克隆和更新资源文件

### 4、Fix_MongoDB_Service.bat
在更新WINDOWS后修复MongoDB服务。(安装环境包时会调用它启动MongoDB服务)

### 5、Environment_Uninstaller.bat

- 这个脚本只删除环境包。Scoop, git, aria2和sudo将被保留。

如果你想卸载其他软件包 

```
使用方法： scoop uninstall package_name1 package_name2 package_name3 ......

scoop uninstall git aria2 sudo

```
- [Uninstall Scoop](https://github.com/ScoopInstaller/Scoop/wiki/Uninstalling-Scoop)

# 启动脚本

### 1、Grasscutter_Start.bat
只运行Grasscutter服务器和代理服务器（游戏将不会被启动）。

### 2、proxy_server.bat
运行代理服务器，它将由Grasscutter_Start.bat自动启动。

### 3、Game_Start.bat
运行Grasscutter服务器和代理服务器，打开代理设置并自动启动游戏。
你应该创建一个 "Genshin Impact game\GenshinImpact.exe(或YuanShen.exe) "的快捷方式，放在批处理脚本所在文件夹中，并将其重命名为 "Genshin"。
