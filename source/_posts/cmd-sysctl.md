---
title: cmd sysctl
date: 2022-03-23 23:49:22
tags:
---
```bash
# 写入配置
sudo sysctl -w fs.suid_dumpable=2
# 读取配置项
sudo sysctl  fs.suid_dumpable
# 显示 所有的 可以配置的选项
sudo sysctcl -a
```
