## 格式
```shell
find [路径[,路径1]] [表达式]
 
```
## parameter
### 基本
```shell
# 名字
-name "filename"  # 可结合正则
-iname "filename" # 同"-name",多了不区分大小写

# 类型
-type [ f | d | l | c | b] 
# c 字符设备文件;
# B 块设备文件

# 大小
-size -10M  # 大于10MB的文件
-size +10k  # 小于10KB的文件
单位：
c 字节
k 千字节
M 兆字节
G 吉字节

# time(小时) & min(分钟)
-mtime & -mmin # 修改
-atime & -amin # 访问
-ctime & -cmin # 创建

 
```
### 高级
```shell
# permanent 永久
# permission 权限
-perm 

# 逻辑运算符
-and
-or
!
# 案例
find /home -type f -name "*.log" -and -size +1M
find /etc $ -name "*.conf" -or -name "*.cfg" $
find /tmp -type f ! -user root

# 执行
-exec cmd {} \;
# 案例
find /path -name "*.tmp" -exec rm {} \;


```
