---
title: about bus
date: 2021-09-04 16:12:48
tags: 
---
# 总线,
  计算机的组成部件间用于传输数据或者指令的物理（软件逻辑）线路，以下列举一些嵌入式中常见的总线和其他总线
# MIPI 
# HDMI

# SPI
  　　标准的SPI总线是有CS（chip select)/SS(slave select), CLOCK, MISO(Master IN Slave out), MOSI 四条线，用于nor flash的扩展的SPI额外多了两条引脚 WP（write protect）,HOLD(用于禁止主机和flash器件的所有通讯)
  　　常见的1-wire(只用一条数据线，bitbang,只能单工), 2-wire（可以双工）, 4-wire(使用WP和HOLD脚作为额外的两条数据线) 都是说用来传输数据的线的数量
  标准的是2-wire, 1-wire 为了节约引脚，4-wire为了提升速率
　　SPI通信的开始总是以CS引脚电平拉低开始，拉高而结束
  SPI clock的极性（ploar）和相位(phase) 各有0，1两种排列组合出来共有4种，所以spi有4种工作模式
　　 四种模式的差异在于读取数据的时机是在第一个还是第二个跳变沿，是上升
沿还是下降沿

| 模式别名    | CPOL      | CPHA | 特性点     |
| :---  | :---     |    :----:   |          :--- |
| mode 0   | 0   | 0        | 空闲（没传输数据）时，时钟线是处于低电平,从第一个上升沿开始采集数据   |
| mode 1  | 0   | 1        | 空闲（没传输数据）时，时钟线是处于低电平，从第二个上升沿开始采集数据   |
| mode 2   | 1   | 0        | 空闲（没传输数据）时，时钟线是处于高电平，钟线是处于低电平,从第一个下降沿开始采集数据   |     |
| mode 3   | 1   | 1        | 空闲（没传输数据）时，时钟线是处于高电平 ，从第二个下降沿开始采集数据      |

时钟的极性
　　CPOL = 0：表示空闲时是低电平
　　CPOL = 1：表示空闲时是高电平
由于数据传输往往是从跳变沿开始的，也就表示开始传输数据的时候，是下降沿还是上升沿。
时钟的相位
　　CPHA = 0：表示从第一个跳变沿开始采样
　　CPHA = 1：表示从第二个跳变沿开始采样
　　一个时钟周期会有2个跳变沿。而相位，直接决定SPI总线从那个跳变沿开始采样数据。
　　至于跳变沿究竟是上升沿还是下降沿，这取决于 CPOL。记住， CPHA 只决定是哪个跳变沿采样。
　　数据发送应该是MSB first
ps:
 　关于SPI的通讯可以参考一些SPI Nor Flash的器件手册，手册上有清晰易懂的图形，或者参考文末的参考博客链接

# I2C (IIC)　
　　　发音 I two see 或者　I square see 全拼写为　Inter－Integrated Circuit
  　　飞利浦公司发明的，只用两条线，一条clock,一条data，支持多主机多从机的模式，需要固定的设备地址，因为只需要用到两条线，所以很在嵌入式设备（板子上)很流行
  I2C总线支持的速率有几种
  | I2C Mode    | Speed      | 特性|
| :---:  | :---     | :--- |
| Standard Mode   |  100 Kbps   |Similar in Implementation, with different timing requirements|
| Fast Mode   | 400 Kbps   | Similar in Implementation, with different timing requirements|
| Fast Mode Plus   | 1Mbps   | Similar in Implementation, with different timing requirements|
| High Speed Mode   | 3.4Mbps   | Reques controller code for high speed transfre|
| Ultra-Fast Mode   | 5 Mbps   | Write-only, Omits some standard I2C features|

  I2C的时序图如下
  ![I2C_timing_diagram.png](images/I2C_timing_diagram.png)
  I2C上的数据仅在时钟线为高电平的时候有效(SCLline high, SDA is Stable)，其取值为1&0 = 0 ， 1 & 1 = 1
  I2C上的ACK = 逻辑 '0'
  I2C上的NACK = 逻辑'1'
  R = 逻辑'1'
  W = 逻辑 '0'
  发送数据是从MSB..LSB的顺序

ps：
  参考资料 来自德州仪器网站的
  slides-i2c-protocol.pdf

# I3C

# UART

# PCI

# NVME

# USB
# ACPI
# SCSI
# platform bus

# ref

SPI部分内容参考了
https://www.cnblogs.com/gmpy/p/12461461.html
