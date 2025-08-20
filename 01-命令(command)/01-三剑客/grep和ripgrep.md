# parameter
- -n : 显示行号
- -w : 精确匹配
- 上下文显示
	- -C 2 "info" \<file> : 显示匹配行**前后**各两行 content : 内容
	- -A 2 "warn" \<file> : 显示匹配行**行后**两行  after : 之后
	- -B 2 "err"   \<file> : 显示匹配行**行前**两行   before : 之前
- -c "info" \<file> : 统计出现的次数                   Count : 数
- -i "info" \<file> : 忽略大小写                          ignore : 忽略

# technique
## 就不会显示grep本身
```bash
ps -ef | grep [s]mb
```
## 查看简洁的配置
```bash
# -E : 拓展正则
# -v : 取反
grep -Ev "#|^$" <ConfigFile>
```

# ripgrep
```bash
# 在当前目录及其子目录下查找包含"example"的所有文件。
rg example

```
[[#parameter | parameter 与 grep 相同的部分]]

## 特有的参数
```bash
# 查找指定的文件
rg --type py example
# 或使用拓展名
rg -g ".py" example
```