library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity ACC  is
	port(
	       reset    : in std_logic;
		   clk       : in std_logic;
	       Load_ACC : in std_logic;
	       ACC_input : in std_logic_vector (7 downto 0);
	       ACC_output :out  std_logic_vector (7 downto 0)       
	);
end ACC;
ARCHITECTURE ACC_body OF ACC IS
signal reg : std_logic_vector (7 downto 0);
BEGIN	
	PROCESS (Load_ACC ,ACC_input,reset)		 
begin					
    if(reset = '1') then 
       reg<= "00000000";
     elsif (clk'event and clk = '1' and Load_ACC = '1') then 
        reg <= ACC_input;
     end if;
end process;
 ACC_output <= reg;
end;
     