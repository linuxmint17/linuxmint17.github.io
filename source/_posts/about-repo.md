---
title: about repo
date: 2020-02-18 18:21:45
tags:
---
# 什么是repo
Repo 简化了跨多个代码库运行的流程，与 Git 相辅相成。请参阅源代码控制工具，了解有关 Repo 和 Git 之间关系的说明。如需详细了解 Repo，请参阅 Repo 命令参考资料和 Repo README。
# repo 命令格式
使用 Repo 需遵循的格式如下：

repo command options

可选元素显示在方括号 [ ] 中。例如，许多命令会用到项目列表 (project-list) 参数。项目列表可以是一个名称列表，也可以是一个本地源代码目录的路径列表：
# repo 的命令使用
repo sync [project0 project1 ... projectn]
repo sync [/path/to/project0 ... /path/to/projectn]

help
安装 Repo 后，您可以通过运行以下命令找到最新文档（开头是包含所有命令的摘要）：

repo help

您可以通过在 Repo 树中运行以下命令来获取有关某个命令的信息：

repo help command

例如，以下命令会生成 Repo init 参数的说明和选项列表，该参数会在当前目录中初始化 Repo（要了解详情，请参阅 init）。

repo help init

init
repo init -u url [options]

在当前目录中安装 Repo。这样会创建一个 .repo/ 目录，其中包含 Repo 源代码和标准 Android 清单文件的 Git 代码库。该 .repo/ 目录中还包含 manifest.xml，该文件是一个指向 .repo/manifests/ 目录中所选清单的符号链接。有关更新清单的说明，请参阅 manifest-format.md。

选项：

-u：指定要从中检索清单代码库的网址。您可以在 https://android.googlesource.com/platform/manifest 中找到通用清单。
-m：选择代码库中的一个清单文件。如果未选择任何清单名称，则会默认选择 default.xml。
-b：指定修订版本，即特定的清单分支。
注意：对于其余的所有 Repo 命令，当前工作目录必须是 .repo/ 的父目录或该父目录的子目录。

sync
repo sync [project-list]

下载新的更改并更新本地环境中的工作文件。如果您在未使用任何参数的情况下运行 repo sync，则该操作会同步所有项目的文件。

运行 repo sync 后，将出现以下情况：

如果目标项目从未同步过，则 repo sync 相当于 git clone。远程代码库中的所有分支都会复制到本地项目目录中。

如果目标项目以前同步过，则 repo sync 相当于以下命令：

git remote update
git rebase origin/branch

其中 branch 是本地项目目录中当前已检出的分支。如果本地分支没有在跟踪远程代码库中的分支，则项目不会发生任何同步。

如果 Git rebase 操作导致合并冲突，请使用常规 Git 命令（例如 git rebase --continue）解决冲突。

repo sync 运行成功后，指定项目中的代码即处于最新状态，已与远程代码库中的代码同步。

选项：

-d：将指定项目切换回清单修订版本。如果项目当前属于某个主题分支，但临时需要清单修订版本，则此选项会有所帮助。

-s：同步到当前清单中的 manifest-server 元素指定的一个已知良好版本。

-f：即使某个项目同步失败，也继续同步其他项目。

upload
repo upload [project-list]

对于指定的项目，Repo 会将本地分支与最后一次 repo sync 时更新的远程分支进行比较。Repo 会提示您选择一个或多个尚未上传以供审核的分支。

接下来，所选分支上的所有提交都会通过 HTTPS 连接传输到 Gerrit。您需要配置一个 HTTPS 密码以启用上传授权。要生成新的用户名/密码对以用于 HTTPS 传输，请访问密码生成器。

当 Gerrit 通过其服务器接收对象数据时，它会将每项提交转变成一项更改，以便审核者可以针对特定提交给出意见。要将几项“检查点”提交合并为一项提交，请使用 git rebase -i，然后再运行 upload。

如果您在未使用任何参数的情况下运行 repo upload，则该操作会搜索所有项目中的更改以进行上传。

要在更改上传后对其进行修改，请使用 git rebase -i 或 git commit --amend 等工具更新您的本地提交。修改完成之后，请执行以下操作：

进行验证以确保更新后的分支是当前已检出的分支。
对于相应系列中的每项提交，请在方括号内输入 Gerrit 更改 ID：
# Replacing from branch foo
[ 3021 ] 35f2596c Refactor part of GetUploadableBranches to lookup one specific...
[ 2829 ] ec18b4ba Update proto client to support patch set replacments
# Insert change numbers in the brackets to add a new patch set.
# To create a new change record, leave the brackets empty.

上传完成后，这些更改将拥有一个额外的补丁程序集。

如果您希望只上传当前已检出的 Git 分支，则可以使用标记 --current-branch（简称 --cbr）。

diff
repo diff [project-list]

使用 git diff 显示提交与工作树之间的明显更改。

download
repo download target change

从审核系统中下载指定更改，并放在您项目的本地工作目录中供使用。

例如，要将更改 23823 下载到您的 platform/build 目录，请运行以下命令：

repo download platform/build 23823

运行 repo sync 会删除使用 repo download 检索到的任何提交。或者，您可以使用 git checkout m/master 检出远程分支。

注意：由于全球的所有服务器均存在复制延迟，因此某项更改出现在网络上（位于 Gerrit 中）的时间与所有用户可通过 repo download 找到此项更改的时间之间存在些许的镜像延迟。

forall
repo forall [project-list] -c command

在每个项目中运行指定的 shell 命令。通过 repo forall 可使用下列额外的环境变量：

REPO_PROJECT 设为了项目的唯一名称。

