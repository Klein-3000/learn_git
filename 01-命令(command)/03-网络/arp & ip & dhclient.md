# ARP
arp：address resolution protocol ： 地址解析协议
作用
将IP地址解析为Mac地址
命令
```shell
# 查看arp缓存 all
arp -a

# 删除arp条目 delete
arp -d ip地址
eg
sudo arp -d 192.168.94.148

# 添加arp条目 set
arp -s IP地址 mac地址
eg
arp -s 192.168.94.148 11-22-33-44-55-66

```
# ip
```shell
# 基本操作
## IP地址
ip [ -b | --brief ] a[ddress]
## Mac地址
ip [ -b | --brief ] l[ink]
## 网关
ip [ -b | --brief ] r[oute]
## 显示邻居表
ip [ -b | --brief ] n[eighbour]


# 临时配置(添加,删除)IP地址
ip a[ddress]{} add|delete <addr/mask> dev [\<device>]{就是网卡}
# 临时配置(添加,删除)网关
ip r[oute] a[dd] default via <gateway> dev <device>
 
```

# dhclient
```shell
# 为 eth0 网卡请求一个 IP 地址
dhclient eth0

# 释放当前 IP（可选）
dhclient -r eth0

# 释放后重新获取
dhclient -r eth0 && dhclient eth0

# 指定 DHCP 客户端租约文件或日志（高级用法）
dhclient -v eth0  # -v 表示显示详细过程
```
`dhclient` 通常用于：
- 网络配置出错后**快速恢复**。
- **测试** DHCP 服务器是否正常。
- 自动化脚本中动态获取 IP。
安装包
`dhcp-client`（RHEL/CentOS） 或 `isc-dhcp-client`（Debian/Ubuntu）
**图形界面用户通常不需要手动运行**： GNOME/KDE 等桌面环境通过 **NetworkManager** 自动管理 DHCP，一般无需手动调用 `dhclient`。
