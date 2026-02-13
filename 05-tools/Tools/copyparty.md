---
language: python
type: tools
function: web 文件传输，管理
---
# copyparty
## http
```shell
copyparty -v <path>::rw [-p <port>]

# example
copyparty -v D:\project\ai::rw 
```

### 常用快捷键
- g : 转换视图
- C-K : 删除(需要有**删除**的权限)
### 权限关系
| 权限缩写 | 含义                  |
| ---- | ------------------- |
| `w`  | 写入（上传）              |
| `d`  | 删除                  |
| `m`  | 移动/重命名              |
| `r`  | 读取（浏览/下载）           |
| `a`  | 管理(管理配置,**没有**删除权限) |
> [!attention] 注意
> 1. http 服务默认使用 **3923**端口
> 2. `+` : 表示全部权限,既(rwdm)
## FTP
```shell
copyparty -v <path>::rw -a <user>:<passwd> --ftp <port>

# example
copyparty -v D:\project\ai::rw -a user:passwd --ftp 21
 
```

## 配置
类似 samba 服务配置
```shell
[global]
    # 指定端口
    p: 80,443
    # 启用数据库，搜索， 撤销等功能
    # “简单文件上传服务” 变为 “云盘”
    #e2dsa
[accounts]
    artemis: 8a20
    verthandi: 2v23
    poseido: 3p21
[groups]
    g1: artemis,poseido

# 指定页面默认显示的目录
[/]
	E:\BilibiliCache\Raw\
	accs:
		r: @g1
		a: poseido
		rwdm: verthandi
        
# 其他需要显示的目录
[/cover]
    E:\BilibiliCache\thumbnails
    accs:
        r: verthandi

 
```