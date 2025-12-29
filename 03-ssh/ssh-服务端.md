# ssh的config配置
![[ssh-客户端#配置#简化登录(使用指定配置--ssh & git)]]

# 相关命令
## 认证相关
1. [[ssh-客户端#ssh (secure shell)| ssh命令]]
2. [[ssh-客户端#ssh-keygen| ssh-keygen 命令]]
3. [[ssh-客户端#ssh-copy-id (id Identity 身份)| ssh-copy-id 命令]]
4. [[ssh-客户端#ssh-agent| ssh-agent 命令]]
## 文件传输
1. [[ssh-客户端#scp (secure copy)| scp 命令]]
2. [[ssh-客户端#sftp (secure file transfer protocol)| sftp 命令]]

[你好]{这是提示信息}

---

# 配置
linux
<span style="background-color:yellow;font-size:40px">/etc/ssh/sshd_config</span>
windows
<span style="background-color:yellow;font-size:40px">C:\ProgrameData\ssh\sshd_config</span>
安装 OpenSSH Server
```powershell
Add-WindowsCapability -Oneline -name OpenSSH.Server~~~0.0.1.0
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

| 字段                                         | 含义           |
| ------------------------------------------ | ------------ |
| Port 22                                    | 定义端口         |
| PermitRootLogin yes                        | 是否允许root远程登录 |
| PublicAuthentication yes                   | 是否允许公钥登录     |
| AuthorizedKeysFlie ./ssh/authenorized_keys | 公钥存放文件       |
| PasswordAuthentication yes                 | 是否允许使用密码     |
