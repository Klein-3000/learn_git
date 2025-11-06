# 一、NFS网络文件系统
需要共享文件的主机都是linux,使用==nfs-utils==软件包
配置文件<span style="background-color:yellow;font-size:40px">/etc/exports</span>
## 参数解析

| 参数             | 作用                                        |
| -------------- | ----------------------------------------- |
| ro             | read only 只读                              |
| rw             | read write 读写                             |
| root_squash    | 当NFS 客户端以root管理员访问时，映射为NFS服务器的==匿名用户==    |
| no_root_squash | 当NFS 客户端以root管理员访问时，映射为NFS服务器的==root管理员== |
| all_squash     | 无论NFS 客户端使用什么用户访问时，映射为NFS服务器的==匿名用户==     |
| sync           | ==同时==将数据存到**内存**与**硬盘**中,保证不丢失数据         |
| async          | ==先内存后硬盘==,**效率高**,可能会丢失数据                |
## 配置(server端)
### Format
```shell
<共享目录> <客户端1>(选项1) <客户端2>(选项2)
```
### config
```shell
# /etc/exports
# 网段
/nfsfile 192.168.94.0/24(rw,sync,root_squash)

# IP地址
/nfsfile 192.168.45.1(rw,sync,root_squash)

# 多个的写法
/nfsfile 192.168.45.10(rw,sync,root_squash) /nfsfile 192.168.45.1(ro,sync)
```
## 相关命令
[[mount(挂载)#NFS服务(nfs-utils)| showmount & exportfs]]
## 客户端访问控制写法（重要）

| 写法                | 含义                     | 示例                           |
| ----------------- | ---------------------- | ---------------------------- |
| `IP地址`            | 允许指定 IP 主机访问           | `192.168.94.100`             |
| `子网/CIDR`         | 允许整个子网访问               | `192.168.94.0/24`            |
| `子网/掩码`           | 用完整掩码表示子网              | `192.168.94.0/255.255.255.0` |
| `域名`              | 允许特定域名的所有主机            | `example.com`                |
| `*.example.com`   | 允许 example.com 域下的所有主机 | `*.example.com`              |
| `*` 或 `0.0.0.0/0` | 允许所有主机访问（不推荐）          | `*(ro)`                      |

> [!warning] 注意
> # 配置问题
> NFS客户端地址与权限之间==没有==空格
> 既 /nfsfile 192.168.94.0/24(rw,sync,no_root_squash)


## 相关服务
nfs-server
rpcbind
# 二、自动挂载(autofs-utila)
配置文件<span style="background-color:yellow;font-size:40px">/etc/auto.master</span>
特点
1. 是一个linux系统守护进程
2. 访问为挂载的文件系统时，将自动挂载该文件系统
3. 节约网络资源和服务器的硬件资源

mount命令和/etc/fatab文件
## 相关服务
autofs
## 配置(建议==.misc==结尾)
### config
```shell
# 挂载目录 子配置文件(自定义配置文件;名字无要求)
# /etc/auto.master
/media /etc/auto.nfs
```
### /etc/auto.nfs
```shell
# 挂载目录 挂载文件类型及权限 :设备名称
# 挂载目录(触发自动挂载的条件,既在/media目录下,cd nfs时自动挂载;或cd /media/nfs)
# 带参数
nfs -ftype=nfs 192.168.94.148:/nfsfile

# 不带参数
nfs 192.168.94.148:/share
```

## 模块化管理(auto.master.d目录)
```shell
# /etc/auto.master
+dir:/etc/auto.master.d
```
### 作用
在auto.master.d创建==.conf==后缀的配置文件
在auto.master文件中使用==auto.config_name==调用
eg
```shell
# 调用 /etc/auto.master.d/nfs.conf的配置
/media /etc/auto.nfs

```