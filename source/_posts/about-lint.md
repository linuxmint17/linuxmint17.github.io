---
title: About Lint
date: 2020-03-07 12:01:50
tags: C/C++
---
# lint 或者 linter是 一种静态程序分析工具
  这里的静态是指在不运行程序的情况下检查代码潜在的问题  
  最早在Unix平台上开发用于检查C语言程序的  
  后来被其他的语言借鉴形成了各种各样的lint工具，以提升代码的健壮性
# splint 是现在的 linux上的lint工具 安装方法 如下
```bash
# apt-get install -y splint
```
# splint 从哪里知道的？
  来自《C专家编程》中的某个章节
# 简单用法 
```cpp
// func.c
int func(int /*@unused@*/a,char **b)
{
    return 0;
}
```

```bash
$  splint func.c 
```
会输出警告信息

# 详细用法可以参考
```bash
man splint
```