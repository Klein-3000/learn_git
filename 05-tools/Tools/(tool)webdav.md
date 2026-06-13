# webdav
## 1. 安装
### github 仓库
[hacdias/webdav: A simple and standalone WebDAV server.](https://github.com/hacdias/webdav)

## 2. 使用

### 2.1 基础命令
```
webdav -c config.yaml
```


### 2.2 配置
```yaml
address: 0.0.0.0
# 默认是 6065
port: 80
directory: /webdav-dir
users:
  - username: verthandi
    password: 2v23
  - useranme: osiris
    password: 11o9
    # 为该用户指定独立的目录和权限
    directory: /webdav1
    permissions: CRUD

    # 权限控制
    rules:
      - path: /webdav2
        permissions: CRUD
      - regex: "^o"
        permissions: RU
```
- `permissions`：C(创建)、R(读取)、U(更新)、D(删除)，可以任意组合，如 CRUD。
- rules：可对用户目录内的路径做细粒度权限控制，支持正则。
- 密码可以使用明文，也可以使用 bcrypt 哈希（用 webdav bcrypt 命令生成）。

## 3. 连接
### 3.1 windows
1. WebClient 服务，默认支持 `https` 协议

#### 修改注册表
```
# 查看
Get-ItemPropertyValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WebClient\Parameters' -Name BasicAuthLevel

# 修改
## SSL/HTTPS
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WebClient\Parameters' -Name BasicAuthLevel -Value 1  -Type DWord -Force

## HTTP
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WebClient\Parameters' -Name BasicAuthLevel -Value 2  -Type DWord -Force

```

- **将值设置为 1**（仅对 SSL/HTTPS 连接启用基本身份验证，这是系统默认的安全设置）
- **将值设置为 2**（为 SSL 和非 SSL/HTTP 连接都启用基本身份验证，通常用于挂载 HTTP 协议的 WebDAV）

### 3.2 rclone
![[(tool)rclone#2.1 基础命令]]