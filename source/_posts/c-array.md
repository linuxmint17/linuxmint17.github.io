---
title: C语言中数组
date: 2020-02-16 12:04:57
tags:
---

# 数组的奇葩
  C语言中x[i]的计算方法 *(x + i)  x是个数组名，一般写数组的时候，x是常量指针,当x是0的时候没问题

```cpp
int is_big_endian(){
    int a = 0xbabe;
    return 0[(unsigned char *)&a] == 0xbe;
}
```

```cpp
int i; // 未初始化的全局变量，被初始化成0
main ()
{
  // read 是自定义函数, read(0, i++ + "hello, world!\n", 1); 实际上调用了系统调用write(1,指向hello, world!的指针，每次偏移一,1);
  // i["]<i;++i){--i;}"] 是判断 *("]<i;++i){--i;"的地址 偏移 i) 是否为0，"]<i;++i){--i;" 的长度和 "hello, world!"的长度一样
  // C语言中的字符串常量和数字做运算的时候是 常量指针const char *类型
  for (; i["]<i;++i){--i;}"]; read ('-' - '-', i++ + "hello, world!\n", '/' / '/'));
}
read (j, i, p)
{
  write (j / p + p, i-- - j, i / i);
}
```