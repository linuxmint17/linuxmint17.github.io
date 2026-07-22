---
title: About GCC
date: 2020-01-20 22:46:20
tags: Tool
---
## gcc
　　gcc 是 GNU Compiler Collection 的缩写，不仅支持 C/C++的编译，还支持Java等
## gcc 基本操作
```bash
 gcc hello.c -o hello 
```
　　会编译输出 hello 可执行文件，如果不使用-o选项指定输出的文件名怎会生成 a.out文件

## 神奇的a.out
　　是汇编(assemble)输出(output)的意思在freebsd 中 man a.out 可以看到相关信息
## gcc的扩展支持语法
   1. 函数内部定义函数
   ```cpp
foo (double a, double b)
{
  double square (double z) { return z * z; }

  return square (a) + square (b);
}
   ```
