# 使用方法
```shell
# [bash & zsh]{必须**全部大写**}
export <env-var> = <value>

# [powershell]{不区分大小写,但value要加上**引号**}
$env:<env-var> = "<value>"

 
```

# 变量
## nvim
```shell
XDG_CONFIG_HOME ： 配置文件

XDG_DATA_HOME : 插件目录

XDG_CACHE_HOME

 
```
> [!attention] 注意
> nvim的环境变量指向**配置**和**插件目录**的==父目录==即可
> nvim 路径拼接规则
> windows : nvim; nvim-data
> linux : nvim ; nvim(因为linux中配置和插件目录拼接规则**一致**,所以记得将他们存放在不同目录下)

## 其他
```shell
# git config (.gitconfig)
GIT_CONFIG_GOLBAL

# starship
STARSHIP_CONFIG

 
```