# flask
## 目录结构
```
├── app.py
├── Dockerfile
└── requirement.txt
```
### app.py
```python
import os
from flask import Flask

app = Flask(__name__)

# 【核心技巧】从环境变量中动态读取配置，如果外部没传，则使用后面的默认值
# 这样代码不用改，就能适应不同环境
PORT = int(os.environ.get("APP_PORT", 5000))
GREETING = os.environ.get("GREETING_MSG", "你好，容器世界！这是默认的 Flask 响应。")

@app.route('/')
def hello():
    # 返回一段 HTML，展示当前收到的问候语和端口
    return f"""
<h2>{GREETING}</h2>
<p>当前应用正监听在容器内的 <b>{PORT}</b> 端口上。</p>
"""

if __name__ == '__main__':
    # 【注意】在容器内部运行 Web 服务，host 必须设置为 '0.0.0.0'
    # 否则应用只会监听容器的 127.0.0.1，导致外部（宿主机）无法访问！
    app.run(host='0.0.0.0', port=PORT)

```
>[!attention] 注意
>    1. 在容器内部运行 Web 服务，host 必须设置为 '0.0.0.0'
>    2.  否则应用只会监听==容器==的 127.0.0.1，导致外部（宿主机）无法访问！

## requirement.txt
```txt
Flask==3.0.0
Werkzeug==3.0.0

```
## Dockerfile
```Dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirement.txt .

RUN pip install --no-cache-dir -r requirement.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]

```

# 步骤
将一个本地的 Flask 应用搬到容器里，我们需要遵循一套严谨的标准工业流程。请您在脑海中牢记这 “四步走” 战略：
## 冻结依赖 (Dependency Freeze)
在本地开发时，您的环境里可能安装了几百个无关的 Python 包。容器是一个纯净的空房间，您必须明确列出 Flask 应用需要的依赖。
动作：生成准确的 requirements.txt 文件。
## 编写 “构建图纸” (Dockerfile Creation)
编写 Dockerfile。这就像是给 Docker 引擎下达的一系列流水线操作指令。
动作：拉取 Python 基础镜像 → 创建工作目录 → 拷贝依赖单并 pip install → 拷贝 Flask 源码 → 暴露端口 → 指定启动命令。
## 压制 “标准集装箱” (Image Building)
让 Docker 引擎根据您的图纸，一层一层地去抓取系统、安装环境、打包代码，最终生成一个静态的、不可篡改的 “镜像 (Image)”。
动作：执行 docker build 命令。
## 实例化运行与验证 (Container Running)
将静态的镜像 “唤醒”，变成一个动态运行的 “容器 (Container)”。
动作：执行 docker run 命令，进行端口映射并测试访问。