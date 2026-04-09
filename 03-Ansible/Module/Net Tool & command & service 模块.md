# Net tools
## get-url & unarchive
```yaml
---
- name: net-tools module
  host: all
  become: yes
  
  tasks:
    - name: test get_url
      get_url:
        url: https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
        dest: /home/ubuntu/
        checksum: md5:e18a9d1a0a6d858b9787e03fc6fdaa20
        
    - name: test unarchive
      unarchive:
        src: /home/ubuntu/Python-3.8.0.tgz
        dest: /home/ubuntu/
        [remote_src: yes]{默认值为**no**， unarchive的**src**默认指定的是本地资源}
       
    # 从本地复制到目标主机上，会自动解压 
    - name: test unarchive local file
      unarchive:
	    src: local_file.tgz
	    dest: /home/ubuntu
      
```
## uri
```yaml
---
- name: net tools module
  host: all
  become: yes
  
  tasks:
    - name: test uri
      uri:
	    url: https://www.example.com
	    return_content: yes
	  register: result
	- debug:
	   var: result
```
# Command
```yaml
---
- name: command module
  host: all
  become: yes
  
  tasks:
    - name: test command
      command: cat /etc/hosts
      register: host_value
      
    - debug:
        msg: "{{ hosts_value }}"
  
```
# Service
```yaml
---
- name: service module
  host: all
  become: yes
  
  tasks:
  - name: start nginx
    service:
      name: nginx
      state: started
      
```
service state的其他值
- reloaded
- restarted
- started
- stopped