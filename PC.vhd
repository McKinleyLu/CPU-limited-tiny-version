LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY pc IS
	PORT(inc_pc: in std_logic;
		 clk       : in std_logic;
		 load_pc:in std_logic;
		 reset  : in std_logic;
		 pc: buffer std_logic_vector(7 downto 0);
		 addr: out std_logic_vector(7 downto 0) );
END pc;
ARCHITECTURE A OF pc IS
begin
PROCESS(inc_pc,load_pc,pc,clk)
begin
	if (clk'event and clk = '0' and reset ='1') then
	pc<="00000000";end if ;
	if(clk'event and clk = '0' and load_pc ='1') then
    pc<="00000011"; 
    --addr<=pc;
   END IF;
	if  (clk'event and clk = '0' and inc_pc='1') then
	addr<=pc;
	pc<=pc+1;
	end if;
	end process;
END A;