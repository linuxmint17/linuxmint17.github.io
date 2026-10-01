---
title: 记录一次把独显虚焊导致黑屏的笔记本改装Linux做无头服务器的过程
date: 2026-10-01 17:09:04
tags:
---
#  记录一次把独显虚焊导致黑屏的笔记本改装Linux做无头服务器的过程

#  硬件条件，2011年 的联想笔记本，型号Z465，AMDCPU，4G内存，500G 机械硬盘，是bios只支持dos分区表，不支持gpt
  Z465 时代的 AMD 没有“CPU 核显”：AMD 直到 2011 年底推出 Llano APU（A系列）才把显卡塞进 CPU。你 2011 年的 Z465（AMD 速龙/羿龙），CPU 内部是不带核显的。
#  OS  选择：第一次是选择了rocky，因为支持更新的时间很长，大约有10年， 第二次选择了 Debian， 因为rocky的GUI安装程序anaconda，在磁盘分区的时候，强制gpt分区表，手动在命令行分区后不被识别，很麻烦，所以 turn to  debian 文字界面安装 更自由

# 采取的方案：把硬盘拆下来，借助其他显示正常的PC，从U 盘启动，安装OS到 USB转接的笔记本电脑硬盘

# 遇到的问题和解决办法:

1. debian net image 最小安装之后 修改 内核启动参数 /etc/dfault/grub 之后执行  grub-mkconfig -o /boot/grub/grub.cfg  找不到 grub-mkconfig（属于 grub-common or grub2-common 包）命令 ，有线网口受限不便连接网络， 使用 usb 共享安卓手机的移动网络，但是 由于是debian最小安装没有 dhclient 命令（属于 isc-dhcp-client 包）

   解决办法 : 从 能联网的机器 下载 grub-common grub2-common的 deb包，通过fat32 u盘，文件共享，使用dpkg -i 安装
   https://www.debian.org/distrib/packages ，注意选对版本和机器架构

2. 使用借用的机器主板技嘉B460M-D3SH 设置 关闭Secure Boot，并开启CSM（Compatibility Support Module） CPU 核显通过 HDMI 或 DP 数字接口输出，会出现已知的黑屏问题
    解决方法： 网上说法更新 固件包之后可以解决，实测没有解决，转用vga模拟输出
3. 配置了IP，能ping通，ssh连不上
   需要把ssh服务设置为开机启动
   ```bash
   systemctl enable ssh --now
   ```
4. 系统从u盘启动 总是uEFI，启动
   
    需要Rufus  dd写入，选择 mbr兼容模式，之后选择启动驱动器的时候，选择开头不带UEFI：的u盘
5. Install the GRUB boot loader to your primary drive?"
   最好手动选择指定的硬盘，安装程序自动选择可能选错

# 学到了什么东西 
- 个人主机后 有可能有两套 HDMI 或者 VGA  或者 DVI 输出接口，一套是主板的，如果cpu不带核显，插在主板的接口上点不亮屏幕
- lvm和分区表的关系

  分区表（MBR / GPT）：是硬盘最底层的“骨架”，决定硬盘怎么划分出基础分区（如 sda1, sda2）。

  LVM（逻辑卷管理）：是建立在“物理分区”之上的“上层建筑”，用来把多个分区合并、动态调整大小。

  关系：LVM 必须建立在某个物理分区上（比如 /dev/sda3）。这个物理分区既可以是 MBR 下的分区，也可以是 GPT 下的分区。
- 视频信号的分类
   vga 模拟， 不支持热拔插
   HDMI 数字
   DVI 数字


- udev 规则可以根据MAC地址给 网卡重名，但是不一定有用，有可能会被网卡驱动重写为 enxae4141f031b9之类的名称

  方法如下

  ```bash
  nano /etc/udev/rules.d/70-persistent-net.rules
  SUBSYSTEM=="net", ACTION=="add", ATTR{type}=="1", NAME="eth0"
  
  update-initramfs -u
  sudo dracut -f # 和上一hang
  ```

- systemd 时间同步服务
  ```bash
  systemctl  --version 
  apt install systemd-timesyncd
   systemctl enable --now systemd-timesyncd
  ```
