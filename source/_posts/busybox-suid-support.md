---
title: busybox SUID support
date: 2022-03-23 23:53:12
tags:
---
* 开启 busybox对suid的支持,编译busybox前修改配置选项
![](images/1523623-20220321005945724-1384452418.png)

```bash
$ chmod u+s /bin/busybox
$ cat /etc/busybox.conf
[SUID]
echo = ssx root.root
```
