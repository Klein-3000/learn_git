```shell
multipass launch --name k3s --cpus 2 --memorys 4G --disk 10G
# 自动下载 ubuntu 镜像,依此安装虚拟机

# 查看创建的虚拟机
multipass list

# 启动和停止
multipass start | stop k3s

# 进入
multipass shell k3s

# 执行命令
multipass exec k3s -- <cmd>
  
```
> [!attention] 注意
> multipass 默认不支持 ssh 登录(不如vagrant)
