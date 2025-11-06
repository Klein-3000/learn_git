---
tags:
  - tools
Type: configure
---
# 配置（windows版）
```bash
# 加速clone,pull (push时,记得注释掉)
[url "https://ghfast.top/github.com"]
        insteadOf = https://github.com
[user]
        name = Klein-3000
        email = hcxt93520@qq.com
        
[core]
		# 换行符问题(windows版)
		autocrlf = true
		# 中文显示问题
        quotepath = off
        # 编辑工具（默认为vim）
        # git config --edit时，调用vim编辑.gitconfig文件
        editor = vim

```
# 说明
![[git进阶操作#无法正常显示中文]]
![[git进阶操作#eol(end of line)问题]]