# filebrowser

## 1. 安装
### github 仓库
[filebrowser/filebrowser: 📂 Web File Browser](https://github.com/filebrowser/filebrowser)

## 2. 使用
### 2.1 基础命令
```
# web 浏览文件
filebrowser [-r]{root} <path/to/dir> [-p]{port} <8080> 
filebrowser [-d]{database, `./filebrowser.db`} [-c]{config, `~/.filebrowser.json`}

# 用户管理
filebrowser users add <user> [<password>]{至少12位}
filebrowser users [ ls | remove <user> ]

# 配置管理
## 初始化和查看
filebrowser config [ init | cat ]
```
### 2.2 配置文件(json)
`$HOME/.filebrowser.json`
#### 2.2.1 linux
```json
{
    "address": "0.0.0.0",
    "port": 80,
    "root": "/root",
    "database": "/root/filebrowser.db",
    "log": "stdout"
}
```
#### 2.2.2 windows
```json
{
    "address": "0.0.0.0",
    "port": 80,
    "root": "D:/share",
    "database": "C:/Users/Lenovo/filebrowser.db",
    "log": "D:/filebrowser.log"
}
```
### 2.3 配置文件(yaml)
```yaml
address: 0.0.0.0
port: 80
# 支持 Windows 的路径写法
root: D:\share
database: D:\share\filebrowser.db
```

# 3. 环境变量
```bash
export FB_ADDRESS="0.0.0.0"
export FB_PORT="80"
export FB_ROOT="D:\share"
export FB_DATABASE="D:\share\filebrowser.db"
```

> [!attenton] 注意
> `filebrowser` 不支持通过==环境变量==直接指定 `filebrowser.json` 的位置