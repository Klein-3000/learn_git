# 1.firewall-cmd
## 1.1基础
```shell
# 1.查看所有规则
--list-all         

# 2.--add 和 --remove
## 添加 "服务" & "端口和协议(TCP or UDP)"
### 服务
--add-service='http'
### 端口和协议
--add-port '81/TCP'

# 删除
--remove-service='http'
--remove-port='81/TCP'

# 永久配置（写入配置文件 | 需重启才生效）
--permanent

# 重载配置
--reload
```
## 1.2高级配置
### 1.2.1态度
- drop 丢弃  | ==请求超时==
- accept 接受
- reject  拒绝 | ==主机不可达==
### 1.2.2配置
- 端口 ==port port= protocol===
- 服务 ==service name===
- 协议 ==protocol value===
```shell
# 基本格式
--add-rich-rule='rule 规则 态度'
--remove-rich-rule='rule 规则 态度'

# 端口 拒绝192.168.94.1的80端口
--add-rich-rule='rule family=ipv4 source address=192.168.94.1/24 port port=80 protocol=TCP reject'
# 拒绝http服务
--add-rich-rule='rule family=ipv4 source address=192.168.94.1/24 service name=http reject'
# 丢弃TCP协议
--add-rich-rule='rule family=ipv4 source address=192.168.94.1/24 protocol value=TCP'
```
> [!warning] 规则
> 从上往下读
> 上面符合,就不读下面了
# 2.selinux
## 2.1配置文件
==/etc/selinux/config==
## 2.2配置
```shell
SELINUX='enforcing'

# 取值
enforcing   强迫 | 1
permissive  宽容 | 0
disable     禁止
```
## 2.3相关命令
```shell
# 查看
sestatus

# 设置
setenforce [ 0 | 1] | [permissive | enforce]
# 查看
getenforce
```

```shell
htconf='/etc/httpd/conf/httpd.conf'
```
