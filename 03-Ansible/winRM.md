# 服务端
```cmd
winrm quickconfig


# 启用 WinRM + PowerShell Remoting
Enable-PSRemoting -Force

# 确保网络为“专用”
Set-NetConnectionProfile -NetworkCategory Private

# （可选）手动放行防火墙
New-NetFirewallRule -Name WinRM-HTTP -DisplayName "WinRM HTTP" -LocalPort 5985 -Protocol TCP -Action Allow
```
> [!attention] 注意
> 需要将网络设置为"专用网络"
## 服务
- `wsman`(5985) = Web Services Management
- `wsmans`(5986) = WS-MAN Secure（即 HTTPS）
## 对比

|操作|`Enable-PSRemoting` 做了什么|`Disable-PSRemoting` 是否回滚？|
|---|---|---|
|1️⃣ 启动 WinRM 服务|✔️ 启动并设为自动|❌ 不关闭服务|
|2️⃣ 创建 HTTP 监听器|✔️ 监听 `*:5985`|❌ 不删除监听器|
|3️⃣ 开放防火墙规则|✔️ 允许 5985 入站|❌ 不删除防火墙规则|
|4️⃣ 修改注册表策略|✔️ 设置 `LocalAccountTokenFilterPolicy=1`（允许非管理员远程）|❌ 不恢复为 0|
# 客户端
```cmd
winrm set winrm/config/Client @{TrustedHosts='*'}

winrs -r:http://<ip_address>:[<port>]{默认为**5985**} -u:<user> -p:<password> cmd
```

```powershell
# 添加信任主机（首次连接非域机器时需要）
Set-Item WSMan:\localhost\Client\TrustedHosts *
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "192.168.1.100" -Concatenate -Force

# 测试连通性
Test-WSMan 192.168.1.100

# 远程执行命令
Invoke-Command -ComputerName 192.168.1.100 -ScriptBlock { ipconfig }

# 交互式会话
Enter-PSSession -ComputerName 192.168.1.100
```


| 服务端                                                                                       | 客户端                                                                                                                    |
| ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `Enable-PSRemoting -force`<br><br><br>`Set-NetConnectionProfile -NetworkCategory Private` | `Set-Item WSMan:\localhost\Client\TrustedHosts -value <server_ip> `<br><br>`Enter-PSSession -ComputerName <server_ip>` |


# 对比

|特性|PowerShell Remoting (WinRM)|OpenSSH on Windows|
|---|---|---|
|底层协议|WS-Management (SOAP over HTTP/HTTPS)|SSH (加密二进制流)|
|默认端口|5985 (HTTP), 5986 (HTTPS)|22|
|数据格式|结构化对象（非纯文本）|纯文本流|
|脚本能力|原生 PowerShell，支持 `.ps1`、模块等|需在远程执行 `pwsh -File ...`|
|安全性|HTTP 明文（不推荐），HTTPS 安全|默认全程加密|
|跨平台|Windows → Windows（最佳）；Linux 可作客户端|全平台通用|
|微软推荐|✅ 传统 Windows 管理首选|✅ 新趋势（尤其混合环境）|