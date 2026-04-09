# Roles
[[ansible.cfg 配置与目录结构设计]]
## 目录结构

```
demo-Role/
├── inventory/
│   ├── hosts                 # ← 建议改名为 hosts
│   ├── group_vars/
│   │   └── all.yml           # 示例
│   └── host_vars/
├── roles/
│   ├── deploy-code/
│   │   └── tasks/
│   │       └── main.yml      # ← 必须存在
│   └── install-python/
│       └── tasks/
│           └── main.yml
├── [requirements.yaml]{ansible-galaxy 讲解}
├── ansible.cfg
└── site.yml
```
## main.yml
```yaml
# demo-Role/roles/install-python/tasks/main.yml
# 不用写 `tasks`
- name: install python
  become: yes
  yum:
    name: 
     - python3
     - python3-devel
     - python3-pip
     - python-setuptools
    state: present
  when: ansible_fcts['distribution'] == "CentOS"
   
```

## site.yml
### 旧的语法
```yml
---
- name: demo role
  hosts: all
  
  tasks:
   - include_role:
      name: install-python
    
   - include_role:
       name: deploy-code
       
   - name: start flask app
      shell: "nohup ~/flask-ansible-demo/.env/bin/python ~/flask-ansible-demo/wsgi.py > /tmp/flask.log 2>&1 &"
      register: myoutput
      
   - name: print stdout
	 debug:
	   var: myoutput
  
   
```
### 新的语法
```yml
---
- name: demo role
  hosts: all
  roles:
   - install-python
   - deploy-code
```

```yml
---
- name: demo role
  hosts: webServers
  
  tasks:
    - import_role:
      name: install-python
```

# 其他内容
handler(饲养员) : 主要用于==检测==配置是否**修改**（与 tasks 同级。用途检查到配置文件被修改提醒管理员重启服务