- systemctl 控制关机，重启
  ```bash
   systemctl reboot
   systemctl poweroff
   systemctl poweroff -i

   apt update
apt install systemd-sysv

sync
systemctl poweroff
  ```

-  ip  命令可以给有线网配置多个ip 临时的，系统重启或者 link down 就会消失

  ```bash
  # 1. 查看当前网卡名称和已有IP
  ip addr show
  
  # 2. 添加第二个不同网段的IP（临时，重启后失效）
  sudo ip addr add 192.168.2.100/24 dev eth0
  
  # 3. 验证两个IP是否都已生效
  ip addr show eth0
  ```
- FIPS（Federal Information Processing Standards，联邦信息处理标准）是美国政府制定的一套极其严格的加密安全标准。

```text

如果你选择 FIPS 模式安装，系统会：

强制只使用经过美国官方认证的加密算法（禁用很多常见的、未认证的算法）。

开机时对加密模块进行自检（如果检测失败，系统甚至会拒绝启动）。

导致部分软件、驱动或 SSH 密钥无法正常工作（因为有些常用加密方式不符合 FIPS 标准）。

可能带来轻微的 CPU 性能损耗。
FIPS 模式是给美国政府机构、金融机构、医疗等受严格监管的企业用来满足合规要求的
```
- “如果没坏，就别修它” (If it ain't broke, don't fix it)
  不要盲目跟 Debian 的大版本更新（如从 12 升 13）
为什么无头服务器绝对不能轻易“跟大版本”？
网卡改名/掉驱动风险极高：大版本升级通常会更新 Linux 内核。老笔记本（2011年）的网卡（有线或无线）在内核更新后，驱动可能会失效或网卡名字重新被打乱（比如你费尽心思固定了 eth0，新内核可能无视规则直接把它变成 enp2s0），一旦网卡掉了，你直接彻底失联。

GRUB 引导损坏：大版本更新会重写 GRUB。你这台机器是 MBR 分区的老 BIOS，如果在更新过程中 GRUB 写错位置（比如写到了 /dev/sda 的第一个分区而不是 MBR），重启后直接黑屏死机。而你没有显卡，无法连接显示器去修复，这就意味着只能再次拆硬盘。

配置文件冲突：升级过程中，Debian 会问你“是否保留旧配置文件”（比如 /etc/ssh/sshd_config、/etc/network/interfaces）。如果你在无头环境下通过 SSH 操作，一旦按错，SSH 服务重启失败，你就再也连不上了。

- 网线直连的“自动翻转”：
联想 Z465 是 2011 年的老机器，它的 USB 网卡是 AX88772B。这种老芯片可能不支持自动 MDI/MDIX 翻转。如果直连不通，可能需要一根 交叉线（Crossover Cable）。不过 USB 网卡通常比较智能，你可以先试普通网线，不通再去买交叉线。

- USB 网卡的“省电”：
直连时，如果笔记本关机，USB 网卡可能会因为主板 USB 接口断电而失去链路，这是正常的。


- 硬盘分区创建，擦除，文件系统建立，toggle

  ```bash
  frisk /dev/sda
  
o （清空并新建 DOS/MBR 分区表）

n -> p -> 1 -> 回车 -> +1G （建 /boot）

a -> 1 （给 /boot 激活启动标志）

n -> p -> 2 -> 回车 -> +8G （建 swap）

n -> p -> 3 -> 回车 -> 回车 （建 /，占满剩余空间）

t -> 2 -> 82 （将第二个分区类型改为 Linux swap）

w （保存退出）
 
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
  
  # 分区擦除
  wipefs -a /dev/sda
  # 如果提示设备忙，加上强制参数
  wipefs -a -f /dev/sda
  
  #确认硬盘分区类型
  lsblk -o NAME,PTTYPE,SIZE,TYPE /dev/sda 
  # 
  sudo fdisk -l /dev/sda | grep "Disklabel type"
  sudo parted -l /dev/sda
  sudo blkid -p /dev/sda
  
  ```


- 内核启动参数 net.ifnames=0 biosdevname=0 **禁用** systemd/udev 的“可预测网络接口名称”（Predictable Network Interface Names）机制，从而恢复传统的 `eth0`、`eth1` 等命名方式

