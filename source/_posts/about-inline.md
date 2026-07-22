---
title: About inline function
date: 2020-01-20 21:54:29
tags: C/C++
---
inline 是C99/C++的关键字之一，目的是取代函数式宏，函数式宏没有类型

## 内联函数 vs 函数式宏（待考证，可能有谬误）
* 编译中的差别：<br>
    * 内联函数 在编译时在调用函数中
内敛只是是一种建议(像regester 一样),不一定被编译器采纳(The inline specification is only a request to the compiler. The compiler may
choose to ignore this request -- -- C++ primer)，如果内敛函数很复杂(循环嵌套比较多)，或者包含静态变量等情况就无法内敛就无法被编译器当做是内联函数
    * 函数式宏 在预处理阶段被文本替换，在预处理阶段必然被替换
* 二进制的区别：<br>
    - 函数式宏 如果被使用多次 代码区增大
    - 内联函数 如果被使用多次 代码区域没有显著增大
* 运行时的差别：<br>
  - 函数式宏，不是函数，在运行时没有体现
  - 内联函数，几乎没有函数参数传递的开销
## 不同编译器对 inline 的支持
* clang
挖坑
* gcc  
挖坑