# 1.nginx
## 1.1启动
```bash
nginx

```
## 1.2参数

`nginx -s `<[[#parameter]]>

## 1.2.1parameter
- **nginx** :启动
- quit :优雅停止
- stop :立即停止
- reload :重载配置文件
- reopen :重新打开日志文件
## 1.2.2检查nginx配置文件的配置
```
nginx -t
```

# 2.htpasswd命令
(用户 不定必须在/etc/passwd中)
```shell
# 创建或覆盖 htpasswd文件
htpasswd -c <PATH> <UserName>

# 添加
htpasswd <PATH> <userName>

# 删除
htpasswd -D <PATH> <UserName>

# 批量创建
htpasswd -b <PATH> <UserName> <password>

```

# 3.httpd命令
```shell
httpd 

# -k 对应的参数
start   # 启动
stop    # 停止

graceful    # 优雅启动
graceful-stop    # 优雅停止

```
> [!info] 区别
> 无"graceful"
> stop 直接停止,无处理完的也停止
> 
> 有"graceful"
> stop 拒绝新的请求,处理未处理完的