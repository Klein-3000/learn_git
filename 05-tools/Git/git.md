---
tags:
  - tools
Type: learn
---
# 基础
## 基础知识
💡 Git 中的对象类型：
- `blob`：文件内容
- `tree`：目录结构（指向 blob 或子 tree）
- `commit`：提交信息（指向一个 tree）
- `tag`：标签
## 基本配置
```bash
# 配置
git config --global user.name "your name"
git config --global user.email "your email"
# 用于https push时,自动认证密码(不安全,明文存储)
git config --global credentials.helper <password>

# 查看
git config --global user.name 
git config --global user.email 
```

## master操作
```bash
# 初始化
git init

# 状态
git status

# 添加到"暂存"(支持正则 * : 所有文件)
git add <file_name>
# 排除部分文件或目录
git add . ':(exclude)fileName'

# 移除~
git rm --cache <file>

# 提交(配置了个人信息才能提交)
git commit [ -m "commit" ]
# 修改提交(编辑器修改提交信息)
git commit --amend

# 查看提交日志(减少"date"行的输出)
git log [file_name] [--pretty=short]
# 查看文件前后差异
git log -p [file_name]
# 以图表形式查看分支(git merge --no-ff branch-name)
git log --graph
# 查看在git仓库执行过的操作
git reflog

# 查看当前暂存区与工作树的差别
# 默认(未进行任何修改)与暂存区一致
# "HEAD" : 查看最新提交和工作树的差别
git diff [HEAD]
```

## branch操作
```bash
# 显示分支预览表
git branch
# 修改主分支名
git branch -m main
# 创建分支，但不进入
git branch -b <新分支> <原分支(默认为"master"或"main")>

# 创建并进入分支
git checkout -b <branch-name>

# 删除分支
# 已合并的分支
git branch -d <branch-name>
# 未合并的分支
git branch -D <branch-name> 

# 切换
# git checkout - 既 cd -
git checkout [ master | branch-name | -]

# 合并(在master中进行)
# --no-ff : git log --graph才会显示分支
git merge --no-ff <branch-name>
# 解决冲突(打开有冲突的文件,手动修改)
<<<<<<< HEAD
feature-a   (当前的内容)
=======     (分界线)
feature-b   (要合并的内容)
>>>>>>> feature-b

```
## 回溯操作
```bash
git reset --hard hash值
```
## 更改历史(哪个分支提交错误,就在哪个分支修改)
因此，我们来更改历史。将“Fix typo"修正的内容与之前一次的提交合并，在历史记录中合并为一次完美的提交。为此，我们要用到 gitrebase命令。
```bash
# 是 ~ 波浪号
# 不是 - 减号 
git rebase -i HEAD~2
# 将第二个"pick"修改为"fixup"
pick c35b0b4 add feature-c
pick 3488555 fix typo 

pick c35b0b4 add feature-c
fixup 3488555 fix typo 

```
用上述方式执行 git rebase 命令，可以选定当前分支中包含 HEAD(最新提交)在内的**两个**最新历史记录为对象，并在编辑器中打开。

---
# 推送到github上
## ssh
```bash
git remote add origin git@github.com:your-name/repository
git branch -M main
git push -u origin main
```
> [!summary] 总结
> 1. 在github添加ssh**公钥**
> 2. 配置ssh的.config文件
> 3. 添加远程仓库
### ssh的.config文件配置
```bash
Host github.com
	HostName github.com
	PreferredAuthentications publickey
	IdentityFile ~/.ssh/<private_key>	

Host myserver
	...

```
### 拓展
```shell
# 自己的服务器
git clone <user@IP>[:]{}/path/to/repo
# 或
git clone myserver[:]{}/path/to/repo
# 或 (了解即可)
git clone ssh://<user@IP>/path/to/repo
git clone ssh://myserver/path/to/repo
 
```
**非裸仓库默认不允许 push 到它的当前分支**（会报错 "refusing to update checked out branch"）。所以推荐用裸仓库作为中心仓库
#### 裸仓库创建
```shell
# 从零开始
git init --bare

# 从旧仓库创建
git clone --bare <old-repo> <bare-repo>
 
```

## https(每次都要输入账号和密码?)
```bash
git remote add origin https://github.com/account/repository.git
eg
git remote add origin https://github.com/Klein-3000/learn_git.git

# master中
git push -u <远程主机> <本地分支>:<远程分支>
eg
git push -u origin master:main

```
## token
```bash
git remote add origin https://[oauth2:]{可选}<token>[@]{注意有**@**符号}github.com/account/repository.git
eg
git remote add origin https://github.com/Klein-3000/learn_git.git

# master中
git push -u <远程主机> <本地分支>:<远程分支>
eg
git push -u origin master:main

```
---
# 其他
## 检查LF(linux & macOS) 与 CRLF(windows)问题
```bash
git ls-files --eol | grep -i "crlf"
```

# 英文单词
1. master 主
2. branch 分支
3. checkout 结账
4. feature 特征
5. merge 合并
6. graph 图
7. fix 修复
8. conflict 冲突
9. pick 选择
10. fixup 修正
11. bare : 裸露的

> [!summary] 对比
> git branch : pwd  显示在哪个分支上
> git checkout \[branch]  | cd & touch 创建分支

