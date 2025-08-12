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