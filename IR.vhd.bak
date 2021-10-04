LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY ir IS
	PORT(
		 load_ir:in std_logic;
		 clk       : in std_logic;
		 ir: in std_logic_vector(7 downto 0);
		 command:out std_logic_vector(2 downto 0);
		 adr: out std_logic_vector(4 downto 0) );
END ir;
ARCHITECTURE A OF ir IS
begin
PROCESS(load_ir,ir,clk)
begin
    if (clk'event and clk = '0' and load_ir='1') then
    command<=ir(7 downto 5);
    adr<=ir(4 downto 0);
     end if;
	end process;
END A;