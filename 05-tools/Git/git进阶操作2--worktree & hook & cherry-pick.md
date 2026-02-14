# 一、worktree
## worktree 基本用法
```shell
# 1. 添加
# worktreeName 推荐命名格式
# repoName-branch
## 基于现有分支
git worktree add [<path/to/directory(worktreeName)>]{常见取值 **../仓库根目录**, 使其与当前仓库**并列**} <branch>
## 新建分支
git worktree add -b <branch> <path/to/directory(worktreeName)>
## 基于远程分支
git worktree add -b <branch> <path/to/directory(worktreeName)> origin/<remote-branch>

# 2. 查看
git worktree list
❯ git worktree list
D:/Users/Lenovo/Pictures/Saved Pictures/[yellow]{worktreeName}       c295c76 [master]
D:/Users/Lenovo/Pictures/Saved Pictures/[yellow-hide]{worktreeName}  e7442ae [hide]

# 3. 删除(修剪)
git worktree remove <worktreeName>

# 4. 移到位置 
git worktree move <worktreeName> <New-path>

# 5. 删除无效的 工作树
git worktree prune [ --dry-run | -n ]
 
```
> [!attention] 注意
> 1. `git worktree add` : 在 .git **目录**中创建 **worktree** 目录来管理worktree
> 2. `worktreeRope` 仓库中只有 [.git]{gitdir: D:/Users/Lenovo/Pictures/Saved Pictures/yellow/.git/worktrees/yellow-hide} **文件**记录它的来历
> 3. 在 `branch-worktree` 中无法`checkout`析出其他分支

## 与sparse 结合
```shell
# 1. worktree
git worktree add ../yellow-hide hide

# 2. sparse
cd ../yellow-hide
git sparse-checkout init
git sparse-checkout < add | set > <subdirectory>

# 查看
## 有哪些目录
git ls-tree --name-only -d [hide]{当前的分支名}
git sparse-checkout list

# 3. checkout
git checkout [hide]{当前的分支名}

 
```
> [!attention] 注意
> `sparse-checkout` 基于目录管理,所以仓库根目录下的**文件**==全部==都会 `checkout` 出来
# 二、hook
## 目录结构
```shell
.git/hooks
	├── applypatch-msg.sample
    ├── commit-msg.sample
    ├── fsmonitor-watchman.sample
    ├── post-update.sample
    ├── pre-applypatch.sample
    ├── pre-commit.sample
    ├── pre-merge-commit.sample
    ├── pre-push.sample
    ├── pre-rebase.sample
    ├── pre-receive.sample
    ├── prepare-commit-msg.sample
    ├── push-to-checkout.sample
    ├── sendemail-validate.sample
    └── update.sample
 
```
## 状态码
- exit 1 ：error --> **不能**通过检测,也==不放行==
- exit 0 ： warning --> **不能**通过检测,但==放行==

# cherry-pick
```shell
# 当前处在 commit1
git cherry-pick <commit2>
 
```
> [!note] 笔记
> 1. `cherry-pick` 将commit2, 添加到 commit1 后
> 2. `cherry-pick` 依次摘一个

# 单词
hook ： 钩子
sample ： 样本
cherry : 樱桃,车厘子
pick : 选择