--Nicholas Schroeder
-- Main Control Unit for 32-bit MIPS CPU

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY CONTROL IS
	PORT(
		OP_CODE			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		ALU_OP			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		REG_DST			: OUT STD_LOGIC;
		REG_WRITE		: OUT STD_LOGIC;
		ALU_SRC_A		: OUT STD_LOGIC;
		ALU_SRC_B		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		PC_SOURCE		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		PC_WRITE_COND	: OUT STD_LOGIC;
		PC_WRITE		: OUT STD_LOGIC;
		I_OR_D			: OUT STD_LOGIC;
		MEM_READ		: OUT STD_LOGIC;
		MEM_WRITE		: OUT STD_LOGIC;
		MEM_TO_REG		: OUT STD_LOGIC;
		IR_WRITE		: OUT STD_LOGIC;
		NOT_ZERO  : OUT STD_LOGIC;
		LUI     : OUT STD_LOGIC;
		LH      : OUT STD_LOGIC;
		STORE_PC : OUT STD_LOGIC;
		NEGATIVE : OUT STD_LOGIC;
		FUNCT   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		MULTIPLY : OUT STD_LOGIC;
		RESET_MULT : OUT STD_LOGIC;
		MULT_WRITE : OUT STD_LOGIC;
		ZERO_EXTEND : OUT STD_LOGIC;
		MULT_DONE : IN STD_LOGIC;
		WRITE_HI : OUT STD_LOGIC;
		WRITE_LO : OUT STD_LOGIC;
	  CLOCK			: IN STD_LOGIC;
		RESET			: IN STD_LOGIC
	);
END CONTROL;

ARCHITECTURE BEHAV OF CONTROL IS

	TYPE STATE_TYPE IS (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,SM,SM_WB);
	SIGNAL STATE : STATE_TYPE;

	SIGNAL R_TYPE : BOOLEAN := FALSE;
	SIGNAL I_TYPE : BOOLEAN := FALSE;
	SIGNAL BRANCH : BOOLEAN := FALSE;

