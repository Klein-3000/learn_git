# 常见用法
## 基本格式
```shell
tcpdump [选项] [过滤表达式]
 
```
##  二、常用选项（Options）

|选项|说明|
|---|---|
|`-i eth0`|指定网卡（如 `eth0`, `ens33`, `wlan0`）|
|`-n`|不解析主机名（显示 IP，不反向 DNS）|
|`-v`, `-vv`, `-vvv`|显示更详细信息（越 `v` 越详细）|
|`-c 10`|只抓 10 个包后停止|
|`-s 0`|抓完整包（不截断，推荐）|
|`-w file.pcap`|保存到文件（用于 Wireshark 分析）|
|`-r file.pcap`|读取已保存的 pcap 文件|
|`-A`|以 ASCII 显示包内容（适合看 HTTP）|
|`-X`|以十六进制 + ASCII 显示|
## 案例
```shell
# 指定源或目标
tcpdump -i <interface> -n  [ src | dst ] <ip>

# 指定端口
tcpdump -i <interface> -n port <port>

# 指定协议
tcpdump -i <interface> -n proto [\<Protocol>]{需要**大写**, 如TCP,UDP,ICMP}

# 抓HTTP请求头(ASCII显示)
sudo tcpdump -i eth0 -n -A -s 0 port 80 | grep -i "host\|get\|user-agent"

# 抓包并保存到文件(共wireshark分析)
tcpdump -i eth0 -s 0 -w http.pcap port 80

 
```