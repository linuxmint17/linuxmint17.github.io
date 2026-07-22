---
title: Linux中的奇葩opensuse
date: 2020-02-18 18:18:36
tags: Linux
---

## 安装完成之后的软件源切换
1. 禁用所有软件源
```bash
$ sudo zypper mr -da
```
2. 添加阿里镜像源
```bash
$ sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/distribution/leap/15.1/repo/oss openSUSE-Aliyun-OSS ;
$ sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/distribution/leap/15.1/repo/non-oss openSUSE-Aliyun-NON-OSS ;
$ sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/update/leap/15.1/oss openSUSE-Aliyun-UPDATE-OSS ;
$ sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/update/leap/15.1/non-oss openSUSE-Aliyun-UPDATE-NON-OSS ;
```
3. 手动刷新软件源
```bash
$ sudo zypper ref
```
## core file 无法生成
opensuse 默认无法产生 core file 需要查找官方文档 设置
## git commit failed
openusse  git 默认无配置文件， git commit 阻塞， 或者是使用了 奇怪的 编辑器。
