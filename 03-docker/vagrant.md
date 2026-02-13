# 简介

加速 : https://mirrors.ustc.edu.cn
# 命令
```shell
# 启动
vagrant up

# 查看状态
vagrant status

# ssh 链接
vagrant ssh
vagrant ssh-config

# 管理
vagrant [suspend]{暂停}/[resume]{重启开始}/[halt]{关机}/reload <name>

# 删除
vagrant destroy <name>

 
```

---
# 相关文件和目录
## Vagrantfile
### 基本内容
```shell
# vagrant init
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004"
  
  # 使用 provider 为 [libvirt]{后台服务 **libvirtd**} 报错时的解决方案
  #config.vm.provider :libvirt do |libvirt|
  #  libvirt.uri = 'qemu:///system'
  #end
  
end
 
```
### 拓展
```shell
# vagrant init
Vagrant.configure("2") do | [config]{变量名, **全局**变量} |
  config.vm.box = "generic/ubuntu2004"
  
  # 全局配置
  ## 自定义 box 的 hostname
  config.vm.hostname = "vagrant-demo"
  ## 指定 box 的版本
  config.vm.box_version = "1905.1"
  
  # 局部配置
  ## 创建多个 host -- 都会继承全局配置
  config.vm.define "<box_name1>"
  config.vm.define "<box_name2>"
  ## 个性化配置
  config.vm.define "<box_name3>" do | [var]{变量名,**局部**变量可自定义} |
	  var.vm.hostname = "box_name3"
  
  
end
 

 
```
## 目录 
### 项目目录 -- .vagrant
```shell
.vagrant
├── machines/
│   └── [default/]{box_name}
│       └── [libvirt/]{provider,既**从哪来** 如virtualBox,Hyperv,VMware}
│           ├── action_provision
│           ├── box_meta
│           ├── created_networks
│           ├── creator_uid
│           ├── id
│           ├── index_uuid
│           ├── [private_key]{`vagrant ssh`链接使用的私钥}
│           ├── synced_folders
│           └── vagrant_cwd
└── rgloader/
    └── loader.rb
 
```
### 全局目录 -- ~/.vagrant.d/
```shell
/root/.vagrant.d
├── boxes/
├── data/
├── gems/
├── insecure_private_key
├── rgloader/
├── setup_version
└── tmp/

 
```
# 单词
destroy : 毁坏
History : 历史
story   : 故事
suspend : 暂停
resume  : 重新开始
halt    : 滑溜溜的
provider : 供应商