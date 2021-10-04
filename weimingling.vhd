library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity weimingling  is
	port(
	      input   : in  std_logic_vector(4  downto 0);
	      reset   : in  std_logic;
	      clk     : in  std_logic;
		 BX_BUS,PC_BUS,LOAD_ACC,LOAD_BX,LOAD_CX,LOAD_IR,LOAD_MAR,LOAD_MDR,LOAD_PC,INC_BX,INC_PC,M_R,M_W,MDR_BUS,ADDER_BUS,ACC_BUS: out STD_LOGIC;--(16)
		 SEL_ACC,SEL_C,SEL_DATA,SEL_F,SEL_Q       : out STD_LOGIC_VECTOR(1 DOWNTO 0);--(6)
		 ALUOP                                         : out STD_LOGIC_VECTOR(4 DOWNTO 0);--(1)
		  output  : out std_logic_vector(4  downto 0);
	      sign    : out std_logic_vector(1  downto 0)  
	);
end  weimingling ;
ARCHITECTURE register_set_body OF weimingling IS
    TYPE my_array IS ARRAY(20 DOWNTO 0) OF STD_LOGIC_VECTOR(37 DOWNTO 0);
	SIGNAL reg : my_array;
    CONSTANT code : my_array:=(
                    0=>"01000010001000000000000000000000000001",
					1=>"00000001000100000000100000000000000010",
					2=>"00000100000001000000000000000001000011",
					--
					3=>"00000010000000100000000000000000001010",
					4=>"00000010000000100000000000000000001011",
					5=>"10000010000000000000000000000000001100",
					6=>"10000010000000000000000000000000001101",
					7=>"10000010000000000000000000000000001110",
					8=>"00001000000000000001000001100010000000",
					9=>"00000000100000000000000000000000010100",
					--
				   10=>"00000001000100000000100000000000001111",
				   11=>"00000001000100000000100000000000010000",
				   12=>"00000001000100000000100000000000010001",
				   13=>"00000001000100000000100000000000010010",
				   14=>"00000001000000010000010000000000010011",
				   20=>"00000000000000000000000000000000000000",
				   --
				   15=>"00010000000001000000000000000000000000",
				   16=>"00001000000001000010000000000000000000",
				   17=>"00100000000001011000000000000000000000",
				   18=>"00100000000001000100000111100000000000",
				   19=>"00000001000000000000000000000000000000"
			      --
 
                 			
		        );	

BEGIN	
	PROCESS (reset,input)			
	VARIABLE i : INTEGER;
	BEGIN
		IF reset='1' THEN
			FOR i IN 20 DOWNTO 0 LOOP
                reg(i) <= code(i);
		    END LOOP;
		    output <= "00000";
		    SIGN   <= "10";
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
       ELSE
		       output  <= reg(CONV_INTEGER(input))( 4 downto 0 );
               sign    <= reg(CONV_INTEGER(input))(6 downto 5);
	BX_BUS   <= reg(CONV_INTEGER(input))(37);
    PC_BUS   <= reg(CONV_INTEGER(input))(36);
	LOAD_ACC <= reg(CONV_INTEGER(input))(35);
	LOAD_BX  <= reg(CONV_INTEGER(input))(34);
	LOAD_CX  <= reg(CONV_INTEGER(input))(33);
	--
	LOAD_IR  <= reg(CONV_INTEGER(input))(32);
	LOAD_MAR <= reg(CONV_INTEGER(input))(31);
	LOAD_MDR <= reg(CONV_INTEGER(input))(30);
	LOAD_PC  <= reg(CONV_INTEGER(input))(29);
	INC_BX   <= reg(CONV_INTEGER(input))(28);
	--
	INC_PC   <= reg(CONV_INTEGER(input))(27);
	M_R      <= reg(CONV_INTEGER(input))(26);
	M_W      <= reg(CONV_INTEGER(input))(25);
	MDR_BUS  <= reg(CONV_INTEGER(input))(24);
	ADDER_BUS<= reg(CONV_INTEGER(input))(23);
	--
	ACC_BUS  <= reg(CONV_INTEGER(input))(22);
	--
	SEL_ACC  <= reg(CONV_INTEGER(input))(21 downto 20);
	SEL_C    <= reg(CONV_INTEGER(input))(19 downto 18);
	SEL_DATA <= reg(CONV_INTEGER(input))(17 downto  16);
	SEL_F    <= reg(CONV_INTEGER(input))(15  downto  14);
	SEL_Q    <= reg(CONV_INTEGER(input))(13  downto  12);
	ALUOP    <= reg(CONV_INTEGER(input))(11  downto 7);
        end if ;

    end process;
	end register_set_body ;