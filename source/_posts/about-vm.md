---
title: About virtualmachine
date: 2020-02-18 19:12:54
tags: others
---
# 新建虚拟机的时候有磁盘类型选择
* IDE
* SCSI(Recommended)
* SATA
* NVMe
# 虚拟机文件磁盘类型
* qcow2
* raw
* vhd
* vmdk
# 常见的虚拟机软件
* VMware Workstation 
* Oracle VM BOX
* KVM(Kernel-based Virtual Machine)
* Xen 
##  VMware虚拟机client是Linux遇到如果在Shell下输错命令或按TAB键补全命令系统会发出类似“嘟嘟 或 滴滴”的蜂鸣声
  1. 编辑 /etc/inputrc设置 bell style 为none
  set bell-style none
  2. 编辑 /etc/inputrc设置　用#注释掉下面两行
    set bell-style visible
    set bell-style audible
  3. vmware 论坛有方案 将配置文件中的选项改为 mks.noBeep = "TRUE"
<p>
　　You can find the global configuration file at:

* Linux hosts:

　　~/.vmware/config
 
* Windows 2000 and XP hosts:

　　C:\Documents and Settings\All Users\Application Data\VMware\VMware_Product\config.ini
 
* Windows Vista, Windows 7, Windows 2008 Server R2, Windows 8, Windows 10 and Windows Server 2012 hosts:

　　C:\ProgramData\VMWare\VMware_Product\config.ini <br>
If the file does not exist, create a new text file and add the mks.noBeep line to it.
</p>

