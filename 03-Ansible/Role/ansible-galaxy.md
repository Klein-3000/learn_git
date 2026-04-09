# 初始化
```bash
# 创建一个新的 role
# 建议在 Roles 目录中执行
ansible-galaxy init <role_name>

# 搜索
ansible-galaxy search <role_name>
# 安装
ansible-galaxy install <username.role_name>
# 列出
ansible-galaxy list 
# 删除
ansible-galaxy remote <role_name>

```
> [!attention] 注意
> git (==/==) : user/repository
> ansible-galaxy(==.==) : user.role
> ansible-galaxy : 使用`_` 作为分割符

# 安装 Role 到本地
![[Role目录结构#目录结构]]
## requirements.yml
### 从 github 获取
```yml
roles:
 - src: https://github.com/xiaopeng163/ansible-galaxy-demo
   scm: git
   version: master
```
### 从 galaxy.ansible.com 获取
```yaml
roles:
  - src: xiaopeng163.ansible_galaxy_demo
    version: master
  - src: geerlingguy.memcached
    version: 1.0.8
```
## 安装
```bash
ansible-galaxy install -r requirements.yml [ --ignore-certs ]
# 默认安装到 ~/.ansible/roles 目录中
```
## 网站
https://galaxy.ansible.com

