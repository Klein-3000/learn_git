# ufw
## 1.基础
```shell
# 查看状态
ufw status [verbose]

# 启停
ufw [enable | disable]

# 开放端口
ufw allow 22/tcp
# 关闭端口
ufw delete allow 22/tcp

```