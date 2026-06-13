# 一、rclone serve
## 1. restic
### 1.1 服务端 (rclone)
```bash
rclone serve restic --addr localhost:8080

```
### 1.2 客户端 (restic)
```bash
export RESTIC_REPOSITORY="rest:http://localhost:8080"
export RESTIC_PASSWORD="passwd"

restic <command>
...
```
### 1.3 restic 命令
1. [[(Backup)Restic | Restic 命令]]
2. [[(Backup)Restic-仓库结构 | Resitc 仓库结构]]

## 2. http
```bash
rclone serve [ http | webdav]{} [< storge >]{可以是==本地==目录,也可以是==资源目录==}   [--addr localhost:8080]{默认值; 其他写法`:8080`为`0.0.0.0:8080`}   [--user < user > --pass < passwd > ]{可选,默认无认证}
```
> [!note] 笔记
> 1. `webdav` 服务, 使用浏览器访问时与 `http` 服务的效果一致
> 2. 但是已经是一个`webdav`服务器了

## 3. sftp
```bash
rclone serve sftp  [< storge >]{可以是==本地==目录,也可以是==资源目录==}  [--addr localhost:2022]{默认值}  --user < user > --pass < passwd >
```
[[ssh-客户端#sftp (secure file transfer protocol) | sftp 命令]]

# 二、环境变量
![[(tool)rclone-环境变量#1.2 服务端 (server)]]

