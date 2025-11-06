![[nginx和htpasswd和httpd命令#1.nginx]]
# 3.配置文件
## 3.1/etc/nginx/nginx.conf | 文件
```python
# 设为"auto"时,process数为处理器的个数
worker_processes auto;

events {
	#worker进程最多可以处理多少个进程
    worker_connections 1024;
}

http {
	# mime.types nginx可以识别的文件类型
	# nginx可以识别,browser不可以则用txt的方式打开,并且会下载下来
    include           mime.types;
    # 文件识别不了,以八进制(oc)格式,传输
    default_type      application/octet-stream;
    sendfile          on;
    keepalive_timeout 65;

    # 配置反向代理
    # upstream : 上游
    # backend ：后端 此处为域名,要与“server”中的“location”配置一致
    #upstream backend {
    # 固定访问
    # ip_hash
    # 默认是轮序weight用来添加权重
    #   server 127.0.0.1:8000 weight=3;
    #   server 127.0.0.1:8080 weight=4; 
    #}
    server {
	    #listen (默认主机的IP地址):80
        listen      80;
        server_name localhost;
        return 301 https://$server.name$request_uri;
	    
		location / {
			# 是"/usr/share/nginx/html"的缩写
			# 可修改为其他路径
			root html;
			# 指明默认页面
			# 找不到就"403 Forbidden"
			index index.html index.htm;
		}
    # 配置反向代理
    #   location /app {
    #           proxy_pass https://backend(域名);
    #       }
    }

    server {
        listen      8000;
        listen      somename:8080;
        server_name somename alias another.alias;
        localtion / {
            root  html;
            index index.html index.htm;
        }
    }
    
    include server/*;
}
```
## 3.2/usr/share/nginx/html | 目录
```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```
# http协议
1. 请求协议
	- 请求协议
	- 请求行
	- 请求头
	-  
	- 请求数据 | 请求体
2. 响应协议
	- 响应协议
	- 响应头
	-  
	- 响应数据

# 4.实验
## 4.1多端口部署多站点和4.2多IP多站点
```python
# http的{}中
# 80 /www/thelema
# 81 /www/songque
server {
	# "listen"未指定IP地址,默认是主机的IP地址
	# 多IP
	# listen 192.168.94.131:80;
	listen       80;
	server_name  www.thelema.com;
	
	location / {
		# 定义根目录
		root /www/thelema;
		# 定义主页面
		index index.html;
	}
}
server {
	# "listen"未指定IP地址,默认是主机的IP地址
	# listen 192.168.94.130:80;
	# 记得把"server_name"注释掉,
	# 因为windows把"www.thelema.com"映射为"192.168.94.131"
	listen       81;
	server_name  www.thelema.com;
	
	location / {
		# 定义根目录
		root /www/songque;
		# 定义主页面
		index index.html;
	}
}
```

## 4.3多域名多站点
```python
#http{}中
server {
	listen 80;
	server_name www.thelema.com;
	location / {
		root /www/thelema;
		index thelema.html
	}
}
server {
	listen 80;
	server_name www.songque.com;
	location / {
		root /www/songque;
		index songque.html
	}
}
```
# 5.hexo | 需安装nodejs和npm
- 安装 ：`npm install hexo-cli -g`
- 初始化 : `hexo init`
- 安装依赖 : `cd blog;npm install`
- 本地运行 : `hexo server / hexo s`
