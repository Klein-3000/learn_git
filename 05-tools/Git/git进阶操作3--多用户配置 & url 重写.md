# 多用户配置
```shell
# ~/.gitconfig
[includeif "gitdir:<path/to/personal-project>"]
	path = ~/.personal.gitconfig
 
```

`personal-project` 目录下所有 git 仓库只会使用 `.personal.gitconfig`
## 效果
```shell
~/
├── .gitconfig                     # 全局默认配置（fallback）
├── .personal.gitconfig            # 个人项目专用配置（如 name/email 等）
├── company-project/               # 公司项目目录（未被 includeif 匹配）
│   ├── repo1/
│   │   └── .git/
│   │       └── config             # ← 继承 ~/.gitconfig
│   └── repo2/
│       └── .git/
│           └── config             # ← 继承 ~/.gitconfig
│
└── personal-project/              # 个人项目目录（被 includeif 匹配）
    ├── repo3/
    │   └── .git/
    │       └── config             # ← 继承 ~/.gitconfig + ~/.personal.gitconfig
    └── repo4/
        └── .git/
            └── config             # ← 继承 ~/.gitconfig + ~/.personal.gitconfig
 
```
## 案例
```shell
# 多用户配置
[includeif "gitdir:D:/Users/Lenovo/Pictures/Saved Pictures/yellow/"]
    path = ~/.config/git/verthandi.gitconfig
    # [相对路径写法]{与**.gitconfig**或**~/.config/git/config** 路径相对}
    # path = verthandi.config

 
```
> [!attention] 注意
> 1. windows 必须使用 `/`
> 2. 路径最后必须是`/`,既`yellow/`有效,`yellow`无效
> 3. 只要配置 `includeif` 受影响的仓库**立即**(即使已经使用过其他配置commit)生效
> 4. `path` 可以绝对路径或相对路径
## 检查是否生效
```shell
# personal-project/repo
git config --show-origin user.name

# or
git config --list
 
```

# url 重写
## 配置
```shell
[url "git@github.com:"]
	insteadOf = "gh[:]{推荐使用这种格式}"
[url "git@gitee.com:"]
	insteadOf = "ge:"

# 纯文本前缀匹配
[url "git@github.com:"]
	insteadOf = "FromGithub"
	

 
```
> [!attention] 📌 核心原则
> `insteadOf` 是**纯文本**==前缀==匹配和替换，不是语义解析。
> - 是 **前缀匹配（prefix match）**
> - **只替换一次（因为只看开头）**
> - **不递归、不全局、不处理中间或结尾**
## 测试
```shell
git ls-remote gh:[Klein-3000/my-project.git]{**必须**是已经**存在**的仓库}
# result
9de7f8104dcb9234d0abc663b263263c2eade8ce        HEAD
9de7f8104dcb9234d0abc663b263263c2eade8ce        refs/heads/main
 
```
## 效果(作用)
```shell
git clone git@github.com:Klein-3000/my-project.git

# 等价于
git clone gh:Klein-3000/my-project.git

# 纯文本前缀匹配
git clone [FromGithub]{git@github.com:}Klein-3000/my-project.git

 
```