# 命令
## 基本用法
```shell
# 连接
mysql [-h lo@calhost] [-P 3306] -u <user> -p<password> [database]

# 外部执行 sql
## 单个 sql 语句
mysql -u <user> -p<password> -e "<sql_cmd>[;]{注意最后的**;**}"
## sql 脚本
mysql -u <user> -p<password> [-t]{table,绘制边框,默认**没有**边框直接返回结果} [<]{重定向符} sql_script.sql

# 调用外部 sql脚本
source /path/to/sql_script.sql
## windows 的情况
source D:/sql/sql_script.sql
```

> [!attention] 注意
> `-p` 指定密码时,要紧贴参数**p**
## 自动登录
### 环境变量
```
MYSQL_HOST
MYSQL_TCP_PORT
MYSQL_USER
MYSQL_PWD  # 密码
```
### 登录路径文件
```shell
#  配置
mysql_config_edior set --login-path=[client]{mysql命令默认使用这个,其他的需要指定} --host='<host>' --user='<user>' --password
# 查看
mysql_config_editor print --login-path <login-path>
# 删除
mysql_config_editor remove --login-path <login-path>

```
> [! note] 配置文件的配置(二进制文件)
> 1. Linux ： `~/.mylogin.cnf`
> 2.windows ： ` $env:appdata/mysql/.mylogin.cnf`


安全(优先级)排序：.mylogin.cnf > .env > 环境变量 > my.cnf 明文密码

---
# 配置与目录
## 配置

### my.cnf
```ini
# linux : /etc/mysql/conf.d/99-custom.cnf
# Windows : mysql 服务安装的根目录中
[mysql]
prompt \u@\h [\d] >

# 效果
root@localhost [students] > sql_cmd
```
> [!attention] 注意
> 只对 ==本机== 才生效 
### /etc/my.cnf
```ini
# 以下是 服务器 配置（mysqld 进程）
[mysqld]

# 关闭主机缓存，避免DNS解析问题
host-cache-size=0

# 【Docker必备】禁止IP反查域名，连接更快、更稳定
skip-name-resolve

# 数据存放目录
datadir=/var/lib/mysql

# 本地socket连接文件
socket=/var/run/mysqld/mysqld.sock

# 限制导入导出目录，提高安全性
secure-file-priv=/var/lib/mysql-files

# 使用 mysql 用户运行，权限最小化
user=mysql

# 进程ID文件
pid-file=/var/run/mysqld/mysqld.pid

[client]
# 客户端默认使用socket连接
socket=/var/run/mysqld/mysqld.sock

# 加载自定义配置
[!includedir]{`!`: 与**vim**中**!**的意思一致,**不是**否定的意思一个命令; `includedir`:表示加载==一个目录==中的配置} /etc/mysql/conf.d/

```
## 三个目录 / 文件的作用

### 1. `/etc/my.cnf`

**MySQL 主配置文件（总控中心）**

- 服务器核心配置（端口、数据目录、缓存、安全）
- 服务端 `[mysqld]` 和客户端 `[client]` 都在这里定义
- 所有 MySQL 启动**必须读取**
- 你不能乱删，乱删 MySQL 直接起不来

### 2. `/etc/mysql/conf.d/`

**扩展配置目录（自定义配置放这里）**

- 官方推荐：**不要改主配置，自定义放这里**
- 里面所有 `.cnf` 后缀文件会被自动加载

### 3. `/var/lib/mysql`

**MySQL 数据目录（数据库本体）**

- 所有数据库、表、数据、日志、索引都在这里
- 删这里 = 删库跑路
- Docker 挂载最重要的目录，必须持久化

