


VMware vSphere是业界领先的虚拟化和云计算平台，该平台高效、安全，适用于混合云

VMware vSphere各个版本除了有不同的功能外，它们对硬件及虚拟机的支持也是有区别的


# 概述

## 虚拟化规划

在虚拟化实施的过程中，如果使用现有的服务器，推荐优先为服务器添加内存、网卡，其次是配置冗余电源、CPU。至于硬盘，在企业虚拟化项目中，优先是配置共享的存储，其次是添加本地硬盘

在实施需要进行容量规划，即一台物理机最多能放多少虚拟机。这是一个综合的问题，既要考虑主机的CPU、内存、磁盘（容量与性能），也要考虑运行的虚拟机需要的资源。在实际使用时，系统总有至少30%甚至更高的富余容量，如果主机上的资源利用率超过80%，整个系统响应会比较慢

在估算虚拟化的容量时，在只考虑CPU的情况下，可以将物理CPU与虚拟CPU按照1∶4～1∶10甚至更高的比例规划。例如一台物理的主机具有4个8核心的CPU，在内存、存储足够的情况下，按照1∶5的比例

在虚拟化时。内存比 CPU 重要

## vSphere

vSphere 不是一个单独的产品，它由一系列产品、组件组成，

- VMware ESXi Server: 计算服务器
- vCenter Server和vSphere Client: 管理端
- VMware High Availability（HA）
- VMware vMotion: 将虚拟机在 VMware ESXi 之间迁移
- VMware Distributed Resource Scheduler（DRS）
- VMware Update Manager
- VMware Converter Enterprise: 完成从虚拟机/物理机到VMware虚拟机的转换

VMware Converter Enterprise可以，VMware vMotion可以实现。

vSphere 数据中心拓扑：

![1589683723](https://pic.haoyu95.cn/uploads/big/048291e492204c605b6b4fe122e6e3f2.png)

数据中心由x86虚拟化服务器、存储器网络和阵列、IP网络、管理服务器和桌面客户端组成


## vCenter Server

vCenter Server 是 VMware vSphere 虚拟化架构中的核心管理工具，可以集中管理多台ESXi主机及虚拟机

vCenter Server是实现VMware High Availability（HA）、VMware vMotion、VMware Distributed Resource Scheduler（DRS）的基础


在vSphere中，清单是可对其设置权限、监控任务与事件并设置警报的虚拟和物理对象的集合。使用文件夹可以对大部分清单对象进行分组，从而更轻松地进行管理。

vSphere管理员可以按用途重命名除主机之外的所有清单对象。例如，可按公司部门、位置或功能对它们进行命名。vCenter Server监控和管理以下虚拟和物理基础架构组件。




# 安装

## ESXi

ESXi 即虚拟化主机 VMware ESXi，不同版本的 ESXi 对系统和硬件要求，详见[https://www.vmware.com/resources/compatibility/search.php](https://www.vmware.com/resources/compatibility/search.php)

可以制作 U 盘，通过光盘启动并加载 VMware ESXi 安装镜像，安装时会对磁盘重新进行分区，即清楚之前的所有数据

安装后可以在 管理->服务 处开启 ssh

管理->系统->时间和日期 配置 NTP  用以同步计算机协议


## vCenter Server


访问 5480 页面的时，需使用 https 访问



# 使用





- [使用 vsphere-automation-sdk-python 自动创建虚拟机](https://juejin.im/post/5d08c5cee51d45777a1261a2#heading-35)
- [Disable Virtual Machine Swap File (.vswp)](https://www.virten.net/2014/09/remove-virtual-machine-swap-file-vswp/)


- [在 VMware Host Client 中挂载 NFS 数据存储](https://docs.vmware.com/cn/VMware-vSphere/6.0/com.vmware.vsphere.html.hostclient.doc/GUID-9F526FAE-A72E-462B-86CE-14078D3A3C67.html)



