## ==[[git#推送到github上 | 推送到github上]]==

## git的alias
```bash
# 配置 git gl --> git config --global --list
git config --global alias.gl "config --global --list"

# 取消alias
git config --global --unset alias.gl

# 查看所用alias
# regexp 正则表达式
git config --get-regexp alias

```
## 无法正常显示中文
```bash
git config [ --global ] core.quotepath off
```
## eol(end of line)问题
- windows : crlf （Carriage Return + Line Feed ：回车+换行） **\r\n**
- linux & macos : lf （ Line Feed ：换行） **\n**
```bash
# windows
git config [ --global ] core.autoeol True

# linux & macos
git config [ --global ] core.autoeol input
```

---
# 一、克隆仓库的单一目录
## 简介
```bash
git --sparse --filter=blob:none <repository_url>
# 就已经下载下来了
git  sparse-checkout < set | add  > <dir_path>

# 将仓库整个克隆下来
git sparse-checkout disable

# 查看sparse-checkout状态和列表
git config core sparseCheckoutCone
git sparse-checkout list

# 查看
## 目录结构
git ls-files <dir_path>
## 文件内容
git show HEAD:<file_name>
### 间接查看图片
git show HEAD:<image.png> > <image.png>
```
## 1 克隆
### 格式
```bash
git clone --sparse --filter=blob:none <repository-url> 
cd <repository-directory>
```
### 案例
```bash
git clone --no-checkout --filter=blob:none https://github.com/Eikanya/Live2d-model.git 
cd Live2d-model
```
## 2. 稀疏
路径: <span style="font-size:32px;background-color:yellow">/Eikanya/Live2d-model/少女前线 girls Frontline/live2dnew/zb26_4703</span>
### 格式
```bash
git sparse-checkout init --cone
git sparse-checkout set <directory-path>
```
### 案例
```bash
git sparse-checkout init --cone 
git sparse-checkout set "少女前线 girls Frontline/live2dnew/zb26_4703"
```

> 📌 路径是仓库内的相对路径，区分大小写，包含空格或特殊字符时需用引号包裹。
## 5. 注意事项

- 使用`--filter=blob:none`选项可以减少克隆时的数据传输量，因为它会阻止Git下载不必要的文件内容。
- `git sparse-checkout init --cone`启用了锥形稀疏检出模式，这简化了多级目录结构的管理，使得操作更加直观。
## 6. 查看仓库中的其他目录
```bash
git ls-tree  [ -r --name-only]  HAED:<dir>
# 等效命令
git ls-files <dir>

# 树状结构展示
git ls-tree -rt HEAD:"少女前线 girls Frontline/live2dnew" | awk '{print $4}' | sed 's|/|_|g' | tree --fromfile .
```
### 查看某子目录结构(注意==:==)
```
git ls-tree HEAD:"少女前线 girls Frontline/live2dnew"
```
🔍 用于探索仓库结构，确认路径是否正确
### 查看某个文件的内容
```bash
git show HEAD:<file_name>

# 间接查看图片
git show HEAD:fastfetch/.config/fastfetch/katia.png > katia.png
```
## 6.同一仓库再次克隆其他目录
```
git sparse-checkout add "碧蓝航线 Azue Lane/Azue Lane(JP)/aijier_4"
```


> [!summary] 总结
> spares-checkout 的路径仓库**内**的路径 
>第一次用 `set`
> 后序使用 `add`

## --sparse 和 --no-checkout的区别
| 对比项        | `--sparse`                                  | `--no-checkout`                                  |
| ---------- | ------------------------------------------- | ------------------------------------------------ |
| 是否自动启用稀疏检出 | ✅ 是，自动初始化 `sparse-checkout`                 | ❌ 否，需手动执行 `init`                                 |
| 是否需要手动设置   | 较少，可直接 `set` 或 `add`                        | 需手动运行 `git sparse-checkout init`                 |
| 适用场景       | 明确只取部分目录                                    | 需自定义初始化流程或延迟配置                                   |
| 命令示例       | `git clone --sparse --filter=blob:none ...` | `git clone --no-checkout --filter=blob:none ...` |

---

# 二、浅克隆(shallow clone )
![[git.png]]