- ```bash
  sudo vi /etc/default/grub
  # 找到 GRUB_CMDLINE_LINUX 这一行，在行末的引号内添加以下内容
  net.ifnames=0 biosdevname=0
  # 如果是 UEFI 引导（现代电脑大多如此）：
  sudo grub2-mkconfig -o /boot/efi/EFI/rocky/grub.cfg
  # 如果是 Legacy BIOS 引导：Leveno z465 就是 legacy bios
  sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  ```


```text
`net.ifnames=0` 与 `biosdevname=0` 这两个内核参数**正在走向生命周期终点，未来发生重大变化甚至被移除的可能性很高**。以下是具体的分析与展望。

### 📌 参数的作用与背景

这两个参数用于**禁用** systemd/udev 的“可预测网络接口名称”（Predictable Network Interface Names）机制，从而恢复传统的 `eth0`、`eth1` 等命名方式。其中：

- **`net.ifnames=0`**：禁用 systemd/udev 的命名策略，让内核使用其原始的探测顺序来命名网卡。
- **`biosdevname=0`**：禁用 Dell 开发的 `biosdevname` 工具，该工具通过读取 BIOS/固件信息来分配如 `em1`、`p2p1` 等名称。

### ⚠️ 关键变化信号

#### 1. RHEL 10 已移除 `net.ifnames=0`

最明确的信号来自 **Red Hat Enterprise Linux (RHEL) 10**。根据 RHEL 10 的发布说明，**`net.ifnames=0` 内核参数已从内核命令行参数中被移除**，所有系统默认启用可预测的网络接口名称。这意味着在 RHEL 10 中，你**无法再通过该参数来禁用可预测命名**。

#### 2. `biosdevname` 已被视为过时

`biosdevname` 的价值已被 systemd 自身更强大的命名方案所取代。systemd 的主要开发者 Lennart Poettering 在 2022 年就曾指出，**`biosdevname` 几乎已被 systemd 的网络命名方案淘汰**，继续安装它并通过 `biosdevname=0` 将其关闭是“矛盾的”做法。从 RHEL 8 开始，systemd 命名已是默认方案，`biosdevname` 不再是主流选择。

### 🔮 未来趋势预测

基于以上信号，可以合理推断：

- **`net.ifnames=0`**：在 RHEL 10 中已被移除，**其他主流发行版（如 Ubuntu、Debian、SUSE）很可能在未来版本中跟进**，逐步弃用或移除该参数。虽然目前许多发行版仍支持该参数，但其“禁用可预测命名”的核心功能与上游 systemd 的设计方向背道而驰，**被彻底移除只是时间问题**。
- **`biosdevname=0`**：随着 `biosdevname` 包本身逐渐被淘汰，该参数的存在意义将越来越小。未来发行版可能不再默认安装 `biosdevname`，届时该参数将变得无关紧要。

### 💡 替代方案与建议

如果你目前依赖这两个参数来维持传统的 `eth0` 命名，需要开始规划迁移方案：

1. **接受并适应可预测命名**：这是最推荐的方式。可预测命名（如 `enp5s0`、`eno1`）解决了多网卡系统中 `eth0`/`eth1` 随机互换的问题，提供了更高的稳定性和安全性。
2. **使用 systemd `.link` 文件自定义命名**：如果必须使用特定名称，可以通过 systemd 的 `.link` 文件，基于 MAC 地址或物理位置来分配自定义名称（如 `internet0`、`dmz0`）。
3. **在配置管理中固化接口名**：确保你的配置管理（如 Ansible）、防火墙规则、网络绑定配置等不再硬编码 `eth0`，而是使用实际的可预测名称。

### 💎 总结

`net.ifnames=0` 和 `biosdevname=0` 代表了 Linux 网络接口命名历史上的一个过渡阶段。随着 systemd 可预测命名方案的成熟和普及，**这两个参数正在被逐步淘汰**。RHEL 10 移除 `net.ifnames=0` 是一个明确的里程碑，预示着其他发行版也将陆续跟进。建议尽早评估并迁移到可预测命名方案或 systemd 的 `.link` 自定义命名，以避免未来系统升级时出现网络配置故障。
```



