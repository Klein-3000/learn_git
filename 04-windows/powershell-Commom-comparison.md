# 对照表
## 配置文件

| bash    | powershell |
| ------- | ---------- |
| ~/.bash | $profile   |
## 命令

| bash     | powershell             |
| -------- | ---------------------- |
| grep     | select-string, findstr |
| wc -l    | ().Count               |
| cat      | cat ，type              |
| ln,touch | new-item               |
# smb服务相关的
## cmd
![[cmd#smb服务]]
## pwsh
```shell
# 建立链接
## 一次性链接(不推荐)

## 长时间链接
new-sambapping [ -LocalPath ] "盘符" [ -RemotePath ] "\\server_addr[@port]\share_dir" credential $cred

# 断开链接
remove-sambapping [ -LocalPath ] "盘符" [ -Force ]

# 查看链接
get-sambapping
 
```
> [!attention] 注意
> 1. 盘符后面要加"==:=="

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
# ln和new-item(从左往右看 ln--->origin)
箭头射中==目标(target)==
## ln
```bash
# 默认为硬链接
ln [ -s ] <full/path/old,link> <full/path/new,target>
```
## new-itme
```powershell
# SymboLiclink 符号链接
New-Item -ItemType SymbolicLink  -Target <Target> -Path <Link>
# HardLink 硬链接
New-Item -ItemType HardLink  -Target <Target> -Path <Link>
```
## 📌 硬链接 vs 符号链接 对比

|特性|硬链接 (Hard Link)|符号链接 (Symbolic Link)|
|---|---|---|
|跨盘符|❌ 不支持|✅ 支持|
|链接目录|❌ 不支持|✅ 支持 (`/D`)|
|`ls` 显示|普通文件（无 `l`）|有 `l` 标志|
|目标删除后|仍可访问（数据保留）|变成“悬空链接”|
|占用空间|不额外占用|不额外占用|
|文件系统限制|仅 NTFS|仅 NTFS|

# 重命名
支持添加前缀或后缀
```powershell
# 前缀(prefix)
<object> | rename-item -newname { "prefix" + $_.name }

# 后缀(suffix)--保持原有的拓展名
<object> | rename-item -newname { $_.basename + "suffix" + $_.extension }

# 正则
<object> | rename-item -newname { $_.name -replace '<old_string>', '<new_string>'}
```

# 用户管理
```powershell
## 添加
New-LocalUser -name <UserName> [-Password <Password>]

## 删除
Remote-local -name <UserName>

## 启用与禁用
Enable-LocalUser -name <UserName>
Disable-LocalUser -name <UserName>

## 密码
Set-LocalUser -name <UserName> -Password (Read-host -AsSecureString) -PasswordNeverExpire $true

## 查看
### 用户列表
get-LocalUser

### 用户详细信息
get-LocalUser -name <UserName> | Format-list *
```
# 用户管理
```powershell
## 查看组列表
get-LocalGroup

## 查看组成员
get-LocalGroupMember -Group -name <GroupName>
## 加入组
Add-LocalGroupMember -Group <GroupName> -Member <UserName>

## 退出组
Remove-LocalGroupMember -Group <GroupName> -Member <UserName>

```
# 历史命令
```
# 历史命令文件的保存路径
(Get-PSReadLineOption).HistorySavePath

# 修改保存的路径
Set-PSReadLineOption -HistorySavePath "$HOME/my_history.txt"
```
