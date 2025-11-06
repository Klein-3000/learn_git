# 1.周期
## crontab
### 格式
```shell
# 五个时段
crontab 分 时 日 月 星(期) 命令

# 分 1~59
# 时 1~23
# 日 1~31 (L:last:最后)
# 月 1~12
# 星 0~7 (0和7都是星期日)

分钟 小时 日 月 星期几 要执行的命令
|    |   |  |   |      |
|    |   |  |   +----- 星期几 (0-7)（0和7=周日）
|    |   |  +------- 月份 (1-12)
|    |   +--------- 日期 (1-31)
|    +----------- 小时 (0-23)
+------------- 分钟 (0-59)


# 间隔
星期一和星期五
* * * * 1,5 command
# 连续
星期一到星期五
* * * * 1-5 command

每隔一天
0 0 */2 * *  command


```

### parameter 
```shell
crontab -l 列出当前的任务
crontab -e [时段 命令] :编辑当前用户的定时任务(打开的编辑器由"EDITOR"决定)
crontab -r [命令]  : 删除定时任务,无指定就是所有
crontab -u <user> :  指定用户(默认是当前用户)
crontab filename  : 执行filename文件中的cron

```
### 实际应用
```shell
# 每天凌晨2点运行脚本，并以日期命名日志文件
 0 2 * * * /home/verthandi/scripts/daily_job.sh > /home/verthandi/logs/daily_job_$(date +\%Y-\%m-\%d).log 2>&1
```
### 其他
- 后台服务: ==**crond**==
- 相关目录:==**/var/log/{syslog,crond}**==
- 删除cron后,自动将该cron备份在==**/home/${user}/.cache/crontab/**==目录中
# 2.定时
## at
### 查看与删除
```shell
atq

atrm <number>

```

|时间格式|示例|含义|
|---|---|---|
|now + N minutes         |at now + 5 minutes	         | 从现在起 N 分钟后|
|now + N hours	           |at now + 2 hours	             |从现在起 N 小时后|
|now + N days	           |at now + 3 days                 |从现在起 N 天后|
|HH:MM                    |	at 14:30	                     |当天的 14:30（下午 2:30）|
|HH:MM YYYY-MM-DD	|at 09:00 2025-06-02	     |指定日期和时间|
|midnight                 	|at midnight	                     |午夜（00:00）|
|noon	                        |at noon	                          |中午（12:00）|
|teatime	                    |at teatime	                      |下午 4 点|
### 在终端设置定时提示
```shell
echo 'echo "时间到了,请注意休息 > $(tty)"' | at 16:00

at 时间 <<EOF
echo "the is at command" > $(tty)
# 确保命令完整输出
sleep 1
# 不用手动ctrl-c退出
exit
EOF

```
###  注意事项
- at 命令默认==不会继承==当前用户的 shell ==环境变量==，建议在脚本中显式设置路径和变量。
- 如果系统==关机或重启==，未执行的 at ==任务将丢失==。
- 只有被授权的用户才能使用 at，管理员可以通过 ==/etc/at.allow ==和==/etc/at.deny ==控制权限
### at.allow和at.deny的内容
```shell
# 这是注释
user1
user2

# 在at.allow就是允许使用at命令的用户
# 在at.deny就是不允许使用at命令的用户

```
# 3.at和crontab的注意事项
### **Shell 环境**

- **问题**：`at` 默认使用 `/bin/sh`，而你的脚本可能依赖于特定的 shell 特性（比如 Bash）。
- **解决方法**：在命令前明确指定 shell。

### **输出重定向**

- **问题**：默认情况下，`at` 和 `cron` 将==标准输出==和==错误==发送到==用户的邮箱==（如果邮件服务可用）。如果没有配置邮件服务，输出可能会丢失。
# 4.显示和设置系统时间
```shell
# 显示
date

# 设置
sudo date -s "2025-06-01 15:52:00"
```
### Format
- %Y: 四位数的年份
- %m: 两位数的月份
- %d: 两位数的日期
- %H: 两位数的小时（24小时制）
- %M: 两位数的分钟
- %S: 两位数的秒
- %A: 完整的星期名
- %a: 缩写的星期名
- %B: 完整的月份名
- %b: 缩写的月份名
年月日: +%Y%m%d
时分秒: +%H%M%S(皆大写)
(大写完整,小写缩写)
星期 : +%a
月份 : +%b