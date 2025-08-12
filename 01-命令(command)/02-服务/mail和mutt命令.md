# mail
软件包mailx
## 基本用法
```shell
echo "邮件正文" | mail -s "邮件主题(就是邮件名)" recipient@example.com

cat mail.txt | mail -s "邮件主题(就是邮件名)" recipient@example.com
```
##  查看当前用户的本地邮件（收件箱）
相关目录 <span style="background-color:yellow;font-size:40px">/var/spool/mail/</span>
默认为所用普通用户创建邮箱
```shell
mail
```
退出方式：
- 输入 `q` 可以退出并保存邮件
- 输入 `d` 删除邮件
- 输入 `?` 查看帮助
## 配置 `/etc/mail.rc`（可选）
编辑 `/etc/mail.rc` 文件来设置默认的 SMTP 邮件服务器(适用于==外发邮件==)
```shell
set smtp=smtp://192.168.94.148:587
set smtp-auth=login 
set smtp-auth-user=sender 
set smtp-auth-password=your_password 
set from="sender@fedora.com"
```

>[!warning] 清空邮件队列(邮箱)
>`> /var/mail/用户名`


---
# mutt
## 发送带附件的邮件
```shell
echo "这是邮件正文" | mutt -s "带附件的邮件" -a /path/to/file.txt \
-- recipient@example.com
```
