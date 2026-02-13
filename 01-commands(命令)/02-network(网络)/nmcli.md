# 守护进程
NetworkManager
/etc/sysconfig/network-scripts/

# 帮助信息
```bash
man nmcli

# 查看配置案例
man nmcli-examples
```
# 实战案例
## 链接WiFi
```bash
# 查看附近的WiFi(关键获取SSID:网络名称)
nmcli [d]{}evice [W]{}iFi [list]

# 链接WiFi
nmcli device WiFi connect "$SSID" password "$password"
nmcli < --ask | -a > device WiFi connetc "SSID"

# 查看 WiFi 密码
## 查看现连接 WiFi 的密码
nmcli [d]{}evice [W]{}iFi [s]{}how-password
## 查看之前连接过的 WiFi 密码
nmcli -s -g 802-11-wireless-security.psk connection show <SSID>
# `-s` 表示静默模式（不显示额外信息），`-g` 表示只获取指定字段。

# 显示Wi-Fi接口的一般信息和属性
 nmcli -p -f general,wifi-properties device show wlan0

```
## 管理WiFi
```bash
# 查看现有的链接(获取UUID、链接名)
nmcli connection [show]

# 启停用链接
nmcli connection [up | down] id "连接名"
nmcli connection [up | down] uuid <UUID>

# 删除已有的链接
nmcli connection delete < name | UUID >

```
## 修改IP地址
```shell
# 设置IP地址
nmcli connection modify <conn_name> ipv4.address <ip>/<mask>

# 设置网关
nmcli connection modify <conn_name> ipv4.gateway <gateway>

# 设置DNS
nmcli connection modify <conn_name> ipv4.dns <dns>

# [method]{方法} 
nmcli connection modify <conn_name> ipv4.method [manual]{手册, 不使用 DHCP}

# 重启接口是配置生效
nmcli connection down | up  <conn_name>
 
```