BEGIN

	PROCESS(CLOCK,RESET)
	BEGIN

		IF(RESET='1' AND RISING_EDGE(CLOCK)) THEN
			STATE <= S0;
		ELSIF(RISING_EDGE(CLOCK)) THEN
			CASE STATE IS
				WHEN S0 =>
					R_TYPE <= FALSE;
					I_TYPE <= FALSE;
					BRANCH <= FALSE;
					STATE <= S1;
					
				WHEN S1 =>
					---LW OR SW---
					IF((UNSIGNED(OP_CODE) > 31) AND (UNSIGNED(OP_CODE) < 44)) THEN
						STATE <= S2;
					---R_TYPE---
					ELSIF(((UNSIGNED(OP_CODE) = 0) AND (UNSIGNED(FUNCT) /= 8)) OR ((UNSIGNED(OP_CODE) > 23) AND (UNSIGNED(OP_CODE) < 32))) THEN						
						R_TYPE <= TRUE;
						STATE <= S6;
					---BRANCH---
					ELSIF((UNSIGNED(OP_CODE) = 1) OR ((UNSIGNED(OP_CODE) > 3) AND (UNSIGNED(OP_CODE) < 8))) THEN
						BRANCH <= TRUE;
						STATE <= S8;
					---JUMP---
					ELSIF((UNSIGNED(OP_CODE) = 2) OR (UNSIGNED(FUNCT)=8 AND UNSIGNED(OP_CODE)=0) OR (UNSIGNED(OP_CODE) = 3)) THEN
						STATE <= S9;
					---ITYPE---
					ELSIF((UNSIGNED(OP_CODE) > 7) AND (UNSIGNED(OP_CODE) < 16)) THEN
						I_TYPE <= TRUE;
						STATE <= S6;
					END IF;
				WHEN S2 =>
					IF((UNSIGNED(OP_CODE) > 31) AND (UNSIGNED(OP_CODE) < 38)) THEN
						STATE <= S3;
					ELSE
						STATE <= S5;
					END IF;
				WHEN S3 =>
					STATE <= S4;
				WHEN S4 =>
					STATE <= S0;
				WHEN S5 =>
					STATE <= S0;
				WHEN S6 =>
				  IF(UNSIGNED(OP_CODE)=0 AND UNSIGNED(FUNCT)=25) THEN
				    STATE <= SM;
				  ELSE
					  STATE <= S7;
					END IF;
				WHEN S7 =>
					STATE <= S0;
				WHEN S8 =>
					STATE <= S0;
				WHEN S9 =>
					STATE <= S0;
				WHEN SM =>
				  IF(MULT_DONE = '1') THEN
				    STATE <= SM_WB;
				  END IF;
				WHEN SM_WB =>
				   STATE <= S0;
				WHEN OTHERS =>
				  STATE <= S0;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS(STATE)
	BEGIN
		CASE STATE IS
			WHEN S0 =>	
			  WRITE_HI <= '0';
			  WRITE_LO <= '0';
			  MULT_WRITE <= '0';			
			  STORE_PC <= '0';
			  LH <= '0';
			  PC_SOURCE <= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '1';
				ALU_OP			<= "0001";
				ALU_SRC_A		<= '0';
			  ALU_SRC_B <= "01";											
				I_OR_D			<= '0';
				REG_WRITE		<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				IR_WRITE		<= '1';

			WHEN S1 =>			
			  IF(UNSIGNED(OP_CODE)=0 AND UNSIGNED(FUNCT)=25) THEN
			    RESET_MULT <= '1';
			  ELSE
			    RESET_MULT <= '0';
			  END IF;

				IF(UNSIGNED(OP_CODE) = 13 OR UNSIGNED(OP_CODE) = 12) THEN
				    ZERO_EXTEND <= '1';
				ELSE
				    ZERO_EXTEND <= '0';
				END IF;
				
				IF(UNSIGNED(OP_CODE) = 0 AND UNSIGNED(FUNCT) = 16) THEN
				  WRITE_HI <= '1';
				ELSIF(UNSIGNED(OP_CODE) = 0 AND UNSIGNED(FUNCT) = 18) THEN
				  WRITE_LO <= '1';
				END IF;
	    
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				STORE_PC <= '0';
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';
				
				ALU_OP <= "0001";
			  ALU_SRC_A <= '0';
				ALU_SRC_B <= "11";
			
			WHEN S2 =>
				ALU_OP 			<= "0001";
				ALU_SRC_A		<= '1';
				ALU_SRC_B		<= "10";

				IF(UNSIGNED(OP_CODE) = 33) THEN
				  LH <= '1';
				END IF;

			WHEN S3 =>
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				I_OR_D			<= '1';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '1';

			WHEN S4 =>
				REG_DST			<= '1';
				REG_WRITE		<= '1';
				I_OR_D			<= '0';
				MEM_READ		<= '0';
				MEM_TO_REG		<= '1';
				IR_WRITE		<= '0';

			WHEN S5 =>
				I_OR_D			<= '1';
				MEM_READ		<= '1';
				MEM_WRITE		<= '1';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';
			
			WHEN S6 =>			  
			  IF(UNSIGNED(OP_CODE)=0 AND UNSIGNED(FUNCT)=25)THEN
			    RESET_MULT <= '0';
					MULTIPLY <= '1';
				ELSE
					MULTIPLY <= '0';
				END IF;			  
				
				LUI <= '0';
				ALU_SRC_A		<= '1';

				IF(I_TYPE = TRUE) THEN
					ALU_SRC_B	<= "10";

					IF(UNSIGNED(OP_CODE) = 8) THEN
						ALU_OP <= "0001"; 	--ADDI
					ELSIF(UNSIGNED(OP_CODE) = 9) THEN
						ALU_OP <= "0010";	--ADDIU
					ELSIF(UNSIGNED(OP_CODE) = 10) THEN
						ALU_OP <= "0011";	--SLTI
					ELSIF(UNSIGNED(OP_CODE) = 11) THEN
						ALU_OP <= "0100";	--SLTIU
					ELSIF(UNSIGNED(OP_CODE) = 12) THEN
						ALU_OP <= "0101";	--ANDI
					ELSIF(UNSIGNED(OP_CODE) = 13) THEN
						ALU_OP <= "0110";	--ORI
					ELSIF(UNSIGNED(OP_CODE) = 14) THEN
						ALU_OP <= "0111";	--XORI
					ELSIF(UNSIGNED(OP_CODE) = 15) THEN
						ALU_OP <= "0110";	--LUI (OR)
						LUI <= '1';
					ELSE
						--SHOULD NEVER HAPPEN
					END IF;
					
				ELSIF(UNSIGNED(OP_CODE) = 0) THEN
					ALU_OP 			<= "0000"; 	--R_TYPE SEE FUNCT IN ALU_CTRL
					ALU_SRC_B		<= "00";
				ELSIF(UNSIGNED(OP_CODE) = 28) THEN
				  ALU_OP <= "1111";     --SIGNAL FOR CLO OR CLZ
				  ALU_SRC_B <= "00";
				END IF;

			WHEN S7 =>
				IF(I_TYPE = TRUE) THEN
					REG_DST 	<= '1';
				ELSE
					REG_DST		<= '0';
				END IF;

				REG_WRITE		<= '1';
				MEM_TO_REG		<= '0';

			WHEN S8 =>
				ALU_OP 			<= "1001";
				ALU_SRC_A		<= '1';
				ALU_SRC_B		<= "00";
				
			  PC_WRITE_COND <= '1';
				PC_SOURCE <= "01";
				
				IF(UNSIGNED(OP_CODE)=5) THEN
				  NOT_ZERO <= '1';
				ELSIF(UNSIGNED(OP_CODE)=4) THEN
				  NOT_ZERO <= '0';
				END IF;
				
				IF(UNSIGNED(OP_CODE)=1) THEN
				  STORE_PC <= '1';
				  REG_WRITE <= '1';
				  NEGATIVE <= '1';
				ELSE
				  STORE_PC <= '0';
				  REG_WRITE <= '0';
				  NEGATIVE <= '0';
				END IF;
						  
			WHEN S9 =>
				
				IF(UNSIGNED(OP_CODE)=2)THEN
				  PC_SOURCE <= "10";
				  PC_WRITE <= '1';
				ELSIF(UNSIGNED(OP_CODE)=0 AND UNSIGNED(FUNCT)=8) THEN
				  PC_SOURCE <= "11";
				  PC_WRITE <= '1';
				END IF;
				
			WHEN SM =>
			  MULTIPLY <= '0';
				RESET_MULT <= '0';
			WHEN SM_WB =>
			  MULT_WRITE <= '1';
			WHEN OTHERS =>
		END CASE;
	END PROCESS;

END BEHAV;
