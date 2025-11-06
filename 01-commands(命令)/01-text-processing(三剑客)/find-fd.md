# find
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
# fd
## 基本格式
`fd <pattern> <path>`
默认行为
	1. 忽略 **.gitignore** 中包含的文件
	2. 递归搜索

## 按类型搜索
使用 `-t` 选项指定搜索的文件类型。

- `f`: 普通文件 (file)
- `d`: 目录 (directory)
- `l`: 符号链接 (symlink)
- `x`: 可执行文件 (executable)
- `e`: 空文件或目录 (empty)
```bash
# 搜索所有目录
fd -t d config

# 搜索所有可执行文件
fd -t x script

# 搜索所有普通文件
fd -t f notes.txt

# 搜索多个类型（例如文件和目录）
fd -t f -t d project
```
## 按拓展名
```bash
# 搜索所有 .txt 文件
fd -e txt

# 搜索所有 .py 或 .js 文件
fd -e py -e js

# 搜索特定名称且特定扩展名的文件
fd -e pdf presentation
```

## 区分大小写/忽略大小写

- `-i` 或 `--ignore-case`: 忽略大小写（默认行为）。
- `-s` 或 `--case-sensitive`: 区分大小写。
- `-S` 或 `--smart-case`: 智能大小写。如果搜索模式包含大写字母，则区分大小写；否则忽略大小写。
```bash
# 显式忽略大小写（默认）
fd -i README

# 强制区分大小写
fd -s README

# 智能大小写：搜索 "ReadMe" 会区分大小写，搜索 "readme" 则忽略
fd -S ReadMe
```
## 总结
> [!summary] 总结
> -t : 指定**类型**
> -e : 指定**拓展名**
> -d : 指定**深度**
> -i : **忽略**大小写
> -s : **严格**区分大小写
> -S : **智能**区分大小写

