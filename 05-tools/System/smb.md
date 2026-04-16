# 一、创建
## 1. windows
```powershell
net share <name>=<path> /grant:<user>,<permission>

```
### 1.1 permission
| 权限级别       | 可执行的操作                                                              | 说明                                         |
| ---------- | ------------------------------------------------------------------- | ------------------------------------------ |
| Read（读取）   | - 查看文件和子文件夹  <br>- 读取文件内容  <br>- 运行可执行程序                            | ❌ 不能创建、修改、删除任何文件或文件夹                       |
| Change（更改） | - 所有 Read 权限  <br>- 创建新文件和文件夹  <br>- 修改现有文件内容  <br>- 删除自己有权限的文件/文件夹 | ⚠️ 不能更改权限（ACL）或取得所有权  <br>这是最常用的“普通用户写入”权限 |
| Full（完全控制） | - 所有 Change 权限  <br>- 更改文件/文件夹的权限（ACL）  <br>- 取得文件/文件夹的所有权          | 🔐 管理员级权限，慎用                               |
#### 📌 关键区别：`Change` vs `Full`

- **`Change`** = 读 + 写 + 删除（数据层面操作）
- **`Full`** = `Change` + **权限管理能力**（安全层面操作）

> 💡 举例：  
> 如果你只给用户 `Change` 权限，他可以上传、编辑、删除自己的文件，但**无法右键 → “属性” → “安全”选项卡去修改该共享的 NTFS 权限**。  
> 而 `Full` 权限允许他这样做（如果 NTFS 权限也允许）
### 1.2 pwsh 管理
#### 1.2.1 服务端
```powershell
# 查看权限
Get-SmbShareAccess -Name <share_name>
## 查看全部共享目录的权限
Get-SmbShare | [ForEach-Object]{"为每一个对象", 可缩写为 **%**}  { Get-SmbShareAccess —Name $_.Name }

# 修改权限
Grant-SmbShareAccess -Name <share_name> -AccountName <User_name> -AccessRight < [Read]{默认值, **只读**} | Full >  [-force]{跳过确认}

# 移除权限
Revoke-SmbShareAccess -Name <share_name> -AccountName <User_name> [-force]{跳过确认}


```

#### 1.2.2 客户端
```powershell
❯ Get-SmbConnection

ServerName ShareName UserName               Credential Dialect NumOpens
---------- --------- --------               ---------- ------- --------
localhost  firewall  LAPTOP-HS0L4TOD\Lenovo \Lenovo    3.1.1   1
```

## 2. linux
1. 配置smb.conf
2. pdbedit创建smb用户
### 2.1 极简版 
```config
# /etc/samba/smb.conf
[global]
    security = [user]{只能是/etc/passwd中有的用户}
[ShareName]
    path = /path/to/share
    valid users = <UserName>
    [read only = no]{必写不然只读，不能读写}
    
```
### 2.2 拓展版
#### 2.2.1 用户名映射与权限区分
```config
# /etc/samba/smb.conf
[global]
    security = user
    username map = /etc/samba/virtual_user_list
[share]
    path = /path/to/share
    valid users = artemis,verthandi
    [read only = no]{必写不然只读，不能读写}
    # 区分服务
    [write list = artemis]{artemis 可读可写}
    [read list = verthandi]{verthandi}
```
虚拟用户名配置文件格式
```shell
user = virtual_user_name
# eg
root = verthandi,thelema
 
```

#### 2.2.2 匿名访问
```shell
[global]
	security = user
	guest account = nobody
	map to guest = bad user
[anonymous]
    path = /tmp/anonymous/
    public = yes
    writable = yes
	create mask = 0665  # 默认为0644,导致对新创建的文件没有写操作
	directory maks=0775 # 默认为0755,导致对新创建的目录没有写操作

 
```

> [!attention] 无法访问
> 1. setenforce 0
> 2. firewall-cmd --add-service="samba"

[[(firewall)firewall-cmd和selinux#1.firewall-cmd | firewall-cmd 命令]]

### 2.3 创建smb用户
```shell
# 增 (交互式输入密码)
pdbedit -a <[user]{/etc/passwd 中已有的用户}>

# 删
pdbedit -x <user>

# 改 注意使用的smbpasswd
smbpasswd <user>
# 交互式修改密码

# 查
pdbedit -L
	
```

|场景|命令|
|---|---|
|用户自己改密码|`smbpasswd`|
|管理员添加用户|`sudo smbpasswd -a user`|
|重置用户密码|`sudo smbpasswd user`|
|禁用账户|`sudo smbpasswd -d user`|
|启用账户|`sudo smbpasswd -e user`|
|删除 SMB 权限|`sudo smbpasswd -x user`|
# 二、访问与离开
## 1. win --> linux
### 1.1 临时挂载
```powershell
# 访问
net use  \\smb_ip\share [/user:<user> <passwd>]

# 离开
net use  \\smb_ip\share  /del

```
### 1.2 永久挂载
```powershell
net use <drive> \\smb_ip\share [/user:<user> <passwd>]

net use <drive> /del
```
## 2. linux --> win
### 2.1 临时挂载
```bash
# 访问
mount -t cifs \
//smb_ip/share /path/to/mount_point \
-o username=<user>,password="<passwd>",uid=$(id -u),gid=$(id -g)

# 离开
umount /path/to/mount_point
```
### 2.2 永久挂载
```bash
# /etc/fstab
//smb_ip/share /path/to/mount_point cifs _netdev,credentials=[/path/to/credentials]{一般放在/etc/samba目录中} 0 0

# credentials文件
username=<user>
password=<passwd>
```
> [!attention] 注意
> credentialsw文件的权限必须是==600==
> `_netdev` 表示“等待网络就绪后再挂载”，对 systemd 系统有效。
> 1. `umount /path/to/mount_point` 取消现有的挂载
> 2. `systemctl daemon-reload` 重启守护进程
> 3. `mount -a`

