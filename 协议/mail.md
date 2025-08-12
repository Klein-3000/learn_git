# 发(25/tcp)
SMTP : simple mail transfer Protocol:简单邮件传输协议
SMTP客户端发送操作命令,SMTP服务返回状态码
只能传输**7**比特==ascll==码文本数据

MIME(multipurpose Internet mail extensions : 多用途因特网邮件拓张 )
## SMTP的链接过程
1. 来者谁(HELO 250)
2. 从哪里来(MAIL FROM 250)
3. 到哪里去(RCPT TO 250)
4. 有何求(DATA ==354==)
5. 传输内容
6. 传输完成(. 250)
7. 告辞(QUIT   ==221==)
![[smtp.png]]
## email结构
由RFC 822定义,已更新为RFC 5322
1. 信封
2. 内容
	1. 首部
	2. 主体

---
# 收(110/tcp)
POP3 ; post Office Protocol-version 3 : 邮局协议3
作用:
	将存储在邮件服务器上邮件离线下载到本地
操作命令
![[pop3.png]]
pop3服务器返回信息
- +OK 正响应
- -ERR 负响应
pop3的3个状态
- 确认状态(login)
- 操作状态(mail Download)
- 更新状态(logout)

> [!note] 共同点
> # SMTP和pop3的4个阶段
> 1. 建立连接
> 2. 身份认证
> 3. 邮件传输
> 4. 断开连接

---
# 收(143/tcp)
 IMAP4(Intemnet Message Access Protocol4 : 因特网邮件分文协议):用于在==本地主机==上访问邮件，占用服务器的TCP/143端口。

> [!note] IMAP4 与 pop3 的区别
> # pop3
> 1. **下载并删除** 或 **下载并保留** 邮件服务器中邮件
> 2. **不允许**用户在邮件服务器上管理自己的邮件
> # IMAP
> 在本地pc上操控邮件服务器中邮箱

---
# 基于万维网的电子邮件
1. 通过==浏览器==(browser)邮件服务器万维网网站,就可以撰写,收发,阅读和管理电子邮件
2. 用户浏览器与邮件服务器之间使用==http==协议
3. 邮件服务器之间使用==SMTP==协议