[toc]

04.19 19:43
powershell

# edit mode
- emasc
- vi
- windows
```pwsh
# 查看pswh版本
$PSVersionTable
或
$PSVersionTable.Version
或
pwsh


# 设置为vi模式
Set-PSReadLineOption -EditMode Vi
```
# 1.alias
获取：Get-alias
设置：set-alias -name pad -value notepad
删除：del alias：pad
# 2.格式化输出format-table==ft==（类似awk）
eg
   ls | formar-table 字段1,字段2
# 3.变量（variable）
设置：$VAR=值
值可以为
- "字符串"  
- `ls`  命令
- `（1-4）/2`  数学表达式
- `$VAR1=$VAR2=1` 同时赋值
- `$VAR`1,$VAR2=$VAR2,$VAR1` 交换赋值
输出：$VAR
删除：del variable：VARName
查看：test-path variable：[VAR] 默认是全部，可指定，可通配

# 4.环境变量（**env**ironment variable）
- 设置：$env:var="value"
- 输出：$env:var
- 查看:ls $env:[var]
- 删除:del $env:var
- 不熟悉
```
[environment]::setenvironmentvariable（"PATH"，"D:\"，"USER"）
```
# 5.powershell脚本执行策略（execution policy）
获取：get-**execution**policy
设置：set-**execution**policy  \<value>
值
- remotesigned（远程签署）
- restricted（限制）

# 6.条件操作符
## 比较
- `-eq -ne`等于 不等于
- `-gt -ge`大于 大于等于
- `-lt -le`小于 小于等于
## 逻辑
- `-and`
- `-or`
- `-not`
-  `-contains` 包含
-  `-notconcatins` 不包含

# 7.if和switch语句
## if
```powershell
if （条件）
    ｛
      powershell
      "直接输出这句话"
    }
elseif （条件）
    {powershell}
else
    {powershell}
```
## switch==$_==
```powershell
switch（value）{
{条件} ｛对应的动作｝
｛（$_ -gt 30） -and （$_  -lt 40）
} ｛动作｝
{ $_ -eq 50 } {动作1}
#效果同上
50 {动作1}
```
> [!note] warning
> switch不熟悉


# 8.数组与foreach
## 8.1数组
- 设置
```powershell
#定义
$var=1,2,3,4或$var=1..4
#空数组
$var=@()
#单个元素与混合
$var=,1
$var=1,"陈丹玲"
#判断
$var -is [array]
```
- 输出`$var`
- 访问、修改、追加
```powershell
#访问
$arr[index]
连续的
$arr[0..10] #正序
$arr[-11..-1] #倒序
不连续的
$arr[1,5]
#修改
$arr[index]=value
#追加
$arr+=value1[,value2]
```

## 8.2foreach
```powershell
$path=D：\Users\Lenovo\pictures
foreach（ $file in $path）{
           if （ $file.length -gt 1gB）
                 {
                    $file.name
                 }
}
```

# 9.while和do-while与break和continue
```powershell
$num=1
while($num -le 6){
    if($num -eq 4)
    {
    $num++
    break
    #continue
    }
    else
    {
    $num
    $num++    
    }
    
}
```

# 10.for==;==
```powershell
$sum=0
for ($i=1;$i -le 100; $i++){
	$sum += $i
}
"1~100的和为:"+$sum
```

# 11.函数(function)与参数定义(argument definition)
## 函数(function)
```powershell
#定义
function funName[( arg[=default] [,arg]  )]
{
[parma(  )]
powershell
[return arg]
}
#查看定义
(get-command -name funName).ScriptBlock
封装为函数
function FunDef($name)
{
(get-command -name $name).ScriptBlock
}
#调用与传参
funName [arg [,arg]]
#删除
del function:funName

```
## 参数定义(argument definition)
**放在函数内部的开头**
- **argument：实参**
- **parameter：形参**
```powershell
parma(
--非强制参数
#限定类型
[string]$username #还有[bool],[int],[array]
#设置默认值
[string]$username = "thelema"

--强制参数-没有简化写法
[parameter(mandatory=$true)] #每个强制参数的上面都要写
[string]$username
)
```
**案例**
```powershell
function Register-User {
param( 
# 强制参数 
[Parameter(Mandatory=$true)] 
[string]$firstName, 
[Parameter(Mandatory=$true)] 
[string]$lastName,
[Parameter(Mandatory=$true)] 
[string]$email, 
# 可选参数 [string]
$phone = "未提供" 
) 
Write-Output "注册用户：$firstName $lastName, 邮箱: $email, 电话: $phone"
}
```


# 12.格式化文本与转义字符==`==与字符串处理
```powershell
--格式化文本(Format)
- 0开始
- 公式要括号
$name="陈丹玲"
$age=21
my wife's name is {0} ,her age is {1} year old ,value={2}-f $name,$age,(3*8)

--转义字符
`n #换行
`r #光标移到开头
`t #tab
`b #Backspace

--字符串处理
-不破坏原有数据
.split("分隔符")                  #将字符串分割为数组
.split("分隔符")[index]     #分割并获取某一列
.indexof("c")                      #索引
.insert(index","str")          #插入-index可以不加"
.replace("old","new")       #替换-区分大小写
-布尔值
.contains("str")                 #包含
```

# 13.输入输出
## 输入 --read-host
```powershell
#格式与python类似
$var = read-host "prompt(提示信息)"
```

# 其他
powershell .ps1
cmd         .bat
@echo off：关闭回显
执行脚本时，只返回结果，不输出命令
argument：参数

## 隐藏cmd窗口执行.bat
ps1调用
```powershell
Start-Process "cmd.exe" -ArgumentList "/c [其他路径]script.bat" -WindowsStyle Hidden
```

