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
