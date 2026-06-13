# rclone
## 1. 安装
```
curl https://rclone.org/install.sh | bash
```

### FUSE
1. Filesystem in Userspace，用户空间文件系统
2. Windows 需要而外安装 [Download · WinFsp](https://winfsp.dev/rel/)  才能使用 `rclone mount` 命令
```
https://github.com/billziss-gh/winfsp/releases/download/v1.7B1/winfsp-1.7.20038.msi
```
> [winfsp]{windows File System Proxy}很久没有更新了

## 2. 使用
### 2.1 基础命令
 命令文档 ： [Commands](https://rclone.org/commands/)
```bash
# 配置资源
rclone config
> 1. n （新建资源）
> 2. 资源名(mywebdav)
> 3. 资源类型(如 ftp webdav)
> 4. 地址(ftp_srv, webdav_srv)
> 5. 认证(用户名和密码)
> 6. 高级设置(advance)
## 查看配置
rclone config show [资源名]
## 配置密码
rclone obscure <origin_passwd>

# 挂载资源
## windows
rclone mount [mywebdav]{资源名}:/  z: [--cache-dir D:\tmp]{指定存储目录}  [--vfs-cache-mode writes | full ]{虚拟文件系统, 写模式} [--file-perms 0777]{设置挂载后文件的权限为 0777（即所有用户可读、可写、可执行）}

# 传输
rclone [copy | move | sync ] mywebdav:/ D:\from-webdav

# 文件管理
## 查看
rclone [ls | lsd ] mywebdav:/
## 查看文件内容
rclone cat mywebdav:/1.txt
## 大小
rclone size mywebdav:/
## 其他`mount`后操作

```

### **`--vfs-cache-mode writes`**
    
- **作用**：设置虚拟文件系统（VFS）的缓存模式为“写入缓存”。
- **分析**：这是 WebDAV 挂载体验的核心参数。
	- **不开缓存（off）**：所有读写都直接走网络，速度极慢且容易出错。
	- **writes 模式**：当你往 Z 盘写入或修改文件时，Rclone 会先把数据快速写入到 `D:\tmp` 这个本地缓存目录中，让你的程序（如 Word、视频剪辑软件）立刻觉得“保存成功”。随后，Rclone 会在后台静默地将这些文件上传到 WebDAV 服务器。
	- **读取行为**：在 `writes` 模式下，**只读文件**（比如你只是打开看一个视频）依然是直接从网络拉取的，不会占用本地磁盘缓存。
### 2.2 配置
1. linux : ~/.config/rclone/rclone.conf
2.  windows : $ENV:AppData\rclone\rclone.conf
#### 2.2.1 webdav
```ini
[mywebdav]
type = webdav
url = <http://webdav_srv:port>
vendor = other
user = <user>
pass =  [<obscured_passwd>]{必须**obscure**,即`rclone obscure <origin_passwd>`}

```
#### 2.2.2 sftp
```
[sftp]
type = sftp
host = <ssh_srv_ip>
user = <user>
port =  22
pass = [<obscured_passwd>]{必须**obscure**,即`rclone obscure <origin_passwd>`}

# 指定已知主机文
known_hosts_file =  ~/.ssh/known_hots

# ssh 密钥
key_file = <path/to/key_file>
key_file_pass = <key_file_pass>

# Linux 系统会自动生成下面的配置
shell_type = unix
# Windows 系统会会自动生成下面的配置
shell_type = cmd

# 文件校验
md5sum_command = md5sum
sha1sum_command = sha1sum
```
案例
```
# 使用 ssh 配置
[s1]
type = sftp
# 支持解析 `~/.ssh/config` 的配置
ssh = ssh [< host >]{主机名}
# 需要配置文件校验的命令，否则无法复制文件等操作
md5sum_command = md5sum
sha1sum_command = sha1sum
known_hosts_file = ~/.ssh/known_hosts
shell_type = unix

# 不使用 ssh 配置
[s2]
type = sftp
user = root
host = 192.168.183.131
pass = Y0BbqALslDIY1XcS4J4chh8j4ns
known_hosts_file = ~/.ssh/known_hosts
shell_type = unix
```

- **左边的 `ssh`**：是 rclone 的一个开关/选项名（代表“外部SSH程序路径”）。
- **右边的 `ssh`**：是你电脑系统里真实的 `ssh` 可执行文件。
- **右边的 `< host >`**：是传给系统 `ssh` 的具体连接目标（别名）

> [!attention] 注意
> 使用 `ssh = ssh <host>` 时,需要手动添加`md5sum_command`和`sha1sum_command`的值(可以为`none`或`md5sum`与`sha1sum`) 否则执行 `copy` 等命令时会**卡住**
####  2.2.3 smb
```
[smb]
type = smb
host = <smb_srv_ip>
user = <user>
pass =  [<obscured_passwd>]{必须**obscure**,即`rclone obscure <origin_passwd>`}

```

#### 2.2.4 crypt
##### 本地（local）
```ini
[secret]
type = crypt
remote = [/path/to/secret]{被加密的目录}
# 可选
# filename_encryption = standard
# directory_name_encryption = True
password = [<obscured_passwd>]{必须**obscure**,即`rclone obscure <origin_passwd>`}
```
##### 远程 (remote)
```ini
[from_remote_secret]
type = crypt
remote = s1:/D:/encrypt
password =  [<obscured_passwd>]{必须**obscure**,即`rclone obscure <origin_passwd>`}
```
> [!attention] 注意
 > `enc` 存放加密后的目录, 需要==先==`enc`==挂载==起来,然后再挂载目录存放文件,才会被 `rclone` 加密
##### 文件名加密模式

| 对比维度     | 关掉 (false)       | 标准 (standard)   |
| :------- | :--------------- | :-------------- |
| 文件名与目录显示 | 不隐藏（文件名和目录结构均可见） | 文件名加密（目录结构可见）   |
| 文件名长度限制  | 支持更长（约 246 个字符）  | 长度受限（约 143 个字符） |
| 上传命名机制   | -                | 相同文件名对应相同的上传名称  |
| 路径与文件操作  | 支持子路径，可复制单个文件    | 支持子路径，可复制单个文件   |
| 目录优化     | -                | 支持使用快捷方式缩短目录递归  |

## 前端界面
[kapitainsky/RcloneBrowser: Simple cross platform GUI for rclone. Supports macOS, GNU/Linux, BSD family and Windows.](https://github.com/kapitainsky/RcloneBrowser)
 本质就是在调用命令行

# 3. 与其他工具联动
## 3.1 与 restic 联动
![[(tool)rclone-serve#1. restic]]
## 3.2 与 webdav 联动
### 3.2.1 服务端 (webdav)
[[(tool)webdav#2. 使用]]
### 3.2.2 客户端 (rclone)



# 单词
1. obscure ： 模糊
2. crypt ： 地下室
3. encrypt ：加密
4. decrypt ： 解密