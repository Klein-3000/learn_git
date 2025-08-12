# tmux 命令笔记

`tmux`（Terminal Multiplexer）是一个终端复用器，允许在单一终端窗口中运行多个终端会话。它支持会话持久化，即使断开连接，程序仍可在后台运行。

---
## 插件管理器(tpm)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

~/.tmux.conf或~/.config/tmux/tmux.config添加
```bash
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
```
### 目录结构

```bash
/home/UserName/.config/tmux
├── plugins
│   └── catppuccin
└── tmux.conf
```
---

## 基本概念

- **Session（会话）**：独立的工作环境，可后台运行。
- **Window（窗口）**：会话中的一个工作区，类似浏览器标签页。
- **Pane（窗格）**：窗口内的分屏区域，可同时运行多个命令。

---

## 常用命令
### 重要

| 命令                                                  | 说明            |
| --------------------------------------------------- | ------------- |
| tmux source-file ~/.config/tmux/tmux.config         | 重新加载配置        |
| tmux kill-server # 关闭所有<br>tmux kill -t 0   # 关闭指定的 | 关闭会话(session) |


### 会话管理

| 命令 | 说明 |
|------|------|
| `tmux new -s <name>` | 创建并进入名为 `<name>` 的新会话 |
| `tmux ls` | 列出所有会话 |
| `tmux attach -t <name>` | 连接到指定会话 |
| `tmux detach` 或 `Ctrl+b d` | 从当前会话分离 |
| `tmux kill-session -t <name>` | 终止指定会话 |

> 💡 提示：`-t` 表示目标（target），`-s` 表示会话名（session name）

---

### 窗口操作（需在 tmux 会话内使用）

| 快捷键 | 说明 |
|--------|------|
| `Ctrl+b c` | 创建新窗口 |
| `Ctrl+b ,` | 重命名当前窗口 |
| `Ctrl+b n` | 切换到下一个窗口 |
| `Ctrl+b p` | 切换到上一个窗口 |
| `Ctrl+b 0-9` | 跳转到编号 0~9 的窗口 |
| `Ctrl+b w` | 打开窗口列表，选择切换 |

---

### 窗格操作（需在 tmux 会话内使用）

| 快捷键 | 说明 |
|--------|------|
| `Ctrl+b %` | 垂直分割窗格 |
| `Ctrl+b "` | 水平分割窗格 |
| `Ctrl+b 方向键` | 在窗格间切换 |
| `Ctrl+b x` | 关闭当前窗格 |
| `Ctrl+b z` | 最大化/恢复当前窗格（切换全屏） |
| `Ctrl+b !` | 将当前窗格移动到新窗口 |

---

## 常见使用场景

- **远程服务器运维**：创建持久会话，防止 SSH 断开导致任务中断。
- **多任务开发**：在一个窗口中并行运行编辑器、服务日志、测试命令等。
- **协作开发**：多个用户可连接到同一会话进行协同操作（需配置）。

---

## 小技巧

- 使用 `tmux new -s dev` 创建开发会话，命名清晰便于管理。
- 分离后可通过 `tmux attach` 重新连接。
- 可通过配置文件 `~/.tmux.conf` 自定义快捷键和主题。

> 📚 参考：`man tmux` 或访问 [tmux 官网](https://github.com/tmux/tmux)