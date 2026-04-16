# 一、nvim 相关目录认识
```powershell
XDG_CONFIG_HOME : 配置文件目录 (~/.config/nvim | $env:LOCALAPPDATA/nvim)

XDG_DATA_HOME   : [应用数据]{插件、LSP、DAP、Tree-sitter} (~/.local/share/nvim | $env:LOCALAPPDATA/nvim-data)

XDG_CACHE_HOME  : [缓存]{临时文件、高亮缓存} (~/.cache/nvim | 系统临时目录，如 %TEMP%/nvim)

XDG_STATE_HOME  : [状态数据]{历史记录、Shada、日志、视图} (~/.local/state/nvim | $env:LOCALAPPDATA/nvim-data)
```
## 1.1 目录结构
#### linux
```shell
~/.config
└───nvim
	├───[init.lua]{主要配置文件,通过`require("config.<fileName>")`调用,就会**加载**lua/config/目录中`.lua`文件的**配置**}
	├───[lazy-lock.json]{lazy管理插件的**版本**}
    └───lua
        ├───[config]{一般配置 "keymap.lua","options.lua","lazy.lua"等文件}
        └───[plugins]{存放,通过lazy安装插件的**配置**}
        
# 插件本体的安装目录
~/.local/share/nvim/lazy

```
#### windows
```shell
[C:\User\<UserName>\AppData\local]{资源管理中输入 %LOCALAPPDATA%}
├───[nvim]{与linux的"nvim"目录一致}
└───[nvim-Data\lazy]{插件本体的安装目录}
 
```
## 1.2 验证
### 命令 (linux 和 windows 通用)
```
nvim --headless --noplugin -u NONE -i NONE -c 'lua io.write(vim.inspect({
    config = vim.fn.stdpath("config"),
    data   = vim.fn.stdpath("data"),
    cache  = vim.fn.stdpath("cache"),
    state  = vim.fn.stdpath("state"),
    log    = vim.fn.stdpath("log")
}))' -c 'qa!'
```
### 结果
#### window
```json
{
  cache = "C:\\Users\\Lenovo\\AppData\\Local\\Temp\\nvim",
  config = "C:\\Users\\Lenovo\\AppData\\Local\\nvim",
  data = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data",
  log = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data",
  state = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data"
}
```
#### linux
```json
{
  cache = "/home/kali/.cache/nvim",
  config = "/home/kali/.config/nvim",
  data = "/home/kali/.local/share/nvim",
  log = "/home/kali/.local/state/nvim",
  state = "/home/kali/.local/state/nvim"
}%
```

# 二、配置环境变量指定neovim的数据和配置路径
## 2.1  Windows 上让所有路径都集中在 `AppData\Local`（便于备份）
```powershell
# PowerShell: 永久设置（当前用户）
[Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$env:LOCALAPPDATA\nvim", "User")
[Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "$env:LOCALAPPDATA\nvim-data", "User")
[Environment]::SetEnvironmentVariable("XDG_STATE_HOME", "$env:LOCALAPPDATA\nvim-state", "User")
[Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", "$env:LOCALAPPDATA\nvim-cache", "User")
```
## 2.2 配置案例(pwsh)
```powershell
E:\tools\
    ├── fastfetch
    ├── Git
    ├── nvim <--nvim本体
    └── nvim-config

#环境变量配置
# windows
## cmd
set XDG_CONFIG_HOME=E:\tools\nvim-config
set XDG_DATA_HOME=E:\tools\nvim-config
#set XDG_CACHE_HOME=E:\tools\nvim-config\cache
#set XDG_STATUS_HOME=E:\tools\nvim-config\state

## pwsh
$env:XDG_CONFIG_HOME = "E:\tools\nvim-config"
$env:XDG_DATA_HOME   = "E:\tools\nvim-config"
#$env:XDG_CACHE_HOME  = "E:\tools\nvim-config\cache"
#$env:XDG_STATUS_HOME = "E:\tools\nvim-config\state"

# linux(默认配置情况)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATUS_HOME="$HOME/.local/state"
```
## 2.3 验证配置是否生效
```
# 单个输出
echo stdpath('config')
echo stdpath('data')
echo stdpath('cache')

# 整个输出
echo &runtimepath

# [输出为文件]{依次执行，不要管命令**消失**的问题}
:redir > ~/nvim_runtimepath.txt
:echo &runtimepath
:redir END
```

