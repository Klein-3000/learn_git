# 多阶段构建与 scratch 镜像
> [!attention] 关键
> 1. `FROM ... as DEV`
> 2. ` COPY --from DEV`
> 3. scratch 镜像的限制：无 shell、无系统库、无用户，仅适合==静态编译==的程序（Go、Rust 等），若运行动态链接程序（如 Python/Java），需改用 alpine（轻量 Linux 镜像）；
## main.go
```golang
package main

import "fmt"

func main(){
	fmt.Println("Hello World!")
}

```

## Dockerfile
```Dockerfile
# 阶段1：构建阶段（基于完整的 Go 编译环境）
FROM golang:1.21 as build

WORKDIR /src
COPY main.go ./

RUN go build -o /bin/hello ./main.go

# 阶段2：运行阶段（基于空镜像 scratch）
FROM scratch
# 直接从 0 号阶段拷贝，不用 as
# COPY --from=0 /bin/hello /bin/hello
COPY --from=build /bin/hello /bin/hello
CMD ["/bin/hello"]
```

|写法|含义|能用吗？|
|---|---|---|
|`COPY --from=build`|从本 Dockerfile 中名为`build`的阶段拷贝|✅ 推荐|
|`COPY --from=0`|从本 Dockerfile 第 0 号阶段拷贝|✅ 可以|
|`COPY --from=golang:1.21`|从 Docker Hub 官方镜像拉取|❌ 不是你想要的|====