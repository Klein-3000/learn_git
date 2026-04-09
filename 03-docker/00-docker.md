# Lazydocker
## install Lazydocker
[[docker(Lazydocker installation script)]]

# 1.基础知识
- repository : 仓库(存放images)
- images   : 镜像(==菜单==)
- container:容器(==一道菜==,运行中的程序)
- 官网
	- https://hub.docker.com
	- https://docker.fxxk.dedyn.io
- 加速镜像
  - docker.1ms.run
  - quay.io
  - 对search和pull子命令才有用
    - docker search docker.1ms.run/mysql
    - docker pull docker.1ms.run/mysql
![[docker1.png]]
![[docker2.png]]
# 2.相关目录
<span style="background:yellow;font-size:40px">/etc/docker/daemon.json</span>
```json
{
  "registry-mirrors": [
    "https://docker.1ms.run"
  ],
  "data-root" : "/data",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}

```
<span style="background:yellow;font-size:40px">/var/lib/docker</span>
# 3.命令

## 1.search and pull  and push
```shell
# 搜索镜像
docker search image_name

# 从Docker注册表拉取镜像,默认是最新版
# repository = registry/library/package
docker pull [registry/library/]package[/latest]
# 简化
docker pull package

# 上传镜像
docker push
```
## 2.container
```bash
# 列出所有 Docker 容器(运行和已停止)
docker ps [ -a | --all ]
# 列出所有id
docker ps -aq 
# 强行关闭所有运行的容器
docker rm -f `docker -aq`

# 从镜像启动容器，并自定义名称
docker run --name container_name image
# 用完既删除
docker run -it --rm container
# 启动某些一开就关的container
docker run <image> sleep infinity

# -d detached mode 后台运行
# --restart [always/unless-stopped] 开机自启动 
     always           总是自启
     unless-stopped   手动停止就不自启了
# -e export        传递环境变量
# -p port          本地端口:docker端口

```
## 拷贝与挂载
>主机与container,containe相互拷贝文件
### docker cp命令
```bash
# 拷贝文件
# container 到 主机
docker cp container_name:PATH host_path
# 主机 到 container
docker cp host_path container_PATH
```
### 绑定挂载( bind mount)
```bash
# 绑定挂载
# -v volume        本地目录(绝对路径):容器目录 宿主机目录会覆盖容器的目录
# 存储空间(命名卷) 命名卷挂载
# -v 卷的名字:容器内目录

```
> [!attention] 注意
> [[01-docker-绑定挂载]]
### 命名卷挂载(named volumes)--具名挂载和匿名挂载
> 相关目录==/var/lib/docker/volumes/==
```bash
# bind mount, "/"开头
docker run -v /home/Mobiusnginx:/usr/share/nginx/html nginx

# 具名挂载
docker run -v V-name:/usr/share/nginx/html nginx

# 匿名挂载, 路径识别为container中的路径
docker run -v /usr/share/nginx/html nginx
```

### volume
```bash
# 创建挂载卷
docker volume create <volume_name>
# 查看挂载卷的位置
 docker volume inspect <volume_name>

# 查看所有挂载卷
# docker volume list

# 删除挂载卷
docker volume rm <volume_name>

# 删除所有没有使用的挂载卷
 docker volume prune -a
```
#### 挂载
![[docker3(--mount).png]]
### rcontainer之间(--volumes-from)---数据卷容器
```bash
docker run --name docker02 --volumes-from docker01 <images_name>
```


