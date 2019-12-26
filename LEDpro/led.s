
.global _start  /* 全局标号 */

/* 
 * 描述： _start 函数，程序从此函数开始执行此函数完成时钟使能、
 *        GPIO 初始化、最终控制GPIO输出低电平来点亮LED灯。
 */

_start:
  /* 例程代码 */
  /* 1、使能所有时钟 */
  ldr r0, =0x020c4068   /* 寄存器CCGR0 */
  ldr r1, =0xffffffff
  str r1, [r0]

  ldr r0, =0x020c406c   /* 寄存器CCGR1 */
  str r1, [r0]

  ldr r0, =0x020C4070   /* 寄存器CCGR2 */
  str r1, [r0]

  ldr r0, =0x020c4074   /* 寄存器CCGR3 */
  str r1, [r0]

  ldr r0, =0x020c4078   /* 寄存器CCGR4 */
  str r1, [r0]

  ldr r0, =0x020c407c   /* 寄存器CCGR5 */
  str r1, [r0]

  ldr r0, =0x020c4080   /* 寄存器CCGR6 */
  str r1, [r0]


  /* 2、设置 GPIO1_IO03 复用为 GPIO1_IO03 */
  ldr r0, =0x020e0068   /* 将寄存器 SW_MUX_GPIO1_IO03_BASE 加载到 r0中 */
  ldr r1, =0x5          /* 设置寄存器 SW_MUX_GPIO1_IO03_BASE 的 MUX_MODE 为 5 */
  str r1, [r0]

  /* 3、配置 GPIO1_IO03 的 IO 属性 
   *bit 16:0 HYS 关闭
   *bit [15:14]: 00默认下拉
   *bit [13]: 0 kepper 功能
   *bit [12]: 1 pull/keeper 使能
   *bit [11]: 0 关闭开路输出
   *bit [7:6]: 10 速度 100Mhz
   *bit [5:3]: 110 R0/6 驱动能力
   *bit [0]: 0 低转换率
   */
  ldr r0, =0x020e02f4   /* 寄存器 SW_PAD_GPIO1_IO03_BASE */
  ldr r1, =0x10b0
  str r1, [r0]

  /* 4、设置 GPIO1_IO03 为输出 */
  ldr r0, =0x0209c004   /* 寄存器 GPIO1_GDIR */
  ldr r1, =0x0000008
  str r1, [r0]

  /* 5、打开 LED0
   * 设置 GPIO1_IO03输出低电平
   */
  ldr r0, =0x0209c000   /* 寄存器 GPIO1_DR */
  ldr r1, =0
  str r1, [r0]

  /*
   * 描述： loop 死循环
   */
  loop:
        b loop

