---
title: bash grammar cheatseet
date: 2021-08-18 00:11:32
tags: shell
---

# 先贴一个bash中类似与c++ 中的switch case的demo
```bash
#!/bin/bash
# switch.sh 
# $# 代表使用这个脚本的时候给这个脚本传递的参数个数 -lt 代表 less than
# $0 代表脚本的名字， 和C语言main函数的argv[]参数类似
if [ $# -lt 1 ]; then
	echo "Usage: $0 [sth] [sth]"
fi
# $1 $2 $3 代表传给脚本的第几个参数
if [ $# -eq 2 ] && [ $2 == "debug" ]; then
	echo "this enter debug mode"
	DBG_FLAG=1
fi

case $1 in
	x86)
        echo "this is case x86"
	;;
	arm32)
	
		echo "this is case arm32"
    ;;
	arm64)
		echo "this is case arm64"
	;;
esac
```