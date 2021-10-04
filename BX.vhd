library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity BX  is
	port(
	       reset     : in std_logic;
	       clk       : in std_logic;
	       Load_bus  : in std_logic;
	       Inc_bus   : in std_logic;
	       Bx_input  : in std_logic_vector (7 downto 0);
	       Bx_output : buffer std_logic_vector (7 downto 0)       
	);
end BX ;
ARCHITECTURE BX_body OF BX IS
BEGIN	
	PROCESS (Load_bus,Inc_bus,Bx_input,reset,clk)		 
begin					
    if(reset = '1') then 
      Bx_output <= "00000000";
     elsif (clk'event and clk = '1' and Load_bus = '1') then 
        Bx_output <= Bx_input;
     end if;
    if(clk'event and clk = '1'  and  Inc_bus = '1')  then
       Bx_output <= Bx_output + 1   ;
    end if ;
end process;
end;
     