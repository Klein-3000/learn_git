# nvim
web : https://www.lazyvim.org

## install config
## 1.Make a backup of your current Neovim files:
```shell
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
 
```
## 2.Clone the starter
```shell
git clone https://github.com/LazyVim/starter ~/.config/nvim
 
```
## 3.Remove the `.git` folder, so you can add it to your own repo later
```shell
rm -rf ~/.config/nvim/.git
 
```

# 配置
## init.lua
```lua
# 不需要写后缀名
# core可以自定义
require("core.options")
```
## plugins manage
1. lazyvim
2. ~~packer.nvim~~


# lazy.nvim 
## 手动方式
```shell
# 原始命令
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/packer/start/lazy.nvim

# http://ghfast.top

git clone https://ghfast.top/github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/packer/start/lazy.nvim
```
## 代理换源
### ghfast.top
```bash
git config --global url."https://ghfast.top/github.com".insteadOf "https://github.com"
```
### gh-proxy.com
```bash
git config --global url."https://gh-proxy.com/github.com".insteadOf "https://github.com"
```
> [!summary] 命令实质
> 在家目录下生成一个名为==.gitconfig==
> 
> ```config
> [url "https://ghfast.top/github.com"]
 >       insteadOf = https://github.com
> ```

# plugins

| plugins           | function     |
| ----------------- | ------------ |
| blink.cmp         | 代码补全         |
| bufferline.nvim   | 顶部标签栏        |
| catppuccin        | 配色方案         |
| conform.nvim      | 代码格式化        |
| flash.nvim        | 搜索的导航        |
| friendly-snippets | 代码片段（函数补全之类） |
| lualine.nvim      | 状态栏          |
## summary
```lua
1. catppuccin/nvim                    --colorscheme
2. nvim-lualine/lualine.nvim          --statusline
3. nvim-tree/nvim-web-devicons        --pretty icons
4. goolord/alpha-nvim                 --pretty startup
5. folke/which-key.nvim               --mappings popup
6. romgrk/barbar.nvim                 --bufferline
7. nvim-treesitter/nvim-treesitter    --improved syntax
8. nvim-tree/nvim-tree.lua            --File explorer
9. ibhagwan/fzf-lua                   --fuzzy finder and grep
10. numToStr/FTerm.nvim               --floating terminal
```