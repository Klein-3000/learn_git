# !
```bash
!^ : 第一个参数
!$ : 最后一个参数
!:n : 第n个参数
!*  : 所有参数
```
> [!warning] 注意
> !没有效果时,执行下面的命令
> ```
> shopt -s histexpand
> ```
# {}
## 重命名
```bash
mv 1.txt{,.bak} --> mv 1.txt 1.txt.bak

mv 1.txt{.bak,} --> mv 1.txt.bak 1.txt
```
## 批量创建
```bash
mkdir -p /opt/{dir1,dir2}
```
# grep
## 查询时,不输出自身
![[grep-ripgrep#technique]]

# sed
![[sed#technique]]

# awk
![[awk#technique]]
