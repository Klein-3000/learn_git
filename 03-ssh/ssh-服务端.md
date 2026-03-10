# 一、服务端配置
linux
<span style="background-color:yellow;font-size:40px">/etc/ssh/sshd_config</span>
windows
<span style="background-color:yellow;font-size:40px">C:\ProgrameData\ssh\sshd_config</span>
安装 OpenSSH Server
```powershell
Add-WindowsCapability -Online -name OpenSSH.Server~~~0.0.1.0
```
防火墙
```powershell
New-NetFirewallRule -Name "OpenSSH-Server-IN-TCP-22" `
    -DisplayName "OpenSSH Server (sshd) on TCP/23" `
    -Direction Inbound `
    -Protocol TCP `
    -LocalProt 23 `
    -Action Allow `
    -Profile Domain,Private,Public
```

## parameter

| 字段                                                          | 含义           |
| ----------------------------------------------------------- | ------------ |
| Port 22                                                     | 定义端口         |
| PermitRootLogin yes                                         | 是否允许root远程登录 |
| PublicAuthentication yes \| [prohibit-password]{允许登录,但禁止密码} | 是否允许公钥登录     |
| AuthorizedKeysFlie ./ssh/authenorized_keys                  | 公钥存放文件       |
| PasswordAuthentication yes                                  | 是否允许使用密码     |
## 配置
```shell
# Port 22
# AddressFamily any
# ListenAddress 0.0.0.0
# ListenAddress ::

# [root用户登录]{测试结果**不符**}
# yes : 没有认证的限制
# no : 不允许登录
#PermitRootLogin [prohibit-password]{允许登录,但禁止密码}

# 公钥登录
# PubkeyAuthentication yes

AuthorizedKey[s]{有一个**s**}File      .ssh/authorized_keys

Subsystem       sftp    sftp-server.exe

# 见下文详解
Match [Group]{匹配**组**} administrators
       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
       
Match [User]{匹配**用户**} UserName
		# 禁止密码登录
		PasswordAuthentication no
		# 公钥登录(默认)
		# PubkeyAuthentication yes 
		# 指定[认证文件]{注意**权限**}的位置与名字
		# AuthorizedKeysFile /path/to/authorized_file
 
```
### windows的配置

```shell
# C:\ProgramData\ssh\sshd_config
# 最后的内容
Match Group administrator[s]{有一个**s**}
       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrator[s]{有一个**s**}_authorized_keys
 
```

| 项目     | 说明                                                              |
| ------ | --------------------------------------------------------------- |
| 作用     | 为 administrator**s** **组**指定统一、安全的公钥文件                          |
| 路径     | `C:\ProgramData\ssh\administrator[s]{有一个**s**}_authorized_keys` |
| 默认启用原因 | 提升安全性、防止密钥文件被篡改、便于集中管理                                          |
| 是否建议修改 | 除非有特殊需求且能保证用户目录安全，否则建议保留                                        |
> [!note] 笔记
> 为`administrators`组的 windows 账户,**不再**使用`~/.ssh/authorized_keys`文件,**而是**使用`C:\ProgramData\ssh\administrators_authorized_keys`文件
### 在linux中实现类似效果
```shell
# 对 sudo 组用户，使用统一的 authorized_keys
Match Group sudo
    AuthorizedKey[s]{有一个**s**}File /etc/ssh/sudo_authorized_keys

# 或者对 wheel 组（RHEL/CentOS 常用）
Match Group wheel
    AuthorizedKeysFile /etc/ssh/admin_authorized_keys
 
```
 > [!attention] 注意
> 1.  注意：`Match` 块必须放在 `sshd_config` **文件末尾**（因为它是条件块，之后的全局配置可能被覆盖）
> 2. `ssh-copy-id` 对于 linux --> windows 的情况, 不起效果
# 二、客户端配置(ssh的config配置)
![[ssh-客户端#配置#简化登录(使用指定配置--ssh & git)]]

# 三、相关命令
## 认证相关
1. [[ssh-客户端#ssh (secure shell)| ssh命令]]
2. [[ssh-客户端#ssh-keygen| ssh-keygen 命令]]
3. [[ssh-客户端#ssh-copy-id (id Identity 身份)| ssh-copy-id 命令]]
4. [[ssh-客户端#ssh-agent| ssh-agent 服务和 ssh-add 命令]]
## 文件传输
1. [[ssh-客户端#scp (secure copy)| scp 命令]]
2. [[ssh-客户端#sftp (secure file transfer protocol)| sftp 命令]]
3. [[rsync]]


