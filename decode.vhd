LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY decode IS
	PORT(		
         code   : in std_logic_vector(30 downto 0);	--I/P Signal	
		 BX_BUS,PC_BUS,LOAD_ACC,LOAD_BX,LOAD_CX,LOAD_IR,LOAD_MAR,LOAD_MDR,LOAD_PC,INC_BX,INC_PC,M_R,M_W,MDR_BUS,ADDER_BUS,ACC_BUS: out STD_LOGIC;--(16)
		 SEL_ACC,SEL_C,SEL_DATA,SEL_F,SEL_Q       : out STD_LOGIC_VECTOR(1 DOWNTO 0);--(6)
		 ALUOP                                         : out STD_LOGIC_VECTOR(4 DOWNTO 0);--(1)
		 reset: in std_logic
		 );
END decode;

ARCHITECTURE A OF decode IS
begin
PROCESS(code,reset)
 begin 
    if(reset = '1') then 
    BX_BUS   <= '0';
    PC_BUS   <= '0';
	LOAD_ACC <= '0';
	LOAD_BX  <= '0';
	LOAD_CX  <= '0';
	--
	LOAD_IR  <= '0';
	LOAD_MAR <= '0';
	LOAD_MDR <= '0';
	LOAD_PC  <= '0';
	INC_BX   <= '0';
	--
	INC_PC   <= '0';
	M_R      <= '0';
	M_W      <= '0';
	MDR_BUS  <= '0';
	ADDER_BUS<= '0';
	--
	ACC_BUS  <= '0';
	--
	SEL_ACC  <= "00";
	SEL_C    <= "00";
	SEL_DATA <= "00";
	SEL_F    <= "00";
	SEL_Q    <= "00";
	ALUOP    <= "00000";
	else
	BX_BUS   <= code(30);
    PC_BUS   <= code(29);
	LOAD_ACC <= code(28);
	LOAD_BX  <= code(27);
	LOAD_CX  <= code(26);
	--
	LOAD_IR  <= code(25);
	LOAD_MAR <= code(24);
	LOAD_MDR <= code(23);
	LOAD_PC  <= code(22);
	INC_BX   <= code(21);
	--
	INC_PC   <= code(20);
	M_R      <= code(19);
	M_W      <= code(18);
	MDR_BUS  <= code(17);
	ADDER_BUS<= code(16);
	--
	ACC_BUS  <= code(15);
	--
	SEL_ACC  <= code(14 downto 13);
	SEL_C    <= code(12 downto 11);
	SEL_DATA <= code(10 downto  9);
	SEL_F    <= code(8  downto  7);
	SEL_Q    <= code(6  downto  5);
	ALUOP    <= code(4  downto 0);
	 end if;
end process;
end A ;	 
	