# 用法
## 一、简单下载
```shell
yt-dlp  [-o /path/to/video/%(title)s.%(ext)s]{指定保存**位置**和指定**文件名**} [--write-subs]{下载**字幕**} <URL>
 
```
## 二、其他用法
```shell
yt-dlp [options] [--] <URL>
 
```
### 2.1 列出下载选项并下载指定内容
```shell
yt-dlp -F <URL>

yt-dlp -f [id]{video_only_id}+[id]{audio_only_id} <URL>
 
```
### 2.2 cookie下载
```shell
yt-dlp --cookies-from-browser <browser> <<URL>>
 
```
### 2.3 下载封面
```shell
# 查看有哪些缩略图(封面)
yt-dlp --list-thumbnails <URL>

# 下载缩略图(封面)
yt-dlp --write-thumbnail [--skip-download]{只下载封面,**不加**此参数**连同**视频一起下载下来} <URL>
 
```

# 单词
thumb ：拇指
fingerprint ： 指纹
thumbnail ： 缩略图