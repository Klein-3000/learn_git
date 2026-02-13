# sshcfg
## 1. 概述
🔍 快速查看、编辑 SSH 配置块，自动展开 `Include` 文件内容，支持彩色高亮与一键跳转编辑。
## 2. **功能亮点（Features）**
- 🎨 **彩色展开 Include**：自动读取 `~/.ssh/` 下的 include 文件，并以青色注释显示来源  
- ⚡ **一键跳转编辑**：`-e host` 直接在 `nvim`/`vim` 中打开配置并定位到 `Host` 行  
- 📁 **快速编辑 include 文件**：`-i config.file` 直接编辑 `~/.ssh/config.file`  
- 🔍 **精准 Host 匹配**：支持多别名（`Host a b c`）、大小写兼容、避免误匹配  
- 🛡️ **安全可靠**：路径限定在 `~/.ssh/`，仅允许 `nvim`/`vim` 编辑
### 效果预览
![[ssh_sshcfg.png]]
## 3. 选项说明
| 选项                     | 说明                                |
| ---------------------- | --------------------------------- |
| `<host>`               | 查看该主机的完整配置块（含 include 展开）         |
| `-e, --edit <host>`    | 用 `nvim`/`vim` 编辑主配置并跳转到 `Host` 行 |
| `-i, --include <file>` | 用 `nvim`/`vim` 编辑 `~/.ssh/<file>` |
| `-h, --help`           | 显示帮助                              |
⚠️ 注意：编辑功能**仅支持 `nvim` 或 `vim`**（通过 `$EDITOR` 环境变量控制）
## 4. **限制（Limitations）**

诚实说明边界，建立信任：
### 当前限制
- 不支持递归 `Include`（即 include 文件中再 include）
- 不支持通配符（如 `Include *.conf`）
- 编辑功能仅限 `nvim`/`vim`（因依赖 `+<line>` 跳转语法）