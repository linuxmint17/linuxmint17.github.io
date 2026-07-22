---
title: About Endianness
date: 2020-02-20 09:56:50
tags: other
---
# 大小端问题(big endian little endian)
　　In computing, endianness refers to the order of bytes (or sometimes bits) within a binary representation of a number
　　In its most common usage, endianness indicates the ordering of bytes within a multi-byte number. A big-endian ordering places the most significant byte first and the least significant byte last, 
　　while a little-endian ordering does the opposite  

　　Historically, various methods of endianness have been used in computing, including exotic forms such as middle-endianness. Today, however, big-endianness is the dominant ordering in networking protocols (IP, TCP, UDP). Conversely, little-endianness is the dominant ordering for processor architectures (x86, most ARM implementations) and their associated memory. File formats can use either ordering; some formats use a mixture of both.

# 大小端的定义

**Big Endian Byte Order**:  
　　*The most significant byte (the "big end") of the data is placed at the byte with the lowest address. The rest of the data is placed in order in the next three bytes in memory.*

**Little Endian Byte Order**:  (LL)  
　　*The least significant byte (the "little end") of the data is placed at the byte with the lowest address. The rest of the data is placed in order in the next three bytes in memory.*

# linux 中转换大小端的函数
  ```bash
  $ man endian 
  ```
  通过以上命令可以获取到转换大小端的函数  
```cpp
  // h short for host
  // b short for big endian
  // l short for little endian
  // 32 means 32 bits integer
    uint32_t htobe32(uint32_t host_32bits);
    uint32_t htole32(uint32_t host_32bits);
    uint32_t be32toh(uint32_t big_endian_32bits);
    uint32_t le32toh(uint32_t little_endian_32bits);
```
# 大小端的影响范围
  1. 文件系统的创建
  2. 网络传输协议的字节序(一般是大端，也有小端Server_Message_Block)
# 判断大小端的C代码
```cpp
// from linux-5.4.3\arch\arm\kernel\setup.c 中161行的一个宏，
// 内核中的写法稍有不同稍加修改可以正常编译
int checkCPUendian()
{
  static union { char c[4]; unsigned long l; } endian_test = { { 'l', '?', '?', 'b' } };
#define ENDIANNESS ((char)endian_test.l)
//if ENDIANNESS=='l'  the CPU is little-endian if ENDIANESS=='b' the CPU is big-endian
  return ENDIANNESS == 'l';
}
```