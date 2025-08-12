# local
```shell
local_enable=YES
# 本地用户登入时的目录
local_root=/var/ftp/fver
# 本地用户是否有写入权限，属于全局设置
write_enable=YES
# 本地用户新增目录时的umask值，默认值为077
local_umask=022
# 本地用户上传文件后的权限，与chmod所使用的数值一致，默认值为
file_open_mode=0755
```

# semanage
```shell
semanage [options] [command] [arguments]
```
## options
1. -l  --list          列出指定类型的 SELinux 策略配置（如端口、文件系统等）。
2. -a --add        添加新的策略配置。
3. -m --modify 修改现有策略配置
4. -d --delete    删除策略配置
5. -t --[[#常见类型|type]]        指定对象类型（如文件系统类型、端口类型等）
6. -f --file          从文件中读取策略配置（用于批量操作）。
7. -v -verbose   显示详细操作信息
## 常用操作
```shell
#  **查询文件系统标签**
semanage fcontext -l  # 列出所有文件系统的安全上下文规则
semanage fcontext -l | grep "/var/www"  # 过滤特定路径的规则

semanage fcontext -a -t httpd_sys_content_t "/var/www/new_dir(/.*)?"
 添加文件系统标签规则
semanage fcontext -a -t httpd_sys_content_t "/var/www/new_dir(/.*)?"
# -t 指定标签类型，路径支持正则表达式（`(/.*)?` 匹配子目录和文件）

# 修改文件系统标签规则
semanage fcontext -m -t httpd_sys_script_exec_t "/var/www/cgi-bin(/.*)?" # 修改现有路径的标签类型

# 删除文件系统标签规则
semanage fcontext -d -t httpd_sys_content_t "/var/www/old_dir"

restorecon -Rv /var/www/new_dir # 使新规则生效（刷新文件标签）
```

## 常见类型
### apache
httpd_sys_content_t
httpd_enable_homedirs

# restorecon
```shell


```

# vim
```shell
set ignorecase  " 搜索时忽略大小写
set smartcase   " 智能大小写：若搜索词包含大写字母，则区分大小写
```