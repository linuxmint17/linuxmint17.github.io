---
title: about-vim
date: 2021-08-26 07:51:06
tags:
---

# 本文章主要讲解vim的学习路径和常用配置及基本介绍和操作
# 模式切换，此处的模式不一定是vim官方的叫法，主要是我自己的理解
  ## 浏览模式（只能使用hjkl进行上下左右光标切换）到编辑模式（可以输入字符）
   键盘上的小写字符（a,i,o)
   a（append)光标的后边位置加入字符
   i（insert)光标当前位置插入字符
   o (open) 在光标的下一行新插入一行空行
   键盘上的大写字符（A,I,O)
   A（Append)在行尾加入字符
   I（Insert)在行首插入字符
   O (Open) 在光标的上一行新插入一行空行
  ## 退出任意(命令模式，编辑模式，列编辑模式)模式到浏览模式
   按键盘上的Esc键一次不行，按两次
　 ## 从浏览模式到命令模式，英文冒号
   ： wq(保存退出)
   ## 浏览模式到行编辑模式
   * V (大写字母v)，可以选中多行进行批量操作
   ## 浏览模式下其他不常用的命令
    J(大写字母j)可以合并当前行和下一行，当前行的行尾和下一行的首部合并到当前行
    
# 命令模式的常用命令
  ## x (保存并退出)
  ## q (没有编辑，直接退出)
  ## q! (已经编辑了，放弃修改退出)
  ## w (把编辑内容从缓存写入磁盘文件，即存盘)
  ## ！ls  （执行shell命令ls)

# vim redo
ctrl + R
# 学习vim的方法
* vimtutor 
* : help topic
# vim 打开没有权限的文件(忘记使用sudo打开) 之后如何强制保存
　　在vim的命令模式中输入:w !sudo tee %
### how this works 摘自[stack overflow](https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work)
<p>
in :w !sudo tee %...

% means "the current file"
As eugene y pointed out, % does indeed mean "the current file name", which is passed to tee so that it knows which file to overwrite.

(In substitution commands, it's slightly different; as :help :% shows, it's equal to 1,$ (the entire file) (thanks to @Orafu for pointing out that this does not evaluate to the filename). For example, :%s/foo/bar means "in the current file, replace occurrences of foo with bar." If you highlight some text before typing :s, you'll see that the highlighted lines take the place of % as your substitution range.)

:w isn't updating your file
One confusing part of this trick is that you might think :w is modifying your file, but it isn't. If you opened and modified file1.txt, then ran :w file2.txt, it would be a "save as"; file1.txt wouldn't be modified, but the current buffer contents would be sent to file2.txt.

Instead of file2.txt, you can substitute a shell command to receive the buffer contents. For instance, :w !cat will just display the contents.

If Vim wasn't run with sudo access, its :w can't modify a protected file, but if it passes the buffer contents to the shell, a command in the shell can be run with sudo. In this case, we use tee.

Understanding tee
https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
As for tee, picture the tee command as a T-shaped pipe in a normal bash piping situation: it directs output to specified file(s) and also sends it to standard output, which can be captured by the next piped command.

For example, in ps -ax | tee processes.txt | grep 'foo', the list of processes will be written to a text file and passed along to grep.

     +-----------+    tee     +------------+
     |           |  --------  |            |
     | ps -ax    |  --------  | grep 'foo' |
     |           |     ||     |            |
     +-----------+     ||     +------------+
                       ||   
               +---------------+
               |               |
               | processes.txt |
               |               |
               +---------------+
(Diagram created with Asciiflow.)

See the tee man page for more info.

Tee as a hack
In the situation your question describes, using tee is a hack because we're ignoring half of what it does. sudo tee writes to our file and also sends the buffer contents to standard output, but we ignore standard output. We don't need to pass anything to another piped command in this case; we're just using tee as an alternate way of writing a file and so that we can call it with sudo.

Making this trick easy
You can add this to your .vimrc to make this trick easy-to-use: just type :w!!.

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
The > /dev/null part explicitly throws away the standard output, since, as I said, we don't need to pass anything to another piped command.
</p>