````text
`systemd` 的 `.link` 文件提供了一种比内核参数更灵活、更持久的方式来为网络接口分配自定义名称。它通过匹配设备的硬件属性（如 MAC 地址、物理路径）来重命名接口，是替代 `net.ifnames=0` 的推荐方案。

### 📁 文件位置与命名规则

`.link` 文件是 ini 风格的文本文件，其搜索路径和优先级如下：

1. **`/etc/systemd/network/`**：本地管理员配置，**优先级最高**。
2. **`/run/systemd/network/`**：运行时配置，优先级次之。
3. **`/usr/lib/systemd/network/`**：系统默认配置，优先级最低。

**关键规则**：
- **文件扩展名**必须为 `.link`。
- 所有文件按**字母数字顺序**处理，**第一个匹配的文件生效**，后续匹配文件会被忽略。
- 系统自带一个默认文件 `99-default.link`。因此，你的自定义文件**文件名前缀建议小于 `70`**（如 `10-eth0.link`），否则可能被系统默认规则抢占。
- 如果 `/etc/` 和 `/usr/lib/` 下有**同名文件**，`/etc/` 下的会替换 `/usr/lib/` 下的。将文件符号链接到 `/dev/null` 可以“屏蔽”该配置。

### ✍️ 核心配置语法

一个 `.link` 文件包含两个核心部分：

#### 1. `[Match]` 部分：定义匹配条件
该部分决定这个文件适用于哪个网络设备。**所有条件必须同时满足**才算匹配。

常用匹配键：
- **`MACAddress=`**：匹配硬件 MAC 地址。**这是最推荐、最稳定的方式**。可以指定多个，用空格分隔。
- **`PermanentMACAddress=`**：匹配设备的永久 MAC 地址，对于某些虚拟化环境比 `MACAddress=` 更可靠。
- **`OriginalName=`**：匹配内核最初分配的接口名（如 `eth0`, `enp3s0`）。**注意**：内核分配的初始名称在不同启动间可能变化，应谨慎使用。
- **`Path=`**：匹配设备的物理路径（`ID_PATH` 属性），如 `pci-0000:00:1f.6`。适用于固定硬件插槽的场景。
- **`Driver=`**：匹配驱动名称。

为避免 udev 警告，如果确实想匹配所有接口，应显式添加 `OriginalName=*`。

#### 2. `[Link]` 部分：定义接口配置
该部分指定匹配后如何配置设备。

- **`Name=`**：**指定自定义的接口名称**。名称长度 1-15 个字符，可包含字母、数字及 `._-` 等。这是实现重命名的核心选项。
- **`NamePolicy=`**：定义命名策略的优先级。**重要**：`Name=` 的优先级低于 `NamePolicy=`。为了让 `Name=` 生效，必须确保 `NamePolicy=` 为空、未设置，或设置为 `keep` 等不产生新名称的策略。
- **`AlternativeName=`**：为接口分配一个**别名**（altname），可多次使用。这样无需重命名，也能通过别名访问接口。
- **`MTUBytes=`**：设置 MTU 大小。
- **`Description=`**：提供人类可读的描述。

### 📝 配置示例

假设你有一块网卡，其 MAC 地址为 `00:11:22:33:44:55`，你想将其重命名为 `wan0`。

**1. 创建文件 `/etc/systemd/network/10-wan0.link`**：
```ini
[Match]
MACAddress=00:11:22:33:44:55

[Link]
Name=wan0
```
**2. 应用配置**：保存后，可以通过重新触发 udev 事件或重启系统来应用更改。更安全的方式是重启网络服务或系统：
```bash
sudo udevadm control --reload
sudo udevadm trigger
```
或者直接重启系统。

### 🔍 故障排除：使用 `udevadm test-builtin`

这是诊断 `.link` 文件问题的核心工具。对目标设备路径运行该命令，可以查看哪个 `.link` 文件被匹配以及最终应用的名称：
```bash
sudo udevadm test-builtin net_setup_link /sys/class/net/<原接口名>
```
在输出中，关注 `ID_NET_LINK_FILE=` 和 `ID_NET_NAME=` 等变量，可以确认规则是否按预期生效。

### 💡 最佳实践提醒

