# 修改的文件
## wsl中/etc/wsl.conf添加了下面内容
```bash
[automount]
enabled = true
options = "metadata,uid=1000,gid=1000,umask=022,iocharset=utf8"

[boot]
command = "sudo /bin/mount --make-shared /"
```
## windows中C:\Users\Lenovo\.wslconfig添加了下面内容
```bash
kernelCommandLine = cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 swapaccount=1
```

## 取消警告
```bash
PODMAN_IGNORE_CGROUPSV1_WARNING=1
```