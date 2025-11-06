```bash
wget -r -np -nH --cut-dirs=5 -P ./local_ssh_backup --follow-tags=a "http://10.1.97.31/D%3A/application/backup/.ssh/"
```
>[!attention] 注意
>会多下载一个“index.html”文件

```bash
wget -r -np -nH --cut-dirs=5 -P ./local_ssh_backup --follow-tags=a --reject=index.html "http://10.1.97.31/D%3A/application/backup/.ssh/"
```
> [!attention] 注意
> 添加"--reject=index.html"参数可以让wget不下载"index.html"文件
> - 注意：该参数会让 `wget` 跳过所有 `index.html`，包括目标目录外的（但因你加了 `-np` 限制父目录，实际只影响当前目录的 `index.html`）。

### 总结

`index.html` 不是 “多余文件”，而是 `wget` 递归下载目录的 “必要中间文件”—— 它是 Everything 服务返回的目录索引页，`wget` 通过它获取文件列表后才能下载实际内容。如果不需要保留，下载后删除即可，不影响其他文件的完整性。

| 参数                      | 全称 / 作用                          | 针对你的需求的意义                                                                                                                                                  |
| ----------------------- | -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-r`                    | `--recursive` 递归下载               | 自动下载 `.ssh` 目录下的所有子目录、子文件，无需手动处理层级                                                                                                                         |
| `-np`                   | `--no-parent` 不遍历父目录             | 只下载 `/.ssh/` 及其子内容，避免误下载上级目录（如 `D:/application/backup/` 下的其他文件）                                                                                            |
| `-nH`                   | `--no-host-directories` 不创建主机名目录 | 避免在本地生成 `10.1.97.31/` 这样的冗余目录，简化本地结构                                                                                                                       |
| `--cut-dirs=5`          | 切除远程路径的前 N 级目录                   | 远程路径是 `D%3A/application/backup/.ssh/`（`D:` 是第 1 级，`application` 第 2 级，…，`backup` 第 4 级），`--cut-dirs=5` 后仅保留 `.ssh` 及其内容，本地不会生成 `D:/application/backup/` 层级 |
| `-P ./local_ssh_backup` | `--directory-prefix` 指定本地保存根路径   | 所有文件最终会存到 `./local_ssh_backup/.ssh/` 下，方便后续查找（路径可自定义）                                                                                                      |
| `--follow-tags=a`       |                                  | 强制 `wget` 跟随页面中所有 `<a>` 标签的链接（无论是否有 `nofollow`），这是解决当前问题的核心 —— 直接让 `wget` 忽略 `nofollow` 限制，去解析文件链接。                                                        |
## URL编码
- "空格 ": %20或+
- ":" : %3A
- "\" : %5C