## wsl的文件的位置"ext4.vhdx"

C:\Users\Lenovo\AppData\Local\wsl\{d754f725-1bbd-492a-aed5-acbdda938ac9}

| 命令                                    | 含义                          |
| ------------------------------------- | --------------------------- |
| 安转                                    | wsl --install <NAME=ubuntu> |
| 更新                                    | wsl --update                |
| wsl                                   | 直接进入                        |
| wsl -l -v                             | 查看安装过的版本{list version}      |
| wsl -d <name>                         | 启动指定的版本                     |
| wsl --export \<NAME> \<PATH>          | 备份\<NAME>的wslsystemc        |
| wsl --import \<NAME> \<安装位置> \<压缩包位置> | 导入wslsystem                 |
| wsl --shutdown                        | 关闭wsl中的linux                |
| wsl --exec linuxcommand               | 执行linux的命令                  |
| exit                                  | 退出                          |

## wsl中

| 命令                | 效果                    |
| ----------------- | --------------------- |
| explorer.exe .    | 用资源管理器打开当前文件夹         |
| code .            | vscode有wsl直接以vscode打开 |
| cd /mnt/win中的path | 进入win的目录              |
| cmd.exe /c cmd命令  | 不进入cmd                |
| cmd.exe /k cmd命令  | 进入cmd,用exit退出cmd      |


# 
## windows 设配激活信息
```
slmgr.vbs -dli
```
个人使用**OEM**或**retail**