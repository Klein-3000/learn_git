# 命令
## 检查配置(textparm)
```
textparm
```
## 编辑认证用户(pdbedit)
```
pdbedit

# add 创建samba用户
-a user_name

# delete 删除samba用户
-x user_name

# list 列出用户列表
-L

# verbose 列出用户详细信息的列表
-Lv

```
%%

```
# 配置成功(successful)的输出
root@admin:/etc/samba# pdbedit -a share
new password:
retype new password:
Unix username:        share
NT username:
Account Flags:        [U          ]
User SID:             S-1-5-21-3001516330-430728077-9609415-1000
Primary Group SID:    S-1-5-21-3001516330-430728077-9609415-513
Full Name:
Home Directory:       \\ADMIN\share
HomeDir Drive:
Logon Script:
Profile Path:         \\ADMIN\share\profile
Domain:               ADMIN
Account desc:
Workstations:
Munged dial:
Logon time:           0
Logoff time:          三, 06 2月 2036 23:06:39 CST
Kickoff time:         三, 06 2月 2036 23:06:39 CST
Password last set:    日, 15 6月 2025 19:42:19 CST
Password can change:  日, 15 6月 2025 19:42:19 CST
Password must change: never
Last bad password   : 0
Bad password count  : 0
Logon hours         : FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
```
%%
> [! warning] 注意
> pdbedit 中的user_name 必须在/etc/passwd中存在
## 查看共享情况(smbclient)
```shell
smbclinet

# user 指定用户名
# list 列出共享清单
smbclient //IP地址/共享目录 -U user_name 

# 匿名用户登录
smbclient //IP地址 -N
```
%% 
root@admin:/etc/samba# smbclient -L 192.168.94.148
Password for \[WORKGROUP\root]:
Anonymous login successful
        Sharename       Type      Comment
        ---------       ----      -------
        database        Disk      Do not arbitrarily modify the database file
        IPC$            IPC       IPC Service (Samba 4.22.2)
SMB1 disabled -- no workgroup available
 %%

# NFS
## 查询NFS服务器的远程共享信息(showmount)
```shell
# 显示NFS服务器的共享列表
-e IP地址
eg
 showmount -e 192.168.94.148
Export list for 192.168.94.148:
/nfsfile 192.168.94.*

# 显示本机挂载的文件资源的情况NFS资源的情况
-a IP地址
eg
 showmount -a 192.168.94.148
All mount points on 192.168.94.148:
# 显示版本号
-v 
```
![[挂载#挂载(mount)#挂载nfs]]

