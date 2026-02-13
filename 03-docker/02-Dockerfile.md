# Dockerfile
## 1.命令(不要忘记最后的==一点==)
```bash
# -f 默认自动寻找名为"Dockerfile"文件
docker build [ -f <dockerfile> ] -t <image_name:tag> .
```
## 2.基础知识
1. 关键字大写
2. 从上到下顺序执行
3. "#"为注释
4. 每一个指令都会创建提交一个新的镜像层,并提交
![[docker.png]]
## 3.常见关键字
### 3.1模板
```dockerfile
# 本地没有对应的system:tag会去pull
FROM system:tag

LABEL org.lael-schema.name="" \
      org.label-schema.author="<author>" \
      org.label-schema.version="<version>"
      
#  设置环境变量(没有"=")   
ENV <env_name> <env_value>

# docker -it <image_name>时的工作目录
WORKDIR [< DIR >]{引用`ENV`定义的变量时需要**$**}

# 构建这个镜像,执行的命令,一般为dnf,apt之类安装命令
RUN <command>

# 暴露端口
EXPOSE <port>
```
### 3.2外部交互
#### COPY
```Dockerfile
# 将本地的 src 目录下的所有内容复制到镜像内的 /app 目录下
COPY ./src /app

# 复制非tar类型压缩包
COPY appliance.zip /app 
RUN unzip appliance.zip
```
#### ADD
```Dockerfile
# 自动解压本地的 application.tar.gz 到镜像内的 /app 目录下
ADD application.tar.gz /app/

# 或者从网络下载文件并添加到镜像内
ADD http://example.com/file.zip /usr/local/
```

>📌**Docker 的安全机制限制了对构建上下文外文件的访问**，即使你有权限，也不能直接引用 `/home/mobius/...` 这种绝对路径。

#### 补充知识：什么是“构建上下文”

- 当你运行 `docker build .`，那个 `.` 就是上下文目录。
- Docker 会把整个目录（除 `.dockerignore` 排除的）打包发送给 Docker daemon。
- `COPY` 和 `ADD` 的源路径**必须是这个目录内的相对路径**。
- 即使你写绝对路径如 `/home/user/file`，Docker 也会报错（除非你用 BuildKit 的高级特性，但不推荐）

> [!attention] 注意
> 1. ADD 仅支持 tar 类型的压缩包解压
> 2. ADD 和 COPY 第二个参数最后加上`/`表示是一个目录
> 3. ADD 和 COPY 都支持 通配符。既`ADD *.tar.gz /opt/` 和 `COPY *.md /opt/`
> 4. ADD 和 COPY 支持 build 所规定的目录,获取内容
> 

### 3.3 CMD & ENTRYPOINT
#### CMD
```Dockerfile
# 生成名为 Mylinux 镜像
FROM alpine
CMD ["echo","hello from CMD"]

# result
docker run -it Mylinux           // 输出`hello from cmd` 
docker run -it Mylinux echo "hi" // 输出 `hi`
docker run -it Mylinux whoami
# container 只执行 whoami 命令后停止

# CMD 同时执行多个命令
FROM alpine
CMD ["/bin/sh", "-c","echo 'hello' > test.txt && cat test.txt"]

// 输出 `hello`
```
#### ENTRYPOINT
```Dockerfile
# 生成名为 Mylinux 镜像
FROM alpine
ENTRYPOINT ["echo","hello from ENTRYPOINT"]

# result
docker run -it Mylinux               // 输出 `hello from ENTRYPOINT`
docker run -it Mylinux "world"       // 输出 `hello from ENTRYPOINT [world]{追加到ENTRYPOINT的后面}`
docker run -it --entrypoint "whoami" // 输出 `root`

```
#### ENTRYPOINT + CMD
```Dockerfile
FROM alpine
ENTRYPOINT ["echo"]
CMD ["hello default"]

# result
docker run -it Mylinux               // 输出 `hello default`
docker run -it Mylinux "custom msg" // 输出 `custom msg`

 
```
>[!summary] CMD 和ENTRYPOINT的区别
>CMD 覆盖
>ENTRYPOINT 不覆盖,除非使用--entrypoint
>常见用法
>```dockerfile
>FROM rocklinux:8
>ENtrypoint ["ls" ]
>CMD ["-a"]
>```
>常见模式是用 `ENTRYPOINT` 来指定应用本身，而用 `CMD` 来提供该应用的默认参数。这样，用户可以通过在 `docker run` 命令中添加额外的参数来覆盖这些默认参数，而不必重新指定整个命令。

|场景|推荐写法|
|---|---|
|镜像代表一个**固定程序**（如 Nginx、Python app）|`ENTRYPOINT ["python", "app.py"]`|
|镜像提供**可变命令的工具**（如 curl、自定义 CLI）|`ENTRYPOINT ["/bin/sh", "-c"]` + `CMD ["default_cmd"]`|
|仅需默认命令，允许完全替换|只用 `CMD`（较少见）|
|**永远优先使用 Exec 格式**|`["cmd", "arg"]` 而非 `"cmd arg"`|
## 4 案例
```dockerfile
FROM rockylinux:8

LABEL org.label-schema.name="MyCentOS" \
      org.label-schema.author="mobius" \
      org.label-schema.version="0.1"

ENV MYPATH /home/

WORKDIR $MYPATH

RUN yum -y install vim nginx

EXPOSE 80

# 创建container时,自动执行命令
# 创建container时,自动执行命令
# docker run -it <image_name>才能看到效果
CMD

ENTRYPOINT
```