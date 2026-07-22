---
title: About FFmpeg
date: 2020-02-14 15:55:52
tags: Tools
---
# FFmpeg 是开源音视频解码库
　　很多音视频软件都使用到了ffmpeg的解码库
# 把图片从raw data 转换成jpg的命令
``` bash
$ ffmpeg -i inputrawdata -s 512x800  -f rgb565   -f image2 -o out.jpeg
```
# 音视频合并 从网站上下载的视频可能音频和视频分开的为了方便观看需要合并
```bash
$ ffmpeg -i inputaudio -i inputvideo  output.mp4
```