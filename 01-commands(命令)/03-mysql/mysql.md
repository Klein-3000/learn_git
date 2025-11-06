mysql命令行清屏
- system clear
- linux的    \\! clear 
- windows的 \\! cls
# 查询
## 基本查询
```
select \* from <table_name>
```
### 修改列名
```shell
select name as "名字", age as "年龄" from <table_name>
 
```
## 条件判断(where, 写在==from==的后面)
### 大小 (>, >=, <= <, \==, !=)
```shell
select \* from <table_name>
where
	age > 20;
 
```
### 逻辑(or, and, ==not==) 
```shell
select \* from <table_name>
where
	class == '2班' and age >= 20;
 
```
### 模糊(like) 
```shell
select \* from <table_name>
where
	name like '%李%';
 
```
> [!note] 拓展
> # % 与 _
> - % : 多个
> - _   : 一个
> # 常用
> 包含'李'  : '%李%'
> 开头'李'  :  '李%'
> 结尾'李'  :  '%李'

### 去重(==distinct==) 

```shell
select distinct class_id,exam_num  from <table_name>
 
```
### 排序(order by) 
- asc : 升序
- desc : 降序
```shell
select \* from <table_name>
order by 
	score desc, age asc;
 
```
### 截断和偏移(limit,==下标==) 
下标从==0==开始
```shell
select \* from <table_name>
limit [start:0]  <offset>
 
```
## 写在select后的
### case (无中生有,基于其他列做出的判断)
```shell
select name,
case when (age > 20) then '成年'
		when ( age > 60) then '年老'
		else '儿童'
		end as '年龄称呼'
from <table_name>
 
```
### 函数
1. date() 日期
2. time() 时间
3. datetime() 日期时间
4. length()  长度
5. 字符处理
	- upper() : 大写
	- lower() : 小写

### 聚合函数
- COUNT：计算指定列的==行数==或==非空值==的数量。
- SUM：计算指定列的数值之和。
- AVG：计算指定列的数值平均值。
- MAX：找出指定列的最大值。
- MIN：找出指定列的最小值。