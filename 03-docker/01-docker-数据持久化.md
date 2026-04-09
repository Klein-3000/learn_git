# mount
```bash
--mount type=<type>,[source]{可以缩写为 **src** }=<src>,[target]{可以缩写为 **dst**}=<path>,...

# type 默认为 [volume]{},其他类型需要明确指定
```
其中：

- `type`：挂载类型（如 `bind`、`volume`、`tmpfs`）
- `source`（或 `src`）：主机上的源路径或 volume 名称
- `target`：容器内的挂载目标路径

### `--target` vs `--destination`

- `target` 是官方文档和推荐使用的标准关键字。
- `destination` 是 `target` 的**别名（alias）**，为了兼容性和用户习惯而保留。
