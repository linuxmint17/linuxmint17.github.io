---
title: About Makefile
date: 2020-01-24 11:24:17
tags: Tool
---
# make 是用来组织大型工程必不可少的工具
　　make 有各种变体: Qt的qmake, 跨平台的 cmake, 微软的 nmake
# make menuconfig
　　好像最早是在linux kernel 中使用到的, 在构建kernel 之前使用这个命令会 
  根据kernel目录下的Makefile和其他的文件以及kconfig语法生成命令行的gui菜单可以勾选，依赖 ncurses
# make -n
　　make 调试使用的命令，空跑一次，不执行实际操作，把要执行的动作打印出来
# make -f filename
　　指定makefile 文件，不默认寻找 Makefile,makefile
# make 
　　假设当前目录下有 hello.c 执行make hello 会尝试编译 hello.c 到hello
# make -C dir_name 
　　执行make 命令之前 进入到 dir_name 中, 常常在项目中递归的使用
# make -k 
