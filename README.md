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



### 输入

六位十进制密码 => 使用四位二进制输入 => `4-16译码器`

若二进制输入不合格（如 (1010)B = (11)H 则报错）

分为`设置密码`阶段和`输入密码`阶段



### 控制开关

有一个开关来切换`设置密码`阶段和`输入密码`阶段



### 复位开关

待实现



### 判断密码正确与否

有一个`寄存器`或多个`寄存器`来记录密码

用`译码器`和`同或门`对每一位进行判断		

另有一个`寄存器`存储错误次数，正确则归零，达到三次灯10秒闪烁