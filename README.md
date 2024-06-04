# Six-digit_Electronic_Lock_Controller
上海大学计算机工程与科学学院计算机科学与技术专业夏季硬件大作业

六位密码电子锁控制器

## 草稿

### 要实现的功能

1. 设定密码
2. 复位开关（恢复为初始密码000000）
3. 输入三次错误报警（利用灯10秒闪烁）
4. 利用数码管显示各种信息
5. 拓展：多个密码的切换，另有更高权限的密码来实现这个切换



### 输入（[3:0] input）

> 六位十进制密码 => 使用四位二进制输入 => `4-16译码器`
>
> 若二进制输入不合格（如 (1010)B = (11)H 则报错）
>

实验箱数码管接口分别标了8、4、2、1，疑似无需译码器和错误判断

分为`设置密码`阶段和`输入密码`阶段

**需要有一个开关（toggle）来切换密码位**，否则开关不够



### 控制开关（mode）

有一个开关来切换`设置密码`阶段和`输入密码`阶段



### 复位开关（reset）

输入一个1，输出24个0（6个十进制0）



### 判断密码正确与否（judge）

有一个`寄存器`或多个`寄存器`来记录密码

用`同或门`(利用^异或)对每一位进行判断

另有一个`寄存器`存储错误次数，正确则归零，达到三次灯10秒闪烁



### 输出（[3:0] output1, [3:0] output2, [3:0] output3, [3:0] output4, [3:0] output5, [3:0] output6）

分别数码管上的6位密码，每个密码四个二进制输出

qian