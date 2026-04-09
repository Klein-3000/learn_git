![[Ansible#四、command]]

# 加密
## 整个文件加密
```bash
# 加密
ansible-vault encrypt all.yaml

# 预览
ansible-vault view all.yaml

# 编辑(不用提前解密)
ansible-vault edit all.yaml

# 解密
ansible-vault decrypt all.yaml

# 执行输入密码
ansible-playbook main.yml --ask-vault-pass
```
## 变量加密
```bash
ansible-vault encrypt_string "vagrant" --name "ansible_password"
# 将输出的加密后的内容粘贴会需要加密的文件
```