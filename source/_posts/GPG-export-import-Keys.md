---
title: GPG export import Keys
date: 2022-03-23 23:35:44
tags:
---

* 列出本地的所有 Key
执行 gpg --list-keys 列出本地所有的密钥
输出结果类似
```bash
 $ gpg --list-keys
 /home/$USER/.gnupg/pubring.gpg
--------------------------------
pub   4 096R/375A500B 2017-03-22 [有效至：2018-03-22]
uid                  Goren G (Git) <gythialy.koo+git@gmail.com>
sub   4096R/ADB9D36C 2017-03-22 [有效至：2018-03-22]
```
* 导出
根据 375A500B 导出相应的公钥和私钥
```bash
gpg --output mygpgkey_pub.gpg --armor --export 375A500B
gpg --output mygpgkey_sec.gpg --armor --export-secret-key 375A500B
```
* 导入
导入刚导入的文件
```bash
gpg --import ~/mygpgkey_pub.gpg
gpg --allow-secret-key-import --import ~/mygpgkey_sec.gpg
```

* 删除密码
```bash
gpg --edit-key 375A500B
# 在弹出的界面中输入原来密码，新密码留空即可
passwd
# 保存修改
save
```
【转载】
https://gythialy.github.io/Howto-import-export-gpg-key/
