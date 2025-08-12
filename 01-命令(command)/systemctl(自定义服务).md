# 目录
<span style="background-color:yellow;font-size:40px">/etc/systemd/system</span>
<span style="background-color:yellow;font-size:40px">/usr/lib/systemd/system</span>
# 字段

| 字段                                      | 含义                                     |
| --------------------------------------- | -------------------------------------- |
| Description                             | 当前服务的简单描述                              |
| Documentation                           | 给出文档位置                                 |
| After                                   | 表示该服务应该在某一个服务之==后==启动                  |
| Before                                  | 表示该服务应该在某一个服务之==前==启动                  |
| Wants                                   | 弱依赖(有更好,没有就算了)                         |
| Requires                                | 强依赖(有你才有我)                             |
| service                                 |                                        |
| Type                                    | 类型(默认为simple : ExecStart启动的进程为==主进程==) |
| ExecStart<br>ExecReload<br>ExecStop<br> | 可以是可执行程序,系统命令,shell脚本                  |
| RemainAferExit                          | 为"yes",表示进程退出后,服务仍然保持运行                |

```shell
[Unit]
Description
```