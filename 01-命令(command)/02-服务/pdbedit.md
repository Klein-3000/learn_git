如果使用的是默认的 TDB（Trivial Database）格式，用户账户信息存储在：
/var/lib/samba/private/passdb.tdb
```bash
# 增
pdbedit -a <user_name>

# 删
pdbedit -d <user_name>


# 列出所有 Samba 用户
pdbedit -L -v

# 查看特定用户信息
pdbedit -L -u username -v
```
> [!note] 注意
> user_name 是/etc/passwd中用户

