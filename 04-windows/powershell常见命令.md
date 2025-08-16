# 对照表
## 配置文件

| bash    | powershell |
| ------- | ---------- |
| ~/.bash | $profile   |



## 命令

| bash  | powershell    |
| ----- | ------------- |
| grep  | select-string |
| wc -l | ().Count      |
| cat   | cat ，type     |

# select-string（grep）
```
# 搜索文件中包含 "error" 的行
Get-Content logfile.txt | Select-String "error"

# 更简洁写法
Select-String "error" logfile.txt

# 忽略大小写
Select-String "error" *.log -CaseSensitive:$false

# 显示行号
Select-String "error" logfile.txt | Format-List

# 递归搜索
Select-String "error" -Path *.log -Recurse

# 使用正则表达式
Select-String "\berror\b" *.log

# 统计匹配行数
(Select-String "error" *.log).Count
```
# get-childitme (ls)
```
# 列出当前目录下的文件和文件夹
ls

# 列出指定目录的内容
ls D:\Documents

# 列出所有文件（包括隐藏文件）
ls -Force

# 只列出文件（不显示目录）
ls -File

# 只列出目录（不显示文件）
ls -Directory

# 递归列出所有子目录内容
ls -Recurse

# 按时间排序（最新在前）
ls | Sort-Object LastWriteTime -Descending

# 按大小排序（从大到小）
ls | Sort-Object Length -Descending
```
# cat
```cmd
# 展示全部
cat <file>

# 前几行
cat -haed <file>

# 后几行
cat -tail <file>
```