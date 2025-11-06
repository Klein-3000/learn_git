# 命令
get-itemproperty

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
