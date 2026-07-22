---
title: git tricks
date: 2022-03-23 23:50:52
tags:
---

* git clone加速下载
 如果只需要最新的代码 不需要历史提交记录的时候可以 给git添加参数 --depth =1
```bash
git clone --depth=1 https://github.com/TheSuperPowerIsRich/OSX-KVM.git
```
