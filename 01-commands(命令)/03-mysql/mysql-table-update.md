```mysql
update 表名 
	set 字段1=值1, 字段2=值2 
[where]{默认**全部替换} 条件;
	
```

example
```mysql
update students
	set age=18
where
	name = "verthandi";
```