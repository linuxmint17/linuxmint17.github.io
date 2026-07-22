---
title: windows 配置本地转发
date: 2022-03-23 23:39:33
tags:
---

* windows 配置本地转发
```cmd
netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=445 connectaddress=114.114.114.114 connectport=1445
# 监听本地 到445端口（samba)的 访问转发到 远端的 1445

netsh interface portproxy delete v4tov4  listenaddress=127.0.0.1 listenport=445 protocol=tcp
# 删除本地转发规则

netsh interface portproxy show v4tov4
#显示本地转发规则
```
