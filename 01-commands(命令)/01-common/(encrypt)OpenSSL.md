# 加密历程
    1. [对称加密]{速度快,但怎么确保秘钥的安全分发}
    2. [非对称加密]{可以安全分发公钥,但加密效率低}
    3. [数字签名]{非对称加密**加密**对称加密的秘钥,**秘钥**对称加密数据, 但怎么证明数据是发送者发的}
    4. [数字证书]

# 散列算法
    特点
        1. 定长输入，定长输出
        2. 不可逆性
        3. 雪崩性(内容不一样了,hash一定不一样)
    指纹 : 文件内容的 hash 值

# openssl
## 非对称加密
```bash
# 生成私钥
openssl genpkey -algorithm RSA \
	-pkeyopt rsa_keygen_bits:2048 \
	-out private.pem
    [-aes-256-cbc]{给私钥设置密码}

# 给已有的私钥加密码
openssl pkey -in private_key_unecrypted.pem
    -aes-256-cbc \
    -out private_key_encrypted.pem

# 提取公钥
openssl pkey \
	-in private.pem \
	-pubout \
	-out public.pem

# 公钥加密
openssl pkeyutl -encrypt \
	-in file.txt \
	-out file.txt.enc \
	-inkey public.pem \
	-pubin

# 私钥加密
openssl pkeyutl -decrypt \
	-in file.txt.enc \
	-out file.txt.dec \
	-inkey private.pem
```

## 对称加密
```bash
# 生成32字节（256位）的对称密钥，并用Base64编码保存

openssl rand -base64 32 > Secret.key

# 加密
openssl enc -aes-256-cbc \
	-in file.txt \
	-out file.txt.enc \
	-pass file:Secret.key

# 解密
openssl enc -aes-256-cbc \[[encrypt(加密文件)]]
	-in file.txt.enc \
	-out file.txt.dec \
	-pass file:Secret.key \
	-d
	
```
## 密码加密
```bash
# 加密
openssl enc -aes-256-cbc \
	[ -pbkdf2 -iter 10000] \
	-in file.txt \
	-out file.txt.enc 
	
# 加密
openssl enc -aes-256-cbc \
	[ -pbkdf2 -iter 10000] \
	-in file.txt \
	-out file.txt.enc \
	-d 

```
对称加密算法
	1. -aes-256-cbc
	2. -aes-256-gcm

> [!attention] 注意
> 1. `enc`子命令,默认为==密码==加密
> 2. 对称加密需要`-pass file:Secret.key`指定
> 3. 密码加密时,建议带上`-pbkdf2 -iter <n>`参数
> 4. 使用`-pbkdf2 -iter <n>`参数密码加密后,解密是也需要使用`-pbkdf2 -iter <n>`,且次数`<n>`也要一致

-pbkdf2：对应 ==Password-Based Key Derivation Function 2==（*基于密码的密钥派生函数 2*）。这是一种密码哈希算法，通过将密码与随机盐值结合并进行多次迭代计算，生成加密所需的密钥，能有效抵抗暴力破解和字典攻击。
-iter：==对应 iteration（迭代）==。该参数用于指定 PBKDF2 算法的迭代次数，例如-iter 10000表示进行 10000 次迭代计算。适当增加迭代次数可以提高密码的安全性，但会增加计算时间。
`pkey` = `EVP_PKEY` = **通用非对称密钥对象**

## 🧩 参数详解

| 参数               | 含义                    | 是否推荐       |
| ---------------- | --------------------- | ---------- |
| `-aes-256-cbc`   | 使用 AES-256-CBC 算法     | ✅ 推荐       |
| `-aes-256-gcm`   | 更安全的 AEAD 模式（支持完整性校验） | ✅ 更高级场景    |
| `-salt`          | 添加“盐”，防止彩虹表攻击         | ✅ **必须启用** |
| `-pbkdf2`        | 使用 PBKDF2 密钥派生函数      | ✅ 推荐       |
| `-iter 10000`    | 增加迭代次数，提高暴力破解难度       | ✅ 推荐       |
| `-in file`       | 输入文件                  | ✅          |
| `-out file`      | 输出文件                  | ✅          |
| `-d`             | 解密模式                  | ✅          |
| `-pass pass:xxx` | 从命令行传密码（**不安全**）      | ❌ 避免       |
| `-pass stdin`    | 从标准输入读密码              | ✅ 安全       |
| `-pass file:xxx` | 从文件读密钥                | ✅ 安全       |
| `-a`             | Base64 编码输出/输入        | ✅ 文本传输时使用  |
## 📊 综合总结表

