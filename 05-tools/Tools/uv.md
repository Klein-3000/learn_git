# 基本用法
## 基础
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