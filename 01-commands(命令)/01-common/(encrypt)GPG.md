# gpg

## Generate key pair
```shell
# generate
##  full
gpg --full-generate-key
> [algorithm]{选择加密算法}
>
> 有效期
> [Rule name]{角色名}
> [Email address]{邮箱地址}
> [comment]{评论, 可为空}

## default
gpg --generate-key

## quick generate
gpg --quick-generate-key <email>

# list
## public key
gpg [ -k | --list-keys ]
## secret key
gpg [ -K | --list-secret-keys]
```
## Management secret key pair
```shell
# export
gpg --export [ -a | --armor]{可选，生成ascii码的公钥} -r < gpg_user > [>]{重定向符} [public.key]{重定向为该文件}

# import
gpg --import [Public.key]{导入公钥}

# edit
gpg --edit-key < gpg_user >
> [expire]{到期，修改到期时间}
> [passwd]{密码, 修改密码}
> [save]{保存并退出}
> [quit]{退出}
> 
> [key 1]{选择对应的key}
> [revkey]{删除}

# 撤销
## 生成测小证书
## 手动复制 ascii ,用vim 编辑生成 revoke_certificate
gpg --gen-revok -r <gpg-user>

## 导入 revoke_certificate
gpg --import revoke_certificate

```
## encrypt & decrypt 
```shell
## Asymmetry encrypt
gpg -e -r < gpg_user > < file >

# Symmetry encrypt
gpg -c < file >

# decrypt
gpg -d < file >
## attention
1. 第一次解密需要密码
2. 后续不需要重复输入(类似`sudo`)


```

## signature & verify
```shell
# sginature
gpg --[detach]{分离}-sign -[r]{recipient: 收件人} < gpg_user > < file >
## result
--> < file >.sig

# verify
gpg --verify < sig_file > < origin_file >
```

# git & gpg
```shell
# 1.
gpg --quick-generate-key <git-email>

# 2.
gpg --export --armor --recipient <git-email> [>]{} gpg.Public
## 将 gpg.Public 粘贴到 github上

# 3. 配置签名秘钥
git config --local user.signingkey <git-email>
## 开启签名提交
git config --local commit.gpgsign true

# 4. 
git commit -S -m 'xxxx'

  
```

# 单词
recipient : 收件人
signing : 签署
revoke : 撤销
certificate : 证书
secret : 秘密