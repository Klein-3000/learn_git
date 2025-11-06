task
1. 源码包程序
2. LNMP 动态网站部署架构
3. 搭建WordPress 博客
4. 选购服务器主机
linux + nginx + mysql + php
# 源码包程序
1. [[压缩打包]]
2. 进入解压的目录
	\# 指定安装的位置(默认为==/usr/local/bin==)
	./configure --prefix=/usr/local/program
3. 对刚刚生成的makefile文件(编译,生成,安装)
	1. make          # 生成二进制安装程序
	2. make install  # 运行二进制的服务安装包
	3. make clean   # 清理源码包临时文件