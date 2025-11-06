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
nmcli device WiFi list

# 链接WiFi
nmcli device WiFi connect "$SSID" password "$password"
nmcli < --ask | -a > device WiFi connetc "SSID"

# 显示Wi-Fi接口的一般信息和属性
 nmcli -p -f general,wifi-properties device show wlan0

```
## 管理WiFi
```bash
# 查看现有的链接(获取UUID、链接名)
nmcli connection show

# 启停用链接
nmcli connection [up | down] id "连接名"
nmcli connection [up | down] uuid <UUID>

```