# hostname
```
# 显示主机名
hostname

# 显示IP地址
hostname -I 
```
# hostnamectl
相关文件<span style="background-color:yellow;font-size:40px">/etc/hostname</span>
```
# 修改主机名为 admin
hostnamectl set-hostname admin
```

# fc-cache
```bash
# 强制,递归,详细 刷新字体
fc-cache -rfv
```
> [!warning] 字体存放位置
> ==~/.local/share/fonts==下

# language(语言)
## 临时修改
```bash
# 修改为中文
export LANG=zh_CN.UTF-8
# 修改为英文
export LANG=en_US.UTF-8
```
## 永久修改
```bash
/etc/default/locale


```