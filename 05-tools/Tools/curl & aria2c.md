# curl
## 下载文件
```shell
# 原名保存到当前目录下
curl [-O]{--remote-name} https://example.com/src.zip

# 重命名保存
curl [-o]{--output} local-src.zip https://example.com/src.zip

# 原名保存到其他目录下
curl --output-dir /src/ -O https://example.com/src.zip
 
```
## 配置文件
```shell
# 自动跟随重定向
-L
# 断点续传
-C -
# 显示简洁进度条
--progress-bar
# 超时设置（避免卡死）
--connect-timeout 10
--max-time 600
# 更友好的 User-Agent（某些服务器会拦截默认 curl UA）
--user-agent "Mozilla/5.0 (compatible; curl)"
# 重试机制
--retry 3 
--retry-delay 2
 
```
## webdav 操作
| 操作  | curl 命令                                                          |
| --- | ---------------------------------------------------------------- |
| 上传  | `curl -q -u user:pass -T local remote`                           |
| 下载  | `curl -q -u user:pass remote -o local`                           |
| 列目录 | `curl -q -u user:pass -X PROPFIND -H "Depth:1" url`              |
| 建目录 | `curl -q -u user:pass -X MKCOL url/`                             |
| 删除  | `curl -q -u user:pass -X DELETE url`                             |
| 移动  | `curl -q -u user:pass -X MOVE -H "Destination: new_url" old_url` |
# aria2c
```shell
# 原名保存到当前路目录下
aria2c https://example.com/src.zip

# 重命名保存
aria2c -o local-src.zip https://example.com/src.zip

# 原名保存到其他目录下
aria2c -d /src https://example.com/src.zip
 
```
## 多url
