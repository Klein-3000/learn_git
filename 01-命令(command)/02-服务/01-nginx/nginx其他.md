# 1.include配置加载
```python
http {
	...
	include /etc/nginx/conf.d/*.conf;
}
```
## 1.1conf.d目录中的配置文件
```python
server {
	# 当对应的".conf"找不到时,使用该页面
	listen   80 default_server;
}
```
# 2.nginx日志记录
## 2.1存放路径 : /var/log/nginx

### 自定义日志格式 
## 状态码
![[http & https#http的状态码]]
#### 1配置
```python
# 写在nginx.conf的http{}中
# <name>大小敏感
log_format <name> '<parameter>';

# parameter
# $remote_addr      客户端的IP地址
# $remote_use       客户端的用户名
# $time_local       本地时间 --建议用[]括起来,既[$time_local]
# $request          请求起始行
# $status           http状态码
# $bytes_sent    响应资源的大小
# $http_referer  记录资源的跳转地址
# $http_user_agent 用户的终端信息
# $gzip_ratio    gzip的压缩级别

log_format combined '$remote_addr - $remote_user [$time_local] "$request" ' #无逗号
					'$status $body_bytes_sent "$http_referer" ' 
					'"$http_user_agent"';

# JSON格式日式
log_format json '{"time": "$time_iso8601", ' 
				'"remote_addr": "$remote_addr", '
				'"remote_user": "$remote_user", ' 
				'"request": "$request", '
				'"status": $status, ' 
				'"body_bytes_sent": $body_bytes_sent, '
				'"request_time": $request_time, ' 
				'"http_referrer": "$http_referer", ' 
				'"http_user_agent": "$http_user_agent"}';
```
#### 2调用
```python
server {
	listen         80;
	server_name    www.thelema.com;
	# 格式为
	# access_log 路径 <日志格式名>
	access_log /opt/nginx/thelemalog combined;
}
```
# 3.开启basic认证
## 配置文件/etc/nginx/htpasswd(默认不存在)
### 1.配置 | 需要htpasswd命令(apache自带,nginx没有。apache2-utils、httpd-tools) 或使用 "openssl"命令
![[nginx和htpasswd和httpd命令#2.htpasswd命令]]

### 2调用
```python
# 在对应的"server"中
server {
	...
	# 提示信息,在新的浏览器中一般不展示
	# 启动
	auth_basic "这是提示信息";
	# 加载的文件
	auth_basic_user_file /etc/nginx/htpasswd;
	
}
```
# 4.SSL证书配置
```python
讲的不好
```
# 5.return跳转 | 重定向 | location中
```python
# 输入thelema.com也可以访问www.thelema.com
server {
		listen      80;
		server_name www.thelema.com;
		...
}

server {
	listen      80;
	server_name thelma.com;
	location / {
		# 作用:输入 http://www.thelema.com 时,自动转换为 https://www.thelema.com
		# $request_uri作用是,保持路劲不变,切换为"https"
		# 302为状态码,表示跳转
		return 302 https://www.thelema.com$request_uri;
	}
}
```
> [!warning] 注意
> windows的==Host==文件也需要修改,不然访问的是公网中的域名对应的网站
> 既
> ==Host==文件的内容为
> ```python
> 192.168.94.131 www.thelema.com
> 192.168.94.131 thelema.com
> ```
# 6.gzip压缩
## 6.1目的
- 节省流量
- 加快传输速度
## 6.2配置 | location中
```python
# 在"location"中
sever {
	...
	location  / {
		gzip on;                     # 开启gzip压缩
		gzip_min_length   1K;        # 最小压缩,小于该值就不压缩
		gzip_buffers      4 3K;      # 内存缓冲
		gzip_http_version 1.1;       # http版本
		gzip_com_level    9;         # 压缩等级 level : 1-9,值越大,压缩时间越长
		# 压缩的文件类型,这类型的文件才会压缩.
		# 图片本身被压缩过了,再压缩没意义
		gzip_type         text/html text/css text/xml application/javascript;
		gzip_vary on;                # http响应头添加gzip表示
		gzip_disable "MSIE [1-7]\."; # 遇到IE浏览器1-7取消gzip压缩
	}
}
```

# 7.开启目录浏览功能
## 配置
```python
# 在"server"中
server {
	...
	# 不能有".html"文件,否者展示".html"的内容
	# 注意目录的权限问题
	# 开启目录功能
	autoindex on;
	# 显示文件大小时,带单位
	autoindex_exact_size off;

	location {
		...
	}
}
```
> [!note] 字符错乱
> 出现中文字符乱码通常是由于 Nginx 没有正确设置响应头中的字符编码（即 `Content-Type` 中缺少 `charset=utf-8`）。
## 解决方案
Markdown 文件本质上是文本文件，浏览器需要知道它的编码格式才能正确显示中文内容。
```
server {
	location ~ \.md$ {
			# 禁止使用默认 MIME 映射(可选)
			# {}后面没有分号
	        types {}
	        # 当无法确定 MIME 类型时使用的默认类型 (可选)
	        default_type text/markdown;
	        # 强制添加响应头，解决中文乱码
	        add_header Content-Type "text/markdown; charset=utf-8";
	    }
	
	# 可选：为其他文本文件也设置 UTF-8 编码
	location ~ \.(txt|log|conf)$ {
	        add_header Content-Type "text/plain; charset=utf-8";
	    }
}
```
### 其他方案
```shell
server {
    listen 80;
    server_name admin.school.com;

    root /home/verthandi/practice/;
    autoindex on;

    location ~ \.md$ {
        add_header Content-Type "text/markdown; charset=utf-8";
    }

    types {
        text/markdown md;
    }
}
```

# 8.访问控制 | allow & deny | location中
## 配置
```python
server {
	...
	location / {
		...
		# 与防火墙的书写规则一样
		# 从上至下
		# 操作的对象可为"IP地址"和"网段"
		
		# 黑名单写法
		deny 192.168.94.1;
		allow 0.0.0.0/0;      #可简写为"allow all"

		# 白名单写法
		# allow 192.168.94.1;
		# deny 0.0.0.0/0;     #可简写为"deny all"
	}
}
```
> [!info] 知识拓展
> 四层禁止 : 显示无法连接
> 七层禁止 : 403Forbidden
> > [!info] 网页出现==403==的情况
> > - 七层禁止
> > - 没有首页==html==文件
> > - nginx用户==没有==读取权限
# 9.location和优先级
## 9.1配置
```python
# 目录结构
/www/songque
├── auth_dir   # 需认证后才能访问
└── songque.html

server {
	...
	location / {
		...
	}

	location /auth_dir {
		auth_basic;
		auth_basic_user_file /etc/nginx/htpasswd;
	}

	# 多个站点根目录 | 了解几个
	# 当访问a目录时,实际访问的是/www/a/index.html;
	# 注意"nginx的目录浏览"功能
	location /a {
		root /wwww
	}
}
```


## 9.2优先级
```python
# 优先级 , 从上到下, 优先级逐渐降低
=   # 针对的是"文件"，精确匹配，不支持正则
~   # 区分大小写
~*  # 不区分大小写
    # 没有符号,表示"模糊"匹配,不支持正则 location /te 可以匹配"te"开头的目录和文件


eg
# 禁止访问根目录下的"1.txt"文件
location = /1.txt {
	return 404;
}

# 不管大小写,"a"开头的目录禁止访问
#location ~* /a+ {
	return 404;
}
 
# 禁止访问".txt"文件
location ~* ^.*\.txt$ {
	return 404;
}
```