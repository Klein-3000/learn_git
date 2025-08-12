# 过滤操作
## 简单过滤
```shell
# 过滤IP地址
# interface Protocol
ip.src==192.168.94.148
ip.dst==192.168.94.1

# 过滤mac地址
# ethernet : 以太网
eth.src==d0:39:57:af:3a:7f
eth.dst==c0:b8:e6:fc:12:8d

# mac地址书写格式
c0-b8-e6-fc-12-8d
c0:b8:e6:fc:12:8d
```
\[waring] mac怎么分割-还是:
## 逻辑过滤
```shell
or  || : 或
and && : 与
     ! : 非
```
> [!note] 拓展
> 交换机的每个端口属于一个冲突域,所有端口属于一个广播域
> 集线器所有端口属于一个广播域和冲突域


# 以太网的帧结构
## 结构
[[以太网|以太网结构]]

dst_mac 
src_mac
type
	ipv4 : 0x0800
	ipv6 : 0x86dd
	arp  : 0x0806
dst_ip
src_ip
> [!note] 提示
> dst_mac和dst_ip 以及src_ip和src_mac不一定一一对应
> dst 的情况
>  - 同一局域网中对应
>  - 跨网段就不对应
> 
> src 的情况
> - 一般是对应的
> - [[#其他src不对应的情况]]

## 其他src不对应的情况
- **ARP欺骗**：攻击者可能会发送伪造的ARP响应，将他们的MAC地址与受害者的IP地址关联起来。
- **网络攻击**：其他类型的网络攻击也可能导致这种不一致，如中间人攻击等。
- **配置错误**：网络设备或主机的配置错误也可能导致这种现象。
- **虚拟化环境**：在某些虚拟化环境中，一个物理接口可能对应多个虚拟机，每个虚拟机有自己的IP地址，但共享同一个物理MAC地址。
---
# arp
address resolution Protocol (Request)
Hardware type:Ethernet(1)                    1:**使用的是标准的6字节MAC地址格式**(WiFi和ethernet)
Protocol type:IPv4(0x0800)
Hardware size:6
Protocol size:4
0pcode:request(1)                              1:**请求**(Request ==broadcast==); 2:**响应**(回复reply ==unicast==)
Sender MAc address:52:62:e3:b2:36:30(52:62:e3:b2:36:30)
Sender%% 发送者 %% IP address:10.97.21.14
Target MAC address: Broadcast(ff:ff:ff:ff:ff:ff)
Target%% 目标;接收者 %% IP address:10.97.0.1
### 试分析广播帧所起的作用是什么？

在图中显示的数据包是一个ARP请求，其作用是解析目标IP地址对应的MAC地址。具体来说：

- **ARP请求**：当一个设备需要与另一个设备通信但不知道其MAC地址时，它会发送一个ARP请求广播帧。在这个广播帧中，发送方会询问“谁拥有IP地址X？请回复你的MAC地址。”
- **ARP响应**：网络中拥有该IP地址的设备会回应一个ARP响应，提供其MAC地址给请求方。
- **更新ARP缓存**：接收到ARP响应后，请求方会将IP地址和对应的MAC地址添加到其ARP缓存中，以便后续通信可以直接使用MAC地址进行数据传输，而不需要再次发送ARP请求。

广播帧在这种情况下起到了关键的作用，因为它允许设备在不知道目标MAC地址的情况下，通过网络中的其他设备找到正确的MAC地址，从而实现不同设备之间的通信。