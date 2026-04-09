# 优先级
1. `ANSIBLE_CONFIG`
2. ansible.cfg
3. ~/ansible.cfg
4. /etc/ansible.cfg
# 基本内容
```cfg
[default]
Inventory = inventory/hosts
```

# 目录结构设计
```
.
├── files                      # copy Module 使用
├── templates                  # template Module 使用
├── ansible.cfg                # 全局 Ansible 配置（可选，也可在各环境内覆盖）
├── site.yml                   # 主 playbook
└── inventory/
    ├── production/
    │   ├── hosts
    │   ├── group_vars/
    │   │   └── all.yaml
    │   └── host_vars/
    │       ├── host1.yaml
    │       └── host2.yaml
    └── test/
        ├── hosts
        ├── ansible.cfg         # 可选：针对 test 环境的特定配置
        ├── group_vars/
        │   └── all.yaml
        └── host_vars/
            ├── host1.yaml
            └── host2.yaml
```

ansible.cfg
```cfg
[default]
inventory=inventory/test/hosts
```