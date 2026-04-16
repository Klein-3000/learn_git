# sudo
## 官网
[[须藤](https://www.sudo.ws/)](https://www.sudo.ws/)
## 命令
```bash
# 列出当前用户可执行的sudo命令
sudo -l

# 以指定用户身份运行
sudo -u <user> <command>

# 撤销sudo凭据缓存
sudo -k

```
# 设置免密
## 创建免密文件
```bash
# [/etc/sudoers.d/99-NOPASSWD ]{**99** 确保被最后加载, 其他的就没有什么限制了}
# 格式
# <用户/[组]{使用==%==表示, 既 ==%admin== }> <主机列表>=(<目标用户列表>) [NOPASSWD:] <命令列表>

# 1. 免密全部命令
Kali ALL=(ALL) NOPASSWD: ALL

# 2. 指定命令
Kali ALL=(ALL) NOPASSWD: [/usr/bin/cat]{需要绝对路径, 且允许免密执行 ==任意== cat 命令}

# 3. 指定多个命令
kali ALL=(ALL) NOPASSWD: /usr/bin/cat, /usr/bin/file -i /root/.bashrc
# 只允许免密执行 `sudo file -i /root/.bashrc`,  `sudo file /root/.bashrc -i` 需要密码

# 4. 其他配置
Defaults timestamp_timeout=0  # 每次都需要输入 sudo 密码
Defaults passwd_tries=3       # 试错3次

```
- `NOPASSWD:` 后**必须加一个空格**；
- 每个逗号后**加一个空格**（提升可读性）；
- 避免在命令路径中使用空格，如必须使用，请用引号或 `\x20` 转义。
> [!attention] 注意
> 1. 直接修改 `/etc/sudoers` 文件没有效果 (不清楚原因)
> 2. 编辑好并保存了 `/etc/sudoers.d/<profile>` 依旧不能生效,需要退出编辑器,立即生效
> 3. sudoers 中的“命令”指的是可执行文件的==绝对路径==，**不能直接包含参数**；
> 4. **严格匹配**免密命令格式
> 5. 权限只要求非 root 用户**无**==写权限==即可, 建议为 ==600==
## 检验是否免密
```bash
❯ sudo -l
Matching Defaults entries for kali on kali:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin,
    use_pty

User kali may run the following commands on kali:
    [(ALL : ALL) ALL]{使用 **sudo** 权限}
    [(ALL) NOPASSWD: /usr/bin/ls, /usr/bin/file -i /root/mitm_capture.pcap, /usr/bin/cat]{可以免密的命令}
```

