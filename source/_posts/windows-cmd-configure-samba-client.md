---
title: windows 命令行 配置samba client
date: 2022-03-23 23:38:02
tags:
---

* windows 命令行 配置samba
```bash
net use
# 查看所有 samba 连接

net use /delete *
# 移除所有samba
net use z: /delete
# 删除 z:盘映射

net use z: \\192.168.28.22\wang  /user:username passwd
# 挂载samba共享为 z:盘
```
