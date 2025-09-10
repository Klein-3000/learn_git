# 本地仓库
```bash
# 初始化仓库
git init

# 追踪文件
git add < . | file_or_dir>

# 取消追踪文件
git restore --staged < . | file_or_dir>

# 查看文件状态
git status

# 添加到本地仓库
git commit -m "<commit>"\

# 提交记录
git log [ --graph ]
# 判断一个文件是否被commit过
## 没输出就是没commit过,反之亦然
git log -- <file>

```
# 恢复与回退
## 恢复
```bash
git checkout < -- | bash > <file>
```
> [!attention] 区别和恢复条件
> # 区别
> -- : 上次提交
> bash : bash所指的提交
> 
> # 恢复条件
> 文件只有被**add** 命令跟踪,就一定可以恢复
## 回退
```bash
# 指定文件回退
git checkout <bash> <file>

# 全部回退
## 保留工作区,删除本地仓库
git reset [ --mixed ] <bash>
## 删除工作区和本地仓库
git reset --hard <bash>

```
> [!attention] 注意
> reset \[--mixed] 命令默认,**保留**工作区,**删除**本地仓库
> reset --hard  命令,**删除**工作区和本地仓库
## 操作记录(回溯)
```bash
git [reflog]{Reference Log : 参考日志}

<bash>             <commit>
d61a98c (HEAD -> master) HEAD@{0}: reset: moving to d61a98c4882
43447bc HEAD@{1}: commit: 32.txt 222
181edb6 HEAD@{2}: commit: 31.txt 222
d61a98c (HEAD -> master) HEAD@{3}: commit: add 31.txt 32.txt file
7da6669 HEAD@{4}: commit: fix 2.txt file
f6b236c HEAD@{5}: commit: modify 2.txt file
44c9b99 HEAD@{6}: commit: add .gitignore file
4de6886 HEAD@{7}: commit (initial): add 2.txt file

```
> [!attention] 注意
> 它**不会被推送**，只存在于你的本地仓库，相当于 Git 的“操作记录”或“撤销历史”

# 远程仓库
## 克隆(clone)
```bash
git clone [ --sparse --filter=blob:None] < url | ssh >
```
### 格式
> [!multi-column]
>> [!left] url
>> https://github.com/<UserName/Repository>\[.git]
 >优点 : 简单易懂
> 缺点 : 可能出现网络问题
> 
>> [!right] ssh
>> gihub.com:<UserName/Repository>\[.git]
>> 优点 : 可以解决网络问题
>> 缺点 : 配置较为复杂,需要再github中配置公钥
## 推送(push)
```bash
# 查看远程仓库地址
git remote -v

# 增删改远程仓库地址
git remote [ add | set | set-url ] origin < url | ssh >

# 推送
git push [-u] origin master[:main]
```
> [!attention] 注意
> 克隆(clone)仓库时,remote就是克隆所使用的"url" 或 "ssh"
> origin ： 将远程仓库地址复制给"origin"
### 配置公钥
#### 生成公私钥
```bash
ssh-keygen
 
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\Lenovo/.ssh/id_ed25519): [<--]{生成公私钥的名字。自定义名字时，则公私钥生成在**当前**的目录中}
Enter passphrase (empty for no passphrase): [<--]{使用这对公私钥时,需要输入的密码。直接回车，则密码为**空**}
Enter same passphrase again: [<--]{确认公私钥的密码}
Your identification has been saved in test
Your public key has been saved in test.pub
The key fingerprint is:
SHA256:aTfVsVRW8trQsWwCcWMnz5l1yDRHez+5Aa1j3smQlMw lenovo@LAPTOP-HS0L4TOD
The key's randomart image is:
+--[ED25519 256]--+
|           o.B**X|
|            *o%XO|
|            .E+@+|
|         . .. *++|
|        S o  *.+o|
|       . . .o = =|
|             . = |
|                 |
|                 |
+----[SHA256]-----+
```
#### 配置ssh
配置目录 
- windows C:\Users\\\<UserName>\.ssh
- linux /home/\<UserName>/.ssh
配置文件
```c
Host [github.com]{主机名, HostName关键字对应的**值**, 用于**缩写**主机地址}
HostName [github.com]{主机地址,可以是**IP地址**,也可以是**主机名**}
[PreferredAuthentications publickey]{**不太重要**, 指定ssh链接时优先使用哪种认证方式, 默认按照一定**认证顺序依次认证**}
IdentityFile ~/.ssh/<private_key>
```
> [!attention] 注意
> config 配置时
> 关键字和值**大小写敏感**
> 大小不对,会导致ssh连接失败