REPO_PATH 是相对于客户端根目录的路径。

REPO_REMOTE 是清单中远程系统的名称。

REPO_LREV 是清单中修订版本的名称，已转换为本地跟踪分支。如果您需要将清单修订版本传递到某个本地运行的 Git 命令，则可使用此变量。

REPO_RREV 是清单中修订版本的名称，与清单中显示的名称完全一致。

选项：

-c：要运行的命令和参数。此命令会通过 /bin/sh 进行评估，它之后的任何参数都将作为 shell 位置参数传递。

-p：在所指定命令的输出结果之前显示项目标头。这通过以下方式实现：将管道绑定到命令的 stdin、stdout 和 sterr 流，然后通过管道将所有输出结果传输到一个分页会话中显示的连续流中。

-v：显示该命令向 stderr 写入的消息。

prune
repo prune [project-list]

删减（删除）已合并的主题。

start
repo start
branch-name [project-list]

从清单中指定的修订版本开始，创建一个新的分支进行开发。

BRANCH_NAME 参数用于简要说明您尝试对项目进行的更改。如果您不知道，则不妨考虑使用名称 default。

project-list 参数指定了将参与此主题分支的项目。

注意：句点 (.) 是一个简写形式，用来代表当前工作目录中的项目。

status
repo status [project-list]

对于每个指定的项目，将工作树与临时区域（索引）以及此分支 (HEAD) 上的最近一次提交进行比较。在这三种状态存在差异之处显示每个文件的摘要行。

要仅查看当前分支的状态，请运行 repo status。系统会按项目列出状态信息。对于项目中的每个文件，系统使用两个字母的代码来表示：

在第一列中，大写字母表示临时区域与上次提交状态之间的不同之处。

字母	含义	说明
-	没有变化	在 HEAD 与索引中相同
A	已添加	不存在于 HEAD 中，但存在于索引中
M	已修改	存在于 HEAD 中，但索引中的文件已修改
D	已删除	存在于 HEAD 中，但不存在于索引中
R	已重命名	不存在于 HEAD 中，索引中文件的路径已更改
C	已复制	不存在于 HEAD 中，复制自索引中的另一个文件
T	模式已更改	HEAD 与索引中的内容相同，但模式已更改
U	未合并	HEAD 与索引之间存在冲突；需要加以解决
在第二列中，小写字母表示工作目录与索引之间的不同之处。

字母	含义	说明
-	新/未知	不存在于索引中，但存在于工作树中
m	已修改	存在于索引中，也存在于工作树中（但已修改）
d	已删除	存在于索引中，但不存在于工作树中


# repo 上传代码 到 gerrit
新建一个 Repo 分支
对于您打算进行的每项更改，请在相关的 Git 存储库中新建一个分支：

repo start NAME .

您可以在同一存储库中同时新建多个独立的分支。“NAME”分支是您的工作区的本地分支，不会包含在 Gerrit 或最终源代码树中。

进行更改
在您修改源代码文件（并且验证）后，请将这些更改提交到您的本地存储库：

git add -A
git commit -s

请在您的提交消息中提供相关更改的详细说明。该说明将会被推送到公开 AOSP 存储库，因此请按照我们的准则来撰写更改列表说明：

以一行摘要（最多 50 个字符）开头，后跟一个空白行。 这是 Git 和 Gerrit 支持的格式，适用于各种屏幕尺寸的设备。

从第三行开始输入较长的说明，说明会在达到 72 个字符时自动硬回车换行。该部分应着重说明更改解决了什么问题，以及如何解决了问题。尽管我们建议您提供第二部分的内容，但这在实现新功能时是可选内容。

添加对任何假设或背景信息的简短说明，这些内容可能对下一年研究此功能的其他贡献者起到很大的帮助作用。

以下是一个示例提交消息：

short description on first line

more detailed description of your patch,
which is likely to take up multiple lines.

repo init 期间提供的唯一更改 ID 以及您的姓名和电子邮件将自动添加到您的提交消息中。

上传到 Gerrit
将更改提交到您的个人历史记录后，请使用以下命令将其上传到 Gerrit：

repo upload

如果您在同一存储库中新建了多个分支，则系统会提示您选择要上传的分支。

上传成功后，Repo 会为您提供 Gerrit 上对应新页面的网址。访问该链接可在审核服务器上查看您上传的补丁程序、添加注释，或者为您的补丁程序申请特定审核者。

上传替换补丁程序
假设某位审核者已看过您的补丁程序，并要求您做一些小小的修改。您可以在 Git 中修改提交的内容，这会在 Gerrit 中生成一个新的补丁程序，该补丁程序与原始补丁程序具有相同的更改 ID。

注意：如果您在上传该补丁程序之后进行了其他提交，那么您将需要手动移动 Git HEAD。
git add -A
git commit --amend

当您上传修改后的补丁程序时，它将替换 Gerrit 和本地 Git 历史记录中的原始补丁程序。

解决同步冲突
如果提交到源代码树的其他补丁程序与您的存在冲突，那么您需要在源代码存储库的新 HEAD 的基础上对您的补丁程序执行“衍合”(rebase) 命令。执行此操作的一种简单方法是运行以下命令：

repo sync

此命令首先从源代码服务器获取更新，然后尝试在新的远程 HEAD 的基础上对您的 HEAD 自动执行衍合命令。

如果自动衍合命令失败，您就必须手动执行衍合。

repo rebase

使用 git mergetool 可帮助您处理衍合冲突。在成功合并冲突文件后，运行以下命令：

git rebase --continue

在自动或手动衍合完成之后，运行 repo upload 来提交衍合后的补丁程序。