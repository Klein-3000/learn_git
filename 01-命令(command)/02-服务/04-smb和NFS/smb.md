NFS ： Network file system ： 网络文件系统
smb 与 vsftpd 的区别
1. vsftpd 不能在线编辑, 处理==大文件==传输
2. smb 可以在线编辑,  对于频繁的==小文件==操作，SMB提供的无缝集成和更好的目录浏览功能
# task
- samba 文件共享服务
- NFS(网络文件系统)
- autofs自动挂在服务
- 读写 访问源 用户控制
# Samba （smb）
常用端口
139
445
## NETBIOS 协议
NetBIOs是==Network Basic Input/Output System==的简称，网络基本输入/输出系统协议。一般指用于局域网通信的一套 API，是由IBM 公司开发。主要作用:通过 NETBIOS 协议获得计算机名称然后把计算机名解析为对应IP 地址。

主配置文件<span style="background:yellow;font-size:24px">/etc/samba/smb.conf</span>
[[NFS|NFS相关命令]]
# 一、配置共享资源
步骤
1. 创建用于访问共享资源的账户信息(pdbedit)
2. 创建用于共享资源的文件目录
3. 修改安全配置
	1. semanage  fcontext -a -t 标签 文件(目录)
	2. restorcon -Rv 目录
	3. selinux 服务与策略
			getsebool -a | grep samba
			==samba_enable_home_dirs --> on==
## 配置
```shell
[global]
	workgroup = SAMBA
	security = user
	passdb backend = tdbsam
[database]
	comment = Do not arbitrary modify the database file
	path = /home/share
	public = on
	writeable = yes
#============================ Share Definitions ==============================
[homes]
        comment = Home Directories
        browseable = no
        writable = yes
;       valid users = %S
;       valid users = MYDOMAIN\%S

[printers]
        comment = All Printers
        path = /var/tmp
        browseable = no
        guest ok = no
        writable = no
        printable = yes
```
## 自定义一个共享资源
```shell
[global] # 全局配置
	workgroup = thelema
	Server string = thelema samba server # 描述信息
	security = share     # share 匿名;user 用户认证
	# passdb backend = tdbsam  
	# 自定义密码文件,smb服务生成
	passdb backend = smbpasswd
	smb passwd file = /etc/samba/smbpasswd
	# 使用 smbpasswd -a <user_name> , 内容存储在/etc/samba/smbpasswd中
	
[thelema]  # 设置共享名;不能重复
	comment = the is thelema share directory  # 描述
	browseable = yes   # 是否允许查看此共享内容。如果是否，后期通过绝对路径，可以查看到。
	path = /home/thelema                       # 共享路径,只能写绝对路径
	public = yes                               # 允许匿名查看
# 访问控制
valid users = user_name [,user_name1,...]
valid users = @group_name

# 设置目录只读
read only = yes # yes 只读 ; no 读写

# 设置目录可写
writable = yes # yes 读写 ; no 只读
write list = user_name          # writable 开启后才生效
write list = @group_name

# 日志服务
log file = /var/log/samba/log.%m
max log size = 50 # 单位为kb

```
> [!note] security 和 passdb backend 的取值
> # security
> 1. share:代表主机无须验证密码。这相当于vsftpd服务的匿名公开访问模式，比较方便，但安全性很差。
> 2. ==user==:代表登录 Samba 服务时需要使用账号密码进行验证，通过后才能获取到文件。这是默认的验证方式，最为常用。
> 3. domain:代表通过域控制器进行身份验证，用来限制用户的来源域。server:代表使用独立主机验证来访用户提供的密码。这相当于集中管理账号，并不常用。
## windows 挂载共享
1. ctrl+r `\\192.168.94.148`
2. 输出smb 账户信息数据库中的对应的账户和密码
3. windows系统缓存的原因,下一次输入IP地址后,直接登录进去(可以重启,再次尝试)
## linux挂载
通用互联网文件系统（Common Internet File Systems）
需要==cifs-utils==软件包
[[挂载| mount 命令解析]]
```shell
mkdir /database

mount -t cifs -o username=share,password=123 //192.168.94.148/database /database
```
## windows & linux
> [!note] 访问samba服务
> # windows
> [[#windows 挂载共享]]
> # linux
> [[NFS#查看共享情况(smbclient) | smbclient 命令方法]]
> [[挂载#挂载smb| mount 命令方法]]


# 拓展
![[pdbedit]]

## 1.虚拟用户映射
```shell
[global]
	security = user
	username map = /etc/samba/virtual_user_list
[share]
	path = /tmp/smb_verthandi
	# 依旧是真实的用户
	valid users = verthandi
```
虚拟用户   
```ini
# /etc/samba/virtual_user_list
verthandi = thelema,v_ver
```
> [!note] 注意
> pdbedit -L 中账户==存在==，即可使用虚拟用映射

## 2.匿名访问
```shell
[global]
	security = user
	map to guest = bad user
	guest account = nobady
[share_anon]
	path = /tmp/anon
	guest ok = yes
	read only = no      # 默认为yes ， 即默认无法上传文件
	create mask = 0665  # 默认为0644,导致对新创建的文件没有写操作
	directory maks=0775 # 默认为0755,导致对新创建的目录没有写操作
```
> [!note] 参数解析
> # map to guest = bad user
> **用户映射策略**：当用户==认证失败==（如用户名不存在、密码错误）时，自动将该用户映射为 `guest` 用户，允许其以匿名身份访问允许匿名的共享
> # guest account = nobody
> - **指定 `guest` 用户身份**：当用户被映射为 `guest` 时，实际使用的系统用户是 `nobody`（或其他指定用户）。
> - **权限控制**：匿名用户的文件操作权限由 `nobody` 用户的系统权限决定。
## 3.区分权限
### 要求
- verthandi : rwx
- share      : r
### 配置
```shell
[local]
	path = /tmp/smb/local
	valid = verthandi,share
	read only = no
	write list = verthandi
	read list  = share
```