# tee
作用接受标准输入，
默认行为
1. 为**覆盖式**写入
```shell
# 1.边看边保存到文件
ls /home | tee my_home.txt

# 2.以root权限写入文件(解决`>`权限问题)
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
## 错误写法
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 3.### 追加内容到文件（不覆盖)
echo "log entry 1" | tee -a logfile.txt
echo "log entry 2" | tee -a logfile.txt
## result logfile.txt的内容
log entry 1
log entry 2

# 4.清空文件内容,不用Ctrl+C退出
tee empty_file.txt <<<[""]{单引号或双引号都可以}
## 类似的命令
> empty_file.txt
 
```
- ✅ `sudo tee` 以 root 权限写入受保护文件
- ✅ 普通用户无法直接 `>` 写入 `/etc/resolv.conf`，但 `tee` 可以