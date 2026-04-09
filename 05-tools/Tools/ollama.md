---
type : tools
function: LLM management
---



# 一、环境变量
| 环境变量                       | 默认值                                                                          | 作用说明                                                                                              |
| -------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `OLLAMA_HOST`              | `127.0.0.1:11434`                                                            | 指定 Ollama 服务监听的地址和端口。  <br>• 设为 `0.0.0.0:11434` 可允许局域网其他设备访问。  <br>• 修改后需重启 `ollama serve` 或系统服务。 |
| ==`OLLAMA_MODELS`==        | Linux/macOS: `~/.ollama/models`  <br>Windows: `%USERPROFILE%\.ollama\models` | 指定模型存储路径。  <br>• 可用于将大模型移至非系统盘（如 D:\AI\models）。  <br>• 需在首次下载模型前设置，否则已下载模型不会自动迁移。                 |
| `OLLAMA_KEEP_ALIVE`        | `-1`（永久保活）                                                                   | 控制模型在内存中保留的时间（单位：秒）。  <br>• 例如设为 `3600` 表示 1 小时无请求后卸载模型。  <br>• `-1` 表示永不卸载（默认）。                  |
| `OLLAMA_NUM_PARALLEL`      | `1`                                                                          | 设置同时处理的请求数（影响并发能力）。                                                                               |
| `OLLAMA_MAX_LOADED_MODELS` | 未明确限制（实际受内存限制）                                                               | 控制最多同时加载到内存中的模型数量（实验性）。                                                                           |
| `OLLAMA_DEBUG`             | 未设置                                                                          | 设为 `1` 或 `true` 可启用调试日志（输出更详细的运行信息）。                                                              |
| `HOME` / `USERPROFILE`     | 系统默认                                                                         | Ollama 使用此变量确定用户主目录，从而定位 `.ollama` 配置目录。                                                          |
## 📁 关键配置目录与文件

Ollama 的配置和数据主要存放在用户主目录下的 `.ollama` 文件夹中：
### 1. **默认根目录**

- **Linux / macOS**: `~/.ollama/`
- **Windows**: `%USERPROFILE%\.ollama\`

### 2. **子目录结构**
```
.ollama/
├── models/                 # 存放所有下载的模型文件（blobs、manifests 等）
│   ├── blobs/
│   └── manifests/
├── config.json             # （较少使用）部分版本可能包含全局配置
└── logs/                   # （可选）日志文件（通常输出到系统日志或 stdout）
```

---

# 二、命令
```bash
# 开始后台服务
ollama serve

# 运行一个模型
ollama run <module> [prompt]{提示}

# 拉取模型
ollama pull <module>

# 查看下载的模型
ollama list

# 显示模型信息
ollama show <module>

# 查看运行中的模型
ollama ps

# 删除模型
ollama rm <module>

# 创建一个模型来自模型文件
ollama create -f <new_module_name> -f <path/to/module_file>
```