---
title: 名词解释
date: 2020-06-17 20:04:12
tags:
---

# ROM(BOOTROM CD-ROM) RAM(SRAM DRAM, SDRAM, DDR)
# FLASH (NOR NAND FLASH)
# SPI  SPL
uboot分为uboot-spl和uboot两个组成部分。SPL是Secondary Program Loader的简称，第二阶段程序加载器，这里所谓的第二阶段是相对于SOC中的BROM来说的，之前的文章已经有所介绍，SOC启动最先执行的是BROM中的固化程序。

BROM会通过检测启动方式来加载第二阶段bootloader。uboot已经是一个bootloader了，那么为什么还多一个uboot spl呢？

这个主要原因是对于一些SOC来说，它的内部SRAM可能会比较小，小到无法装载下一个完整的uboot镜像，那么就需要spl，它主要负责初始化外部RAM和环境，并加载真正的uboot镜像到外部RAM中来执行。

所以由此来看，SPL应该是一个非常小的loader程序，可以运行于SOC的内部SRAM中，它的主要功能就是加载真正的uboot并运行之

ARM SoC的启动过程：

RomBoot --> SPL --> u-boot --> Linux kernel --> file system --> start application

(RomBoot是固化在SoC内部的。)

spl的产生：

因为芯片厂商固化的ROM支持从nandflash， SDCARD等外部介质启动，所以RomBoot会根据硬件电路的启动模式选择读取对应介质一小段数据到内存。BootRom读取多少才算合适呢？每个用户的需求不一样，大小也不能确定。很多芯片厂商干脆就只读4K/8K/16K等很小一段数据。这段数据你可以存放芯片初始化，读取介质数据到内存的工作是完全没有问题的。就这样在我们的软件界就产生了一个SPL概念，RomBoot读取这一小段代码就叫spl

# elf / bin 
# objcopy用于将object的部分获全部内容拷贝到另一个object，从而可以实现格式的变换。
Gcc 编译出来的是ELF文件。通常gcc –o test test.c,生成的test文件就是ELF格式的，在linuxshell下输入 ./test就可以执行。

Bin 文件是经过压缩的可执行文件，去掉ELF格式的东西。是直接的内存映像的表示。在系统没有加载操作系统的时候可以执行。

elf（executable  and   link   format）文件里面包含了符号表，汇编等。
BIN文件是将elf文件中的代码段，数据段，还有一些自定义的段抽取出来做成的一个内存的镜像。
# xxxx-elf-objcopy –O binary test.o test.bin

# nor vs nand

NOR FLASH 是很常见的一种存储芯片，数据掉电不会丢失。NOR FLASH 支持 Execute On Chip，即程序可以直接在 FLASH 片内执行。这点和 NAND FLASH 不一样。因此，在嵌入是系统中，NOR FLAS H 很适合作为启动程序的存储介质。NOR FLAS H 的读取和 RAM 很类似，但不可以直接进行写操作。对 NOR FLAS H 的写操作需要遵循特定的命令序列，最终由芯片内部的控制单元完成写操作。所以，NOR FLASH 一般是作为用于程序的存储与运行的工具。

 

NOR 的特点是芯片内执行(XIP， Execute In Place)，这样应用程序可以直接在 FLASH 闪存内运行，不必再把代码读到系统 RAM 中。NOR FLASH 的传输效率很高，在 1~4MB 的小容量时具有很高的成本效益，但是很低的写入和擦除速度大大影响了它的性能。

 

2NAND FLASH 与 NOR FLASH 的性能比较

FLASH 闪存是非易失存储器，可以对称为块的存储器单元块进行擦写和再编程。任何 FLASH 器件的写入操作只能在空或已擦除的单元内进行，所以大多数情况下，在进行写入操作之前必须先执行擦除。NAND FLASH 器件执行擦除操作是十分简单的，而 NOR FLASH 则要求在进行擦除前先要将目标块内所有的位都写为 0。

 

由于擦除 NOR FLASH 器件时是以 64～128KB 的块进行的，执行一个写入 / 擦除操作的时间为 5s，与此相反，擦除 NAND FLASH 器件是以 8～32KB 的块进行的，执行相同的操作最多只需要 4ms。

 

执行擦除时块尺寸的不同进一步拉大了 NOR FLASH 和 NADN FLASH 之间的性能差距，统计表明，对于给定的一套写入操作(尤其是更新小文件时更多的擦除操作必须在基于 NOR FLASH 的单元中进行。

 

NAND FLASH 的单元尺寸几乎是 NOR FLASH 器件的一半，由于生产过程更为简单，NAND FLASH 结构可以在给定的模具尺寸内提供更高的容量，也就相应地降低了价格。

 

NOR FLASH 占据了容量为 1～16MB 闪存市场的大部分，而 NAND FLASH 只是用在 8～128MB 的产品当中，这也说明 NOR 主要应用在代码存储介质中，NAND FLASH 适合于数据存储，NAND FLASH 在 Compact Flash、Secure Digital、PC Cards 和 MMC 存储卡市场上所占份额最大

#
Application-Specific Integrated Circuit

