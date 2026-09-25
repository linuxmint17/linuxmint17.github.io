---
title: adb install xapk
date: 2026-09-25 10:10:35
tags:
---
###  从 apkpure download 到了 Tailscale_1.102.4-t3caf7d9e7-g1b32d3caa_APKPure.xapk
```bash
adb install  Tailscale_1.102.4-t3caf7d9e7-g1b32d3caa_APKPure.xapk # 会报错
```
### 需要解压缩，用 adb install-multiple
```bash
mkdir tmp
mv Tailscale_* tmp
cd tmp
unzip Tailscale_*
adb install-multiple *.apk
```
