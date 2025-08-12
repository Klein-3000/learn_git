# 1.相关命令
![[nginx和htpasswd和httpd命令#3.httpd命令]]

# 2.重要参数 | 指令

## 2.参数 | 指令

| 参数 \| 指令                                                                            | 意思                                                                                                                                                                   |
| ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ==**ServiceRoot**== "/etc/http"                                                     | 指明apache服务配置文件的==根目录==(方便其他配置==简写==)                                                                                                                                 |
| **==DocumentRoot==** "/www/html"                                                    | 网页的根目录                                                                                                                                                               |
| ==**ServerName **== www.example.com                                                 | 域名                                                                                                                                                                   |
| ==**IndexRoot**== index.html                                                        | 指定首页                                                                                                                                                                 |
| # Listen 192.168.94.146:80 \[protocol\]<br>==**Listen**== 80<br>==**Listen**== 8080 | 监听端口                                                                                                                                                                 |
| ==**Include**== conf.modules/*conf<br>和<br>==**IncludeOptional**== conf.d/*conf     | 导入配置文件                                                                                                                                                               |
| ==**User**== apache<br>==**Group**== apache                                         | httpd服务启动时的==账号==和==组==                                                                                                                                              |
| ==**ServerAdmin**== root@localhost                                                  | 服务运行时的管理员邮箱地址                                                                                                                                                        |
| ==**ErrorLog**== "/logs/error_log"                                                  | 错误日志存放的位置                                                                                                                                                            |
| ==**ErrorLevel**== warn<br><br>==**LogLevel**== warn                                | 错误级别 & 日志级别  <br>- <span style="color:red">error 错误</span><br>- <span style="color:red">warn 警告</span><br>- notice 请注意(==正常==但重要的情况)<br>- info 基本信息<br>- debug 调试级信息 |
| ==**LogFormat**== "格式" 名字<br><br># 调用<br>CustomLog "logs/access_log" 名字             | 日志格式<br><br>[[apache 目录;标识(变量)#2.标识(变量)\| 相关内容(标识)]]<br><br>[[http & https#http的状态码\| 状态码]]                                                                                 |
| ==**UseDir**== \[ disable \| name ]<br>name 默认为"==public_html=="                    | 网站==数据==在用户==家目录==中保存数据的目录==名称==                                                                                                                                     |
## 2.2 标签
==**\<Directory>**==
- Options ==访问时展示形式==
      Options Indexes  :没有首页,就展示目录结构
	  Options FollowSymlinks :默认设施,允许访问符号链接
      Options None : 关闭
- AllowOverride ==`.htaccess`文件中允许指令类型==
	- AllowOverride All : 全部指令
	- AllowOverride None :  默认值不允许
	- AllowOverride directive-type \[directive-type] : 具体指令类型
- Require  ==权限访问设置==
	- Require all  granted  : 无条件允许访问
	- Require all denied    : 无条件拒绝访问
	- Require ip <span style="color green">192.168.94.1</spam> : 指定ip地址范围的客户端可以访问

# 3."xml" | /etc/httpd/conf/httpd.conf中配置

| xml  \[to be continued]                                                                                                                                                                                                                                                                       | 意思                                                           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| \<Ifmodule alias_module\><br>     # ==外部重定向==(外部路径)<br>     Redirect \[permanent] /webpath  http://www.example.com/bar<br><br>	 # ==将uri映射到文件系统的其他位置== (内部路径)<br>	 Alis      /webpath  /full/filesystem/path<br><br>	 # 脚本映射<br>	 ScriptsAlias /cgi-bin/ "/var/www/cgi-bin/"<br>\</Ifmodule\> | 文档映射功能                                                       |
| 外部重定向                                                                                                                                                                                                                                                                                         | 输入==ServerIP/webpaht==<br>访问的是==http://www.example.com/bar== |
| 内部路径<br>\<Directory "/full/filesystem/path"><br>    AllowOverride None<br>	# 以目录结构展示<br>	Optional Indexes \[ \| None]<br>	# 允许访问<br>	Require All granted<br>\<Directory>                                                                                                                      | 注意<br>     权限问题<br>	 index.html                              |

# 4.虚拟主机 | 无";"结尾
## 基本步骤
1. 编辑"hosts"文件
2. 创建网站目录
3. 编辑配置文件"/etc/httpd/conf.d/XX.conf

## 4.1 多域名
```xml
# domain example1.com
<VirtualHost *:80>
	ServerName     example1.com
	DocumentRoot   "/www/html"
	
	<Directory "/www/html">
		AllowOverride All
		Require All granted
	</Directory>
</VirtualHost>

# domain example2.com
<VirtualHost *:80>
	ServerName     example2.com
	DocumentRoot   "/www/html"
	
	<Directory "/www/html">
		AllowOverride All
		Require All granted
	</Directory>
</VirtualHost>
```
## <del>4.2多端口(同个或多个) | 不常用</del>
```xml
# port 80
<VirtualHost *:80>
	DocumentRoot "/www/html/80"
	ServerName example.com
	
	<Directory "/www/html/80">
		AllowOverride All
		Require All granted
	</Directory>
</VirtualHost>

# port 8080
# 可以直接写在"XX.conf"文件中
Listen 8080
<VirtualHost *:8080>
	DocumentRoot "/www/html/8080"
	ServerName example.com
	
	<Directory "/www/html/80">
		AllowOverride All
		Require All granted
	</Directory>
</VirtualHost>
```
## 4.3 多ip(多域名)
```xml
# ip 192.168.94.5
<VirtualHost 192.168.94.5:80>
	ServerName     example1.com
	DocumentRoot   "/www/html"
	
	<Directory "/www/html">
		AllowOverride All
		Require All granted
	</Directory>
</VirtualHost>

# ip address 192.168.94.6
<VirtualHost 192.168.94.6:80>
	ServerName     example2.com
	DocumentRoot   "/www/html"
	
	<Directory "/www/html">
		AllowOverride All
		Require All granted
	</Directory>
</VirtualHost>
```

> [!info] 提示
> 写在/etc/httpd/conf.d目录书写配置(".conf"结尾),模块化配置
> > [!info] ".conf"的原因
> > /etc/httpd/conf/httpd.conf
> > ```shell
> > # 由这行决定
> > IndexOptional /etc/httpd/conf.d/*.conf
> > ```
# 5.rewrite
## 5.1 三个核心
1. RewriteEngine
2. RewriteCond (Conduit : 管道)
3. RewriteRule
## 5.2 RewriteEngine
Rewrite功能的总开关
```xml
RewriteEngine on
```
## 5.3 RewriteCond
定义规则条件,当请求满足RewriteCond的配置的条件式,执行RewriteCond后面的RewriteRule的语句
```xml
RewriteEngine on
RewriteCond %{HTTP_USER_AGENT} ^Mozilla//5/.0.*
RewriteRule index      index.html

# 常见配置
RewriteCond %{HTTP_REFERER}  (www.text.com)
RewriteCond %{HTTP_USER_AGENT} ^Mozilla//5/.0.*
RewriteCond %{REQUEST_FILENAME} 1-9
```
> [!info] 变量解析
> # 变量
> HTTP_REFERER 访问者从哪来
> REQUEST_FILENAME 匹配当前访问的文件
> - `-d` 目录 `!-d` 不是目录
> - `-f` 文件 `!-f`不是文件
> - `$1` 第一个参数
> # eg
> ```xml
> RewriteCond %{REQUEST_FILENAME} !-f
> RewriteCond %{REQUEST_FILENAME} !-d
> ```
## 5.4RewriteRule
### 5.4.1格式
```xml
RewriteRule Pattern Susbtitution [Flags]

# Pattern 模式
# substitution 替换
# flags 参数限制
- nc : nocase 忽略大小写
- R  : Redirect 强制重定向
- L  : last 结尾规则,已经匹配到了,就立即停止
```
### 5.4.2案例
```xml
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
# "\d" 正则中表示数字
RewriteRule ^news/aports/(\d+)\.html web/index\.php?c=news
```
# 6.防盗链 \[to be continued]
## 6.1目的
1. 防止别人调用我们服务器中的图片,文件,视频资源
2. 减少服务压力
## 6.2盗链主机网页配置
```xml
<h1>盗链主机</h1>
<img src="http://172.16.247.247/Pictures.png"/>
```
## 6.3防盗链配置
```xml
<Directory>
RewriteEngine on
# 添加白名单
RewriteCond %{HTTP_REFERER} !^http://172.16.2474.247/.*$ [NC]
# 盗用时,返回"link.png"图片给他
RewriteRule .*\.(gif|jpg|swf)$ http://172.16.247.247/other/link.png
</Directory>
```
> [!info] 其他方法
> SetEnvIFNoCase

# 7.域名跳转 | (==ServerAlias==)
## 7.1案例 | 京东域名的变迁
old : www.360buy.com 将其跳转为new domain name
new : www.jd.com
## 7.2 域名跳转实现
步骤
	1.编辑"==Host=="文件
### 7.2.1 单个域名跳转
```xml
# old www.example.com
# new www.linux.com
<VirtualHost 192.168.94.147:80>
	ServerName www.linux.com
	ServerAlias www.example.com
	DocumentRoot /www/linux
	
	<Directory "/www/linux">
			AllowOverride All
			Require All  granted
	</Directory>
	  
	RewriteEngine on
	RewriteCond %{HTTP_HOST} ^www.example.com$
	RewriteRule ^/(.*)$ http://www.linux.com/$1 [R=301,L]
<VirtualHost>
```
### 7.2.2多域名跳转
```xml
# old www.example.com www.elinux.com
# new www.linux.com
<VirtualHost 192.168.94.147:80>
	ServerName www.linux.com
	ServerAlias www.example.com
	serverAlias www.elinux.com
	DocumentRoot /www/linux
	
	<Directory "/www/linux">
			AllowOverride All
			Require All  granted
	</Directory>
	  
	RewriteEngine on
	RewriteCond %{HTTP_HOST} ^www.example.com$ [OR]
	RewriteCond %{HTTP_HOST} www.elinux.com$
	RewriteRule ^/(.*)$ http://www.linux.com/$1 [R=301,L]
<VirtualHost>
```
# 8.日志切割
## 8.1切割原因
单个日志会变得非常大,不便于日志的管理和分析
## 8.2分割方式
### 8.2.1rotatelogs, apache自动的工具(==在httpd.conf中==)
```xml
# 注释掉原有的log配置
ErrorLogs "/logs/error_log"
CustomLog "logs/access_log" combined

# 添加下面的配置
# 86400秒,一天的时间,既每天生成配置
Error_Log "|/usr/sbin/rotatelogs -l logs/error_%Y%m%d.log 86400"
CustomLog "|/usr/sbin/rotatelogs -l logs/access_%Y%m%d.log 86400" combined
 
```
### 8.2.2 cronlog , 第三方工具
> [!info] cronolog
> 作用: 可以把apache的日志切分成按==日==或按==月==保存的文件
> 用法 : 与rotatelogs大致一致,在配置文件都要==写全==路径
> 区别 : cronolog不需要写"86400"
> `which cronolog`确定cronolog的完整路径

配置
```xml
# 每天生成,结尾为"%d" ,既day

Error_Log "|/绝对路径/cronolog  logs/error_%Y%m%d.log"
CustomLog "|/绝对路径/cronolog  logs/access_%Y%m%d.log" combined
```
