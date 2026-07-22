---
title: sudo echo 3 > /proc/sys/vm/drop_caches 权限不足
date: 2022-03-23 23:46:43
tags: Linux
---
```bash
# 以下命令可以解决 sudo 权限不够的问题
sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
# 以下命令也可以
sudo sysctl -w vm.drop_caches=3
```
