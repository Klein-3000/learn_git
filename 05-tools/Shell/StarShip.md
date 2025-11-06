# 基本信息
官网 : [Starship](https://starship.rs/)
预设 : [Presets | Starship](https://starship.rs/presets/)
# 安装
```shell
curl -sS https://starship.rs/install.sh | sh
```

# 初始化
```shell
# bash
eval "$(starship init bash)"

# zsh
eval "$(starship init zsh)"

# powershell
Invoke-Expression (&starship init powershell)
```
# 配置文件
> [!attention] 注意
> # 默认配置配置文件 
> linux : ~/.config/starship.toml
> windows : C:\Users\<UserName>\config\starship.toml
> # 可由STARSHIP_CONDIG指定
> 配置文件名都==可以不==是**starship.tmol**

# 常用命令
```shell
starship
	config : 使用默认编辑器编辑starship的配置文件
	explain : 查看starship加载的内容与时间
	timings : 

 
```
# 单词
1. invoke ： 调用
2. expression ： 表达式
3. experimental ： 实验
4. report  报告
5. explain : 解释