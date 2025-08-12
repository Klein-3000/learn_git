# 1.提示快(提示框)
- [[#基础]]
- [[#嵌套]]
- [[#默认折叠与展开]]
- [[#其他样式]]

## 基础
> [!Note] WARNING
> 记得完成实验

## 嵌套
> [!Note] 嵌套-1
> 	这是第1层
> > [!Note] 嵌套-2
> > 这是第2层
## 默认折叠与展开
> [!Note]- 折叠
> test
> test1

> [!Note]+ 展开
> test1
> test2

## 其他样式


> [!quote] oh my god
> oh my


- note
- info
- tip
- faq
- error
- abstract :摘要
- about:关于(非)
- todo:代办
- success:成功
- failure:失败
- question:问题
- warning
- bug
- example
- danger:危险
- quote:引用

---
# 2.查询|query
- line 
- file
- created

```query
line:(git)
```
```query

file:(大作业)
```
# 3.代办列表
- [ ] table1
- [ ] table2
- [x] 格式`- [ ] text`

# 4.注释
<!-- html风格 -->
%%
预览模式,看不见
%%

# 5.==变量==和脚注
**名相同时,==第一个==为准**
## 变量
### 格式
```md
[变量名]

[变量名]:url

```
### 示例
 [linux主题]

[linux主题]:
https://github.com/HyDE-Project/hyde-themes?tab=readme-ov-file

## 脚注
### 格式
```
--设置
[^脚注代号]:内容

--引用
--预览模式下,自动显示在结尾
[^脚注代号]

```
## 示例


[^1]:周树人
[^2]:绍兴人

鲁迅原名是[^1],浙江[^2]

# 6.拓展标记
## 键盘文本 | `<kbd>`
<kbd>键盘文本</kbd>
<kbd>Ctrl</kbd>+<kbd>x</kbd>
## 放大(缩小)文本
- 普通文本
- <big>放大文本</big>
- <small>缩小文本</small>
## 颜色
<font style="color :blue">蓝色文本</font>

# 7.图 | graph
## 流程图
- mermaid:美人鱼
- graph:图
- LR:left right:左右
- TB:top bottom:上下

```mermaid
graph LR
girl((Elysia))
pardofelis-.虚线.->girl
thelema--实线-->girl-->pardofelis

```

## 饼图
~~~mermaid
pie
	title role
	"Elysia":50
	"thelema":31
	"pardofelis":19
~~~



