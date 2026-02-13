# 创建
## windows
```powershell
net share <name>=<path> /grant:<user>,<permission>

```

## linux
1. 配置smb.conf
2. pdbedit创建smb用户
### 极简版
```config
# /etc/samba/smb.conf
[global]
    security = [user]{只能是/etc/passwd中有的用户}
[ShareName]
    path = /path/to/share
    valid users = <UserName>
    [read only = no]{必写不然只读，不能读写}
    
```
### 拓展版
#### 用户名映射与权限区分
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

#### 匿名访问
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

### 创建smb用户
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
# 访问与离开
## win --> linux
### 临时挂载
```powershell
# 访问
net use  \\smb_ip\share [/user:<user> <passwd>]

# 离开
net use  \\smb_ip\share  /del

```
### 永久挂载
```powershell
net use <drive> \\smb_ip\share [/user:<user> <passwd>]

net use <drive> /del
```
## linux --> win
### 临时挂载
```bash
# 访问
mount -t cifs \
//smb_ip/share /path/to/mount_point \
-o username=<user>,password="<passwd>",uid=$(id -u),gid=$(id -g)

# 离开
umount /path/to/mount_point
```
### 永久挂载
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

