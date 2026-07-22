---
title: About IPC
date: 2020-03-29 10:29:29
tags: Linux
---
# IPC (Inter-Porcess Communication) 进程间通信
　　多个进程需要协作的时候通信必不可少
# IPC 的五种基本方法
1. Pipes / FIFOs 管道
2. Message Queues 消息队列
3. Shared Memory 共享内存
4. POSIX Semaphores POSIX 信号量
5. Sockets 套接字
## Pipes 的特性
1. 兼容性问题：最早的时候都是半双工，有的系统却提供了全双工的管道
2. 适用范围的问题：只能在具有相同的祖先进程的进程间使用，多数情况是在父子进程之间使用
### Pipes 的使用
　　使用pipe需要了解两个函数
```cpp
// 需要包含头文件 <unistd.h>
int pipe(int fd[2]); // 创建两个文件描述符，fd[0] 用于读取，fd[1]用于写入
// 需要包含头文件 <unistd.h> 和 <sys/types.h>
pid_t fork(void); // 通过复制父进程创建子进程
// 标准头文件 <stdio.h>
// The  popen() function opens a process by creating a pipe, forking,
// and invoking the shell
FILE *popen(const char *command, const char *type);
int pclose(FILE *stream);
```

```cpp
// 以下代码对 APUE 中的代码做了简化和改动
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#define MAXLINE 4096

int main(void)
{
    int n;
    int fd[2];
    pid_t pid;
    char line[MAXLINE];
    if (pipe(fd) < 0) {
        printf("pipe create error");
        exit(-1);
    }
    pid = fork();
    if (pid < 0) {
        printf("fork child error");
        exit(-1);
    }
    if (pid > 0) { // 父进程
        close(fd[0]);
        write(fd[1], "Hello child\n", sizeof("Hello child\n") - 1);
        printf("write some thing inside %u\n", getpid());
    } else { // 子进程
        close(fd[1]);
        n = read(fd[0], line, MAXLINE);
        write(STDOUT_FILENO, line, n); 
        printf("read some thing from %u\n", getppid());
    }
    exit(0);
}
```
## Message Queues 的特性

##  Message Queues 的使用

## Shared Memory 的特性
  共享内存不提供同步机制，user需要使用消息队列，信号量或者sockets提供的消息机制
## Shared Memory 的使用

## POSIX Semaphores 的特性

## POSIX Semaphores 的使用

## Sockets 的特性

## Sockets 的使用