如果使用的是默认的 TDB（Trivial Database）格式，用户账户信息存储在：
<span style="background-color:yellow;font-size:30px">/var/lib/samba/private/passdb.tdb</span>
```bash
# 增
pdbedit -a <user_name>

# 删
pdbedit -x <user_name>

# 改
## 修改密码
echo "<passwd>" | pdbedit [-t]{从**标准输入**中获取密码} <user_name>

# 查
## 列出所有 Samba 用户
pdbedit -Lv
## 查看特定用户信息
pdbedit -Lv -u username 

# 转储与还原
## 转储dump
pdbedit --dump
## 还原
pdbedit --restore

```
> [!note] 注意
> user_name 是/etc/passwd中用户

