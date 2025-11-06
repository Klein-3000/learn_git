# 组合
nginx mariadb WordPress（docker）
# mariadb
```shell
CREATE DATABASE wordpress; 
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wppassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%'; 
FLUSH PRIVILEGES;
```
# docker
```shell
docker run --name wordpress -e WORDPRESS_DB_HOST=192.168.94.148:3306 \
-e WORDPRESS_DB_USER=wpuser \
-e WORDPRESS_DB_PASSWORD=wppassword \
-e WORDPRESS_DB_NAME=wordpress \
-p 8080:80 \
-v wordpress_data:/var/www/html \
-d wordpress:latest
```