---
title: Linux software commonly used
date: 2021-08-07 16:06:06
tags: Linux
---

### ubuntu 内核调试开发常用软件包名 记录

```bash
libncurses5-dev gcc-arm-linux-gnueabi build-essential gcc-5-arm-linux-gnueabi git libssl-dev openssl bc flex bison qemu make gdb gdb-multiarch \
device-tree-compiler uml-utilities bridge-utils  nfs-kernel-server
```
```bash
# openssl's lib
libssl-dev
# elf's lib
libelf-dev
```
## 内核启动的三种方式
* initrd （init ram disk）
* init= 
* root
