# 一、全局配置
## 环境变量
> [!summary] 总结
> 1. `/etc/profile` 会自动加载 `/etc/profile.d/*.sh` 文件
> 2. 推荐创建 `/etc/profile.d/script.sh`
> 3. 一般不推荐全局配置环境变量 **容易起冲突**
```
# 全局环境变量
export EDITOR=vim
```

## 命令别名
- bash --> /etc/bash.bashrc
- zsh  --> /etc/zsh/zshrc
```bash
# 到对应的 全局 *rc 文件中配置
# 即可所有用户都能使用
alias 
```

---

# 二、!
## 获取参数
```bash
# 单个参数
!^   : 第一个参数
!$   : 最后一个参数
!:n  : 第n个参数

# 多个参数
!:2-$ :获取第2个到最后一个参数
!*    : 所有参数
```
> [!warning] 注意
> !没有效果时,执行下面的命令
> ```
> shopt -s histexpand
> ```
## 参数替换

|语法|作用|示例|
|---|---|---|
|`!!:s/旧/新`|替换**第一个**匹配|`!!:s/2/e`|
|`!!:gs/旧/新`|**全局全部替换**|`!!:gs/2/e`|
|`!!:p`|只**预览**命令，不执行|`!!:gs/2/e:p`|

---

# 三、{}
## 重命名
```bash
mv 1.txt{,.bak} --> mv 1.txt 1.txt.bak

mv 1.txt{.bak,} --> mv 1.txt.bak 1.txt
```
## 批量创建
```bash
mkdir -p /opt/{dir1,dir2}
```

---

# 四、grep
## 查询时,不输出自身
![[grep-ripgrep#technique]]


---

# 五、sed
![[sed#technique]]


---

# 六、awk
![[awk#technique]]


