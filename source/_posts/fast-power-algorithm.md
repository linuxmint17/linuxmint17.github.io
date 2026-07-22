---
title: fast-power-algorithm
date: 2021-08-17 23:52:24
tags: algorithm C/C++
---

# 快速幂算法， 先贴一下算法模板，后边研究好了再贴研究心得,还有什么矩阵的快速幂算法
```cpp
int fastpow(int base, int n) {
	int ans = 1;
	while (n) {
		if (n&1) {
            ans *= base;
		}
		base *= base;
		n >>= 1;
	}
	return ans;
}
```
# 直接幂算法，在数值比较大的时候，在做算法题目的时候，时间复杂度不能接受
```cpp
int normalpow(int base, int n) {
    int ans = 1;
    int i;
    for (i = 0; i < n; i++) {
        ans *= base;
    }
    return ans;
}
```