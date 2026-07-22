---
title: About Thread
date: 2020-01-24 13:39:12
tags: Linux
---
# 多线程编程是实用程序必然要用到的工具 没有多线程、多进程编程就不是现代编程人员做的事情
# 多线程的优缺点
    **优点**
    *
    *
    **缺点**
    *
    *    pthread_cond_wait pthread_cond_signal
# 多线程的同步方法
# 多进程的同步方法
# 原子操作
# binder 通信
# RPC 调用
```cpp
char * mystrstr(const char *str,const char *substr)
{
	if(str==NULL||substr==NULL)
	{
		printf("error NULL\n");
		return NULL;
	}
    if(strlen(str)<strlen(substr))
	{
		return NULL;
	}
	char *cp=str;
	char *subcp=substr;
	while(*cp)
	{
		while(*cp && *subcp && !(*cp-*subcp))
		{
			subcp++;
		}
		cp++;
	}
}
```
