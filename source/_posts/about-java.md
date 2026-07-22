---
title: About Java
date: 2020-02-19 15:17:39
tags:
---
# Java是啥？
 　　Java是面向对象编程语言，最早是Sun公司的后来被Oracle收购了，已经有20多年的历史了，是为了针对c++的缺点
# Java 编程环境配置
 　　java运行依赖于java虚拟机,所以要安装JDK,因为java规范和jvm 规范是公开的，所以jdk有开源实现版本openjdk，JDK 和oracle JDK  
 　　具体步骤可以参考[此链接](https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/)
 1. 安装JDK  
　　谷歌或者百度，搜索 oracle jdk,下载安装
 2. 配置 **JAVA_HOME**, **CLASSPATH** 和 **PATH** 等环境变量　　

　　**PATH** 环境变量中是平台可执行文件的所在的路径的集合　　

　　**JAVA_HOME** 指向JDK software 安装的地方,比如说, D:\Program Files\Java\jdk1.8.0_181　　

　　**CLASSPATH** variable is one way to tell applications, including the JDK tools, where to look for user classes. (Classes that are part of the JRE, JDK platform, and extensions should be defined through other means, such as the bootstrap class path or the extensions directory.)

　　The preferred way to specify the class path is by using the -cp command line switch. This allows the CLASSPATH to be set individually for each application without affecting other applications. Setting the CLASSPATH can be tricky and should be performed with care.

　　The default value of the class path is ".", meaning that only the current directory is searched. Specifying either the CLASSPATH variable or the -cp command line switch overrides this value.
    
 3. 配置之后验证　　

　　在新打开的命令行中输入java -version 查看是否有输出版本号，如果有则成功
# Java 强迫面向对象编程
 　　即使想写个简单Hello world程序，也很麻烦。必须创建一个Java类，而且类名和文件名还必须一样  
 
```java
// BitOpt.java
class BitOpt {
  public static void main(String[] args)
  {
    int a = -1;
    System.out.println("Hello world");
    System.out.println(a>>>30);
    System.out.println(a>>30);
  }
}

```
# Java 之JNI(Java Native Interface)
  java 为了吸收和利用现有的C和C++代码提供了JNI接口，用于使用C和C++代码提供了JNI接口，用于使用C和C++  
  Android应用apk中的.so文件是动态库允许厂商将自己的私有算法封装进入so库，提供一定程度的密码保护.  
  在一些比较耗时的算法场景，使用jni可以加快程序运行速度