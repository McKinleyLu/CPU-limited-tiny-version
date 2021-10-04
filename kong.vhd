library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity kong  is
	port(
          IR      : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          PSW     : IN STD_LOGIC;
          RESET	  : IN STD_LOGIC;
          CLK     : IN STD_LOGIC;
		  output  : IN std_logic_vector(4  downto 0);
	      sign    : IN std_logic_vector(1  downto 0);
          ADDRESS : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)		  
	);
end   kong ;

ARCHITECTURE forming_part_body of  kong is
begin
    process(IR,RESET,CLK,PSW,OUTPUT,SIGN)
	 BEGIN 
	     IF RESET = '1'  THEN   ADDRESS <=  "00000";
		 ELSIF CLK'EVENT AND CLK = '1' THEN 
		       IF SIGN = "00"     THEN ADDRESS <= OUTPUT ;
			    ELSIF SIGN = "10"  THEN 
                 IF IR = "000"     THEN ADDRESS <= "00011";     --SET
                 ELSIF IR = "001"  THEN ADDRESS <= "00100";
                 ELSIF IR = "010"  THEN ADDRESS <= "00101";
                 ELSIF IR = "011"  THEN ADDRESS <= "00110";
                 ELSIF IR = "110"  THEN ADDRESS <= "01000";
                 ELSIF IR = "101"  THEN ADDRESS <= "01001";
                 ELSIF IR = "100"  THEN ADDRESS <= "00111";
                 END IF;       
			 ELSIF SIGN = "01"  then
			      IF PSW ='0' THEN ADDRESS <= "00101";
                  else              ADDRESS <= "00111"; 
                  END IF ;
			ELSE                  
				     
		    END IF;

		END IF ;
	END PROCESS;
END forming_part_body;