# 用法
## 转换格式
```shell
ffmpeg -i [video.m4s]{输入文件} [video.mp4]{输出文件} [-loglevel error]{只输出**错误**信息, 避免刷屏} 
 
```
## 剪辑
```shell
ffmpeg -i video.mp4 [-ss]{需要放在`-i`参数的后面} [< hh:mm:ss >]{开始时间} -t [< hh:mm:ss >]{结束时间} 
 
```
> [!attention] 注意
> `-ss`和`-t`后面若只有数字,ffmpeg将把他当做**秒**
> - -ss : 开始时间
> - -t  : 持续时间
> - -to : 结束时间
### 设置元数据(metadata)
```
ffmpeg -i .\iuno.m4s -i .\cosplay-iuno2.png `
  -map 0:a -map 1 `
  -c:a copy `
  -c:v mjpeg `
  -disposition:v attached_pic `
  -metadata title="今夜不属于你" `
  -metadata artist="iuno" `
  -metadata date="2025" `
  -metadata genre="古典, 忧伤" `
  -metadata album="" `
  .\iuno_with_metadata.m4a
```
