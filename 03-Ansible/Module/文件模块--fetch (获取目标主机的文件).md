![[ansible.cfg 配置与目录结构设计#目录结构设计]]

# fetch
```yaml
---
- name: file module
  host: all
  become: yes
  
  tasks:
	# 从目标主机获取
    - name: fetch a file
      fetch:
        src: /etc/test/test.txt
        dest: [./tmp/]{按**主机名**创建目录进行分类}
```
