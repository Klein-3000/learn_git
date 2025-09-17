# tr(translate)
```shell
# 替换
echo 123 | tr '2' '\n' --> 1\n3

# 压缩
echo 111222333 | tr -s '123' --> 123

# 删除
echo 111222333 | tr -d '1' --> 222333
```
