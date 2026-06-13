# frp
## 1. 安装
### github 仓库
[fatedier/frp: A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.](https://github.com/fatedier/frp)

## 2. 使用
### 2.1 frps (服务端)
```toml
# 服务端与客户端绑定的通信端口，需确保未被占用并在防火墙中放行
bindPort = 7000 

# 授权令牌，客户端连接时需提供相同 token，建议设置为复杂字符串以保障安全
auth.token = "your_strong_token_here" 

# Web 仪表盘配置，方便通过浏览器查看代理状态和流量统计
webServer.addr = "0.0.0.0" 
webServer.port = 7500        
webServer.user = "admin"     
webServer.password = "your_secure_password"  

# 日志配置
log.file = "./frps.log"      
log.level = "info"           
log.maxDays = 7              
```

### 2.2 frpc (客户端)
```toml
# 公共配置
serverAddr = "你的服务器公网IP" # 填写 frp 服务端的公网 IP 地址
serverPort = 7000              # 与服务端配置的 bindPort 保持一致
auth.token = "your_strong_token_here" # 与服务端配置的 token 完全一致

# 代理规则（例如暴露本地的 Web 博客服务）
[[proxies]]
name = "web_blog"              # 自定义的代理名称，需保持唯一
type = "http"                  # 转发协议类型，Web 服务填 http
localIP = "127.0.0.1"          # 内网资源的本地 IP，本机服务填 127.0.0.1 即可
localPort = 80                 # 本地服务运行的实际端口
customDomains = ["yourdomain.com"] # 绑定的域名（若使用 HTTP 协议通常需要绑定域名）

[[proxies]]
name = "vm-ubuntu"
type = "tcp"
localIP = "192.168.183.131"
localPort = 22
remotePort = 2222
```

## 3. 命令
```bash
# 验证配置
frps verify -c frps.toml

frpc verify -c frpc.toml
```

