# 1.常用参数
端口 
Server
- 20 进行数据传输(主动模式;被动模式下大于1023)
- 21接受客户端发出的相关ftp命令和参数
clinet
- cmd和data都是大于==1023==
模式(对==服务器==而言)
- 主动模式(active mode; ):ftp Server ==主动==向clinet 发起链接请求
- 被动模式(passive mode; pasv命令默认):==等待==clinet 发起链接请求
客户端类型
- 匿名用户(anonymous)
- 本地用户(local)     # linux ==/etc/passwd==中的用户
- 虚拟用户(Virtual)  # 
默认加载的配置文件
- vsftp.conf
- 其他名字的使用方法(要带"==.conf=="的后缀)
	- systemctl start vsftpd@<span style="color:red">anonymous</span>



| 参数                                                                | 作用                                       |
| ----------------------------------------------------------------- | ---------------------------------------- |
| Listen=\[YES \| NO]                                               | 是否已==独立运行==的方式监听服务                       |
| listen_address===IP地址==                                           | 设置要监听的IP地址                               |
| listen_port===21==                                                | 设置FTP服务的监听端口                             |
| download_enable=\[ YES \| ON]                                     | 是否允许==下载文件==                             |
| xferlog_enable=\[ YES \| ON]<br>xferlog_std_format=\[ YES \| ON ] | 启用xferlog日志<br>xferlog日志格式               |
| connect_form_port20=\[ YES \| ON]                                 | 支持主动模式(默认被动模式)                           |
| pam_service_name=vsftpd                                           | 指定==认证文件==                               |
| userlist_enable=\[ YES \| ON ]<br>userlist_deny=\[YES \| ON]      | 启用用户列表(==黑名单==)<br>YES : 黑名单<br>NO : 白名单 |
| tcp_warppers=\[ YES \| ON ]                                       | 支持tcp_warppers功能(==限流==)                 |
| dirmessage_enable=\[ YES \| ON ]                                  | 启用消息功能                                   |

配置文件/etc/vsftpd/vsftpd.conf
安全策略 <span style="background:yellow;font-size:40px">ftpd_full_access=on</span>
# 2.服务程序
匿名(==anonymous==)开放模式: ==无需密码==
本地(==local==)用户模式: ==linux本地用户==,本地用户被攻陷的话,linux也容易被攻陷
虚拟(==Virtual==)用户模式: 类似与httpd的==basic认证==

# 任务
### 一
要求
1. 本地用户登录
2. 不允许匿名用户登录
3. 指定目录
4. 限定目录
配置
```shell
anonymous_enable=NO


```
# 3.配置
> [!info] 相关的包 
> ```shell
>   dnf  vsftpd  pam    pam-level    db4    db4-level    db4-utils    db44-tcl -y
>   ```

|                                           | anonymous                                                                                                                                                                             | local                                                                                                                                                                                                                                    | Virtual                                                                  |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| 配置文件                                      | /etc/vsftpd/vsftpd.conf                                                                                                                                                               | /etc/vsftpd/vsftpd.conf                                                                                                                                                                                                                  |                                                                          |
| 配置                                        | anonymous_enable=YES<br>anon_root=/var/ftp<br><br>anon_upload_enable=NO<br>[[#selinux\|allow_ftpd_full_access]]=YES<br><br>anon_mkdir_write_enable=yes<br>anon_other_write_enable=yes | local_enabel=YES<br>write_enable=YES # 写总开关<br># 文件 644<br># 目录 755<br>local_umask=022<br># 禁止任意切换,同时启用,不然local用登录不了<br>chroot_local_user=YES<br>allow_writeable_chroot=YES<br><br># 指定目录<br>user_config_dir=/etc/vsftpd/[[#userconfig]] | guest_enable=YES<br>guest_username===ftpusr==<br>pam_service_name=vsftpd |
| 创建虚拟用户权限文件(如:/etc/vsftpd/user_conf/user1) |                                                                                                                                                                                       |                                                                                                                                                                                                                                          | local_root=/home/ftpuser/upload<br>write_enable=YES                      |
| 用户                                        | ftp & anonymous                                                                                                                                                                       | linux中==/etc/passwd==中的用户                                                                                                                                                                                                                |                                                                          |
|                                           |                                                                                                                                                                                       | ftp://verthandi@192.168.94.148                                                                                                                                                                                                           |                                                                          |


## userconfig
创建verthandi文件%%与登录的用户一致%%
	local_root=/var/ftp/verthandi
## selinux
allow_ftpd_full_access


# 虚拟用户
1. ftp认证的用户数据库文件（奇数行为账户名，偶数行为密码）
2. vsftpd服务程序用于存储文件的根目录以及用于虚拟用户映射的系统本地用户
3. 建立用于支持虚拟用户的pam文件
4. 在vsftpd服务程序的主配置文件中通过pam_service_name参数将pam认证文件名称修改为vsftpd.vu
5. 为虚拟用户设置不同的权限