# 三、更新仓库
```bash
# 默认从名为"origin"的远程仓库获取
git fetch [ origin ] [ branch_name | -all ]

git pull origin main
```
- **`git fetch`** 是一个更保守的操作，它让你有机会在合并前检查远程仓库的更改。这对于避免不必要的合并冲突特别有用。
- **`git pull`** 则更加直接，适合那些希望快速同步最新更改并且对即将到来的更改有信心的人
### 多远程仓库场景

当你的本地仓库配置了多个远程仓库时，明确指定远程仓库变得尤为重要。例如，如果你添加了一个名为 `upstream` 的远程仓库，那么：

- 执行 `git fetch` 将仍然默认从 `origin` 获取更新。
- 如果你想从 `upstream` 获取更新，则需要执行 `git fetch upstream`。

在这种情况下，使用 `git fetch origin` 可以更清晰地表明你的意图是从 `origin` 远程仓库而不是其他任何远程仓库获取更新。

---
# 四、恢复与重置
## 恢复文件（被staged了才能就回来）
```bash
# 删除的
## 未commit
git restore -- <file_or_dir>

##  commit过的
git checkout -- <file_or_dir>


# 单个文件回退(回退版本的hash值)
git restore --source=<hash> <file_name>
```
## 重置版本(谨慎操作)
```bash
git reset [ --mixed ] <hash>
```

| 参数             | 作用(工作区; 暂存区。1：保存， 0：删除) |
| -------------- | ----------------------- |
| --mixed (混合默认) | 1; 0                    |
| --soft (软)     | 1；1                     |
| --hard (硬)     | 0；0                     |

---
# 查看差异以及是谁写的

| 命diff令                                                                       | 作用                                        |
| ---------------------------------------------------------------------------- | ----------------------------------------- |
| ==区域直接==                                                                     |                                           |
| git diff                                                                     | **working** vs **stage**                  |
| git diff HEAD                                                                | **working** & **stage** vs **local_repo** |
| git diff \[ --cached \| --stage ]                                            | **stage** vs **local_repo**               |
| ==提交之间==                                                                     |                                           |
| git diff <commit_hash1> <commit_hash2><br>git diff HEAD~ HEAD    (上个版本与这个版本) |                                           |
| ==分支之间==                                                                     |                                           |
| git diff \<branch1> \<branch2>                                               |                                           |
## blame
```bash
git blame <file>

# output resultPS D:\0repository\linux> git blame .\05-tools\git.md
# hash   author              date       time              content
^32c8bab (Klein-3000        2025-08-12 22:40:08 +0800   1) # 基础
^32c8bab (Klein-3000        2025-08-12 22:40:08 +0800   2) ## 基本配置

```
---
# 五、git rm 与直接删除的区别

| 操作                             | 效果(工作区; 本地仓库)                      |
| ------------------------------ | ---------------------------------- |
| 直接删除                           | 0; 1 (再次执行`git ad`d命令后,本地仓库的也会被删除) |
| git rm \[-r] \<files>          | 0; 0                               |
| git rm \[-r] --cached \<files> | 1; 0 (是`git add`的**反向**操作)         |
## 说明
直接删除
1. 已经被git track且commit的(既已经在本地仓库中),可以通过`git ls-files`查看文件,并通过`git Checkout -- <file_or_dir>`就回来
2. 没有被git track的就**直接没有**
---
# 六、.gitignore
![[gitignore.png]]
## 案例
![[gitignore1.png]]
## 可以去github中找(不行就ai)
[github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
## 相关命令
```bash
# 检查文件是否被忽略
git check-ignore -v <Files>
```
# 七、贮藏区(git stash)
将==暂存区==内==容贮==藏来
```bash
# 添加贮藏
git stash

# 贮藏列表
git stash list

# 弹出并删除贮藏
git stash pop

# 弹出但不删除
# 默认恢复最近的
git stash apply [ 'stash@{1}' ]

# 删除贮藏
# 默认删除最近的
git stash drop [ 'stash@{1}' ]
# 清空贮藏
git stash clear

# 查看贮藏的内容
git stash show -p
```
[git stash暂存，再也不怕老板让临时改 bug 啦_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1oX4y1E7WQ/?spm_id_from=333.337.search-card.all.click&vd_source=7cf858504e86c3660b73a6ea8f54d272)
# 八、修改提交记录
```bash
# 修改上一个提交(建议不使用参数)
git commit --amend [ -m <commit> ]

# 修改作者
git commit --amend --author="<name> <email>"

# 将文件添加到先前的提交
git commit --amend --no-edit
git push --force-with-lease origin master
```