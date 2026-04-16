## 1. 重启
快速按下任意键
## 2. 编辑模式
==按e键进入编辑模式==
![[permission-单用户模式-编辑模式.png]]
## 3. 启动系统
==ctrl+x 启动系统==

## 4. 进入单用户模式
![[permissions_单用户模式-效果图.png]]
## 5. 重新挂载磁盘
```bash
# 重新以读写方式挂载磁盘
mount -o remount,rw /sysroot/

# 修改主目录
chroot /sys/sysroot
```
## 6. 修改密码
```bash
passwd

```
## 7. 添加 selinux 验证(可选)
```bash
# 如果关闭 selinux, 可不做该步骤
touch /.autorelable
```
## 8. 重启验证密码
```bash
exit
reboot

```
> [!attention] 注意
> 会重启**两次**