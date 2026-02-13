---
language: python
type: tools
function: web, url, 管理
---
# buku
## 简介
### 📘 `buku` — 命令行书签管理器（Bookmarks for Unix）

`buku` 是一个轻量、高效、基于终端的书签管理工具，专为开发者和命令行爱好者设计。它将 URL、标题、标签存储在本地 SQLite 数据库中，支持全文搜索、标签过滤、批量操作，并可通过浏览器一键打开。

> ✅ **只存 URL，不保存网页内容**  
> 🔍 **支持按关键词、标签、索引快速查找**  
> ⌨️ **纯命令行 + 可选 TUI 界面**

## 相关目录
### 数据库存放位置
```shell
~/.local/share/buku/bookmarks.db
 
```
### 软件位置
```shell
~/.local/bin/buku.exe
 
```

## 使用
### 命令
```shell
# 1.增
buku -a <url> [--tag <tag1>,<tag2>]

# 2.删
buku -d <index>

# 3.改
## 更新(默认全部更新)
buku -u [index]
## 交换位置
buku --swap <index1> <index2>

# 4.查
## 关键字
buku <key word> [<key word1>]

## 索引
### 查看全部
buku -p
### 范围
buku -p <range>

# 5.打开
buku -o <range>
 
```
### range
- 10 20 : 查找索引为10和20 (2个)
- 10-20 : 查找索引为10到20 (10个)
- 10 20-30 :  查找索引为10,以及20到30 (11个)
### 备份与迁移
#### 备份
```shell
$ buku -e bookmarks.html [--tag <tag1> <tag2>]
$ buku -e bookmarks.xbel
$ buku -e bookmarks.md
$ buku -e bookmarks.org
$ buku -e bookmarks.db
 
```
默认导出全部
#### 迁移
```shell
$ buku -i bookmarks.html
$ buku -i bookmarks.xbel
$ buku -i bookmarks.md
$ buku -i bookmarks.org
$ buku -i bookmarks.db
 
```