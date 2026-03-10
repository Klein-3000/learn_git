# 一、tag
```shell
# 增
## 创建轻量标签--不常用
git tag <tag>
## 创建附注标签
git tag [-a]{add} <tag> -m < message >
## 给历史提交打标签
git tag -a <tag> [< hash >]{历史提交的哈希值} -m  < message >

# 删
## 删除本地
git tag -d <tag>
## 删除远程
git push origin :refs/tags/<tag>
#(简化版)
git push --delete origin <tag>
# 查
## 查看有哪些标签
git tag
## 查看附注标签的信息
git tag [-n1]{查看前1的信息. -n99 : 查看附注信息的前**99**行信息}
## 查看指定标签的附注标签的信息
git tag -l "<正则表达式>" -n
 
```
## 标签推送与获取
```shell
# 推送
# 推送标签到远程仓库
## 默认`git push`不会推送标签
git push origin <tag>
## 推送所有标签
git push origin --tags

# 获取
git fetch origin --tags
 
```
## 案例 -- 基于标签开发,应新建分支
```shell
git checkout -b [hotfix-from-< tag >]{建议采用这种命名格式} <tag>
 
```

---

# 二、导出对应标签的版本(archive)
## 本地
```shell
# windows
git archive  -o </path/to/file> <tag | commit_hash > [<dir-prefix>]

# linux
git archive  -o </path/to/file> <tag | commit_hash> [<dir-prefix>]
 
```
> [!attention] 注意
> 1. 只支持`tar`,`zip`,`tar.gz`
> 2. 默认为`tar`
> 3. `zip`需要明确,既`-o archive.zip`
> 4. 其他后缀名一律为`tar`,既`-o archive.rar`只能生成一个名为`archive.rar`的`tar`文件

> [!note] `dir-prefix`
> 1. `git archive`默认时全部归档
> 2. `repo/{docs,src}`只想要`repo/docs`则`-o archive.zip <hash> docs` 
> 3. 可以精确到当个文件, 既`-o archive.zip <hash> docs/1.doc`
## 远程
```shell
git archive --remote=<远程仓库URL> <tag | commit_hash > | tar -x -C ./output_dir
 
```
### 案例
```shell
# 导出远程仓库中 tag 为`v1.0.0` 版本,并自动解压
git archive --remote=git@gitee.com:verthandi-v/dangdang v1.0.0 | tar -x -C D:\downloads
 
```

✅ 优点：

- 只包含该版本的**源代码文件**（不包含 `.git` 目录）
- 干净、轻量、适合交付
- 自动排除 `.gitignore` 中忽略的文件
### 💡 补充：如果同事也需要能继续开发（含 Git 历史）

那你可以创建一个**仅包含到 v1.0.1 的浅层仓库**：
```shell
git clone --single-branch --branch v1.0.1 --depth 1 file://$(pwd) ../project-v1.0.1
cd ../project-v1.0.1
```
# 三、停止跟踪与重新跟踪(skip)
```shell
# 停止跟踪
git update-index --skip-worktree < file >
# 重新跟踪
git update-index --no-skip-worktree < file >
# 查看已经停止跟踪的文件
git cat-file [ | grep ^S ]{过滤出停止跟踪的文件}

```
## 🔍 状态标记说明
- git ls-files -v 的首字母含义：
- h = skip-worktree（隐藏状态，但实际显示为 S）
- S = skip-worktree（Git 2.25+ 版本中明确显示为 S）
- H = assume-unchanged
-  '（空格）= 正常追踪的文件
- 💡 注意：在较新版本的 Git 中，skip-worktree 明确显示为 S，而 assume-unchanged 显示为 h。
## ⚠️ 注意事项
- `skip-worktree` vs `assume-unchanged`：
- `--skip-worktree`：告诉 Git 忽略工作区对该文件的修改（即使你修改了也不会显示为 modified）
- `--assume-unchanged`：告诉 Git 假设文件未被修改（主要用于性能优化）
- 团队协作：`skip-worktree` 设置是**本地**的，**不会**被推送到远程仓库，其他协作者看不到这个设置。
- 配置文件场景：通常用于==本地配置文件==（如 .env.local、database.yml），避免误提交敏感信息。

---
# 四、 复用其他仓库的代码
## 比较

| 名字                                          | 区别                |
| ------------------------------------------- | ----------------- |
| subtree                                     | 复用其他仓库的代码         |
| [[git进阶操作#九、添加模块仓库(submodule)\| submodule]] | 将其他仓库**完整**的嵌入到本地 |
## 命令
```shell
git subtree [add]{添加子树(首次添加)}/[pull]{来取子树更新(后续更新)} [--prefix < prefix >]{子树在本地仓库中的路劲(**文件夹**名称)} [< repository >]{外部仓库地址(URL)} [< ref >]{外部仓库的分支或标签名称}
 
```

