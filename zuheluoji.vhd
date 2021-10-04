LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY mo IS
	PORT(CP :IN STD_LOGIC;		--CLOCK
		 DIN:IN STD_LOGIC_VECTOR(2 DOWNTO 0);		--I/P Signal	
		 BX_BUS,PC_BUS,LOAD_ACC,LOAD_BX,LOAD_CX,LOAD_IR,LOAD_MAR,LOAD_MDR,LOAD_PC,INC_BX,INC_PC,M_R,M_W,MDR_BUS,ADDER_BUS,ACC_BUS: buffer STD_LOGIC;--(16)
		 SELM,SEL_ACC,SEL_C,SEL_DATA,SEL_F,SEL_Q       : buffer STD_LOGIC_VECTOR(1 DOWNTO 0);--(6)
		 ALUOP                                         : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);--(1)
		 STATES                                        : out std_logic_vector(3 downto 0);
		 PWBZ : IN STD_LOGIC; 	--O/P Signal
		 reset: in std_logic
		 );
END mo;
ARCHITECTURE A OF mo IS
	TYPE	STATE IS (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15);	--State Type Declare
	SIGNAL	PRESENTSTATE	:STATE;	--Present State
	SIGNAL 	NEXTSTATE		:STATE;	--Next State
BEGIN
	SWITCHTONEXTSTATE:PROCESS(CP)
	BEGIN
		IF CP'EVENT AND CP='1' THEN
		       PRESENTSTATE <=NEXTSTATE;
		END IF;
