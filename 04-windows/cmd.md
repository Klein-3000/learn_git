# 用户管理
```cmd
# 添加用户
net user <userName> /add
# 删除用户
net user <userName> /del

# 修改密码
net user <userName> <password>

# 查看系统用户(有s)
net users
# 查看指定用户
net user <userName>
```
# smb服务
## 链接smb服务--(net use)
```shell
# 查看
net use

# 创建链接
net use V: "\\192.168.94.147[@445]{}\verthandi" [*]{交互式输入密码} /user:<UserName> /persistent:yes

# 删除链接
net use <Z: | \\IP@port\共享名> /delete
 
```
> [!attention] persistent的作用
> 在资源管理中创建一个可以直接访问的**虚拟盘符**出来
## 管理smb服务--(XX-smbshare)
### 创建new-smbshare
```shell
# 交互式
[new-smbshare]{-readaccess "everyone"}
	name
	path
	
## everyone 全权限(可读可写)
new-smbshare -name <name> -path "full/to/path" -fullaccess "everyone"

## everyone 只读
new-smbshare -name <name> -path "full/to/path" -readaccess "everyone"

## 特定用户
new-smbshare -name <name> -path "full/to/path" -fullaccess "DOMAIN\Users", "Admins"

```
### 查看get-smbshare
```shell
# 查看smb共享列表

# result
Name        ScopeName Path             Description
----        --------- ----             -----------
0-linux实践 *         D:\0-linux实践
ADMIN$      *         C:\WINDOWS       远程管理
C$          *         C:\              默认共享
D$          *         D:\              默认共享
Everything  *         D:\Everything
gitPublic   *         D:\2-桌宠\test
IPC$        *                          远程 IPC
Mylive2d    *         D:\2-桌宠\live2d

# 查看并显示权限
get-smbshare [\<ShareName>] | get-smbshareaccess
 
```
### 删除remove-smbshare
```shell
remote-smbshare <ShareName>
 
```
## 管理smb服务的权限(XX-smbshareaccess)
```shell
# 查看
Get-SmbShareAccess -Name gitPublic | Where-Object AccountName -eq "Everyone"

# 添加
Grant-SmbShareAccess -Name gitPublic -AccountName "Everyone" -AccessRight Full -Force

# 删除
Revoke-SmbShareAccess -Name gitPublic -AccountName "Everyone" -Force
 
```
## 管理smb客户端(XX-smbsession与XX-smbopenfile)
### XX-smbsession
```shell
# 查看谁链接链接我
get-smbsession

# 断开链接
remove-smbsession [ -sessionid ] <id> [ -Force ]
## 断开来自 192.168.1.105 的连接
sessions | ? ClientComputerName -eq "192.168.1.105" | Remove-SmbSession -Force
```
### XX-smbopenfile
```shell
# 查看
## 查看单个
get-smbopenfile [ -sessionid ] <id>
## 查看全部
get-smbsession | get-smbopenfile

# 移除
remove-openfile [ -fileid ] <id>

 
```

## 启用网络发现与关闭密码保护共享
建议界面化操作

| 图形界面设置                           | 对应 PowerShell 命令                                                               |
| -------------------------------- | ------------------------------------------------------------------------------ |
| 控制面板 → 网络和共享中心 → 高级共享设置 → 启用网络发现 | `netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes` |
| 关闭密码保护的共享                        | `Set-SmbServerConfiguration -AllowInsecureGuestAuth $true`                     |
## 案例
```shell
# 查看共享目录
new-smbshare -name "Public" -path "D:\Public" -fullaccess "everyone"

# 启用网络发现
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
# 关闭密码保护的共享
Set-SmbServerConfiguration -AllowInsecureGuestAuth $true

 
```

# ~~管理smb服务--cmd~~(直接用pwsh的)
#### net share
| 功能       | 命令                             |
| -------- | ------------------------------ |
| 查看所有共享   | `net share`                    |
| ~~创建共享~~ | `net share 名称=路径`              |
| 创建带备注的共享 | `net share 名称=路径 /remark:"说明"` |
| 删除共享     | `net share 名称 /delete`         |
#### net session

| 作用         | 命令                         | 详解              |
| ---------- | -------------------------- | --------------- |
| **监控共享访问** | `net session`              | 看谁在用我的共享文件夹     |
| **排查异常连接** | `net session \\IP`         | 查看某个 IP 的详细连接信息 |
| **释放资源**   | `net session \\IP /delete` | 断开占用磁盘或文件的连接    |
# 贡献资源
## 自己（net share）


| 映射网络驱动器  | `net use Z: \\IP\共享名`              |
| -------- | ---------------------------------- |
| 断开网络连接   | `net use <Z: \| \\IP\共享名> /delete` |
### 案例
```
# 1. 创建共享（网络层允许读写）
net share MyShare=D:\SharedFolder /grant:Everyone,CHANGE

# 2. 设置 NTFS 权限（文件系统层允许读写）
icacls "D:\SharedFolder" /grant Everyone:(OI)(CI)M

# 3.注意
everyone 改为系统用户,访问共享目录就要输入系统用户及其密码
```
> [!summary] 权限
> # net share
> 1. CHANGE :改变(change)
> 2. READ : 读
> 3. FULL : 全
> # icacl -- **Improved** **Control Access Control Lists**（ 改进版 控制访问控制列表）
> - `(OI)`：Object Inherit → 文件继承“写入”权限
> - `(CI)`：Container Inherit → 子文件夹继承权限
> - `M`：Modify（修改）→ 包含读取、写入、删除


## 被人 (net view)
| 命令                         | 说明                          |
| -------------------------- | --------------------------- |
| `net view`                 | 查看当前域或工作组中的所有计算机            |
| `net view \\ComputerName`  | 查看指定计算机的共享列表                |
| `net view \\192.168.1.100` | 查看 IP 为 192.168.1.100 的电脑共享 |
| `net view /domain`         | 查看域中所有计算机（在域环境中）            |

# 英文单词
grant : 授予(格兰特)
revoke : 撤销
persistent : 持久的
