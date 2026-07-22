---
title: Linux cmd (II)
date: 2021-09-16 22:29:11
tags: tools
---

# linux cmd 1
```bash
# 创建 512M的空文件
dd if=/dev/zero of=./output.bin bs=1M count=512
# 创建 2M 的全为0xff的文件
# 命令, 用到了管道, 重定向操作,tr 命令用的比较少,这里用上了
tr "\000" "\377" < /dev/zero | dd of=./output.bin bs=1024 count=2048
```
# mtd(闪存类) 设备可以当作字符也可以当作块设备来操作根据dev下的设备名
# /dev/mtd0 是字符设备 /dev/mtdblock0 块设备
# 可以直接cat /dev/mtd0> mtd0.bin读出,使 echo mtd0.bin >/dev/mtd0 写入
# 查看16进制
```bash
xxd output.bin |less
```

