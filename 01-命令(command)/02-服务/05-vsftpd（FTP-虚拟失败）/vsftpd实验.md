# 1.匿名用户登录(anonymous)
## 配置
```shell
anonymous_enable=YES           # 启用匿名用户登录
local_enable=NO
anon_umask=022                 # 
write_enable=YES
anon_upload_enable=YES         # 允许上传文件
anon_mkdir_wire_enable=YES     # 创建目录
anon_other_wire_enable=YES     # 对目录重命名和删除目录
```
> [!warning] 注意
> 关闭firewalld服务
> selinux设置为==permissive==
> ftpd_full_access=on

# 本地用户(local)
[vsftp搭建虚拟用户模式 - 国杰响当当 - 博客园](https://www.cnblogs.com/luguojie/p/18589005)
## 配置
```shell
anonymous_enable=NO
local_enable=YES
local_umask=022
write_enable=YES

chroot_local_user=YES              # 禁止任意切换目录
local_root=/var/ftp/pub/local_ver  # 初始的目录

userlist_enable=YES                # 使用user_list中的名单,默认为NO
userlist_file=/etc/vsftpd/user_list# 指定名单文件,默认为此路径中的文件
userlist_deny=YES                  # YES user_list 为 黑名单(默认);NO user_list为 白名单

# 认证
pam_service_name=vsftpd
# 个性化设置
user_config_dir=/etc/vsftpd/users_config
```
> [!note] 笔记
> # 默认动作
> 默认根目录为登录用户的==家目录==
> 由于启动了==userlist_enable==,所以无法使用user_list中的所用用户
> # 个性化设置
> 在/etc/vsftpd/users_config(user_config**自定义**)目录中,创建对应==用户名==(**不需要**任何后缀)的文件,在文件中进行权限设置
> 如: 给用户verthandi个性化权限(**禁止**verthandi对用共享目录的**写操作**)
> vim /etc/vsftpd/users_config/verthandi
> write_enable=no



> [!warning] chroot_local_user 参数解析
> vsftpd 会要求该目录不能对用户本身可写（即不能是 777、757、775 等），否则会报错：
> `500 OOPS: refusing to run with writable root inside chroot()`
> 创建一个非家目录的共享文件夹
> 1. 目录(==local_root==的值)  /var/ftp/local_user 755
> 2. 共享文件夹             /var/ftp/local_user/share 777

> [!warning] 注意(FTP root 账号)
> 要使用root账号,就要处理下面的俩个配置,把root注释掉
> 1. user_list(可黑可白)
> 2. ftpuser(黑名单,出现在里面无论怎么设置都无法登录)

# 虚拟用户(Virtual)--失败
步骤
1. 创建用于FTP认证的==用户数据库文件==
2. 创建 vsfpd 服务程序用于==存储文件==的**根目录**以及用于==虚拟用户==**映射**的==系统本地用户==
3. 建立用于支持虚拟用户的[[#PAM]]文件
4. 在 vsftpd 服务程序的主配置文件中通过==pam_service_name== 参数将PAM 认证文件的名称修改为 ==vsfpd.vu==
5. 为虚拟用户设置不同的权限
## 相关命令
需要使用到==libdb-utils==软件包中db_load命令
```shell
# T 转换[ backlog ]
# t type 类型
# f file 文件
db_load -T -t hash -f vuser.list vuser.db

# 降低数据库文件的权限(避免其他人看到数据库文件的内容)
chmod 600 vuser.db

# 创建 nologin用户
userad -d /var/ftproot -s /sbin/nologin Virtual

chmod -fR 755 /var/ftproot
```
## 配置

> [!warning] 注意
> 虚拟用户需要映射到/etc/passwd中禁止登录(==nologin==)的用户

## 为虚拟用户设置不同的权限
```shell
mkdir /etc/vsftpd/vusers_dir
cd /etc/vsftpd/vusers_dir
vim zhangsan
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
```

# PAM
PAM(pluggable authentication mode : 可插拔认证模块)
## 配置文件(/etc/pam.d/vsftpd.vu)
```shell
auth required pam_userdb.so db=/etc/vsftpd/vuser
account required pam_userdb.so db=/etc/vsftpd/vuser
```
> [!warning]
> 配置文件中vuser是指db_load命令创建的认证文件
> ==不需要==后缀名
# TFTP(简单文件传输协议)
## 安装
```shell
dnf install tftp-server tftp xinetd
```
