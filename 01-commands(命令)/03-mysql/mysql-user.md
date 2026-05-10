# 创建
```mysql
-- 1. 创建用户（指定 用户名 + 主机 + 密码）
CREATE USER '用户名'@'主机限制' IDENTIFIED BY '密码';

-- 2. 授权（允许操作哪些库/表）
GRANT 权限 ON 库名.表名 TO '用户名'@'主机限制';

-- 3. 刷新权限（让配置立即生效）
FLUSH PRIVILEGES;

-- 4. 验证
SELECT user,host FROM mysql.user;

-- 5. 查看有哪些权限
show grants for '用户名'@'主机限制'
```
## example
```mysql
# 创建用户
create user 'klein'@'%' identified by 'klein';
# 授权
grant ALL on [administrator]{数据库}.[users]{数据表} to 'klein'@'%';
# 刷新
flush privileges;
# 验证
select user,host from mysql.user;
# 查看
show grants for 'klein'@'%'; 
```
## 权限
### 1. 数据操作权限（最常用）
| 权限         | 作用      |
| ---------- | ------- |
| **SELECT** | 查询数据（读） |
| **INSERT** | 插入数据    |
| **UPDATE** | 修改数据    |
| **DELETE** | 删除数据    |
### 2. 结构管理权限
|权限|作用|
|---|---|
|**CREATE**|创建库、表|
|**DROP**|删除库、表|
|**ALTER**|修改表结构|
|**INDEX**|创建 / 删除索引|
|**VIEW**|创建视图|
### 3. 管理权限（高危）
|权限|作用|
|---|---|
|**CREATE USER**|创建用户|
|**GRANT OPTION**|允许把自己的权限再授权给别人|
|**SHUTDOWN**|关闭 MySQL 服务|
三种范围：

1. `*.*` → 全局所有库、所有表
2. `库名.*` → 某个库下所有表
3. `库名.表名` → 某张表

---
# 修改与撤销与删除
## 重命名
```mysql
rename user 'klein'@'%' to 'KLEIN'@'local';
```
## 修改密码
```mysql
alter user 'KLEIN'@'%' identified by 'new_passwd';
# 改自己的密码
alter user user() identified by 'new_passwd';
```
## 修改权限
### 1. 追加授权（叠加权限）
原来有查询，再给插入、修改：
```mysql
GRANT INSERT,UPDATE ON students.* TO 'klein'@'%';
```
### 2. 覆盖成全权限
```mysql
GRANT ALL ON students.* TO 'klein'@'%';
```
### 3. 授权后必须刷新（部分版本需要）
```mysql
flush privileges;
```
## 撤销权限
### 回收指定权限
```mysql
REVOKE DELETE,ALTER ON students.* FROM 'klein'@'%';
```
### 回收该库所有权限
```mysql
REVOKE ALL ON students.* FROM 'klein'@'%';
```

## 删除用户
```mysql
drop user 'klein'@'localhost', 'klein'@'192.168.183.131';
```
> [!attention] 注意
> 1. mysql 一个完整的账户格式 `'<user>'@'<host>'`
> 2. `'<klen>'@'<localhost>` 和 `'<klein>'@'%'` 是不同账户


---
# 单词
identified : 确认
grant : 授予
flush :冲刷
privileges : 特权
invoke ：调用
revoke ：撤销
alter : 改动