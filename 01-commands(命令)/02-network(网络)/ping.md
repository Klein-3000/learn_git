# ping命令
```shell
# ping的个数 number
ping -n 10 www.example.com
# linux为c
ping -c 10 www.example.com

# ping包的长度 length,单位为字节
ping -l 1024 www.template.com
# linux为s size
ping -s 1024 www.template.com

# 一直ping下去
ping -t www.verthandi.com
```
### ICMP Echo 报文结构简要说明：

ICMP Echo ==请求（类型8）==和==应答（类型0）==报文格式如下（简化版）：

| 字段名称                    | 描述                                      |
| ----------------------- | --------------------------------------- |
| 类型（Type）                | 表示报文类型（Echo Request = 8，Echo Reply = 0） |
| 代码（Code）                | 通常为0，在某些特殊情况下使用                         |
| 校验和（Checksum）           | 校验ICMP头部和数据                             |
| **标识符（Identifier）**     | 用于区分不同的 ping 进程                         |
| **序号（Sequence Number）** | 用于区分同一 ping 命令中的不同报文                    |
| 数据（Data）                | 可选数据，通常包含时间戳或填充内容                       |
# 总结

| 选项                     | 说明                         |
| ---------------------- | -------------------------- |
| A. 类型（Type）            | 区分==请求/应答==类型，非匹配依据        |
| B. 代码（Code）            | 一般为0，无实际区分作用               |
| C. 标识（Identifier）      | **核心字段**，唯一标识一次 ping 命令    |
| D. 序号（Sequence Number） | 用于区分同一 ping 内的多个数据包，不是主要标识 |
