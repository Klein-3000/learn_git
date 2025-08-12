
# 1.静态页面部署

1. 安转httpd
2. 修改配置文件

```html
DocumentRoot "/www"

<Directory "/www">

		AllowOverride
		
		require all granted

</Directory>
```
3. 创建静态页面目录并修改所粗

```shell
mkdir /www

vim index.html
# 内容

<h1 style="text-align:center;color:SkyBlue>Welcome my website </h1>
```
4. 关闭防火墙,enforce设置为enforce(0)

```shell
systemctl stop firewalld

setenforce 0
```
> [!info] selinux和firewall-cmd
> # SELINUX
> 配置文件 /etc/selinux/config
> `SELINUX=enforcing`
> ## SELINUX的取值
> - enforcing   执行;强迫
> - permissive  宽容的
> - disabled      禁止
> ## [[firewall-cmd和selinux#1.firewall-cmd] | firewall-cmd命令]]
> ## [[firewall-cmd和selinux#2.selinux | selinux]]


# 编辑/etc/yum.repos.d/rhel8.repo文件
```shell
[BaseOS]
name=BaseOS
baseurlfile:///media/cdrom/BaseOS
enabled=1
gpgcheck=0
[Appstream]
name=AppStream
baseurl=file:///media/cdrom/Appstream
enabled=1
gpgcheck=0
```