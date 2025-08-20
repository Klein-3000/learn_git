# Format
sed \[Option] \[parameter] \[filename]
# Option

| Option | 含义                               |
| ------ | -------------------------------- |
| -n     | ==取消默认==sed的输出,常于p结合使用           |
| -i     | 直接将修改结果写入文件，不用-i，sed修改的是==内存数据== |
| -e     | ==多次编辑==,不需要管道符了                 |
| -r     | 支持正则扩展                           |

# parameter

| parameter   | 含义                 |
| ----------- | ------------------ |
| a           | append 指定行的==下一行== |
| d           | delete             |
| i           | insert 指定行的==上一行== |
| p           | print              |
| s/正则/替换内容/g | 匹配(==当前==)的行       |
# matching range

| range     | 含义                                                                                                   |
| --------- | ---------------------------------------------------------------------------------------------------- |
| 空地址       | 全文处理                                                                                                 |
| 单地址       | 指定文件的某一行                                                                                             |
| /Pattern/ | 被匹配的行                                                                                                |
| 范围区间      | 10,20    10到20行<br>10,+5    10行以及下5行<br>/Pattern1/,/Pattern2/                                        |
| 步长        | A~B  从A行开始,下一个行号为(A+B)<br>eg<br>1~2   表示1, 3 , 5, 7...  既==奇数==行<br>2~2    表示2, 4, 6, 8 ... 既==偶数==行 |

# technique
### 输出指定范围行的内容
```shell
sed '<start>,<stop>p' -n filename

# grep方案
grep -C <center> filename
```
### 行首与行尾
```shell
# 行首添加内容
sed 's/^/&#/'  filename [-i]

# 行尾添加内容
sed 's/$/&#/'  filename [-i]
```
### 换行符(回车)问题
```shell
sed 's/\r$//' filename
```
换行符
- \n (newline): huanhang
- \r (return) : 回车

| windows | linux; macos |
| ------- | ------------ |
| \n\r    | \n           |
