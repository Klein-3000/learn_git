# 终端语言设置
![[hostname(ctl)和fc-cache和language(语言)#language(语言)]]
# 添加命令到环境变量中
```bash
# 查看
echo $PATH

# 单用户使用(软连接方法, 相关目录/usr/local/bin/)
# ln -s 源 目的
ln -s /home/$USER/.fzf/bin/fzf /usr/local/bin/fzf

# PATH （添加到 .bashrc 或 .zshrc 文件)
export PATH=$PATH:/home/$USER/.fzf/bin/fzf

```
## 多用户使用
```bash
# 将命令目录安装在/opt中

# 软连接到/usr/local/bin目录中
ln -s /opt/command_dir/command  /usr/local/bin/command

# 权限问题
# 目录
sudo chmod -R 755 /opt/command_dir/
# 命令
sudo chmod +x /opt/command_dir/command
```
# windows编辑脚本无法在linux中执行
## 查找问题
```bash
head -n1 script_name.sh | cat -A
```
有问题的输出结果
```bash
#!/bin/bash^M$
```
> [!summary] 原因
> 这里的 `^M` 就是罪魁祸首 —— 它是 Windows 风格的回车符 `\r`。
> Linux/Unix 系统的换行是 `\n`，而 Windows 是 `\r\n`。当你在 Windows 上编辑脚本并上传到 Linux时，就会带入这个 `\r`，导致 shebang 解析失败。

## 解决问题
### sed命令(简单高效)
```bash
sed -i 's/\r$//' script_name.sh
```
### 使用vim编辑器
```bash
:set fileformat=unix 
:wq
```



# 一
## 二
### 三
#### 四
##### 五
###### 六
