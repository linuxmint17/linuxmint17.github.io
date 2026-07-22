---
title: 嵌入式 bootargs mtd自动分区的设置
date: 2022-03-23 23:44:38
tags:
---
* 内核mtd子模块 需要开启 cmdline partition parse的支持
![](https://img2022.cnblogs.com/blog/1523623/202203/1523623-20220320223605579-2042250006.png)

* bootargs 要配置正确的分区表
```bash
uboot#
setenv bootargs console=ttyS0,115200 root=/dev/mtdblock2 rootfstype=jffs2  init=/init mem=64M mtdparts=spi0.0:704k(boot),2048k(kernel),2432k(rootfs),1664k(drv),-(app)
uboot#
sa
uboot#
reset
*
