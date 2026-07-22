---
title: About Git
date: 2020-01-18 15:46:25
tags: Tools git
---
#  git - the stupid content tracker

  Git is a fast, scalable, distributed revision control system
with an unusually rich command set that provides
both high-level operations and full access to internals.

## git的基本配置
* 设置用户名
``` bash
$ git config --global user.name "Your Name"
```
* 设置邮箱
``` bash
$ git config --global user.email "your_email@whatever.com"
```
* 设置换行符

    * linux/unix/Mac 用户
``` bash   
$ git config --global core.autocrlf input; git config --global core.safecrlf true
```

    * windows 用户
``` bash
$ git config --global core.autocrlf true; git config --global core.safecrlf true
```
* 配置文件 ~/.gitconfig

    [github/linuxmint17/confs/blob/master/gitconfig](https://github.com/linuxmint17/confs/blob/master/gitconfig)
    
## git 的基础操作
``` bas
$ mkdir code
```
初始化git仓库
``` bash
$ git init -c code
```
``` bash
$ cd code
```
使用最喜欢(emacs/vim/nano/notepad++/sublime/vscode)的编辑器编辑文件
``` bash
$ emacs hello.c  
```
添加文件到暂存区
``` bash
$ git add hello.c
```
检查git仓库状态
``` bash
$ git status
$ git status . -u no # don't display the untracked files  . mean current git repo
```
``` bash
$ git commit -s " init commit of repo";
```
``` bash
$ git log
```
revert a commit
```bash
git revert commit-id
```
start a branch
```
git branch my-branch-name
# how to name a branch ,name it after a real co-workers'name ,if it's only for him/her, then you can commit on that branch won't mess things up
# in the commit log you can describe what this commit about  , it's usually for debugsome functions or purly for uploading code, or name it
# after a feature function you are developing, is great
```
## how to use a git patch 
```bash
# this is git foramt patch version contains commit-msg
git format-patch commit-id
git apply/am xxx-001-patch
# this is old fashion diff vpatch ersion
git diff > xxx.diff
git am/apply xxx.idff
```
## git 小技巧

### 暂存
``` bash
$ git stash
```
### 挑选
``` bash
$ git  cherry-pick commit-id
```
### 变基
``` bash
$ git rebase -i commit-id
```
### 查看文件变更
　　查看 hello.c 文件中的10到20行的修改记录
``` bash
$ git blame -L 10,20 hello.c
```
### 从历史版本中取出某个文件
　　从历史版本(commit-id)中取出hello.c
``` bash
$  git checkout  commit-id  hello.c
```
###  commit it when debug or develop has been done some of it , at the last time you can rebase it or git reset --soft it
```bash
# use the last commit-id
git commit --amend  
# 
git reset --soft
# 
git reset --mixed
```
### 我在哪个分支，merge是否成功，rebase 是否成功，cherry-pick是否成功？
　　配置shell的命令提示符可以帮你解决这个问题

### 操作方法
``` bash
1. git clone git://git.kernel.org/pub/scm/git/git.git
2. cp git/contrib/completion/git-completion.bash ~/.git-completion.bash
3. cp git/contrib/completion/git-prompt.sh  ~/.git-prompt.sh
4. vi ~/.bashrc 插入
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=”verbose git svn”
export PS1='\[\033[0;32m\]\D{%Y/%m/%d} \t\[\033[0m\]\[\033[0;35m\]\u@\h\[\033[0m\]\[\033[0;33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[0m\]\n\$'
5. source ~/.bashrc
```
## some other concepts
* base, detached head, 
## git 底层命令
　　挖坑 想起来再填
## git 的detached head
    很有趣
## 学习git的资源

* git的官方网站 [git-scm.com](https://git-scm.com/)

