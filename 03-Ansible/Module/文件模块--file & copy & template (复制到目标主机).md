![[ansible.cfg 配置与目录结构设计#目录结构设计]]

# copy & template

```yaml
# site.yaml
---
- name: file module
  hosts: all
  gather_facts: no
  [become: yes]{启用特权升级，类似**sudo**}
  
  task:
  - name: Create a directory if it does not exist
    file:
      path: /etc/test
      state: directory
      mode: 700
  
  - name : copy file from local to remote
    [copy:]{只是复制，不会创建目录}
     src: files/test.txt
     dest: /etc/test/test.txt 
     # 默认赋予 `ssh`链接的用户
     owner: foo
     group: foo
     mode: '0644'
     # mode: u+rw,g-wx,o-rwx
     [backup: yes]{默认会覆盖文件}
     
  - name: test template
    template:
      src: templates/test.j2
      dest: /etc/test/test.cfg
     
```

[jinja2]{じんじゃ：神社}的语法　
```j2
# templates/test.j2
[default]
http_port = {{ [http_prot]{到**group_vars**或(和)**local_vars**中获取} }}
```