---
title: C 语言中的main函数
date: 2020-02-15 23:48:28
tags: C/C++
---
## C语言中main写法
```CPP
// 接受任意参数但不起作用
int main()
{
    return 0;
}
// 明确不接受任何参数
int main(void)
{
    return 0;
}
// argc 参数的个数， argv 指向参数字符的首地址
int main(int argc, char **argv)
{
    return 0;
}
// 同上，第二个参数的不同写法
int main(int argc, char *argv[])
{
    return 0;
}
// 此版本可以打印出环境变量
int main(int argc, char *argv[], char *env)
{
    return 0;
}
```
## 关于main函数
1. main函数并非必须存在，只是约定俗成的一个程序启动入口罢了,main函数被crt(C语言运行时)调用可以通过编译器指令来替换入口函数
```CPP
// entry.c
#include <stdio.h>
int entry()
{
    printf("hello world\n");
//  return 0; // this will cause coredump ,因为程序直接entry 开始没有运行环境
    exit(0); // this works fine
}
```
```bash
$ gcc -nostartfiles -e entry entry.c -o helloword
$ ./helloword
```
2. main 在c语言中还可以自己调用自己
```cpp
int main()
{
    static int counter = 0;
    printf("hello world");
    counter++;
    main();
    if (counter == 2) {
        return 0;
    }
}
```
3. main是个符号而已
1984年的IOCCC(International Obfuscated C Code Contest/国际C代码混淆大赛)的两位牛人(Sjoerd Mullender

Robbert van Renesse)通过下面的代码获得了特等奖The Grand Prize, 影响到后来的比赛规则，不鼓励写依赖硬件的代码

```cpp
short main[] = {
	277, 04735, -4129, 25, 0, 477, 1019, 0xbef, 0, 12800,
	-113, 21119, 0x52d7, -1006, -7151, 0, 0x4bc, 020004,
	14880, 10541, 2056, 04010, 4548, 3044, -6716, 0x9,
	4407, 6, 5568, 1, -30460, 0, 0x9, 5570, 512, -30419,
	0x7e82, 0760, 6, 0, 4, 02400, 15, 0, 4, 1280, 4, 0,
	4, 0, 0, 0, 0x8, 0, 4, 0, ',', 0, 12, 0, 4, 0, '#',
	0, 020, 0, 4, 0, 30, 0, 026, 0, 0x6176, 120, 25712,
	'p', 072163, 'r', 29303, 29801, 'e'
};
```
 ### 下面是裁判的评论
<p>
Judges' comments:
Without question, this C program is the most obfuscated C program that has ever been received! Like all great contest entries, they result in a change of rules for the following year. To prevent a flood of similar programs, we requested that programs be non machine specific.

This program was selected for the 1987 t-shirt collection.

NOTE: If your machine is not a Vax-11 or pdp-11, this program will not execute correctly. In later years, machine dependent code was discouraged.

The C startup routine (via crt0.o) transfers control to a location named main. In this case, main just happens to be in the data area. The array of shorts, which has been further obfuscated by use of different data types, just happens to form a meaningful set of PDP-11 and Vax instructions. The first word is a PDP-11 branch instruction that branches to the rest of the PDP code. On the Vax main is called with the calls instruction which uses the first word of the subroutine as a mask of registers to be saved. So on the Vax the first word can be anything. The real Vax code starts with the second word. This small program makes direct calls to the write() Unix system call to produce a message on the screen. Can you guess what is printed? We knew you couldn’t! :-)
</p>