END PROCESS SWITCHTONEXTSTATE;
CHANGESTATEMODE:PROCESS(DIN,PRESENTSTATE)
	BEGIN
		CASE PRESENTSTATE IS
				WHEN S0=>				--STATE S0
                     PC_BUS    <= '1';
					 LOAD_MAR  <= '1';
					 INC_PC    <= '1';
					 IF RESET = '1'THEN NEXTSTATE <= S0;
					 ELSE 
			            NEXTSTATE <= S1;
			        END IF;
					 STATES    <= "0000";
					 --reset
					  BX_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
					  
					  
				WHEN S1=>				--STATE S1
                     M_R       <= '1';
					 LOAD_MDR  <= '1';
					 SEL_DATA      <= "10";
					 NEXTSTATE <= S2;
					 STATES     <= "0001";
					 --reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
				WHEN S2=>				--STATE S2
                     MDR_BUS   <= '1';
					 LOAD_IR   <= '1';
		             IF      DIN = "000" THEN NEXTSTATE <= S3;   --set bx
					 ELSIF   DIN = "001" THEN NEXTSTATE <= S3;   --set cx
					 ELSIF   DIN = "010" THEN NEXTSTATE <= S6;   --load
					 ELSIF   DIN = "011" THEN NEXTSTATE <= S6;   --ADD
					 ELSIF   DIN = "100" THEN NEXTSTATE <= S6;   --STORE
					 ELSIF   DIN = "101" THEN NEXTSTATE <= S12;  --JNZ
					 ELSIF   DIN = "110" THEN NEXTSTATE <= S13;  --DEC
					 END IF;
					 STATES     <= "0010";
					 --reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
				WHEN S3=>				--STATE S3
                     ADDER_BUS <= '1';
					 LOAD_MAR  <= '1';
					 NEXTSTATE <= S14;
					 STATES     <= "0011";
					 --reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ACC_BUS   <= '0';
                WHEN S4=>
				     MDR_BUS      <= '1';
					 LOAD_BX      <= '1';
					 NEXTSTATE    <= S0;
					 STATES        <= "0100";
					 --reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
			    WHEN S5=>
				     MDR_BUS      <= '1';
					 LOAD_CX      <= '1';
					 SEL_C        <= "10";
					 NEXTSTATE    <= S0;
					 STATES        <= "0101";
					 --reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
			    WHEN S6=>
				     BX_BUS       <= '1';
					 LOAD_MAR     <= '1';
					 INC_BX       <= '1';
					 IF DIN = "100" THEN NEXTSTATE <= S10;
			         ELSE 
					 NEXTSTATE    <= S14;
					 END IF;
					 STATES        <= "0110";
					 --reset
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
			    WHEN S7=>
				     MDR_BUS      <= '1';
					 SEL_ACC      <= "10";
					 LOAD_ACC     <= '1';
		             NEXTSTATE    <= S0;
					 STATES       <= "0111";
					  ACC_BUS   <= '1';
					--reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  ADDER_BUS <= '0';
				WHEN S8=> 
				     MDR_BUS      <= '1';
					 SEL_Q        <= "11";
					 ALUOP        <= "10000";
					 SEL_ACC      <= "01";
					 LOAD_ACC     <= '1';
					 SEL_F        <= "01";
					 NEXTSTATE    <= S0;
					 STATES        <= "1000";
					 --reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
				WHEN S10=>
					 SEL_DATA  <= "01";
					 LOAD_ACC  <= '1';
					 LOAD_MDR  <= '1';
					 LOAD_ACC  <= '1';
					 NEXTSTATE    <= S11;
					 STATES        <= "1010";
					 --reset
					  PC_BUS    <= '0';
				     BX_BUS       <= '0';
					 LOAD_MAR     <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
				WHEN S11=> 
				     M_W          <= '1';
					 NEXTSTATE    <= S0;
					 STATES        <= "1011";
				--reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
			    WHEN S12=>
			          LOAD_PC   <= '1';
					 IF PWBZ = '0' THEN   NEXTSTATE    <= S9;  
					 else
			             NEXTSTATE    <= S0;
			        end if ;   
					 STATES        <= "1100";
					--reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
				WHEN S13=>     
				     SEL_Q      <= "01";
				     SEL_C      <= "01";
				     ALUOP   	<= "10011";	
					 LOAD_CX   <= '1';						 
				     NEXTSTATE    <= S15;
					 STATES        <= "1101";
			     --reset
					  LOAD_PC      <= '0';
                      MDR_BUS      <= '0';
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
				WHEN S14=>               
				     M_R       <= '1';
					 SEL_DATA  <= "10";
					 LOAD_MDR  <= '1';
					 STATES     <= "1110";
					  LOAD_CX   <= '0';	
					 IF     DIN = "000" THEN NEXTSTATE <= S4;
					 ELSIF  DIN = "001" THEN NEXTSTATE <= S5;
					 ELSIF  DIN = "010" THEN NEXTSTATE <= S7;
					 ELSIF  DIN = "011" THEN NEXTSTATE <= S8;
					 END IF;
				--reset
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';
					WHEN S15=>      					
					  LOAD_CX   <= '0';	
					--RESET
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_PC   <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';	
                      LOAD_MDR  <= '0';		
				      M_R       <= '0';	
				      NEXTSTATE <=S0;	
					 STATES        <= "1111";
					
					 WHEN S9=>
					 STATES        <= "1001";
					 NEXTSTATE<=S0;
					--reset		
					  LOAD_PC   <= '0';	
					  BX_BUS    <= '0';
					  PC_BUS    <= '0';
					  LOAD_ACC  <= '0';
					  LOAD_BX   <= '0';
					  LOAD_CX   <= '0';
					  LOAD_IR   <= '0';
					  LOAD_MAR  <= '0';
					  LOAD_MDR  <= '0';
					  INC_BX    <= '0';
					  INC_PC    <= '0';
					  M_R       <= '0';
					  M_W       <= '0';
					  MDR_BUS   <= '0';
					  ADDER_BUS <= '0';
					  ACC_BUS   <= '0';					
				WHEN OTHERS=>			--Initial State
					NEXTSTATE<=S0;
		    	--OUTPUT
			    END CASE;
		END PROCESS CHANGESTATEMODE;
END A;