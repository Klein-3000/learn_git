# 环境变量$env
```shell
# 输出配置的path
$env:path -split ';'

# 注意分隔符
# windows --> :(分号)
# linux --> :(冒号)
## 添加path
$env:path += "$path;<full_path>"
## 类比bash
export PATH="$PATH:<full_path>"

# 添加环境变量
$env:XDG_CONFIG_HOME


 
```
## 案例
![[nvim(custom)#配置环境变量指定neovim的数据和配置路径]]
