```
.env
compose.yaml
```
```ini
# .env
MYSQL_ROOT_PASSWORD=123456
MYSQL_DATABASE=Administrator
MYSQL_USER=iuno
MYSQL_PASSWORD=iuno
```

```yaml
# compose.yaml
services:
	mysql:
		image: mysql:5.7
		ports:
			- 3306:3306
	    environment:
		    # 必写的环境变量
		    - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
		    # 非必要环境变量
		    ## 创建数据库
		    - MYSQL_DATABASE=${MYSQL_DATABASE}
		    ## 创建普通用户
		    - MYSQL_USER=${MYSQL_USER}
		    ## 设置普通用户密码
		    - MYSQL_PASSWORD=${MYSQL_PASSWORD}
		volumes:
			- ./data:/var/lib/mysql[:z]{selinux 的限制}
			- ./config:/etc/mysql/conf.d:z
```