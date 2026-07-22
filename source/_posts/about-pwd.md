---
title: About pwd
date: 2020-01-28 20:31:17
tags: Linux/C
---
# 关于工作路径
　　工作路径是进程的一个重要的属性，在pcb结构中应该是一项成员，平时和文件交互的比较少的业务很少会关注程序的工作路径的问题
# 情形
　　为了适配不同的厂商或者版本，想要后台程序通过读取配置文件方法来，减少某个组件编译次数, 每次厂商变更只需要改下配置文件中的厂商名字就行了，不必要在代码中写死，每次都要换个厂都要加个宏，在代码中加入一个常量
# 需求
　　Android后台程序(为方便设置为daemon.exe位于/system/bin/目录下)daemon.exe开机启动的时候要读取/system/bin/下的product.conf文配置文件.

# 代码实现 主要代码就是打开文件的地方，然后调用系统的解析取配置文件的接口，读取配置文件是一个有意思的小项目，可以自己实现一次
```cpp
Linux 环境中包含 <unistd.h>头文件可以使用
getcwd, getwd, get_current_dir_name 获取程序的当前工作路径

       char *getcwd(char *buf, size_t size);

       char *getwd(char *buf);

       char *get_current_dir_name(void);
```
```cpp

#define CONFIG_FILE_PATH "./product.conf"
int app_init()
{
// 省略若干行代码...
  FILE *fp = fopen(CONFIG_FILE_PATH, "r");
  if (fp == NULL) {
     printf("fopen error");
     return -1;
  }
  char *current_work_dir = get_current_dir_name();
  if (current_work_dir != NULL) {
      printf("current working dir is [%s]", current_work_dir);
      free(current_work_dir);
  }
// 省略若干行代码...
  if (fp != NULL)
  fclose(fp);
// 省略若干行代码...
}
```
## 问题出现之后我的直觉告诉先打印errno, 然后猜测可能是工作路径的问题就，调用系统的函数获取不同情境下的工作路径
手里没有root权限的android 手机，就使用linux，linux中开机拉起服务的地方加入自己写的程序的路径

#附加题：如何创建守护进程？ 参考 APUE
1. 通过fork 创建子进程
2. 子进程kill 父进程
3. 设置自己的工作路径
4. 

这个时候是采用绝对路径，还是相对路径
项目中的程序位于 /system/bin 下配置文件也在同一级文件目录中。
程序开机由系统脚本拉起后常驻后台，检测其他进程.

首先设为绝对路径，./exe 拉起 测试ok,系统脚本拉起也ok,但是同事A认为同一级目录下 直接读取文件名就可以了，
听命令改，./exe 测试ok ,然而系统脚本拉起之后整个系统无法正常运行，因为配置文件没有读取到，程序报出错误打印
经过测试，Android init.rc 中拉起的程序工作路径是/ ，而非程序所在目录，当使用 ./exe 拉起程序的时候工作路径在当前目录
使用相对路径自然找到配置文件