---
title: Linux 下无法生成 coredump 文件
date: 2022-03-23 23:47:47
tags:
---
*  首先确认 linux内核配置支持了 coredump
*  然后 执行可执行文件的用户配置
```bash
ulimit -c unlimited
```
*  其次 确认配置了 /proc/sys/kernel/core_pattern 指定的生成core的路径，user 有写入权限
*  如果可执行文件 被chmod u+s 或者g+s 改过属性 或者setcap 添加过 capability 需要修改 节点
```bash
  echo 2 > /proc/sys/fs/suid_dumpable
```
* 配置 core_pattern
```bash
# 最简单的配置
echo /tmp/core_%e_%p > /proc/sys/kernel/core_pattern
# 复杂一丢丢的
echo /core/core_%e_%p > /proc/sys/kernel/core_pattern
mkdir -m 1777 /core
```

* 一个相关的网站

   https://sysctl-explorer.net/fs/suid_dumpable/

* 下方为man 5 core 的相关的摘要
![](images/1523623-20220320234410267-1834205770.png)