| 概念          | 全称                                                              | 作用          | 是否必须         |
| ----------- | --------------------------------------------------------------- | ----------- | ------------ |
| **AES**     | Advanced Encryption Standard                                    | 对称加密算法      | ✅ 核心         |
| **256**     | 256-bit key                                                     | 密钥长度，决定安全性  | ✅ 推荐         |
| **CBC**     | Cipher Block Chaining                                           | 分组加密模式      | ✅ 常见，但无完整性校验 |
| **-salt**   | Salt（随机盐）                                                       | 防止彩虹表，确保唯一性 | ✅ **必须启用**   |
| **-pbkdf2** | Password-Based Key Derivation Function 2<br>**基于密码的密钥派生函数 第2版** | 将密码转为强密钥    | ✅ 推荐         |
| **-iter N** | Iteration Count                                                 | 增加破解时间成本    | ✅ 推荐 ≥10,000 |
# 非对称加密原理
###  在 RSA 中：

- **公钥** = `(N, e)`
    
    - `N` 是两个大质数的乘积
    - `e` 是一个公开的指数
    - 任何人都可以用它加密
- **私钥** = `(N, d)`
    
    - `d` 是一个只有你知道的“秘密指数”
    - 它和 `p`, `q` 有关，没有 `p` 和 `q` 就算不出来

> ✅ 加密：`密文 = 明文^e mod N`  
> ✅ 解密：`明文 = 密文^d mod N`

> [!attention] 注意
> RSA不能加密大文件
> 实际实践 : 对称加密加解密==文件==, 非对称加密对称==密钥==

---

# 数字签名
## 🔐 正确理解：加密 + 签名 = 完整安全通信

### 🎯 典型场景：Alice 给 Bob 发加密且带签名的文件

| 步骤  | 操作                                    | 使用的密钥     | 目的                             |
| --- | ------------------------------------- | --------- | ------------------------------ |
| 1   | Alice 用 **Bob 的 RSA 公钥**加密文件          | Bob 的公钥   | ✅ 保证只有 Bob 能解密（机密性）            |
| 2   | Alice 用 **自己的 Ed25519 私钥**对文件（或密文）签名  | Alice 的私钥 | ✅ 证明是 Alice 发的，且未被篡改（认证 + 完整性） |
| 3   | Bob 收到后，先用 **Alice 的 Ed25519 公钥**验证签名 | Alice 的公钥 | ✅ 确认来源和完整性                     |
| 4   | 再用 **自己的 RSA 私钥**解密                   | Bob 的私钥   | ✅ 获取明文                         |
## 实际案例
```bash
# 1. 生成消息
echo "Secret message from Alice to Bob" > message.txt

# 2. Ed25519 签名（使用 dgst，目前仍是标准方式）
openssl dgst -sign alice_ed25519.key -out message.sig message.txt

# 3. 使用 pkeyutl 进行 RSA 加密（现代方式）
openssl pkeyutl -encrypt \
    -inkey bob_rsa.pub \
    -pubin \
    -in message.txt \
    -out message.enc \
    -pkeyopt rsa_padding_mode:oaep \
    -pkeyopt rsa_oaep_md:sha256

# 4. Bob 解密（现代方式）
openssl pkeyutl -decrypt \
    -inkey bob_rsa.key \
    -in message.enc \
    -out message_decrypted.txt \
    -pkeyopt rsa_padding_mode:oaep \
    -pkeyopt rsa_oaep_md:sha256

# 5. 验证签名
openssl dgst -verify alice_ed25519.pub -signature message.sig message_decrypted.txt
```


---

# age
## 密码加密
```bash
# 加密
age -p  <fileName> > <Secretfile>

# 解密
age -d  <Secretfile> > <fileName>
```
# 非对称加密
## 生成公私钥
`age-keygen -o <SecretKeyFile>`
输出案例
```bash
# created: 2025-10-07T14:40:00Z
# public key: age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p
AGE-SECRET-KEY-1N9JEPW6DWJ0ZQUDX63F5A03GX8QUW7PXDE39N8UYF82VZ9PC8UFS3M7XA9
```
## 加解密
```bash
## 提取公钥
grep public <SecretKeyFile> | awk '{print $NF}' > public.key

## 公钥加密
age --encrypt --recipient $(cat public.key) < <fileName> > <Secretfile>

## 私钥解密
age --decrypt --identity <SecretKeyfile> < <Secretfile> > <fileName> 
```


---

# 伪装
```bash
# 原生的cat命令
cat Image.png file.enc > new_image.png

# 提取出来
tail -c $(stat -c%s file.enc) new_image.png
```
> [!attention] 注意
> 需要保留`file.enc`文件,便于stat命令计算出file.enc的文件的大小
> 或者记住`stat -c%s file.enc`的数值

---

# 单词
recipient : 接收人
Identity : 身份
digest : 摘要 ==dgst==

task 任务
- 使用 AEAD 模式（如 AES-GCM）
- 添加数字签名防篡改
- 做好密钥管理
