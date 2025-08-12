# 壁纸(wallpaper)
## 简单壁纸
### hyprctl命令
```bash
# 查看监视器名
hyprctl monitors
```
### 设置壁纸
```conf
# ~/.config/hypr/hyprpaper.conf
monitor=<monitor>,/wallpaper/to/paht

# ~/.config/hypr/hyprland.conf
exec-one hyprpaper &
```
## 复杂壁纸(动态)
### swww命令
```rust
# 安装 
swww cargo install swww 

# 初始化 
swww swww init 

# 设置壁纸 
swww img /path/to/your/wallpaper.png --outputs HDMI-A-1
```