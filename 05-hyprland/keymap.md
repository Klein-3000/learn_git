## 🧠 **快捷键总览**

|类别|功能|快捷键|说明|
|---|---|---|---|
|🔚 **退出 / 系统操作**|退出 Hyprland、锁屏、关机等|`Ctrl+Alt+Del`, `Super+Q`, `Super+Shift+Q` 等|包括关闭窗口、强制关闭进程、锁屏、电源菜单等|
|🖥️ **布局与窗口管理**|布局切换、调整大小、移动窗口|`Super+[IJKL]`, `Super+Shift+[←↓↑→]` 等|支持 Master/Dwindle 布局操作|
|🎮 **分组与聚焦**|窗口分组、切换焦点|`Super+G`, `Alt+Tab`|支持窗口分组切换和浮动窗口循环|
|🔊 **音量与媒体控制**|音量调节、播放/暂停等|`XF86Audio*` 键|使用自定义脚本调用|
|📸 **截图相关**|截图、区域截图、延迟截图|`Super+PrintScreen`, `Super+Shift+S`|使用脚本调用截图工具如 `grim`, `slurp`, `swappy`|
|📏 **调整窗口尺寸**|调整活动窗口大小|`Super+Shift+[←↓↑→]`|每次调整 ±50 像素|
|🔄 **移动窗口位置**|移动窗口或交换位置|`Super+Ctrl+[←↓↑→]`, `Super+Alt+[←↓↑→]`|可以将窗口移到相邻方向或交换位置|
|🧭 **工作区切换**|切换、移动窗口到工作区|`Super+[1~0]`, `Super+Shift+[1~0]`|支持滚动切换、特殊工作区切换等|
|🖱️ **鼠标操作**|鼠标拖拽窗口、调整大小|`Super+左键/右键拖动`|使用鼠标结合 Mod 键进行窗口操作|

---

## 📌 **详细分类解析**

### 🔚 退出与系统操作

|快捷键|功能|说明|
|---|---|---|
|`Ctrl+Alt+Del`|退出 Hyprland|发送 exit 信号|
|`Super+Q`|关闭当前窗口|不是“kill”，而是正常关闭|
|`Super+Shift+Q`|强制关闭当前窗口|执行脚本 KillActiveProcess.sh|
|`Ctrl+Alt+L`|锁屏|执行 LockScreen.sh|
|`Ctrl+Alt+P`|显示电源菜单|执行 Wlogout.sh|
|`Super+Shift+N`|打开通知面板|使用 swaync-client|
|`Super+Shift+E`|打开设置菜单|Kool_Quick_Settings.sh|

---

### 🖥️ 布局与窗口管理

#### 布局操作（Master/Dwindle）

|快捷键|功能|说明|
|---|---|---|
|`Super+Ctrl+D`|从主区移除窗口|removemaster|
|`Super+I`|添加到主区|addmaster|
|`Super+J/K`|循环下一个/上一个窗口|cyclenext/cycleprev|
|`Super+Ctrl+Enter`|和主窗口交换位置|swapwithmaster|
|`Super+Shift+I`|切换分割方向（仅 dwindle）|togglesplit|
|`Super+P`|进入伪模式（pseudo window）|dwindle 特有|
|`Super+M`|调整分割比例|splitratio +0.3|

#### 分组操作

|快捷键|功能|说明|
|---|---|---|
|`Super+G`|切换窗口分组|togglegroup|
|`Super+Ctrl+Tab`|在分组中切换焦点|changegroupactive|
|`Alt+Tab`|浮动窗口循环|cyclenext + bringactivetotop|

---

### 🔊 音量与媒体控制

|快捷键|功能|说明|
|---|---|---|
|`XF86AudioRaiseVolume`|音量增加|执行 Volume.sh --inc|
|`XF86AudioLowerVolume`|音量减少|执行 Volume.sh --dec|
|`XF86AudioMicMute`|麦克风静音切换|执行 Volume.sh --toggle-mic|
|`XF86AudioMute`|音量静音切换|执行 Volume.sh --toggle|
|`XF86Sleep`|睡眠系统|systemctl suspend|
|`XF86Rfkill`|飞行模式切换|执行 AirplaneMode.sh|
|`XF86AudioPlayPause`, `XF86AudioNext`, `XF86AudioPrev`, `XF86AudioStop`|媒体控制|控制播放、暂停、下一曲、上一曲、停止|

---

### 📸 截图相关

|快捷键|功能|说明|
|---|---|---|
|`Super+Print`|全屏截图|ScreenShot.sh --now|
|`Super+Shift+Print`|区域截图|ScreenShot.sh --area|
|`Super+Ctrl+Print`|5秒后截图|ScreenShot.sh --in5|
|`Super+Ctrl+Shift+Print`|10秒后截图|ScreenShot.sh --in10|
|`Alt+Print`|活动窗口截图|ScreenShot.sh --active|
|`Super+Shift+S`|使用 swappy 截图|ScreenShot.sh --swappy|

---

### 📏 窗口尺寸调整

|快捷键|功能|说明|
|---|---|---|
|`Super+Shift+←`|向左扩展窗口宽度|resizeactive -50 0|
|`Super+Shift+→`|向右扩展窗口宽度|resizeactive +50 0|
|`Super+Shift+↑`|向上扩展窗口高度|resizeactive 0 -50|
|`Super+Shift+↓`|向下扩展窗口高度|resizeactive 0 +50|

---

### 🔄 移动窗口与交换位置

|快捷键|功能|说明|
|---|---|---|
|`Super+Ctrl+←/→/↑/↓`|移动窗口|movewindow 方向|
|`Super+Alt+←/→/↑/↓`|交换窗口位置|swapwindow 方向|

---

### 🧭 工作区操作

|快捷键|功能|说明|
|---|---|---|
|`Super+Tab`|切换到下一个工作区|workspace m+1|
|`Super+Shift+Tab`|切换到前一个工作区|workspace m-1|
|`Super+数字键 1~0`|切换到对应编号工作区|code:10~19|
|`Super+Shift+数字键 1~0`|将当前窗口移动到对应工作区并跳转|movetoworkspace|
|`Super+Ctrl+数字键 1~0`|将当前窗口静默移动到对应工作区|movetoworkspacesilent|
|`Super+[ 或 ]`|移动窗口到前后工作区|movetoworkspace -1/+1|
|`Super+Shift+[ 或 ]`|同上||
|`Super+Ctrl+[ 或 ]`|同上（静默）||
|`Super+Scroll Up/Down` 或 `Super+,` / `.`|滚动切换工作区|e+1/e-1|

---

### 🖱️ 鼠标操作（窗口拖动/调整）

|快捷键|功能|说明|
|---|---|---|
|`Super+鼠标左键拖动`|移动窗口|bindm movewindow|
|`Super+鼠标右键拖动`|调整窗口大小|bindm resizewindow  绑定调整大小窗口|

---

## 🧩 **变量说明**

bash

深色版本

```
$mainMod = SUPER         # 主要修饰键（Windows 键）
$scriptsDir = $HOME/.config/hypr/scripts     # 脚本目录
$UserConfigs = $HOME/.config/hypr/UserConfigs # 用户配置目录
$UserScripts = $HOME/.config/hypr/UserScripts # 用户脚本目录
```