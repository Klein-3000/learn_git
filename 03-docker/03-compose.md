# compose组织container
## 1. 命令
```shell
# 创建
docker compose up -d

# 删除
# 默认只 清除容器和网络
docker compose down [-v]{volume :彻底销毁环境 + 清空所有数据}

# 启停
docker compose < start | stop | restart > 

# 交互
docker compose exec <service_name> [< cmd >]{如`/bin/bash`}

 
```

### 对比
```shell
docker compose up [-d]
docker compose run

docker compose down
docker compose rm 
```

| 命令       | 作用        |   启动？ | 删除容器？ | 删除网络？ | 用途      |
| -------- | --------- | ----: | ----: | ----: | ------- |
| **up**   | 启动所有服务    |     ✅ |     ❌ |     ❌ | 日常启动项目  |
| **run**  | 临时运行单个容器  | ✅(临时) |     ❌ |     ❌ | 执行命令、调试 |
| **down** | 停止 + 销毁环境 |     ❌ |     ✅ |     ✅ | 彻底关闭项目  |
| **rm**   | 只删停止的容器   |     ❌ |     ✅ |     ❌ | 清理无用容器  |

## 注意
Compose 会按以下规则生成容器名：
```shell
<项目目录名>-<服务名>-<序号>
 
```
- **项目目录名（Project name）**：默认是 `compose.yaml` 所在目录的**文件夹名**  
    → 你的目录是 `/root/docker/Compose`，所以项目名是 `compose`
- **服务名（Service name）**：你在 `compose.yaml` 中定义的 `alpine:`
- **序号**：用于支持 `deploy.replicas` 或多次启动，通常为 `1`

### 自定义 项目目录名 和 容器名
```shell
docker compose -p myproject up -d
 
```

```yaml
service:
  <service_name>:
    image: <image>
    container_name: <container_name>
```
⚠️ 注意：使用 `container_name` 后，**无法 scale 多个副本**（因为容器名必须唯一）。
### `docker compose exec` 和 `docker exec` 的区别是什么？

|特性|`docker compose exec`|`docker exec`|
|---|---|---|
|**操作对象**|Compose **服务名**（如 `alpine`）|**容器 ID 或容器名**（如 `compose-alpine-1`）|
|**依赖 Compose 项目**|✅ 必须在 `compose.yaml` 目录下运行|❌ 不需要 Compose|
|**自动解析容器**|✅ 自动找到对应服务的容器|❌ 需手动指定容器|
|**多副本支持**|✅ 自动选择一个实例（或指定 `--index`）|❌ 必须指定具体容器|
|**环境一致性**|✅ 继承 Compose 的上下文（如网络、环境变量）|⚠️ 仅操作容器本身|
|**可移植性**|✅ 脚本中更稳定（不依赖容器名）|❌ 容器名可能变化|

---
## 🎯 2. **Compose.yaml 推荐掌握到什么程度？**

对于**日常开发和运维**，建议掌握以下层级：

### ✅ **基础必备（必须会）**

|功能|示例|
|---|---|
|服务定义、镜像、容器名|`image`, `container_name`|
|端口映射|`ports`|
|环境变量|`environment`|
|卷挂载（绑定 + 命名卷）|`volumes`|
|重启策略|`restart`|
|依赖关系|`depends_on`|

### ✅ **进阶常用（强烈推荐）**

|功能|说明|
|---|---|
|**自定义网络**|`networks` + 顶层声明|
|**健康检查**|`healthcheck`（用于服务自愈、K8s 风格探针）|
|**日志配置**|`logging`（限制日志大小）|
|**部署资源限制**（仅 Swarm 模式）|`deploy.resources`|
|**多文件拆分**|`docker compose -f file1.yml -f override.yml`|

### ✅ **高阶（按需学习）**

- secrets / configs（敏感信息管理）
- profiles（条件启动服务）
- extension fields（YAML anchors 复用配置）
- build + context（构建镜像）

---
## 3.yaml写法
```yaml
version:'3' #docker-compose.yml的文件版本
services:
  db:  #第一个容器名(db)
   image: mysql:5.7
   restart: always # 开机自启动
   environment:
     MYSQL_ROOT_PASSWORD:123456
     MYSQL_DATABASE: wordpress
     MYSQL_USER: wordpress
     MYSQL_PASSWORD: 123456 #和下面的WORDPRESS_DB_PASSWORD值要对应上
  Wordpress:
    depends_on
     - db
    image: Wordpress:5.6
    ports:
     - "83:83" # 端口映射
    restart: always
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: 123456
 
```
> [!warning] 注意
> 1. yml只能使用<span style="background:green;color:white">空格</span>,不能使用<span style="background:red;color:white">tab键</span>
> 2. 仅`environment`为单数,其他关键字皆为复数
### Healthcheck--(健康检查)
命令 
```bash
  --health-cmd "redis-cli ping" \
  --health-interval 30s \
  --health-timeout 10s \
  --health-retries 3 \
```
compose
```yaml
healthcheck:
  test: ["CMD", "redis-cli", "ping"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 0s   # 可选，默认 0s
```
🔔 注意：

- `test` 必须是一个**列表**（YAML 中用 `[...]` 或多行 `-`），不能直接写字符串。
- 对应 `--health-cmd "redis-cli ping"` → 拆成命令数组：`["CMD", "redis-cli", "ping"]`
- 其他参数直接映射：`interval` ← `--health-interval`，等等。