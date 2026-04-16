---
language: golang
type: tools
function: 文件备份
---
官网 : https://restic.net
[restic 文档 — restic 0.18.1 文献](https://restic.readthedocs.io/en/stable/)


![[(Backup)Restic-仓库结构#目录结构]]
# 一、初始化
```shell
# 本地
restic [-r]{可简写为**r**}epo /path/to/backup-repo [init]{初始化}

# 远程
restic [-r]{可简写为**r**}epo sftp:[User@ip]{支持ssh主机名解析}:/path/to/backup-repo init

 
```
# 二、备份
```shell
restic  [backup]{备份}  [/path/to/src1]{推荐使用**相对路径**}  [--dry-run -vvv]{真正备份先运行} [--tag <tag> ]
 
```
> [!note] 笔记
> 推荐使用**相对路径**, 一般就是备份某一个目录的**内容**,而不是想要还原原本的**路径和内容**
> `backup`可以同时指定多个目录
>> [!note] 其他参数
>> `--exclude '正则'` : 排除不要备份的(backup子命令特有)
>> `--Include '正则'` : 只恢复指定的备份(restore子命令特有)

[[#6.2 stats]] 
# 三、快照管理
```shell
# 查看
restic  snapshots

# 修剪
restic  forget --keep-last [1]{指定保留最后几个快照} --prune [--dry-run -vvv]

# 删除
restic  forget < latest | snapshot_id >
 
```
>[!attention] 注意
>`latest` 有相同内容的 snapshot 时, 删除**旧的** snapshot 
>`snapshot_id` 才能**精确**删除不想要的 snapshot

# 四、查看与恢复
## 4.1 find & diff
```
# 查找文件或目录
# 默认精确匹配
restic find [-l]{类似`ls -l`的功能} <key_world>

# 查看新增了哪些备份文件 ( 从 old 到 new 的变化)
restic diff  <old> <new>

```
### diff 中的符合含义

|符号|含义|说明|
|:--|:--|:--|
|`+`|Added (新增)|文件在快照 B 中存在，但在快照 A 中不存在。|
|`-`|Removed (删除)|文件在快照 A 中存在，但在快照 B 中消失了。|
|`M`|Modified (修改)|文件内容发生了变化（最常用）。|
|`U`|Updated (元数据更新)|文件内容没变，但元数据变了（如权限 `chmod`、时间戳 `touch`）。  <br>_注：需配合 `--metadata` flag 才能看到详细差异，否则可能不显示或仅提示。_|
|`T`|Type Changed (类型变更)|文件类型变了（例如：普通文件变成了符号链接，或目录变成了文件）。|
|`?`|Bitrot Detected (数据腐烂)|高危警告。文件元数据完全一致，但内容哈希值变了。这通常意味着磁盘位翻转或静默数据损坏。|

## 4.2 restore

```shell
# 挂载查看 -- win 版本 不支持
restic mount /path/to/mount_dir < latest | snapshot_id >

# 普通查看
restic ls [-l]{查看详细信息} < latest | snapshots_id >

# 恢复
restic restore < latest | snapshots_id > --target /path/to/[dst]{一般不写dst}

备份时 D:\src
还原是 
	- D:\ --> D:\src 
	- D:\src --> D:\src\[src]{restic恢复的目录}
	   
```
>[!attention] 注意
>`--target` 指定路径**不存**在时,自动**递归**创建`
>`--exclude-xattr 'security.selinux'` : 在有 selinux 的 linux 上恢复时使用
## 4.3 dump
它与 `restore` 的核心区别在于：

- **`restore`**：将文件解压并还原到磁盘上的具体目录，恢复完整的文件系统结构（包括权限、时间戳等）。
- **`dump`**：将文件内容直接输出到**标准输出 (stdout)** 或打包成 **`.tar` / `.zip`** 文件。它不关心目标磁盘的权限结构，非常适合**临时查看文件内容**、**管道传输**或**提取特定文件夹而不污染当前目录**。
```
# 语法: restic dump <快照ID> <文件路径>

# 1. 查看单个文件内容
# stdout
restic dump <snapshots_id> [<path/to/file>]{`restic ls`输出的路径} 
# 1.1 查看文本文件
restic dump <snapshots_id> [<path/to/file>]{`restic ls`输出的路径} | cat
# 1.2 查看图片
restic dump <snapshots_id> [<path/to/file>]{`restic ls`输出的路径} | mpv -

# 2. 提取整个文件夹为Tar包(默认)
restic dump <snapshots> <path/to/dir> [-a zip ]{指定其他归档类型,默认为 **tar**} [-t]{target} archive.tar

# 3. 提取整个快照
restic dump <snapshots> [/]{表示根目录} -t archive.tar

```
### dump VS restore

|特性|`restic restore`|`restic dump`|
|:--|:--|:--|
|输出形式|还原为普通文件和文件夹|输出为文件流、`.tar` 或 `.zip`|
|权限处理|保留原始权限 (可能导致跨机器无法访问)|忽略权限 (打包进归档，无权限问题)|
|适用场景|灾难恢复、完整回滚系统|临时取文件、提取部分数据、跨平台传输|
|速度|需要写入大量小文件，较慢|流式写入大文件，通常较快|
|路径结构|严格还原目录树|可灵活调整 (通过 `snapshot:subfolder` 语法)|
# 五、仓库之间的协同
```shell
restic -r [/dest/restic-repo]{目的仓库(新的)} copy [latest | snapshots_id]{默认复制整个**仓库**} --from-repo [/src/restic-repo]{源仓库(旧的)} -vvv
# 传输方向
/src/restic-repo --> /dest/restic-repo
 
```

# 六、仓库维护
## 6.1 健康检查
```shell
# 查看仓库大小
restic stats [--mode raw-data ]

# 数据完整性校验
restic check [--read-data]
 
```
## 6.2 stats
```shell
repository 79404b4e opened (version 2, compression level auto)
[0:00] 100.00%  1 / 1 index files loaded
scanning...
Stats in raw-data mode:
     Snapshots processed:  [2]{快照个数}
        Total Blob Count:  752
 Total Uncompressed Size:  640.215 MiB
              Total Size:  [579.773 MiB]{仓库总大小}
    Compression Progress:  100.00%
       Compression Ratio:  [1.10x]{压缩比}
Compression Space Saving:  9.44%
 
```
> [!attention] 注意
> `stats` 是还原后的大小,不是仓库本身的大小

## 6.3 密码管理
```
# 列出密码列表
restic key list

# 增加和删除密码
restic key add
restic key remote <key_id>

# 增加并删除旧密码
restic key passwd
```

## 6.4 tag管理
```
# 添加
restic tag --add <flags> <snapshots_id>

# 删除
restic tag --remove <flags> <snapshots_id>

# 设置
restic tag --set <flags1,flags2...> <snapshots_id>
```
> [!attention] 注意
> 每次进行`tag` 修改时, `snapshots_id` 都会==改变==
## 6.5 rewrite(删除仓库中的敏感文件)
### 作用
它的核心作用是：**在不重新备份数据的前提下，修改现有快照的内容或元数据**。它会读取旧快照，排除掉你指定的文件（或应用其他修改），然后创建一个**新的快照**。

最关键的是，Restic 具有**数据去重**功能。如果新快照中的大部分文件与旧快照相同，Restic **不会**重新上传或存储这些数据块，只是创建新的元数据引用。因此，这个操作通常非常快且节省空间。
### 推荐流程
1. rewrite -n 
2. rewrite [--forget]{仅删除对应的snapshots}
3. prune(彻底清除数据块) 
4. find (检查文件是否真的删除了)
### 命令
```
# 语法: restic rewrite [snapshots]{可选,默认为全部snapshots} <action>

# 
restic rewrite --exclude '正则' [-n]
```
### forget参数

![[Restic_rewrite1.png]]
![[Restic_rewrite2.png]]

|特性|不使用 `--forget`|使用 `--forget`|
|:--|:--|:--|
|旧快照状态|保留 (依然存在)|删除 (消失)|
|新快照标签|自动添加 `rewrite`|不添加 `rewrite` (保持原标签)|
|设计意图|审计/测试：明确区分原版和改版，方便回滚。|替换/清理：彻底替换旧数据，保持仓库整洁。|
|后续操作|需要手动删除旧快照或带 `rewrite` 的新快照。|通常紧接着运行 `prune` 来释放空间。|
# 七、自动化
> [!note] 环境变量
> `$env:restic_repository` : 设置仓库路径,后续 restic 命令不需要使用`-r`指定仓库
> `$env:restic_from_repository` : 设置仓库路径,后续 restic 命令不需要使用`-from-repo`指定仓库
> `$env:restic_password`设置密码,与restic交互时,不用每次都需要输入密码
> `$env:restic_password_file`:指定密码文件,更安全
> `$env:restic_cache_dir`: 设置缓存目录
### 案例
```shell
`$env:restic_password_file='C:\restic-passwd'

# restic-passwd文件内容
[2v23]{仓库的密码}
 
```
## 其他命令(portable)
### restic-Browser
[emuell/restic-browser：用于浏览和恢复restic备份仓库的图形界面。](https://github.com/emuell/restic-browser)
### resticProfile
[CreativeProjects/resticProfile：配置配置文件管理器和restic备份调度器](https://github.com/creativeprojects/resticprofile/)
# 单词
1. snapshot : 快照
2. forget : 忘记
