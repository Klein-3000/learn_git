# task
- 电子邮件系统
- 部署基础的电子邮件系统
- 设置用户别名信箱
- linux邮件客户端
# 基础知识
[[mail | SMTP 和 POP3]]
# MUA & MDA & MTA
- 邮件用户代理 (mail user agent ==MUA==) : 为用户**收发**邮件的==服务器==(客户端软件)
- 邮件投递代理 (mail delivery agent ==MDA==): 把来自MTA的有邮件==保存==到本地的收件箱中
- 邮件传输代理 (mail transfer agent ==MTA==) : ==转发==处理**不同**电子邮件**服务供应商**之间的邮件，把来自于 MUA 的邮件转发到合适的 MTA 服务器。例如，我们从新浪信箱向谷歌信箱发送一封电子邮件，这封电子邮件的传输过程如图
![[mail.png]]
> [!warning] 注意
> 1. **添加反垃圾与反病毒模块**:它能够很有效地阻止垃圾邮件或病毒邮件对企业信箱的干扰
> 2. **对邮件加密**:可有效保护邮件内容不被黑客盗取和篡改
> 3. **添加邮件监控审核模块**:可有效地监控企业全体员工的邮件中是否有敏感词，是否有透露企业资料等违规行为。
> 4. **保障稳定性**:电子邮件系统的稳定性至关重要，运维人员应做到保证电子邮件系统的稳定运行，并及时做好防范分布式拒绝服务(DistributedDenialofServicc，DDoS)攻击的准备。

---
# 部署基础的电子邮件系统
## steps
1. 配置服务器主机名,需要保证服务器==主机名==与==发信域名==保持一致(/etc/hostname 或 使用 [[hostname(ctl)和fc-cache和language(语言)]]命令)
2. 防火墙问题
3. 重新学习named  bind-chroot
---
# 配置Postfix服务程序
软件包 : postfix
配置文件 <span style="background-color:yellow;font-size:40px">/etc/postfix/main.cf</span>
## 参数

| 参数                                                                         | 作用                               |
| -------------------------------------------------------------------------- | -------------------------------- |
| myhostname = mail.fedora.com                                               | 邮局系统的主机名                         |
| mydomain = fedora.com                                                      | 邮局系统的域名                          |
| myorigin = \$mydomain                                                      | 从本机发出的邮件的域名名称(邮箱后缀,如@==qq.com==) |
| inet_interfaces = all                                                      | **监听**的网卡接口,postfix默认只监听==本地主机== |
| mydestination = \$myhostname, localhost.\$mydomain, localhost , \$mydomain | ==谁==可以**接收**邮件的主机名              |
| mynetworks = 192.168.94.0/24 或 0.0.0.0/0                                   | 设置可**转发**哪些==主机==的邮件             |
| relay_domains = \$mydestination                                            | 设置可**转发**哪些==网络==的邮件             |
| inter_protocol = ipv4                                                      |                                  |
| alias_maps = hash:/etc/aliases                                             | 设定邮件别名的路径                        |

postmap hash:/etc/postfix/access
postalias hash:/etc/alias
## 配置
```shell
myhostname = mail.fedora.com
mydomain = fedora.com
mydomain = $mydomain
inet_interfaces = all
mydestination = $myhostname, $mydomain
```
$x_{1,2}=\frac {-b\pm \sqrt {b^2-4ac}}{2a}$

---
# 配置dovecot服务程序
软件包 dovecot
配置文件<span style="background-color:yellow;font-size:40px">/etc/dovecot/dovecot.conf</span>
doveconf 命令检查配置
## 配置
有点问题
```shell
protocols = imap pop3 lmtp
# 禁止明文认证
disable_planintext_auth = no
# 登录受信任网络
login_trusted_networks = 192.168.94.0/24
# 配置邮件格式与存储路径
mail_location = mbox:~/mail:INBOX=/var/mail%u
```
可以正常启动
```shell
protocols = imap pop3 lmtp
listen = *, ::
disable_plaintext_auth = no
mail_location = maildir:~/Maildir
auth_mechanisms = plain login
login_trusted_networks = 192.168.94.0/24
dict {
}
!include conf.d/*.conf
!include_try local.conf
```
---
# 客户使用电子邮件系统
[[mail和mutt命令]]

---
# 设置用户别名信箱
配置文件<span style="background-color:yellow;font-size:40px">/etc/aliases</span>
## 配置
```
# dream@fedora.com 就是 sender@fedora.com
dream:   sender

# 使用newaliases让新用户别名立即生效

```
---
# linux邮件客户端
软件包thunderbird(图形化界面)
