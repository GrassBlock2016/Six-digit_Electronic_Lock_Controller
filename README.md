# Six-digit_Electronic_Lock_Controller
上海大学计算机工程与科学学院计算机科学与技术专业夏季硬件大作业

六位密码电子锁控制器

## 项目介绍

本项目基于 Quartus II 6.0 软件以及 Verilog HDL 语言编写，并已经过 DICE SEM II 实验箱的上机调试和验收（全员绩点 4.0），不幸的是从 23 届开始，大二夏季实训不再有这门课。该项目各主要文件的说明如下：

### 目录结构

```
├─ error_counter.v              // 错误计数器模块
├─ judge.v                  	// 密码正确与否的判断模块
├─ led_flasher.v               	// 报警闪烁灯控制模块
├─ passwd_register.v            // 密码寄存器模块
├─ register.v                	// 底部寄存器模块
├─ SixDigit_Electronic_Lock_Controller.v  // 顶层电路设计模块
├─ yima2to4.v                	// 2-4译码器模块
├─ SixDigit_Electronic_Lock_Controller.qpf // 项目主文件
├─ f1.vmf				// 单密码输入正确情景仿真模拟波形文件
├─ f2.vmf				// 密码归零按钮情景仿真模拟波形文件
├─ f3.vmf				// 密码输入三次错误报警情景仿真模拟波形文件
├─ f4.vmf				// 多密码输入情景仿真模拟波形文件
├─ f5.vmf				// 隐藏密码情景仿真模拟波形文件
├─ ......                       			// 其他文件略
```

### 功能介绍

1. 可以设定密码
2. 可以有复位开关
3. 输入三次错误要报警
4. 利用数码管显示各种信息
5. 拓展：可以设定多个密码
6. 拓展：可以在数码管上隐藏正在输入或设置的密码

### 接口说明

|      | 接口名          | 说明                                                         |
| ---- | --------------- | ------------------------------------------------------------ |
| 输入 | m               | 切换模式，接开关，0为设置密码，1为输入密码                   |
|      | [3:0]  inA, inB | 两个十进制位的密码输入，接6个开关，非10进制会不显示且传入0到寄存器 |
|      | clk             | 手动信号，接一个单步脉冲，按一下输入（设置）一次密码或进行一次判断 |
|      | clr             | 清空，接开关，同时清空数码管和当前模式对应的寄存器           |
|      | true_clk        | 连续的时钟信号，接10Hz口，主要用于控制报警灯的闪烁           |
|      | a0,  a1         | 切换高两位、中两位、低两位密码以及判断，接2个开关，是实验箱开关数量有限的无奈之举 |
|      | ps0,  ps1       | 多密码的切换，接2个开关                                      |
|      | hide            | 输入时隐藏密码（类似于软件输入形如“\*\*\*\*\*\*”的密码样式），接一个开关 |
| 输出 | out1-6          | 显示密码，分别接数码管对应的24个接口                         |
|      | res             | 显示判断结果，接1个led灯，当且仅当a0a1=11且按下clk时才可能发生改变 |
|      | eo              | 错误计数，接2个led灯                                         |
|      | led             | 报警灯，接1个led灯，输入错误三次时自动开始报警闪烁           |

## 注意事项

1. 本项目应该不涉及时序逻辑电路，故 always 中赋值应使用阻塞式（=）而非非阻塞式（<=）

2. 自己在 Quartus 进行学习测试时应注意，主 module 名应于文件名一致才能运行

3. 仿真文件的加载是用的绝对路径，每个人电脑路径不一样记得选一下再加载，不用过多去新建了

4. 如有问题，欢迎联系我们讨论交流
