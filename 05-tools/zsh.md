# 网络问题
![[nvim(Lazyvim)#lazy.nvim#代理换源]]
# 安装
## 安装插件管理器(install plugins manager)
### 1.zinit
```bash
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```
#### zinit配置(configure)
```bash
# 终端中使用vi模式编辑命令
zinit light jeffreytse/zsh-vi-mode
# 语法错误提示
zinit light zsh-users/zsh-syntax-highlighting
# 命令建议
zinit ice atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
# 双击<esc>添加或删除sudo(从ohmyzsh中获取sudo插件)
zinit snippet OMZP::sudo
# 终端主题
zinit light romkatv/powerlevel10k
```
![[zinit]]
### 2.oh-my-zsh
```bash
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
```
#### oh-my-zsh配置
```bash
~/.zshrc
# 启用自带的插件
plugins=(
        vi-mode
)

# 设置主题
ZSH_THEME=<theme_name>
```

### 3.zplug
```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```


