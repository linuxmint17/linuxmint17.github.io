---
title: About sizeof
date: 2020-01-24 13:20:35
tags: C/C++
---
# sizeof 的误解，sizeof 不是函数(function)，是运算符(operator)
　　函数在程序运行的时候起作用，运算符求出来的大小是在编译时就确定下来的
## 常见的sizeof操作
* 对结构体类型求大小
```CPP
    typedef struct {
        char a;
        int b;
        char *ptr;
        double c;
        char name[19];
    } Demo;
    
    // 结构体的实际所占用内存大小，需要内存对齐，按照4byte或者8byte对齐，
    // 对齐的原则整体大小能被4整除，而且每个成员的地址偏移都是4的整数倍
    std::cout << sizeof(Demo) << std::endl;
```
* 对联合体求大小
```cpp
#include<stdio.h>
// 联合体的大小是能够容纳最大的成员的大小, 还要考虑一下四字节对齐
typedef union {
  int a[3];
  char b[8] ;
} data;
int main()
{
    printf("sizeof(data)= %d\n", sizeof(data)); // 12
    return 0;
}
```
* 对字符串常量求大小
```CPP
    char *p1 = "abc";
    char p2[] = "abc";
    int sz1 = sizeof("mute");
    int len1 = strlen("mute");
    int sz2 = sizeof(p1);
    int sz3 = sizeof(p2);
    int len2 = strlen(p1);
    int len3 = strlen(p2);
```
* 对指针变量、指针类型求大小
```CPP
    char* ptr = "abcdefg";
    int sz1 = sizeof(ptr);
    int sz2 = sizeof(char*);
    int sz3 = sizeof(*ptr);
    // x64 平台结果是881 指针类型解引用之后的大小就是*前面类型的大小
    std::cout << sz1 << sz2 << sz3 << std::endl;
    // 通常来说sizeof 对指针类型(变量)求值x86(32bit)平台就是4Btye,x64平台就算是8Byte
```

* 对含有虚函数的class求大小
* 求数组的大小 、对变量求大小、 对类型求大小
```Cpp
    int array[] = {10, 20, 30, 100, 200};
    // 第一种写法
    for (int i = 0; i < sizeof(array) / sizeof(int); i++) {
        std::cout << array[i] << std::endl;
    }
    // 第二种写法
    for (int i = 0; i < sizeof(array) / sizeof(array[0]); i++) {
        std::cout << array[i] << std::endl;
    }
```
* sizeof 的一个考题
```cpp
#include<iostream>
using namespace std;
struct MyStruct {
  int i;
  char str[10];
  char *ptr;
};
int main()
{
    char a[3][4];
    //x86 windows (char *) type 4byte ,x64 windwows (char *)type 8bytes
    char **b[3][4]; // 指针数组，12个元素，每个指针大小4或者8
    cout<<"sizeof(MyStruct)= " << sizeof(MyStruct) << endl;
    cout<<"sizeof(a)" <<sizeof(a) << endl; 
    cout<<"sizeof(b)" <<sizeof(b) << endl; 
    return 0;
}
```
## sizeof 的原理
[参考知乎用户**_蓝色_**的回答](https://www.zhihu.com/question/26090484)
## x按n字节对齐的宏的来源
x = nq + r, 其中  0 <= r < n                  //最小非负剩余

q, r 是唯一确定的。q = [x/n], r = x - n[x/n]. 这个是带余除法的一个简单形式。在 c 语言中， q, r 容易计算出来： q = x/n, r = x % n.

所谓把 x 按 n 对齐指的是：若 r=0, 取 qn, 若 r>0, 取 (q+1)n. 这也相当于把 x 表示为：

x = nq + r', 其中 -n < r' <=0                //最大非正剩余   

nq 是我们所求。关键是如何用 c 语言计算它。由于我们能处理标准的带余除法，所以可以把这个式子转换成一个标准的带余除法，
然后加以处理：

x+n = qn + (n+r')，其中 0<n+r'<=n            //最大正剩余

x+n-1 = qn + (n+r'-1), 其中 0<= n+r'-1 <n    //最小非负剩余

所以 qn = [(x+n-1)/n]n. 用 c 语言计算就是：

((x+n-1)/n)*n

若 n 是 2 的方幂, 比如 2^m，则除为右移 m 位，乘为左移 m 位。所以把 x+n-1 的最低 m 个二进制位清 0就可以了。得到：

(x+n-1) & ~(n-1)

