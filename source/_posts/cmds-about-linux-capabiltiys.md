---
title: Linux capabilities 相关的命令 
date: 2022-03-23 23:45:40
tags:
---
* 可以通过一些命令设置 可执行文件的capabilities 或者查看进程或者文件的capabilites
``` bash
# opensuse 安装命令
sudo zypper install  -y libcap-ng-utils libcap-progs
# debian 安装命令
sudo apt install libcap2-bin libcap-ng-utils
```
``` bash
# 查看当前有特殊capabilites的所有进程
pscap -a
```
![](images/1523623-20220320231801303-557692776.png)

```bash
# 查看指定进程的capababilities
getpcaps  1252
```
![](images/1523623-20220320231829321-341864005.png)

```bash
# 显示文件系统中支持capabilities的 文件
filecap
```
![](images/1523623-20220320231700675-913474523.png)
```bash
# 给 可执行文件赋予 capability
sudo setcap  'cap_net_admin,cap_sys_admin'+eip /bin/busybox
sudo setcap '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37'+eip /bin/busybox
# 获取可执行文件的 capability
sudo getcap /usr/bin/cdrecord
```
![](images/1523623-20220320231953717-1924941323.png)

