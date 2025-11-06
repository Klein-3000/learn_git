# 配置
<span style="background-color:yellow;font-size:40px">/root/.ssh</span> 或 <span style="background-color:yellow;font-size:40px">/home/${USER}/.ssh</span>
## 目录
```shell
/root/.ssh
├── authorized_keys
├── config               # 自定义文件(需要自己创建)
├── known_hosts
└── known_hosts.old
```
> [!summary] 权限问题
> .ssh 700
> 私钥 600
## 简化登录(使用指定配置--ssh & git)
配置文件 : .ssh/config
### 配置
```shell
Host <myserver>
	HostName <IP>
	User <username>
	Port <port>
	# 建议配置
    # 有添加到ssh-add时，却不指定，ssh会逐个尝试
    IdentityFile /path/to/private/key
    # 自定义knwon_hosts 文件的路径
    UserKnwonHostsFile /path/to/knownHosts
    # 只使用[指定]{**IdentityFile**指定,或**ssh-add-L**列出的},忽略[标准私钥]{~/.ssh/id_rsa,~/.ssh/id_ecdsa}
    IdentitiesOnly yes
```
### 命令
```shell
# ssh
ssh -F /path/to/config <myserver> 

# git
git -c core.sshCommand="ssh -F /path/to/config/" clone git@github.com:User/repository
## 使用环境变量GIT_SSH_COMMAND
export GIT_SSH_COMMAND="ssh -F /path/to/config/"
git clone git@github.com:User/repository

```
# ssh (secure shell)
```shell
ssh username@remote_host_ip
```
> [!note] password free login
> ssh 默认是找`~/.ssh/id_rsa`、`id_ed25519` 等默认文件
> 使用的是==非默认==的私钥（如 `id_ed25519_fedora`），==需要==**指定**它
> eg
> `ssh user@remote -i ~/.ssh/private_key`


---
# ssh-keygen
作用: **生成**、**管理**和**转换** SSH 认证密钥
## format
```shell
ssh-keygen
```
## operation
```shell
-p： passphrase：密码；口令：修改私钥密码

-t ： type

-i: import:                      ~共~

-f：File：              指定用于存储私钥的文件名

-y：show public key

-C：comment：评论 ：非必须，有默认格式，有则便于管理

-R: remove : 删除known_hosts中的"指纹"
```
> [!note] 加密类型
> rsa：基于RSA算法，默认长度为3072位。
> ecdsa：基于椭圆曲线DSA算法。
> ed25519：基于Ed25519算法，提供了较好的安全性和性能。

> [!warning] 注意事项
> ssh-keygen 默认生成的私钥和公钥名字==一直不变==.既连续两次使用默认生成,只会有一对公私钥文件,==新代旧==

## common operation
### show and extract the public key
```shell
# show public key
ssh-keygen -y -f ~/.ssh/private_key

# extract public key
ssh-keygen -y -f ~/.ssh/private_key > public_key.pub

```
### Display fingerprints
```bash
ssh-keygen -l -f <Public_key>
```
### modify the private key password phrase
```shell
# interactive 
ssh-keygen -p 

# non interactive
ssh-keygen -p -P "old_passwd" -N "new_passwd" -f  ~/.ssh/private_key

# cancel password
ssh-keygen -p -P "old_passwd" -N "" -f  ~/.ssh/private_key
```
### ssh warning
#### matter(问题,麻烦)
```bash
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
@ WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED! @ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY! 
Someone could be eavesdropping on you right now (man-in-the-middle attack)! It is also possible that a host key has just been changed. 
The fingerprint for the ED25519 key sent by the remote host is SHA256:TWKLhVUibTjHhKUEUXbcxN4dJv9ZbEwRK12szqyUdUA.
Please contact your system administrator. Add correct host key in /c/Users/Lenovo/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /c/Users/Lenovo/.ssh/known_hosts:49 Host key for github.com has changed and you have requested strict checking. Host key verification failed.
fatal: Could not read from remote repository. Please make sure you have the correct access rights and the repository exists.
```
#### solution(解决方案)
```bash
# 就是配置在config中对应的'HostName'
ssh-keygen -R <HostName>
```
> [!note] 参数解析
> -p : 修改密码
> -P : 修改现有的密码
> -N : 新的密码

---
# ssh-copy-id (id: Identity : 身份)
```shell
ssh-copy-id -i /path/to/public/key  username@remote_host
```
> [!note] 上传到哪里
> .ssh/authorzed_keys 文件中
> `-i` 参数后面跟的是你的公钥文件路径（默认是 `~/.ssh/id_rsa.pub`）
> 

# ssh-agent
## summary

| 命令                         | 含义                     |
| -------------------------- | ---------------------- |
| `eval $(ssh-agent)`        | 启动 `ssh-agent`,操作对象时私钥 |
| `ssh-add ~/.ssh/id_rsa`    | 添加私钥                   |
| `ssh-add -l`               | 列出已加载的**公钥的指纹**        |
| `ssh-add -D`               | 删除所有已加载的**私钥**         |
| `ssh-add -d ~/.ssh/id_rsa` | 删除指定已加载的**私钥**         |
| `ssh-add -L`               | 显示所有公钥                 |
## environment variable
 $SSH_AUTH_SOCK 
 $SSH_AGENT_PID

---
# scp (secure copy)
作用 : 用于脚本
## parameter
```shell
# 限制使用的带宽（以Kbit/s为单位）
-l 500   

# 保留原有属性
-p         

# 安静传输
-q         
```
## local to remote (upload)
```shell
scp /path/to/local/Resources username@remote_host:/path/to/remote/resources
```
## remote to local (Download)
```shell
scp username@remote_host:/path/to/remote/resources /path/to/local/sources
```
---
# sftp (secure file transfer protocol)
## format
```shell
sftp remote_host_ip
```
## operation
1. cd：更改远程目录
2. lcd：更改本地目录
3. ls：列出远程目录中的文件
4. lls：列出本地目录中的文件
5. get：从远程服务器下载文件到本地机器

### ==下载==到指定的本地目录

sftp> get remote_filename /local/path/

### 从本地机器==上传==文件到远程服务器。

sftp> put local_filename /remote/path/

### 分别用于==批量==下载和上传文件。(mget 和 mput)

sftp> mget \*.txt

sftp> mput \*.txt

1. exit 和 bye 退出
2. rm和rename对远程主机（remote Host）的文件的操作
3. mkdir和rmdir在远程主机（remote Host）创建和删除文件夹

rename oldFileName newFileName

linux中重命名是mv  "old"  "new"

> [!warning] 注意
> scp 和 sftp 命令涉及到目录传输时,需要使用==r==(recursion)参数
