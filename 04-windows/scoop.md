# 与winget的区别
- **Winget**：微软官方包管理器，主要调用 MSI/EXE 安装程序，行为类似手动安装（即“下一步”自动化），通常全局安装到 `Program Files`，**不管理依赖**，也不隔离环境。
- **Scoop**：社区驱动的命令行包管理器，**默认用户级安装**（无需管理员权限），将软件解压到 `$env:SCOOP\apps`，通过 **shims（软链接）** 将命令加入 PATH；部分 bucket（如 `main`）中的工具是绿色版或便携版，**不处理复杂依赖**（注意：Scoop **并不真正解决依赖树问题**，这点常被误解）。


---
# 安装
```powershell
# 配置安装环境
 Set-ExecutionPolicy RemoteSigned -scope CurrentUser
 $env:SCOOP='D:\Scoop'
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
# 软件目录的内容
## 以croc命令为例(一个文件共享命令)
|文件名|所属方|是否 croc 运行必需|用途说明|
|---|---|---|---|
|`croc.exe`|croc 项目|✅ 是|主程序，执行文件|
|`LICENSE`|croc 项目|❌ 否|开源许可证|
|`manifest.json`|Scoop|❌ 否|安装配方，用于管理版本/升级|
|`install.json`|Scoop|❌ 否|安装状态记录，用于卸载/追踪|

---

# 命令
![[package-management(包管理)#4.windows]]