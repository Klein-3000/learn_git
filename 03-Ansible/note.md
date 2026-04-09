# hosts和 gather_facts的作用
### 1. `hosts: localhost`

**作用：指定这个 play（剧本）要在哪些主机上运行。**
- `localhost` 表示 **在运行 ansible 命令的本机（控制节点自身）上执行任务**。
- 这是 Ansible 的一个特殊关键字，代表当前执行 `ansible-playbook` 命令的机器。
- 不需要在 inventory（清单文件）中显式定义 `localhost`，Ansible 默认内置支持。

✅ 适用场景：
- 测试 playbook
- 本地文件操作（如生成配置、处理模板）
- 调用本地命令或脚本
- 控制流任务（如 pause、set_fact 等）

> 💡 如果你写的是 `hosts: webservers`，那 Ansible 会去 inventory 里找名为 `webservers` 的主机组，并在其上执行任务。

---

### 2. `gather_facts: no`

**作用：禁止 Ansible 在执行任务前自动收集目标主机的系统信息（称为 "facts"）。**
- 默认情况下，Ansible 每次运行 play 时会先执行 `setup` 模块，收集大量信息，例如：
    
    - 操作系统版本 (`ansible_os_family`, `ansible_distribution`)
    - IP 地址 (`ansible_default_ipv4.address`)
    - 内存、CPU、磁盘等硬件信息
    - 网络接口、时间、用户等
- 设置为 `no` 后，**跳过这一步**，可以：
    
    - ⚡ **加快 playbook 执行速度**
    - 🧼 **减少不必要的网络/系统开销**
    - 🔒 **避免在不支持 fact 收集的环境出错**（比如某些容器或受限 shell）