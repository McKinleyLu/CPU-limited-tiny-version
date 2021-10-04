# 模型机CPU - 组合逻辑-限制版

1. 本次实验选取的开发工具是quartusII，Quartus II 是Altera公司的综合性CPLD/FPGA开发软件，原理图、VHDL、VerilogHDL以及AHDL（Altera Hardware 支持Description Language）等多种设计输入形式，内嵌自有的综合器以及仿真器，可以完成从设计输入到硬件配置的完整PLD设计流程。Quartus II可以在Windows、Linux以及Unix上使用，除了可以使用Tcl脚本完成设计流程外，提供了完善的用户图形界面设计方式。具有运行速度快，界面统一，功能集中，易学易用等特点。

2. Quartus II支持Altera的IP核，包含了LPM/MegaFunction宏功能模块库，使用户可以充分利用成熟的模块，简化了设计的复杂性、加快了设计速度。对第三方EDA工具的良好支持也使用户可以在设计流程的各个阶段使用熟悉的第三方EDA工具。

3. 此外，Quartus II 通过和DSP Builder工具与Matlab/Simulink相结合，可以方便地实现各种DSP应用系统；支持Altera的片上可编程系统（SOPC）开发，集系统级设计、嵌入式软件开发、可编程逻辑设计于一体，是一种综合性的开发平台

4. 指令格式

   ![指令格式](/projects/2.png)

5. 包含七种指令

   |     指令     |                     含义                      |
   | :----------: | :-------------------------------------------: |
   |  **Set B**   |         **操作数对应的地址的值给BX**          |
   |  **Set C**   |         **操作数对应的地址的值给CX**          |
   | **Load ACC** | **ACC <-** **M([BX])**           **BX<-BX+1** |
   |   **ADD**    |    **ACC<-ACC+[CX]**        **BX  <-BX+1**    |
   |   **DEC**    |                 **CX <-CX-1**                 |

6. 数据通路

   ![数据通路](/projects/cpu-struct.png)

7. 状态转换

   ![状态转换](/projects/cpu-state.png)

8. 调试仿真

   累加和1+2+3+4+5，最后放进第15号内存单元，并将结果读进CX中。

   ![指令执行顺序](/projects/1.png)

9. 个人总结

      时钟问题：由于各器件对时钟的要求并不完全一致，应通过仿真观察其变化。通过这次试验，总结以下几点时钟修改方法

   *  如果想让某器件输出值在某几个时钟内固定，则该器件需要添加时钟，如本实验中的

   ​    主存、控制器（状态机)、寄存器以及标志位寄存器

   * 发现时钟有差，采取以下方案

   ​    (1)确定所有使能无误

   ​    (2)需要当前操作的使能应该在上一步操作结束时，已经拥有使能信号

   ​    (3)改上升(下降)沿为下降(上升)沿

   ​    (4)在器件内添加信号(singal)，在process内将值赋值给信号，process外将信号值赋值给输出

   ​    (5)减少器件，避免由器件过多而产生的延迟

   ​    (6)注意，状态机内不要添加大量功能性代码，而是构造相应器件。状态机要保证控制状态的要求。