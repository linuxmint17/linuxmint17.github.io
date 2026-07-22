---
title: mysql
date: 2020-02-14 17:20:24
tags:
---
# mysql 是很流行的一款开源数据库软件
　　mysql是跨平台的关系型数据库，安装可以参考[mysql安装官网指导](https://dev.mysql.com/doc/mysql-sles-repo-quick-guide/en/) <br>
mysql好像是从5.7版本之后，安装完会有一个随机的root密码使用grep password /var/log/mysqld.log 查找密码，否则无法登陆
安装完成之后要用mysql_secure_instation 设置一下安全属性
# mysql 基本指令
* CREATE DATABASE ssusers; 创建数据库
* DROP DATABASE ssusers; 删除数据库
* SHOW DATABASES; 显示数据库
* CREATE USER 'ssmanger'@'localhost' IDENTIFIED BY '123456'; 创建用户 ssmanger 本机可以访问 mysql
* GRANT ALL privileges  ON  ssusers.* TO ssmanger@'localhost'; 将数据库所有权限给用户 ssmanager
* SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword'); 更新mysql用户密码
* CREATE USER 'wordpressadmin'@'%' IDENTIFIED BY '123456'; 创建用户 wordpressadmin在所有ip可以访问mysql
# mysql 多表查询
 