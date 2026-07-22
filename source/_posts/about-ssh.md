---
title: about-ssh
date: 2020-02-19 09:52:19
tags: Linux
---
# ssh
  Secure Shell (SSH) is a cryptographic network protocol for operating network services securely over an unsecured network
# ssh 也是Linux 命令之一，用于(取代telnet等不安全的协议软件)安全连接访问远程服务器.
  ssh 基本用法 以root用户通过端口22333登录192.168.23.4主机
```bash
$ ssh root@192.168.23.4:2233  
```
# ssh的特殊姿势
  只有你拥有台海外vps并且安装了ssh服务，可以通过ssh动态端口转发实现fq

  ssh [-D [bind_address:]port root@remotehost:2233

  一般bind_address 是localhost
# netstat -nat 查看端口使用情况

# ssh 相关命令
ssh-agent

ssh-keygen

