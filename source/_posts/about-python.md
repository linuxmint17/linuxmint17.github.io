---
title: About python
date: 2020-02-18 20:41:30
tags: others
---
# Python 是Guido van Rossum 圣诞节无聊发明的一种编程语言
特征
* 非强制面向对象
* 动态类型
* 脚本(解释型)语言
* 类C语法
* 语法块按照对齐产生
# python 三种实现
* cpython C 
* jpython Java
* IronPython .NET

# python 优化方法
1. 使用pypy python版的python解释器
2. shed skin 将python代码转换成c++的代码

# python 工具
pyvenv

# python中的不可变类型
Interger, string, tuple

# 变量名没有类型，对象有类型
slice切片操作
list [],
tuple（）

# 创建自测试的模块
在模块的尾部加入以下代码
if __name__ == '__main__':
    import doctest
    doctest.testmod()
此模块在python解释器中直接运行时候就能进行doctest

