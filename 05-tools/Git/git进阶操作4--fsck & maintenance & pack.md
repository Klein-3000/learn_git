# 一、fsck
## 基本概念
`git fsck`（全称：**file system check**）是 Git 提供的一个**仓库完整性检查工具**，用于扫描 Git 对象数据库（`.git/objects/`）和引用（refs），检测是否存在**损坏、丢失、孤立或不一致的对象**。
### ✅ 核心作用
> **验证 Git 仓库的内部一致性，找出潜在的数据问题。**

它会遍历所有 Git 对象（commit、tree、blob、tag）以及引用（branches、tags、HEAD 等），检查：

- 对象是否完整（未损坏）
- 对象之间的引用是否有效（例如：一个 commit 指向的 tree 是否存在）
- 是否存在“悬空”（dangling）或“不可达”（unreachable）的对象
- 是否有缺失的对象（比如 `.git/objects/` 中文件被误删）
### 🔍 常见检查项（输出类型）

运行 `git fsck` 后，你可能会看到以下类型的提示：

| 输出示例                     | 含义                                                | 是否严重                  |
| ------------------------ | ------------------------------------------------- | --------------------- |
| `dangling commit abc123` | 存在一个 commit，但没有任何分支/标签指向它（可能是 rebase、reset 后残留）   | ⚠️ 通常无害，可清理           |
| `dangling blob def456`   | 存在一个文件内容（blob），但未被任何 tree 引用（比如 `git add` 后又改了文件） | ⚠️ 无害，Git 会在 gc 时自动清理 |
| `missing tree xyz789`    | 某个 commit 声称包含一个 tree，但该 tree 对象不存在               | ❌ **严重错误！仓库损坏**       |
| `broken link`            | 对象引用了不存在的子对象                                      | ❌ **严重错误**            |
| `unreachable commit ...` | commit 存在，但无法从任何 ref 到达（类似 dangling，但更广义）         | ⚠️ 通常无害               |

## 常用命令
```shell
# 基本检查（只检查 HEAD 及其可达对象）
git fsck

# 检查所有对象（包括 dangling/unreachable）
git fsck --full

# 只显示错误（忽略 dangling/unreachable）
git fsck --no-dangling

# 检查并显示详细信息
git fsck --verbose

# 检查特定对象
git fsck <object-id>
 
```
### ⚠️ 注意事项
- **`dangling` 对象通常是正常的**！它们是 Git 操作（如 `git commit --amend`、`git reset`）产生的临时残留，**不会影响功能**，Git 会在 `git gc` 时自动清理。
- **真正需要关注的是 `missing`、`broken`、`corrupt` 等错误**，这些表示仓库已损坏。
- `git fsck` **不会修复问题**，只负责检测。修复需手动操作（如从备份恢复、重新克隆等）。
    

---
# maintenance
```shell
# 注册需要自动维护的仓库
git maintenance [register | unregister ]

# 开始自动清理 
git maintenance start

# 结束自动清理
git maintenance stop
 
```


---

# 三、pack
## 压缩
```shell
git gc
 
```
## 解压
```shell
git unpack-objects < <path/to/PackFile>
 
```
> [!attention] 注意
> `.git/object/pack/`目录中不能有`.pack`文件,需要将`.pack`文件移动到其他地方,再来`unpack-objects`


---

# 单词
pack : 包