# 三、插件总结

| 插件                                                                              | 作用                                                                              |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| [[#1.snack.nvim]]<br>需要而外的命令<br>rg \<leader>/ 工作目录文件搜索<br>fg \<leader>e 资源管理器搜索 | 1. 提起界面(dashboard:提示板)<br>2. 文件管理器(explorer)                                    |
| [[#2.lualine.nvim]]                                                             | 状态栏                                                                             |
| [[#3.1 folker/tokyonight]]<br>[[#3.2 catppuccin]]                               | 主题<br>配色                                                                        |
| [[#4.barbar(buffer line)]]                                                      | buffer栏                                                                         |
| [[#5 foke/noice.nvim]]                                                          | 悬浮命令行                                                                           |
| [[#6 numToStr/FTerm]]                                                           | 悬浮终端                                                                            |
| render-markdown.nvim<br>obsidian.nvim                                           | markdown预览                                                                      |
| Twilight                                                                        | 专注于当前的代码(其余变暗)                                                                  |
| nvim-biscuits                                                                   | 展示==右==符号对应的左符号的行<br>def function{<br><br>}%% 光标于此行<显示内容> %%:==def function {== |
| nvim-toggler                                                                    | 反转类<br>True <--> flase                                                          |
| smear-cursor.nvim                                                               | 光标动画                                                                            |
| rainbow-delimiters.nvim                                                         | 不同深度显示不同的花括号                                                                    |
|                                                                                 |                                                                                 |
# 四、nvim中文输入(windows)
> [!summary] 总结
> 需要[im-select.exe]([github.com/daipeihust/im-select](https://github.com/daipeihust/im-select))
> [配置文档(macOS)]{[姜绍彬的博客](https://shaobin-jiang.github.io/blog/posts/neovim-ime/)}
> im-select功能==win+空格键==
## im-select.exe
默认输出当前输入法的代码

- 搜狗输入法为**2052** (中英文输入)
- 英语(美国)为**1033**  (只能英文输入)
```cmd
# 切换到搜狗输入法
im-select.exe 2052
```
## 配置(wsl依旧使用,使用/mnt/to/path/im-select.exe)
```bash
# 将<path-to-im-select>替换为im-select存放的目录
local ime_autogroup = vim.api.nvim_create_augroup("ImeAutoGroup", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
    group = ime_autogroup,
    callback = function ()
        vim.cmd(":silent :!<path-to-im-select> 1033")
    end
})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = ime_autogroup,
    callback = function ()
        vim.cmd(":silent :!<path-to-im-select> 2052")
    end
})

```

# 1.snack.nvim
#### 📁 文件与项目操作

|快捷键|功能|
|---|---|
|`<leader><space>`|智能查找文件|
|`<leader>e`|打开文件浏览器|
|`<leader>ff`|查找文件|
|`<leader>fr`|最近打开的文件|
|`<leader>fp`|项目列表|

#### 🔍 搜索与查找

|快捷键|功能|
|---|---|
|`<leader>/`|全局搜索|
|`<leader>sw`|搜索选中词或当前单词|
|`<leader>sB`|在已打开缓冲区中搜索|
|`<leader>sb`|查看当前缓冲区的所有行|

#### 🐙 Git 集成

|快捷键|功能|
|---|---|
|`<leader>gs`|Git 状态|
|`<leader>gb`|Git 分支切换|
|`<leader>gl`|Git 日志|
|`<leader>gd`|Git 差异对比|

#### 💻 LSP 支持（语言服务器）

|快捷键|功能|
|---|---|
|`gd`|跳转到定义|
|`gD`|跳转到声明|
|`gr`|查找引用|
|`gy`|跳转到类型定义|

#### 🎛️ 其他实用功能

| 快捷键          | 功能               |
| ------------ | ---------------- |
| `<leader>z`  | 切换 Zen 模式（专注模式）  |
| `<leader>Z`  | 缩放当前窗口           |
| `<leader>bd` | 删除当前缓冲区          |
| `<leader>cR` | 重命名文件            |
| `<c-/>`      | 打开终端             |
| `]]` / `[[`  | 跳转到下一个/上一个相同单词位置 |
#### 自定启动界面的logo
```lua
return {
	"folke/sancks.nvim",
	opts = {
		dashboard = {
			preset = {
				header = [[
					-- ASCII图案
				]],
			},
		},
	},
}
```

> [!warning] 所需依赖系统命令
> explorer 的`/`模糊搜索,需要`fd`命令
> \<leader>/ ,需要`rg`命令


# 2.lualine.nvim
```lua
+-------------------------------------------------+
| A | B | C                             X | Y | Z |
+-------------------------------------------------+

sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
```

# 3.themes
## 3.1 folker/tokyonight
### use
```lua
colorscheme tokyonight

" There are also colorschemes for the different styles.
colorscheme tokyonight-night
colorscheme tokyonight-storm
colorscheme tokyonight-day
colorscheme tokyonight-moon
 
```
## 3.2 catppuccin


# 4.barbar(buffer line)
### 📝 快捷键概览

|快捷键|功能描述|
|---|---|
|`<A-,>`|切换到上一个 buffer|
|`<A-.>`|切换到下一个 buffer|
|`<A-<>`|将当前 buffer 向前移动|
|`<A->>`|将当前 buffer 向后移动|
|`<A-1>` 至 `<A-9>`|跳转到编号为 1 至 9 的 buffer|
|`<A-0>`|跳转到最后一个 buffer|
|`<A-p>`|固定/取消固定当前 buffer|
|`<A-c>`|关闭当前 buffer|
|`<C-p>`|进入“魔法” buffer 选择模式（用于快速切换 buffer）|
|`<C-s-p>`|进入“魔法” buffer 删除模式（用于快速删除 buffer）|
|`<Space>bb`|按照 buffer 编号排序|
|`<Space>bn`|按照 buffer 名称排序|
|`<Space>bd`|按照目录结构排序|
|`<Space>bl`|按照语言排序|
|`<Space>bw`|按照窗口编号排序|
# 5 foke/noice.nvim
```lua
-- lazy.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
}
```
# 6 numToStr/FTerm
```lua
return {  
  "numToStr/FTerm.nvim",  
  config = function()  
    require("FTerm").setup({  
      ft         = 'FTerm',                    -- 终端 buffer 的 filetype  
      cmd        = os.getenv('SHELL'),         -- 默认 shell（也可以写成 {"zsh"} 或 {"bash"}）  
      border     = 'rounded',                  -- 窗口边框样式（可选: 'none', 'single', 'double', 'rounded'）  
      auto_close = true,                       -- 命令执行完后自动关闭终端  
      hl         = 'NormalFloat',              -- 使用浮动窗口高亮组  
      blend      = 10,                         -- 设置透明度（0-100，越大越透明）  
      dimensions = {  
        height = 0.8,  
        width  = 0.8,  
        x      = 0.5,  
        y      = 0.5,  
      },  
      clear_env  = false,  
      env        = nil,  
      on_exit    = nil,  
      on_stdout  = nil,  
      on_stderr  = nil,  
  
      -- 可以在这里加上快捷键绑定  
    })  
  
    -- 快捷键：切换终端  
    vim.keymap.set("n", "<leader>tt", require("FTerm").toggle, { desc = "Toggle Terminal" })  
    -- 运行当前文件  
    vim.keymap.set("n", "<leader>tr", "<cmd>lua require('FTerm').run(vim.fn.expand('%:p'))<CR>", { desc = "Run current file" })  
  end  
}
```
