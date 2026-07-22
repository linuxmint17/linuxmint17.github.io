---
title: windows 系统修复
date: 2022-03-23 23:40:49
tags:
---

* windows 修复
```bash
sfc /SCANNOW 
rem  上一条命令发现问题才执行后续命令
Dism /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-image /RestoreHealth
sfc /SCANNOW
```
