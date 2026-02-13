# 一、bundle
```shell
# 打包
git bundle create archive.bundle [<hash>]{一般为**HEAD**, 完整打包整个仓库}

# 检验
git bundle verify archive.bundle
 
```
## 复现
```shell
# 1. 从零复现
git clone archive.bundle
## 
git remote -v
# 显示 archive.bundle 的全路径

# 2. 正常更新
git pull archive.bundle


# 3. 从 sparse.bundle(C->D->E) 更新旧仓库, 旧仓库处在main分支中,且 A->B->C
git bundle unbundle sparse.bundle
## 获取最新的 `HEAD`(sparse_hash) 值
git bundle verify sparse.bundle
git branch [< from-sparse >]{建议这样命名} <sparse_hash>
git merge < from-sparse >
## result (A->B->[C]{old}->D->[E]{**merge** 和 **from-sparse**})


```
> [!attention] 注意
> 从`archive.bundle`包中克隆的仓库默认没有分支名
> 需要`git checkout -b main`创建`main`分支(只有main分支了)