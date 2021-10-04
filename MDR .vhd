library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity MDR   is
	port(
	       reset    : in std_logic;
	       clk      : in std_logic;
	       Load_MDR : in std_logic;
	       MDR_input : in std_logic_vector (7 downto 0);
	       MDR_output :buffer std_logic_vector (7 downto 0)       
	);
end MDR ;
ARCHITECTURE MDR_body OF MDR  IS
BEGIN	
	PROCESS (Load_MDR ,MDR_input,reset)		 
begin					
    if(reset = '1') then 
       MDR_output <= "00000000";
     elsif (clk'event and clk = '1' and Load_MDR  = '1') then 
       MDR_output <= MDR_input;
     end if;
end process;
end;