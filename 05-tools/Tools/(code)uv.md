# 一、安装(install)
## 官方独立安装
```
curl -LsSf https://astral.sh/uv/install.sh | sh
```
## pip 安装
```
pip install uv
```
## 配置加速镜像
### 命令行参数
```
# 临时使用国内源
uv pip install flask netmiko -i https://pypi.tuna.tsinghua.edu.cn/simple/
uv pip install flask netmiko -i https://mirrors.aliyun.com/pypi/simple/
uv pip install flask netmiko -i https://pypi.mirrors.ustc.edu.cn/simple/
```
### 全局配置(环境变量)
```
# 设置全局索引URL
export UV_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple/"
```

---

# 二、基本用法
## 基本流程
```python
# 初始化
## 工程化
uv init
## 简单项目
uv venv 

# 添加库
## 必须是 `init`
uv add <repository>
## 不在 `pyproject.toml` 中登记
uv pip install <repository>

# 激活环境
## linux
source .venv/bin/activate
## window
.venv\Scripts\[activate.ps1]{cmd 使用**activate.bat** 脚本}

# 查看是否在虚拟环境中
$env:virtual_env

# 禁用环境
## Linux & Windows pwsh
deactivate
## Windows cmd
.venv\Scripts\deactivate.bat

# 运行
python main.py
# 或(不需要提前激活)
uv run main.py

# 导出 requirements.txt
uv export -o requirements.txt
```

## 复现
```python
uv sync
```

### python 版本
```python
# 查看支持python版本
uv python list
# 安装指定版本
uv python install <Version>

# 运行
# 临时
uv run -p <Version> [ python | file.py ]

# 依赖树(dependencies tree)
uv tree
```
相关文件
==pyproject.toml==

---
# 三、详情

## 基础
### 使用
```shell
# 初始化 -- 生成 pyproject.toml 文件
uv init [ -p <version> ]
```
`uv init`后的结果
1. `git init`
2. 生成以下文件
3. 没有生成`.venv`目录
```
❯ ls

        Directory: D:\Project\GitHub\pocket-tts


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          2026/2/4     22:21            109   .gitignore
-a---          2026/2/4     22:21              5   .python-version
-a---          2026/2/4     22:21             88   main.py
-a---          2026/2/4     22:21            156   pyproject.toml
-a---          2026/2/4     22:21              0 󰪷  [README.md]{空白文件}
```
pyproject.toml
```toml
[project]  
name = "pocket-tts"  
version = "0.1.0"  
description = "Add your description here"  
readme = "README.md"  
requires-python = ">=3.13"  
dependencies = []
```

```
# 添加依赖 -- 对 pyproject.toml文件进行操作
uv add <package>

# 运行
uv run [pytool] <pyfile>


 
```



# 单词
库 module
