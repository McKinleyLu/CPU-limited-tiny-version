LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY mainStore IS
PORT(   MemR: in std_logic; 
		MemW: in std_logic;
		reset: in std_logic;  
		clk : in std_logic;  -- Time   
		MAR: IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
		DataIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
		DataOut: out STD_LOGIC_VECTOR (7 downto 0)
		
	);
END mainStore;
ARCHITECTURE mainStore_body OF mainStore IS
	TYPE my_array IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	Signal  reg : my_array ;
	Signal tempOutput: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
begin
	PROCESS (reset,clk,MAR)
	VARIABLE i :integer;
	 begin
		IF reset = '1' then	
					reg(0)<=  "00101000"; -- Set Bx
					reg(1)<=  "00001001"; -- Set Cx
					reg(2)<=  "01000000"; -- Load ACC
					reg(3)<=  "01100000"; -- Add ACC
					reg(4)<=  "11000000"; -- Dec CX
					reg(5)<=  "10100100"; -- JNZ 
					reg(6)<=  "10001111"; --  Store M
					reg(7)<=  "111ZZZZZ";-- STOP
-------------------------------------------------------
					reg(8)<= "00000101";   -- 5 numbers
					reg(9)<= "00001010";   --  10 First data address
					reg(10)<="00000001";  --  1  data1  
					reg(11)<="00000010";  --  2  data2
					reg(12)<="00000011";  --  3  data3
					reg(13)<="00000100";  --  4  data4
					reg(14)<="00000101";  --  5  data5    
					reg(15)<="00000000";   --Sum  1+2+3+4+5
				  FOR i IN 63 downto 16 LOOP
							reg(i) <= "00000000";
				  END LOOP;
		ELSE 
			IF clk'event AND clk='0' then
					IF MemR = '1'then
						tempOutput <= reg(CONV_INTEGER(MAR));
					ELSIF MemW = '1' then
						  reg(CONV_INTEGER(MAR))<=   DataIn;	
						tempOutput <= DataIn;
					END IF; 
			END IF;
		END IF;
	END PROCESS;
		DataOut	<= tempOutput ;
END mainStore_body ;