# 一、介绍
## 1.1 对比
compose : 单机
swarm   : 集群
## 1.2 基本知识
swarm 中每个 docker 的容器称为一个节点(node)
- manager node : 管理节点,允许多个,但只能有一个**leader**
- worker node  : 工作节点
- 节点可以有多重身份
[Raft]{木筏} : 用于选举manager 节点的 leader (至少需要2个manager 节点参与选举), 并确保 manager 节点间的状态信息同步
## 1.3 工作流程
1. **集群初始化**:通过 docker swarm init 初始化集群，执行该命令的Docker主机自动成为Manager节点(Leader)
2. **节点加入**:将其他Docker主机加入集群。Manager节点会为新节点分配角色和相应的任务
3. **服务定义**:用户通过定义服务来描述容器化应用程序，定义完成后交给Manager节点去分配(任务是Swarm中的最小调度单位，表现为一个单一的容器。服务是一组任务的集合且定义了任务属性)
4. **调度策略**:Leader节点根据调度策略(spread-默认,binpack和random)，在集群中选择合适的节点来部署容器实例
5. **容器编排**:Leader节点负责对容器进行编排和管理，包括创建、启动、停止、重启容器实例等操作

#  二、Swarm集群管理
## 2.1 准备工作
2个Manager节点、2个Worker节点
Manager1: 192.168.56.106    hostname=manager1
Manager2: 192.168.56.107    hostname=manager2
Worker1: 192.168.56.116     hostname=worker1
Worker2: 192.168.56.117     hostname=worker2

## 2.2 命令
### 2.2.1 集群管理
```shell
# 初始化集群
docker swarm init --advertise-addr=192.168.56.106
# 指定其他节点用来与当前节点通信的IP(默认端口 2377 )

# 获取token -- 只有 Manager 才能使用
docker swarm join-token < manager | worker >

# 加入节点
## 加入 Manager node
docker swarm join --advertise-addr=<自己的广播地址> \
	--token <Manager_token> \
	<leader_ip>:[< port >]{是`2377`的话,可以不写}
	
## 加入 worker node
docker swarm join --advertise-addr=<自己的广播地址> \
	--token <worker_token> \
	<Manager_ip>:<port>
	
# 集群解散
docker swarm leave [ --force ]
# 节点退出集群, Manager 节点退出加`--force`
docker node rm <node_name>

 
```
特别说明:
	命令执行成功后，Swarm会自动将当前节点作为Manager节点并自动生成集群的token
	token分两类:**管理token**和**工作token**，分别用于其他的管理节点和工作节点加入集群使用
		[docker swarm join-token worker]{管理节点查看工作token}
		[docker swarm join-token manager]{管理节点查看管理token}

### 2.2.2 节点管理 -- Manager操作
```shell
# 查看集群节点
docker node ls                 # 所有节点
docker node inspect <node_name># 指定节点

# 节点升级与降级
docker node promote <node_name> # worker --> Manager
docker node dermote <node_name> # Manager --> worker

# 节点上线与下线
## 下线
docker node update --availability darain <node_name>
## 上线
docker node update --availability active <node_name>
 
```

