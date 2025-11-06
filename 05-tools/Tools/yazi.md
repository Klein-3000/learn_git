# 安装
官网网址 : [Installation | Yazi](https://yazi-rs.github.io/docs/installation)
学习网站 : https://quickref.cn/docs/yazi.html
github ： https://github.com/sxyazi/yazi/


## 依赖
- [nerd-fonts](https://www.nerdfonts.com/) ([_recommended_](https://yazi-rs.github.io/docs/faq#dont-like-nerd-fonts))
- [`ffmpeg`](https://www.ffmpeg.org/) (for video thumbnails ： 用于视频缩略图)
- [7-Zip](https://www.7-zip.org/) (for archive extraction and preview ：用于压缩和预览)
- [`jq`](https://jqlang.github.io/jq/) (for JSON preview)
- [`poppler`](https://poppler.freedesktop.org/) (for PDF preview)
- [`fd`](https://github.com/sharkdp/fd) (for file searching)
- [`rg`](https://github.com/BurntSushi/ripgrep) (for file content searching)
- [`fzf`](https://github.com/junegunn/fzf) (for quick file subtree navigation, >= 0.53.0)
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) (for historical directories navigation, requires `fzf`)
- [`resvg`](https://github.com/linebender/resvg) (for SVG preview)
- [ImageMagick](https://imagemagick.org/) (for Font, HEIC, and JPEG XL preview, >= 7.1.1)
- [`xclip`](https://github.com/astrand/xclip) / [`wl-clipboard`](https://github.com/bugaevc/wl-clipboard) / [`xsel`](https://github.com/kfish/xsel) (for Linux clipboard support)
## windows
```powershell
scoop install yazi
# Install the optional dependencies (recommended):
scoop install ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick
```

# 依赖
## 1. ffmpeg

## 2. 7-zip
[[压缩打包#7z | 7z 命令详解]]

## 3. poppler
```bash
# 提取文本
pdftotext Document.pdf <output.txt>

# 合并pdf
pdfunite <file1.pdf> <file2.pdf> <...>

```
## 4. fd
![[find-fd#基本格式]]
![[find-fd#总结]]
# 配置
- `~/.config/yazi/yazi.toml` on Unix-like systems.
- [`%AppData%\yazi\config\yazi.toml`]{C:\Users\\\<user>\APPDATA\Roaming\yazi\config\yazi.toml}on Windows.