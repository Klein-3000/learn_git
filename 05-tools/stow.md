# 作用
1. 在.dotfile目录中管理配置文件
2. 在.dotfile目录==中==,执行`stow package`,自动将package软连到(==.dotfile目录的==)上级目录相对应的位置
```bash
# 上级目录为~
~/.dotfile
|_nvim     # package name
	|_.config
		|_nvim
			|_...nvim config
# pwd
# ~/.dotfile/
stow nvim
# 就是执行下面的命令
ln -s ~/.dotfile/nvim/.config/nvim  ~/.config/nvim
```
# 命令(在.dotfile目录中)
```bash
stow package

stow -R package

stow -D package

# 复现.dotfile中所有配置
# pwd ~
cd .dotfile
stow */
```
>[!warning] 注意
>所用stow都要在.dotfile目录中执行
>`*/`,shell中的通配符,表示当前目录下的所有 **子目录**

