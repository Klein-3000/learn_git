```mysql
# 增
create table student (
    id int primary key auto_increment,
    name varchar(20) not null,
    age int,
    gender varchar(10)
);

# 删
## 一条一条的清空数据
delect table <table>
## 直接删除 table
drop table <table>

# 改
rename table <old_table> to <new_table>

# 查
## 查看表结构
desc student;
-- 或
describe student;
## 查看建表语句
show create table student;

```


---
# 单词
primary ： 主要的
increment ：增量
describe ：描述
