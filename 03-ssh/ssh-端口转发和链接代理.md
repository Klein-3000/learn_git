# 本地端口转发 -- LocalForward
![[ssh_local.png]]
```shell
# 基本格式
ssh -L [本地IP:]{默认为**localhost**,只能通过**localhost**或**127.0.0.1**访问}本地端口:目标主机:目标端口 user@跳板机

# 多端口
ssh -L ... -L ...

# 其他参数
## 组合写法
ssh [-fNL ]{参数位置**不能**变} [本地IP:]本地端口:目标主机:目标端口 user@跳板机
## 拆开写法
ssh -L 8080:192.168.1.16:9090 -N fedora

 
```
- `-L [bind_address:]port:host:hostport`：定义本地转发规则（必须紧跟其参数）
- `-N`：不执行远程命令（常用于纯端口转发）
- `-f`：后台运行（Windows 上部分版本支持，但行为可能不如 Linux 稳定）
### 📌 原理：

- 在 **本地机器** 上监听一个端口（如 `8080`）；
- 所有发往该端口的流量，通过 SSH 隧道转发到 **跳板机（SSH 服务器）能访问的某个目标主机:端口**。

> 注意：**“目标主机”是从跳板机的视角解析的**（即目标主机对跳板机必须可达）。

## 配置
```shell
# ssh -L 3306:127.0.0.1:3306 user@server_ip
Host localPort
    Hostname <server_ip>
    User <user>
    LocalForward 3306 127.0.0.1:3306

```
---

# 远程端口转发 -- RemoteForward
![[ssh_remote.png]]
```shell
ssh -R [远程IP:]远程端口:本地主机:本地端口 user@远程服务器
 
```
### 📌 原理：

- 在 **远程服务器（SSH 服务端）** 上监听一个端口；
- 所有发往该远程端口的流量，通过 SSH 隧道转发回 **你本地机器（SSH 客户端）能访问的某个服务**。

> 注意：**“本地主机”是从你当前客户端的视角解析的**。
```shell
# ssh -L 3306:127.0.0.1:3306 user@server_ip
Host localPort
    Hostname <server_ip>
    User <user>
    RemoteForward 3306 127.0.0.1:3306
 
```
> [!attention] 注意
> 远程端口转发需要开启
> - `GatewayPorts clientspecified`：允许客户端用 `-R [bind:]port:...` 必须手动指定绑定地址，否则依旧是 `-R localhost:prot:...`
> - `GatewayPorts yes`：所有 `-R` 自动绑定到 `0.0.0.0`

✅ **一句话记住**：

- **`-L`：本地开个门，通向远程内网**（我要进去）。
- **`-R`：远程开个门，通向我的本地**（让人进来）。


---
# 链接代理 -- ProxyJump
跳板链接/代理跳转
## 命令
```shell
ssh -J Jump_user@Jump_host target_user@target_host
# 需要输入两次密码
# Jump_user 一次
# target_user 一次
 
```
## 配置
### 基本配置
```shell
Host tg
	HostHost <target_ip>
	User <target_user>
	ProxyJump Jump_user@Jump_host
 
```
### 进阶配置
```shell
Host J
	HostHost <Jump_ip>
	User <Jump_user>
	IdentityFile /path/to/Jump_key
 
Host tg
	HostHost <target_ip>
	User <target_user>
	ProxyJump J
 	IdentityFile /path/to/target_key

 
```



