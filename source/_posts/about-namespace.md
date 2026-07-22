---
title: namespace
date: 2020-05-23 22:59:06
tags: C/C++
---
# namespace (命名空间) 是C++的一个关键字
　　不同的命名空间中相同的标识符在编译的时候不会产生错误
　　在不同的命名空间中可以使用相同名字的变量或者函数名称
# C 语言的标识符 也有命名空间 （内容来自 C语言规范草案 6.2.3 节)
* label names
标签名 包括 goto 语句 中用到的标签和  switch case中的 标签
* the tags name of structures, unions and enumurations
结构、联合、枚举的tag名
* the members of structures or unions; each structure or union has a seperate name space for its number;
结构体、联合的成员名
* all other identifiers,called ordinary identifiers (declared in ordinary declarators or as
enumeration constants)
其他普通的变量，或者枚举常量
# C++中使用namesapce 关键字可以构造一个命名空间
 C/C++ 中的 每一对花括号 是一个 命名空间

#变量的声明(declaration),定义(definition),初始化(initalization)
　　C 语言中变量的带初始化的声明就是定义
不带有初始化的全局对象构成了一个 试探性定义
这个Tentative definitions 特性仅仅C语言只有，C++是不支持的

　　在两个C文件中同时声明两个一模一样的未初始化的全局变量的时候，
C语言能够编译通过的C++不支持这样的

# C++ 类copy constructor 的执行时机就很有趣

C++ 对于 将一个对象的值 赋给 另一个对象的 场景进行了细分
一类就是 赋值；赋值的时候使用的是 = 的重载函数
另一类就是 初始化；
初始化可能发生的三个场景 ：
1. 在声明变量的同时用另一个对象初始化
2. 对象的拷贝被当做函数参数传递
3. 临时对象产生的时候，例如返回值是一个对象的时候

# C语言标准规定 不应该 使用 对全局变量使用 register 修饰

但是gnu C 标准支持这个特性, clang不支持这个特性，同样的代码使用clang编译会报错
uboot 代码中 有如下宏
https://gcc.gnu.org/onlinedocs/gcc/Global-Register-Variables.html
 using the volatile qualifier does not fully prevent the compiler from optimizing accesses to the register
在文件 uboot-2019.07/arch/riscv/include/asm/global_data.h 有如下宏,
```cpp
#define DECLARE_GLOBAL_DATA_PTR register gd_t *gd asm ("gp")
```
