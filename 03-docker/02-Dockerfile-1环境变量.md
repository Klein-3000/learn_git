# 一、需要掌握的
## 1. `.env` 文件
项目根目录 .env 文件 + docker-compose.yml 引用
```yaml
# .env 文件（本地默认加载）
MYSQL_USER=root
MYSQL_PASSWORD=123456
```
```yaml
# docker-compose.yml
services:
  db:
    image: mysql
    environment:
      - MYSQL_USER
      - MYSQL_PASSWORD
```
## 2. `env-file` 字段
```yaml
env_file:
  - .env.prod
```
用于区分开发 / 测试 / 生产环境。
## 3. `environment` 字段
```yaml
environment:
  - MY_VAR=hello
```
environment 直接写死（简单小项目）
## **environment > env_file > .env 文件**

谁写在后面，谁优先级高！

谁更 “靠近容器”，谁优先级高！

---

# 二 、整体认识
## 1. Dockerfile 构建时，内置
```Dockerfile
ENV MY_VAR=hello
```
## 2. .env 文件
```yaml
service:
	...
	environment:
		# compose 自动填写
		- MY_VAR
```
## 3.  --env-file 参数
```shell
docker compose --env-file my.env up
```
## 4. env-file 字段
```yaml
services:
	...
	env-file:
		- service-private.env
```

![[##3. --env-file 参数]]

> [!attention] 注意
> 有==相同==的变量` service-private.env` 将覆盖 `my.env`

## 5.  environment 字段
```yaml
services:
	...
	env-file:
		- service-private.env
    environment:
	    - MY_VAR="LEVEL-5"
```
> [!attention] 注意
> 使用的`environment`设置的变量
## 6. 从 shell 中获取
```yaml
services:
	...
	environment:
		- MY_VAR=${FROM_SHELL_MY_VAR}
```
> [!attention] 注意
> `export FROM_SHELL_MY_VAR="..."` 

## 7. -e 参数
```shell
docker compose --rm -e MY_VAR="LEVEL7" <service_name>
```