## 3.启停docker容器(interactive)
```bash
# 启动或停止现有的容器
docker start | stop(10s反应时间) | kill(速度快) | restart | top(进程) | stats(CPU和memory情况) [ container_name | container_ID ]

# 进入容器(开启新的shell)
docker exec -it container_name | container_id /bin/bash(bash命令行)
## 简写(进入原有的shell)
docker attach container_name_or_id

# 非交互式(不进去)
docker exec -it container_name cmd(命令)
# 查看容器的进程
docker top container_name | container_id
# 查看占用资源情况
docker stats container_name | container_id

```
## 4.docker镜像(images)操作
```bah
# 显示已下载镜像的列表
docker images
# 删除镜像(没有容器依赖该镜像时,才可以删除)
# 所有tag且没有container引用了docker就删除这个image
docker rmi [ image_name[:version] | IMAGE_ID ]

# 删除容器
docker rm [ -f ]container_name
```
> [!summary] tag
> docker tag old_image\[:tag] new_image\[:tag]
> ### 💡 补充：`docker tag` 不是复制，而是“打标签”
>- 它不会占用额外磁盘空间
>- 只是为同一个镜像增加一个别名（引用）
>- 删除某个标签（`docker rmi rocky:latest`）也不会影响原始镜像，只要还有其他标签存在
>### 注意
>删除旧的tag时
>只能`docker rmi <old_image_name[:tag]>`
>不能`docker rmi <hash>`
### 💡 小贴士

- 镜像是静态模板，容器是镜像的运行实例。
- 只要还有容器存在（即使已停止），Docker 就会保留它所依赖的镜像。
- 使用 `docker system prune` 可以清理无用资源（停止的容器、悬空镜像等），但不会删除有标签的镜像或仍在使用的资源。
## 5. 日志和容器信息和
```bash
 # 日志logs
 docker logs [ -ft | --follow --timestamp] container_name_or_id

# 容器信息
docker inspect container_name_or_id

```
### inspect
Docker 会按以下**优先级顺序**在本地数据库中查找匹配项：
1. **Container（容器）**
2. **Image（镜像）**
3. **Local volume（本地卷）**
4. **Network（网络）**
5. **其他（Swarm 相关对象）**
> 🔍 **关键点**：**容器优先于镜像**！

```bash
# 明确 inspect 镜像
docker inspect --type=image nginx

# 明确 inspect 容器
docker inspect --type=container nginx

# inspect 网络
docker inspect --type=network mynet

# inspect 卷
docker inspect --type=volume myvol
```

## 6. save and load
```bash
# 打包镜像(源文件->新文件)
# 根tar命令相反
docker save image_name:version -o  new.docker.image_naem.tar.gz
# 安转打包的镜像
docker load -i new.docker.image_naem.tar.gz

# 注意"image_name"只能是小写字母
# 无论container的状态都可以使用
docker commit -m "提示信息" -a "作者" container_name_or_id [author]image_name[:tag]
```
> [!warning] container_name的含义
> 不是run启动的images名字
> 而是在docker ps中names列显示的名字

> [!info] 其他
> 默认从==172.17.0.2==开始分配地址
> docker run 时,建议加上参数==-d==.不然当前会话就被该容器占用了,ctrl-c容器就停止

---
# 4.docker Network(bridge)
默认是172.17.0.2 **/16**
```shell
# 创建网络
docker network create [ --driver bridge ] [--subnet 172.18.0.0/16 --gateway 172.18.0.1] <Network_name>

# 查看网络
docker network ls

# 删除网络
docker network rm <network_name>

# 联系(创建container时,自带了"--net"参数)
# "--ip"绑定ip地址
docker run [ --net bridge ] [--ip <ip> ]<image_name>

# 指定网络
docker --Network <network_name> 
```
> [!attention] 注意
> 1. `--subnet` 和`--gateway` 建议一起使用,单独使用`--subnet`参数,docker不会自动配置gateway

> [!summary] 总结
> bridge 的container **不能**直接通过主机名ping通
> custom net 的container **可以**直接通过主机名ping通
## 不同网络的container之间的通信
```bash
# 将container添加到network网络中
# 一个container两个ip
docker network connect <network> <container> [ --alias <alias> ]

# 断开链接
docker network disconnect [ -f ] <network> <container>
```

