---
title: Linux commands
date: 2020-02-14 16:06:06
tags: Linux
---

# linux 命令列表
1. systemctl (Control the systemd system and service manager)

    systemd 系统用来替代之前的linux 中的system V 目的在于统一系统服务,
    并行启动系统服务程序,加快系统启动,大部分现代linux使用此程序引导系统.  
    **常用命令如下**
```bash
#    systemctl enable service_name
#    systemctl start service_name
#    systemctl status service_name
#    systemctl restart service_name
#    systemctl disable service_name
```

2. pushd  popd

　　pushd dir_name 切换目录的同时把当前目录圧入栈,方便后续使用popd 弹出栈切换目录  

　　popd 弹出上一次的目录栈，相当于cd -
    popd 可以多次使用，直到目录栈为空，cd - 多次使用只会在两个目录之间来回切换

3. grep  
```bash
$ grep -nrw getPower --include="*.h,*.c"
```
　　递归的查找当前目录中c文件和头文件，全词匹配 getPower -n 显示行号， -w 全词匹配 -r递归

4. sed(stream editor for filtering and transforming text)  

    流文本编辑器，执行格式匹配和替换 -i 输出到源文件
5. firewall-cmd 取代 ipfilter  

　　debian系的 可以通过sudo apt-get -y install firewalld安装
    * 开放端口
sudo firewall-cmd --permanent --add-port=22444/udp && sudo firewall-cmd --permanent --add-port=22444/tcp && sudo firewall-cmd --reload
    * 关闭端口
sudo firewall-cmd --permanent --remove-port=22444/udp && sudo firewall-cmd --permanent --remove-port=22444/tcp && sudo firewall-cmd --reload
    * 将80端口的流量转发至192.168.0.1的8080端口
sudo firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toaddr=192.168.0.1:toport=8080
    *使防火墙规则生效 </br>
    firewall-cmd --reload 
    * 列出所有的防火墙规则 </br>
    firewall-cmd  --list-all
    * 列出所有的防火墙允许通过的服务规则</br>
    firewall-cmd --list-services
    * 列出所有的防火墙开放端口规则</br> firewall-cmd --list-ports
6. yum install python-pip python34-pip </br>
　　centos 安装pip 管理python包
## cetnos selinux 下开启/变更 ssh 端口
``` bash
# yum provides semanage 查询哪个软件包提供 semanage ,debian系的 用apt-cache search semanage
# yum -y install policycoreutils-python
# semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
```
## linux 安装 libsodium 
``` bash
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar xfz LATEST.tar.gz && cd libsodium-stable/
```
## centos 安装epel软件源
``` bash
# yum -y update && yum -y install epel-release
```
## opensuse 搜索软件组 
``` bash
# zypper install -t pattern
```
## opensuse 中文指导文档
[文档链接](https://opensuse-guide.ustclug.org/srvlamp.php)

## 查看linux运行级别
``` bash
$ who -r
$ runlevel
```
## 查看linux的默认网关
``` bash
$ route -n
$ netstat -nr
```
# install ssh
``` bash
apt-get install ssh
```
# install man pages
``` bash
apt-get install manpages-posix-dev
apt-get install glibc-doc
```
# install git
``` bash
apt-get install git-core gitk
```
# install build-essential 
``` bash
atp-get install build-essential gcc-doc
```
# change all files permession  current dir
```bash
find ./ -type d -exec chmod 644 {} \;
```
# change all dir permession in  current dir
```bash
find path -type d -exec chmod 755 {} \;
```
# what todo whit DHCP timeout is taking so long. 
 Edit \/etc/sysconfig/network/dhcp and change the values for DHCLIENT_WAIT_AT_BOOT and DHCLIENT6 WAIT AT BOOT
# 目录介绍
1. \/usr/local/ 一般安装自己编译的软件
2. debian系的/lib/systemd/system 目录下有各种service文件和系统运行级别的target文件
3. debian系的 \/usr/lib/systemd/usr/ 目录一般存放用户定义的service


