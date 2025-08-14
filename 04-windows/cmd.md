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

# 贡献资源
## 自己（net share）

| 功能       | 命令                                 |
| -------- | ---------------------------------- |
| 查看所有共享   | `net share`                        |
| 创建共享     | `net share 名称=路径`                  |
| 创建带备注的共享 | `net share 名称=路径 /remark:"说明"`     |
| 删除共享     | `net share 名称 /delete`             |
| 映射网络驱动器  | `net use Z: \\IP\共享名`              |
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

# 会话（net session）

| 作用         | 命令                         | 详解              |
| ---------- | -------------------------- | --------------- |
| **监控共享访问** | `net session`              | 看谁在用我的共享文件夹     |
| **排查异常连接** | `net session \\IP`         | 查看某个 IP 的详细连接信息 |
| **释放资源**   | `net session \\IP /delete` | 断开占用磁盘或文件的连接    |


# 英文单词
grant : 授予(格兰特)