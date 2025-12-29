# 命令
get-itemproperty

## 图标设置
```powershell
# 创建路径
new-item -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DriveIcons\[Z]{盘符}\DefaultIcon"  -force

# 设置(修改)图标
set-itemproperty -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DriveIcons\[Z]{盘符}\DefaultIcon" -name "(default)" -value "[/path/to/ico]{图标的路径}" 

# 恢复默认图标
remove-itemproperty -name "(default)"
```
# 字体(font)
```powershell
# CURRENT user
hkcu:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts

# global
hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts

```

# 盘符
## 位置
```powershell
hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DriveIcons\
    C\"(DefaultIcon)"
    D\"(DefaultIcon)"

```
## 图标准备
```powershell
magick input.image -define icon:resize=256 output.ico 
```
## 刷新图标
```powershell
## 推荐
# 记忆 ie4 user init
ie4uinit -show

## 可选
重启 Explorer 进程
```