### 2.2.3 服务管理 -- Manager 操作
#### 服务的定义
```shell
docker service crate --name <service_name> \
	[-d] [-p] [-e] [--network] [--mount] [--replicas] \
	<image>:<tag>
	
# eg
## 自定义 nginx 主页面
docker service create -d --name mynginx --replicas=2 \
	-p 80:80 \
	[--mount]{由于使用`replicas`参数,因为不知道到底是谁在工作,所以所有节点需要有相同的`nginx`主页目录,既`/root/nginx/html`}type=bind,source=/root/nginx/html,target=/usr/share/nginx/html \
	nginx:latest
	
## mysql 服务
docker service crate -d --name mydb --replicas=2 \
	-p 3306:3306 \
	-e MYSQL_ROOT_PASSWORD=123456 \
	-e MYSQL_DATABASE=testdb \
	mysql:lates

```
> [!note] mode 参数
> docker service crate ... --mode replicated ...
> 说明: 副本服务模式(默认)。在每个 node 上可以运行一个或多个副本
> docker service crate ... --mode global ..
> 说明: 全局服务模式。 强制在每个 node 上运行一个副本(列如收集所有容器的日志)
#### 服务管理
```shell
# 查看集群中所有服务
docker service ls
# 查看集群中指定的服务 -- 会显示是谁具体负责
docker service ps <service_name>

# 服务移除 -- 一个或多个
docker service rm <service_name>

# 服务日志
docker service logs <service_name>


 
```
> [!attention] 注意
> 集群中的服务,不管是谁在具体负责,只要服务在运行,就可以通过**任意**该集群的主机访问

### 3 swarm集群的弹性伸缩
弹性伸缩就是**动态**的增加或减少集群中某个服务的任务数
```shell
docker service update --replicas <新副本数> <service_name>

docker service scale <service_name> = <新副本数>
 
```
### 4 swarm集群服务的滚动更新
滚动更新既在**不停止服务**的情况下去更新服务,也称为**灰度更新**
```shell
docker service update \
	--image <基础镜像> \
	[--update-delay ]{定义滚动更新的时间间隔(默认0),单位如s、m、h， 1h20m30s既1小时20分30秒} 60s
	[--update-parallelism]{定义并行更新的最大数量(正更新的这些任务不可用)} 5
	<service_name>
	
# eg
## 要求: 升级没啥用起来服务基础镜像(v5.7->v8.0),由原来2个副本扩展到5个副本,每60秒扩容5
docker service update --replicas=5 \
	--image mysql:8.0 \
	--update-delay 60s \
	--update-parallism 5 \
	mydb
 
```
#### visualizer 镜像
可让swarm的服务滚动更新实时显示在UI界面上,便于观察滚动更新的过程。
Manager node 上执行
```shell
docker service crate \
	--name=viz \
	--publish 8088:8080/tcp \
	--constraint=node,role=manager \
	--mount=type=bind,src=/var/run/docker.sock.dst=/var/run/docker.sock \
	dockersamples/visualizer
 
```
### 5 swarm 中使用 docker compose
```yaml
services:
	deploy:
		replicas:2                               # 服务的副本数量
		mode: replicated(默认) | global           # 服务的模式
		[placement]{放置}:                               # 服务部署的目标节点
			[constraints]{限制}:                         
				- "node.id=nodeid"               # 根据节点id部署任务
				- "node.hostname=nodehostname"   # 根据节点主机名部署任务
			restart_policy:                      # 指定服务部署的重启策略
				[condition]{条件} : [none]{不重启} | [on-failure]{容器故障是重启}   
				delay: 10s                       # 尝试重启的时间 间隔(默认5s)
				max_[attempts]{尝试}: 3                  # 最多的尝试次数(默认无限制)

 
```
> [!attention] 注意
> docker compose up : 会**忽略** `deploy` 部分的内容
#### docker stack
```shell
docker stack deploy -c </path/to/compose.yaml> <stack_name>

# 查看 stack
## 查看所有 stack
docker stack ls
## 查看指定的 stack
docker stack ps <stack_name>

# 移除 stack
docker stack rm

# 停止 stack
docker stack down <stack_name>

 
```
> [!attention] 注意
> `docker stack deploy` 不支持 `name`关键字,仅支持已有的镜像.

# 三、单词
advertise : 做广告;广播
reachable : 可获得的
leave     : 离开
inspect   : 检查
promote   : 升级;晋升
demote    : 降级
available : 可用
availability : 可用性
drain : 排除
replica   : 副本
scale     : 规模
parallelism : 并行性
visual    : 视觉
visualize : 可视化
constraint : 限制
deploy    : 部署
placement : 放置
condition : 条件
attempts  : 尝试