- **优先使用 `MACAddress=`** 进行匹配，它比 `OriginalName=` 稳定得多。
- **文件名前缀务必小于 `70`**，以确保在默认规则之前被处理。
- **更改接口名后，务必同步更新**所有依赖该名称的配置，包括 `systemd-networkd` 的 `.network` 文件、防火墙规则、配置文件等。

`.link` 文件提供了一种声明式、持久化的接口命名管理方式，是应对 `net.ifnames=0` 被淘汰的可靠升级路径。
````


- MBR 分区
在 MBR 架构下，一块硬盘最多只能有 4 个主分区。

如果你只需要 3 个分区（/boot、swap、/），完全在主分区的名额之内。

只有当你需要创建 5 个或更多分区时，才必须牺牲一个主分区的名额，把它变成“扩展分区”，然后再在里面切出逻辑分区（比如 sda5、sda6）。


- 判断对grub的修改是否生效

  ```bash
  grep GRUB_CMDLINE_LINUX /etc/default/grub  # 确认修改的行内容是想要的
  #具体的例子 就是 
  # 如果输出里包含了 net.ifnames=0 biosdevname=0：说明文本改对了。
  #如果输出里没有这两个参数：说明你还没改。
  
  grep net.ifnames /boot/grub/grub.cfg
  # 如果显示有 net.ifnames=0：说明已经生效了（可能会显示很多行，这是正常的）。
  #如果没有任何输出：说明没生效。即使你第一步改对了，也没有成功写入引导。
  
  ```


- #### 使用 systemd系统的systemd-networkd服务，给网卡配置静态双ip

  ```bash
  [Match]
  # Name=eth0, 名称不确定，匹配时序不确定，改为以USB->RJ45 的MAC地址匹配
  # 实际上改了内核启动参数 外置的 USB 转网口 不插入的话，肯定 系统的有线 网卡是肯定是 eth0，
  # 但是 用USB网卡MAC 配置静态ip有一个好处，有点儿像是 交换机的 管理ip，和其网口不想干
  MACAddress=00:0e:c6:b2:0c:92 
  
  [Network]
  Address=192.168.1.100/24
  Address=192.168.2.100/24
  Gateway=192.168.1.1
  DNS=223.5.5.5
  ```

  #遇到的问题 1

  

  ```
  apt install -y network-manager
  systemctl enable --now NetworkManager
  nmtui
  ```

  # kickstart， 安装服务器 操作系统
  # 使用USB显示适配器 
 
# todo 
  这是Rocky Linux 10为无头服务器提供的一项非常方便的功能。你无需连接任何显示器，就能通过网络远程完成图形化安装。

工作原理：在安装启动时，通过添加特定的内核参数，安装程序会启动一个RDP服务。你只需从另一台电脑（比如你的主力机）用RDP客户端连接过去，就能看到完整的图形安装界面。

操作方法：

从U盘启动，在GRUB菜单界面按 e 键进入编辑模式。
找到以 linuxefi 或 linux 开头的行，在行末添加以下参数（用户名和密码请自行设定）：
bash
inst.rdp inst.rdp.username=你的用户名 inst.rdp.password=你的密码
按 Ctrl+X 启动。
从另一台电脑上，用RDP客户端（Windows自带的“远程桌面连接”即可）连接安装机的IP地址，即可开始图形化安装。


用文本模式安装（最稳妥，无图形界面依赖）
如果RDP不方便，还可以退回到最传统的文本模式安装。这种方式不依赖任何显卡输出，只需要键盘操作即可完成安装。

操作方法：

从U盘启动，在GRUB菜单界面按 e 键进入编辑模式。
在 linuxefi 或 linux 行末添加参数 inst.text。
按 Ctrl+X 启动，即可进入文本安装界面。后续的安装步骤（选择语言、分区、设置网络等）都可以通过键盘方向键和回车来完成。


ARCH 

apline

# 命令行安装 rocky 10 测试

```bash 
# 挂载（假设根目录挂载到 /mnt/sysimage）
mkdir -p /mnt/sysimage
mount /dev/sda3 /mnt/sysimage
mkdir /mnt/sysimage/boot
mount /dev/sda1 /mnt/sysimage/boot
swapon /dev/sda2
dnf --installroot=/mnt/sysimage 

echo "vm.swappiness=10" >> /etc/sysctl.conf 
```







