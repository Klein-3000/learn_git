# ping
```yaml
# site.yaml
---
- name: system module
  hosts: all
  gather_facts: no
  
task:
  - name: ping 
    ping
    
  - name: print facts
    debug:
      msg: "{{ [ansiable_date_time]{gather_facts返回json中的字段} }}"
      
  - name: create group
    group:
      name: ansible_demo
      [state: present]{默认值为**present**,确保组的存在}
      
  - name: delete Group
    group:
      name: ansible_demo
      state: absent
      
  - name: create user
    user:
      name: demo 
      # {{}} : 变量或表达式
      # 调用 password_hash; 需要而外安装 passw
      password: "{{ '[demo]{passwd}' | password_hash('sha512') }}"
      
  - name: create user
    user:
      name: demo
      state: absent
      [remove: yes]{删除对应的家目录}     
    
```


# 单词
present : 出席；现在
absent : 缺席