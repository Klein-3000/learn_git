http : hypertext transfer Protocol : 超文本传输协议
https :hypertext transfer Protocol secure : 超文本传输安全协议

# http的动作
- **GET**：用于 HTTP 协议中从服务器获取数据，类似于 FTP 中的 RETR 命令，但用于下载而非上传。
- **POST**：通常用于 HTTP 协议中向服务器提交数据，在某些上下文中可以用来上传文件，但这不是 FTP 的命令。
- **HEAD**：用于 HTTP 请求只获取头部信息，与上传无关。
- **OPTIONS**：用于 HTTP 请求查询服务器支持的请求方法，与上传无关。
## http请求(get)
![[http-get.png]]
## http响应(post)
![[http-post.png]]
# https
通过==SSL（Secure Sockets Layer）==或==TLS（Transport Layer Security）==加密来保证互联网传输的安全性，防止窃听、篡改以及中间人攻击等。HTTPS通常使用TCP的443端口进行通信。
# http的状态码
200 : 没问题
301 : 资源被永久移动到新地方
302 : 页面跳转
304 : browser使用的是缓存的页面

400 : bad request | 客户端不能被服务器所理解
401 : unauthorized | 请求未经授权
403 : Forbidden | 服务器拒绝提供服务(禁止)
404 : Not Found | 请求资源不存在(没找到)
500 : Internet server Error | 服务器发生不可预期的错误
503 : server unavailable | 服务器当前不能处理客户端的请求