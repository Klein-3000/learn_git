# yum
```yaml
# site.yaml
---
- name: package module
  hosts: all
  gather_facts: no
  [become: yes]{启用特权升级，类似**sudo**}
  
tasks:
  - name: test yum module
    yum:
      name: git
      state: present
      
# 安装多个
  - name: multi
    yum:
      name: "{{packages}}"
    vars:
      packages:
      - httpd
      - httpd-tools
  
```
  
# apt
```yaml
# site.yaml
---
- name: package module
  hosts: all
  gather_facts: yes
  [become: yes]{启用特权升级，类似**sudo**}
    
# 安装多个  
tasks:
  - name: test yum module
    apt:
      name: 
        - git
        - samba
      state: present
    # 是 Ubuntu 时，才执行 apt命令
    when: ansible_facts['distribution'] == "Ubuntu"
      
  - name: test yum module
    yum:
      name: git
      state: present
    # 是 CentOS 时，才执行 apt命令
    when: ansible_facts['distribution'] == "CentOS"
```
# package
特点：自动==识别==操作系统，调用对用的包管理工具
```yaml
---
- name: package module
  host: all
  
tasks:
  - name: General Package manager
    package:
      name: git
      state: persent
```
# pip
需要
- pip
- virtualenv
- setuptools
```yaml
---
- name: pip
  host: all
  gather_facts: no
  become: yes
  
tasks:
  - name: pip install flask
    pip:
	  name: flask
	  state: present
	  virtualenv: /home/ubuntu/[vir]{这个不存在, 由**venv**创建}
	  virtualenv_command: /usr/bin/python3 -m venv
	  
  - name: install [specified]{指定} python requirements in indicated
    pip:
      requirement: /my_app/requirements.txt
	
```

# 单词
distribution ： 分布
general ： 通用