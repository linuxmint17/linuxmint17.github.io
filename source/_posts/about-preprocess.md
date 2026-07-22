---
title: About preprocess
date: 2020-02-23 16:29:51
tags: C/C++
---
# 预处理是C/C++ 编译过程中的第一个环节, 处理以\#开头的文本行
* 比如免费版和付费版的功能多少的条件编译
* 实现代码对于不同平台的兼容，或者对相同平台的不同版本进行兼容
# 宏的作用常见的就是简单的文本替换功能，实现函数的替换，DEBUG版本加打印，release 版本不加打印
```cpp
// 此代码来自 Learn C the hard way 一书
#ifndef __dbg_h__
#define __dbg_h__

#include <stdio.h>
#include <errno.h>
#include <string.h>
#ifdef NDEBUG
#define debug(M, ...)
#else
#define debug(M, ...) fprintf(stderr, "DEBUG %s:%d: " M "\n", __
FILE__, __LINE__, ##__VA_ARGS__)
#endif
#define clean_errno() (errno == 0 ? "None" : strerror(errno))
#define log_err(M, ...) fprintf(stderr, "[ERROR] (%s:%d: errno:
%s) " M "\n", __FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
#define log_warn(M, ...) fprintf(stderr, "[WARN] (%s:%d: errno:
%s) " M "\n", __FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
#define log_info(M, ...) fprintf(stderr, "[INFO] (%s:%d) " M "\n"
, __FILE__, __LINE__, ##__VA_ARGS__)
#define check(A, M, ...) if(!(A)) { log_err(M, ##__VA_ARGS__); e
rrno=0; goto error; }
#define sentinel(M, ...) { log_err(M, ##__VA_ARGS__); errno=0;
goto error; }
#define check_mem(A) check((A), "Out of memory.")
#define check_debug(A, M, ...) if(!(A)) { debug(M, ##__VA_ARGS__
); errno=0; goto error; }
#endif
```
# 字符串化输入
　　\# 可以实现将输入的内容字符串化
```cpp
#define STR(input)  #input
```
# 粘贴两个字符串 
　　\#\# 可以粘贴两个字符串
```cpp
#define STRPASTE(str1, str2)  str1##str2
```
# 宏函数的嵌套调用翻译过程
```cpp
#if defined(ANDROID1) && defined(ANDROID2)
int android = 12;
#endif
#if ANDROID2
int android = 12;
#else
int android = 1;
#endif// end of android2

#ifdef ANDROID1
#ifdef ANDROID2
int android  =12;
#endif
int android = 1;
#endif
```
```cpp
#define ANDROID9 1
#define STRINGLIZE(input)  #input
#define CATSTRINGS(str1, str2) str1##str2
```
# 预处理中常见的关键字，和写法
1. 注释代码
```cpp
#if 0
// temperatory deleted code or debug/test code
#endif
#ifdef DEBUG
//调试代码
#else
//非调试代码
#endif
```
# 常见问题，注意事项
* 不要让临时变量污染函数空间,使用do{}while(0) 的宏来做到这点
* 定义宏函数的时候多使用括号，因为宏是简单的文本替换
