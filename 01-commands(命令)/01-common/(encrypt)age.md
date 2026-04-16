# 一、简述

| 密码加密(**-p**)     | `age [-a] -p  unencrypt_file > encrypted_file.age`                       |
| ---------------- | ------------------------------------------------------------------------ |
| 密码解密( **-d** )   | `age -d encrypted_file.age > decrypt_file`                               |
|                  |                                                                          |
| 生成公私钥            | `age-keygen -o <public_key_name>`                                        |
| 公钥加密(**-r**)     | `age [-a] -r $(age-keygen -y public_key) unencrypt_file > encrypted.age` |
| 私钥解密( **-d -i**) | `age -d -i private_key  encrypted_file.age > decrypt_file`               |


---

# 二、密码加解密
```bash
# 加密
age [-a]{armor, 用于生成**纯文本文件**的加密文件} [-p]{passphrase}   file.txt > file.txt.age

# 解密
age [-d]{decrypt} file.txt.age
```

---

# 三、公私钥加解密
```
# 生成公私钥文件
age-keygen -o <private_file>
# 查看公钥内容
age-keygen -y <private_file>

# 加密
age [-a]{armor, 用于生成**纯文本文件**的加密文件} [-r]{recipient} [$(age-keygen -y <private_file> )]{必须是 **公钥** 的 ==内容==} file.txt > file.txt.age
age [-a]{armor, 用于生成**纯文本文件**的加密文件} [-r]{recipient} [$(age-keygen -y <private_file> )]{必须是 **公钥** 的 ==内容==} [-o]{tar类命令的逻辑}  file.txt.age file.txt

# 解密
age [-d]{decrypt} [-i]{Identity} <private_file> file.txt.age > file.txt
age [-d]{decrypt} [-i]{Identity} <private_file> [-o]{tar类命令的逻辑}  file.txt file.txt.age 
```
## 进阶


---

# 四、加解密多个文件
```bash
# 加密
tar czf - file1.txt file2.txt | age -r $(age-keygen -y <private> ) > archive.tar.gz

# 解密
age -d -i <private_file> | tar xzf - 
```

---


# 单词
encrypt : 加密
decrypt : 解密
armor : 护甲
Identity : 身份
recipient : 收件人
passphrase : 短语,口令
