# 基本用法
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
```python
# 添加库
uv add <repository>

# 激活环境
source .venv/bin/activate

# 运行
python main.py
# 或(不需要提前激活)
uv run main.py
```

## 复现
```python
uv sync
```

# 单词
库 module