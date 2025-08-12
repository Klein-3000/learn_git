# 1.nginx相关的目录

| 目录                                            | 详情      |
| --------------------------------------------- | ------- |
| /etc/nginx<br>- nginx.conf<br>d conf.d        | 主配置目录   |
| /usr/sharce/nginx                             | 默认文档根目录 |
| /var/log/nginx<br>- access.log<br>- error.log | 日志目录    |
# 2.nginx 常见变量
## 相关内容
[[nginx其他#1配置| nginx 日志记录]]
## 重点
1. host             //http请求头的http域名
2. referer          //从哪个URI跳转过来
3. user_agent     //用户浏览器的信息
4. remote_addr  //客户端的IP
5. status          //http的状态码

| 变量名                                                    | 描述                                                                                                                                                                                                                                                                                                                                      |
| ------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`$args`**                                            | 请求行中的参数（GET请求参数）。<br>www.123.com/1.php?a=1&b=2<br>`$args['a']`就是"1"                                                                                                                                                                                                                                                                     |
| `$query_string`                                        | 同`$args`。                                                                                                                                                                                                                                                                                                                               |
| `$is_args`                                             | 如果请求中有参数，这个变量的值为"?"，否则为空字符串。                                                                                                                                                                                                                                                                                                            |
| `$request_uri`                                         | 完整的原始请求URI（含参数）。                                                                                                                                                                                                                                                                                                                        |
| `$uri`                                                 | 当前请求的规范化URI。                                                                                                                                                                                                                                                                                                                            |
| `$document_uri`                                        | 同`$uri`。                                                                                                                                                                                                                                                                                                                                |
| `$host`                                                | 请求中的主机名，若无则为客户端请求的IP。                                                                                                                                                                                                                                                                                                                   |
| `$http_host`                                           | 来自请求行的"Host"头字段的内容。                                                                                                                                                                                                                                                                                                                     |
| `$server_name`                                         | 在匹配的server块中定义的服务器名称。                                                                                                                                                                                                                                                                                                                   |
| **`$remote_addr`**                                     | 客户端地址。                                                                                                                                                                                                                                                                                                                                  |
| **`$remote_user`**                                     | 使用==**auth_basic**==模块时的用户名。                                                                                                                                                                                                                                                                                                            |
| `$request_filename`                                    | 当前请求文件的物理路径。                                                                                                                                                                                                                                                                                                                            |
| **`$request_method`**                                  | 请求方法（如GET, POST）。                                                                                                                                                                                                                                                                                                                       |
| `$server_protocol`                                     | 请求协议（如HTTP/1.1, HTTP/2.0）。                                                                                                                                                                                                                                                                                                              |
| **`$scheme`**                                          | 所用协议，http 或 https。                                                                                                                                                                                                                                                                                                                      |
| **`$status`**                                          | 响应状态码。                                                                                                                                                                                                                                                                                                                                  |
| `$upstream_status`                                     | 上游服务器响应的状态码。                                                                                                                                                                                                                                                                                                                            |
| `$body_bytes_sent`                                     | 发送给客户端的字节数，不包括响应头。                                                                                                                                                                                                                                                                                                                      |
| **`$bytes_sent`**                                      | 发送到客户端的总字节数。                                                                                                                                                                                                                                                                                                                            |
| `$connection`                                          | 连接序列号。                                                                                                                                                                                                                                                                                                                                  |
| `$connection_requests`                                 | 当前连接的请求数。                                                                                                                                                                                                                                                                                                                               |
| **`$msec`**                                            | 日志写入时间的时间戳，带有毫秒。                                                                                                                                                                                                                                                                                                                        |
| `$time_iso8601`                                        | ISO 8601格式的本地时间。                                                                                                                                                                                                                                                                                                                        |
| **`$time_local`**                                      | 标准日志格式的本地时间。                                                                                                                                                                                                                                                                                                                            |
| **`content-type`**<br>- text/javascript<br>- image/png | HTTP响应信息里的"content-type",文本文件在浏览器上可以直接==预览==.                                                                                                                                                                                                                                                                                           |
| **`content-lenght`**                                   |                                                                                                                                                                                                                                                                                                                                         |
| **`http_user_agent`**                                  | 客户端的的详细信息,(既==浏览器==标识)。可用`curl -A` 指定<br>eg<br>`curl -A 'browser1' www.thelema.com`<br>没指定标识时,为curl+版本<br><br>Result<br>```java<br>192.168.94.1 - admini [19/May/2025:11:41:03 +0800] "GET / HTTP/1.1" 200 403 "-" "curl/8.12.1"<br>192.168.94.1 - admini [19/May/2025:11:41:59 +0800] "GET / HTTP/1.1" 200 403 "-" "'browser1'"<br>``` |
# 3.URI和URL以及URN
## 3.1关系 | URI可细分为URL和URN
URI%%统一资源==标识==符%%
- URL%%统一资源==定位==符%%：通过描述资源的==位置==来标识资源。
- URN%%统一资源==名称==%%：通过提供资源的唯一==名称==来标识资源，不依赖于资源的位置
## 3.2区别
URI的主要目的是标识资源，而URL的目的不仅是标识资源，还要提供访问资源的方法。
%%人话：URL是URI的一种类型，它不仅说明了“==你是谁==”，还说明了“==你在哪里==”以及如何访问到你。%%
# 4.根据语言匹配不同语言的特点
## 4.1nginx中英文自动匹配
```python
server {
	listen       80;
	server_name  www.thelema.com;
	index        index.html;
	charset      utf-8;
	location / {
		if ($http_accept_language ~* ^en) {
		# 如果accept_language的值以"en"开头,(既英文)name返回英文站点目录,否则返回中文
		# 有时会根据IP地址来返回不同的目录
			root /www/html/lang/en;
		}
			root /www/html/lang/cn;
	}
}
```