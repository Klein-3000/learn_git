# 包管理(apk)
```shell
# 搜索
apk search [-v] <keyword>

# 安装
apk add [--no-cachd]{不保留缓存,减小镜像体积} <package> [<package1> ...]

# 卸载
apk del <package>

# 清理缓存
apk cache clean

 
```
# shell(sh)
1. 默认配置文件 /etc/profile
2. 默认不会自动加载