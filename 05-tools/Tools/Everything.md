 everything : https://www.voidtools.com/zh-cn/
操作符: 
1. space	与 (AND)
2.  |	或 (OR)
3. !	非 (NOT)
4. < >	分组
5. " "	搜索引号内的词组.通配符: 
6. *	匹配 0 个或多个字符.
7. ?	匹配 1 个字符.宏: 
8. quot : 双引号 (")
9. apos : 单引号 (')
10. amp : 与号 (&)
11. lt : 小于 (<)
12. gt : 大于 (>)
13. `#<n> : 十进制 Unicode 字符 <n>`.
14. `#x<n> : 十六进制 Unicode 字符 <n>`.
15. audio : 搜索音频文件.
16. zip : 搜索压缩文件.
17. doc : 搜索文档文件.
18. exe : 搜索可执行文件.
19. pic : 搜索图片文件.
20. video : 搜索视频文件.修饰符: 
21. ascii : 启用快速 ASCII 大小写对比.

# 其他知识
[【神器工具1分钟入门】everything#07 另类的文件重命名，太神了，你一定得看，我崩溃了_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1rY411u7v8?spm_id_from=333.788.player.switch&vd_source=7cf858504e86c3660b73a6ea8f54d272&trackid=web_related_0.router-related-2206419-45xsh.1761381276163.597)

## everything选项
![[everything_选项.png]]
![[everything_选项-效果.png]]

## 另类重命名
![[everything_重命名.png]]
操作
	- 选中文件或目录
	- 右击`重命名`
特点
	1. 支持正则
	2. 支持直接大小写,首字母大写等
	3. 可在`新文件名(n)`中为,为每个文件或目录**单独**重命名

## 高级移动与复制(`编辑`)
![[everything_高级移动与复制.png]]


## 添加筛选器
![[everything_筛选器.png]]

语法
	ext:<文件拓展名>\[;<文件拓展名1>...]
	记得填写`名称`和`宏`

拓张
	word : ext:doc;docx;wps;docm;dotx
	ppt : ext:ppt;pptx;dpt;pptm;potx
	excel : ext:xls;xlsx;et;xlsm;xltx
	office : ext:doc;docx;wps;docm;dotx;ppt;pptx;dpt;pptm;potx;xls;xlsx;et;xlsm;xltx