---
title: about filesystems
date: 2022-03-23 23:34:11
tags:
---

```bash
# 查看 linux 支持的文件系统
cat /proc/filesystems
```
![](images/1523623-20220320235459194-1258184622.png)

* procfs  常见的 内存文件系统
The proc filesystem doesn't support capabilities, ACL, or even changing basic permissions with chmod. Unix permissions determine whether the calling process gets access. Thus only root can write that file. With user namespaces, that's the global root (the one in the original namespace); root in a container doesn't get to change sysctl settings.
* sysfs
常见的内存文件系统
* tmpfs
支持 xattr  常见的内存文件系统
* jffs2
支持 xattr 嵌入式常用的带有日志的
* squashfs
 支持xattr 高压缩只读文件系统
* iso9660
 光盘iso格式的文件系统
* ext4
支持 xattr Linux下常见的文件系统
* fat32
或者vfat ，U盘，sdcard常见文件系统
* NTFS
 Windows NTFS（英語：New Technology File System），是Microsoft公司开发的专用文件系统，从Windows NT 3.1开始成为Windows NT家族的默认文件系统。
* NFS
网络文件系统 (Network File System)
【参考】
https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html

