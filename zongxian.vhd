LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY zongxian IS
	PORT(adder_bus,MDR_bus,BX_bus,ACC_bus,PC_bus:IN STD_LOGIC;--每个bus信号
		 IR:in STD_LOGIC_vector(4 downto 0);--IR 输入五位
		 MDR,BX,ACC,PC:in STD_LOGIC_vector(7 downto 0);-- 各数据 八位
		 data:out STD_LOGIC_vector(7 downto 0)--输出数据
		 );
END zongxian;
ARCHITECTURE B OF zongxian IS
begin
PROCESS (adder_bus,MDR_bus,bx_bus,acc_bus,pc_bus,IR,MDR,BX,ACC,PC)
begin 
if adder_bus='1' then data<="000"&IR;
elsif MDR_bus='1' then data<=MDR;
elsif BX_bus='1' then data<=BX;
elsif ACC_bus='1' then data<=ACC;
elsif PC_bus='1' then data<=PC;
end if;
end process;
END B;