# common Usage
## convert(magick)
```bash
# 转换格式（JPG 转 PNG）
convert input.jpg output.png

# 调整图像大小
convert input.jpg -resize 800x600 resized.jpg

# 裁剪图像
convert input.jpg -crop 400x300+50+50 cropped.jpg

# 旋转图像
convert input.jpg -rotate 90 rotated.jpg

# 添加文字水印
convert input.jpg -pointsize 32 -fill white -draw "text 100,100 'Watermark'" watermarked.jpg

# 模糊处理
convert input.jpg -blur 0x8 blurred.jpg

# 调整亮度/对比度
convert input.jpg -brightness-contrast 20x10 brightened.jpg
```
> [!attention] 注意：
> 在较新版本的 ImageMagick（7+）中，`convert` 命令被建议替换为 `magick`，以避免与 Windows 系统自带的 `convert` 命令冲突。
## Identity
```bash
# 显示图像格式、尺寸、色深、颜色空间、文件大小等
identify image.jpg | *.jpg

# 显示更详细的属性（包括EXIF、配置文件等）
identify -verbose image.jpg
```
## Icon
```bash
magick input.png \ 
-define icon:auto-resize=256,128,96,64,48,32,16 \ 
icon.ico

# 完整命令
magick gothic-love.png \ 
-resize 256x256^ \ 
-gravity center-gravity center \ 
-extent 256x256 \ 
-define icon:auto-resize=256,128,96,64,48,32,16 \ 
-define png:compression-level=9 \ 
icon.ico
```
# word
resize : 调整
crop : 剪裁(图片)
rotate : 旋转
fill : 填满
draw : 画
blur : 模糊