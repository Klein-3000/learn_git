```mysql
# 增
create database <database>;
## 避免报错
create database if not exists testdb;

# 删
drop database <database>;

# 改
<none>

# 查
show databases;

```
## 重命名数据库的方案
```shell
mysqldump -u root -p 旧库 > backup.sql
mysql -u root -p -e "CREATE DATABASE 新库"
mysql -u root -p 新库 < backup.sql
```
> [!attention] 注意
> 1. ==不能==直接重命名数据库
> 2. 只能通过新建数据库,然后迁移,实现重命名的效果
