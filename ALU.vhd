library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity alu is
	port(
		selects : in std_logic_vector(4 downto 0);
		a  : in std_logic_vector(7 downto 0);
		b  : in std_logic_vector(7 downto 0);
		cout    : out std_logic_vector(7 downto 0);
		c       : out std_logic;
		s       : out std_logic;
		o       : out std_logic;
		z       : out std_logic
	);
end  alu;

architecture aluu of alu is
signal result: std_logic_vector(8 downto 0);
begin
abc : process(selects,b,a,result)
begin
  case selects is
	when  "10000" =>  --��ʱΪ�ӷ���
	result <= ('0'&b) + ('0'&a);
	cout <= result(7 downto 0);
	c    <= result(8);
	o <= ( a(7) and b(7) and not(result(7)) ) or ( not(a(7)) and not(b(7)) and result(7)) ;
	when "10001" =>    --��ʱΪ������
	    result <= ('0'&a) - ('0'&b) ;
	   	cout <= result(7 downto 0);
		c    <= result(8);
	    o <= (a(7) and not(b(7)) and not(result(7))) or (not(a(7)) and b(7) and result(7));
	when "10010" =>      ----��ʱΪ��1
	     result <= ('0'&a) + ("00000001");
	   	cout <= result(7 downto 0);
		c    <= result(8);
		 o <= ( a(7) and '0' and not(result(7)) ) or ( not(a(7)) and not('0') and result(7)) ;
	when "10011" =>     ----��ʱΪ��1
		result <= ('0'&a) - ("00000001");
	   	cout <= result(7 downto 0);
		c    <= result(8);
		 o <= (a(7) and not('0') and not(result(7))) or (not(a(7)) and '0' and result(7));
	when "10100" =>      --��ʱΪ��2
	 	 result <= ('0'&a) - ("00000001");
	   	cout <= result(7 downto 0);
		c    <= result(8);
			 o <= (a(7) and not('0') and not(result(7))) or (not(a(7)) and '0' and result(7));
	when "10101" =>      --��ʱΪ��2
	     result <= ('0'&a) + ("00000001");
	   	cout <= result(7 downto 0);
		c    <= result(8);
		 o <= ( a(7) and '0' and not(result(7)) ) or ( not(a(7)) and not('0') and result(7)) ;
	when "10110" =>      --��ʱΪ�ӷ�����1
		result <= ('0'&a) - ('0'&b)  + ("00000001");
	   	cout <= result(7 downto 0);
		c    <= result(8);
		 o <= (a(7) and not('0') and not(result(7))) or (not(a(7)) and '0' and result(7));
	when "10111" =>      --��ʱΪ�ӷ�����2
		result <= ('0'&a) + ('0'&b) -  ("00000001");
	   	cout <= result(7 downto 0);
		c    <= result(8);
			 o <= (a(7) and not('0') and not(result(7))) or (not(a(7)) and '0' and result(7));

	 when "00000" =>                      --��ʱΪ��
	 cout <= "ZZZZZZZZ";
	 when  "00001" =>                     --��ʱΪ��
	 cout <= a or b;
	 when "00010" =>                      --��ʱΪ��
	 cout <= not a;
	 when "00011" =>                      --��ʱΪ���
	 cout <= a nand b;
	 when "00100" =>                      --��ʱΪ���
	 cout <= a nor b;
	when "00101" =>                       --��ʱΪͬ��
	cout <= a xor b;
	when "00110" =>                       --��ʱΪ���
	cout <= a xnor b;
	when others =>
	cout <= "ZZZZZZZZ";
	end case;

	if ( result = "000000000") then z <= '1';
	else z <= '0';
	end if;
	
	if(result(8) = '1') then s <= '1';
	else s <= '0';
	end if ;
	end process;
	end aluu;