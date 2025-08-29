# 与winget的区别
- winget只是省去了“下一步，下一步”
- scoop 会处理依赖，默认在`c:\<user_name\scoop`】

---
# 安装
```powershell
# 配置安装环境
 Set-ExecutionPolicy RemoteSigned -scope CurrentUser
 $env:SCOOP='D:\1Scoop'
 [Environment]::SetEnvironmentVariable('SCOOP',$env:SCOOP,'User')

# 设置scoop global环境变量
 $env:SCOOP_GLOBAL='D:\ScoopGlobalApps'
 [Environment]::SetEnvironmentVariable('SCOOP_GLOBAL',$env:SCOOP_GLOBAL,'User')

# 安装命令 （建议：使用全局magic上网运行最佳。先打开magic上网工具，然后重启shell，执行y安装命令）
 Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
# 或
 iwr -useb get.scoop.sh | iex
# GitHub访问不畅时，上面两条命令都会不成功。当然我们还有备选方案：配置hosts（配上访问raw.githubusercontent.com最快的ip到hosts中），然后再试试下面的命令
 iex (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/lukesampson/scoop/master/bin/install.ps1')  

# 安装完成后，输入下面命令验证是否成功（常见的命令可以通过此方法来查看）
 scoop help
```

---
# 其他内容
[【好软推荐】Scoop - Windows快速软件安装指南 - 老船长SleepyOcean - 博客园](https://www.cnblogs.com/sleepyocean/p/17017084.html)

---
# 命令
![[包管理#windows]]