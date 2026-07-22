---
title: C++ VS c
date: 2020-02-24 17:55:43
tags: C/C++
---
# C++ 曾经被叫做C With class, C++ 是兼容C的，并不是100%兼容
  C++ 中的C子集是C++的一部分，C语言中允许的东西到C++中可能会不允许  
  1. 全局变量初始化: C语言中只能使用 constant初始化全局变量 C++可以通过函数初始化
```cpp
#include <stdio.h>
int init()
{
    printf("inside init func\n");
    return 100;
}

int global_int = init(); // 此语句cpp文件能够编译执行，c文件编译失败

int main()
{
    printf("Hello world\n");
    printf("global_int= %d\n", global_int);
    return 0;
}
```
# C++的C子集 是更好的C，将C中的一些不严格的编译检查，变得相对更严格

# C++ 编译器编译之后函数的 mangling name 和C编译器编出来的函数名称的 namgling name 不一样,
　　当C++代码调用非标准规定的的C库(比如说FFmpeg是一个纯C的库)的时候，先包含C的头文件然后使用 
```cpp
# include ""
extern "C" { c } 
```
# C++ 中的 引用reference vs 指针pointer
　　指针是某个内存对象的地址，通过指针可以间接地修改内存对象的内容
　　引用是种隐式(implicit)的指针, 是某个对象的别名，通过以引用可以直接操作该对象
```cpp
#include<iostream>
// 此函数通过引用直接修改指针i, 使其自增1，指针自增或者自减的大小是指针指向的内存的基本类型的大小sizeof(int)
void func(int* & i)
{
    i++;
}

int main()
{
    int *i = 0;
    func(i);
    printf("%d\n", i); // 结果应该是4
    return 0;
}
```
