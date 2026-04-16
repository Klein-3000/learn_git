libpam.so

```bash
ldd /path/to/command
# 有调用 libpam.so 库 pam 才有效果
```

## root 用户 su 普通用户也要密码

```bash
# /etc/pam.d/su
auth required pam_env.so
auth [required]{默认为 **sufficient** } pam_rootok.so
...

```
## 普通用户 su 其他用户不需要密码
```
# /etc/pam.d/su
auth required   pam_env.so
[auth sufficient pam_permit.so]{启效果的配置}
auth sufficient pam_rootok.so
...
```
## 免密登录系统
```bash
# /etc/pam.d/system-auth
auth required   pam_env.so 
[auth sufficient pam_permit.so]{启效果的配置}
...
```
## 密码正确也不能登录
```bash
# /etc/pam.d/system-auth
auth required   pam_env.so
auth [required]{默认为 **sufficient** }   pam_unix.so try_first_pass nullok
...
```