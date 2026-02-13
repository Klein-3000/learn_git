# 基础
## 标准输入输出
### 类型
- 0 : 标准输**入**
- 1 : 标准输**出** 
- 2 : 标准==错误==输**出**

> [!attention] 注意
> 1.  `>`默认是`1>`
> 2.  stderr 需要显示指定, 既`2>`

| 概念       | 类比                     |
| -------- | ---------------------- |
| `stdout` | 主演说的话（正常剧情）            |
| `stderr` | 导演在旁边喊“NG！重来！”（错误提示）   |
| `>`      | 只录主演的声音                |
| `2>&1`   | 把导演的喊话也混进主演的录音轨道里，一起保存 |

### 案例
```shell
# 1. stdout
❯ ls > ls.err
## ls 的 stdout 到`ls.err`文件中
❯ cat ls.err
Lenovo
Lenovo.pub
PortForward
PortForward.pub
authorized_keys
config
known_hosts
known_hosts.old
local.config
ls.err
vagrant-ubuntu

# 2. stderr (`ls none-dir`: 查看名为`none-dir的目录,不存在,所以是stderr)
❯ ls none-dir > ls.err
ls: cannot access 'none-dir': No such file or directory
## 所以`ls.err`变为空
❯ cat ls.err

# 3. stdout & stderr
❯ [ls none-dir > ls.err 2>&1]{终端**没有**任何输出}
# [ls none-dir 2>&1 > ls.err]{终端会**stderr**}
## stderr 输出到 stdout 指定的文件, 既 `ls.err`
❯ cat ls.err
ls: cannot access 'none-dir': No such file or directory
 
```
**记忆技巧**：

- **“先文件，后合并”**：`> file 2>&1`(等同于`&> file`) → 全部进文件。
- **“先合并，后文件”**：`2>&1 > file` → 错误仍留终端，只有 stdout 进文件。
> [!summary] 总结
> `-` 解决的是“**数据从哪来/到哪去**”，而 `2>&1` 解决的是“**错误信息别丢掉**”
## `-`
使用 `-` 表示标准输入（stdin）或标准输出（stdout)