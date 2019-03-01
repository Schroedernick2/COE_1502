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
		CLOCK			: IN STD_LOGIC;
		RESET			: IN STD_LOGIC
	);
END CONTROL;

ARCHITECTURE BEHAV OF CONTROL IS

	TYPE STATE_TYPE IS (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9);
	SIGNAL STATE : STATE_TYPE;

	SIGNAL R_TYPE : BOOLEAN := FALSE;
	SIGNAL I_TYPE : BOOLEAN := FALSE;

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
					STATE <= S1;
				WHEN S1 =>
					---LW OR SW---
					IF((UNSIGNED(OP_CODE) > 31) AND (UNSIGNED(OP_CODE) < 44)) THEN
						STATE <= S2;
					---R_TYPE---
					ELSIF((UNSIGNED(OP_CODE) = 0) OR ((UNSIGNED(OP_CODE) > 23) AND (UNSIGNED(OP_CODE) < 32))) THEN
						R_TYPE <= TRUE;
						STATE <= S6;
					---BRANCH---
					ELSIF((UNSIGNED(OP_CODE) = 1) OR ((UNSIGNED(OP_CODE) > 3) AND (UNSIGNED(OP_CODE) < 8))) THEN
						STATE <= S8;
					---JUMP---
					ELSIF((UNSIGNED(OP_CODE) = 2) OR (UNSIGNED(OP_CODE) = 3)) THEN
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
					STATE <= S7;
				WHEN S7 =>
					STATE <= S0;
				WHEN S8 =>
					STATE <= S0;
				WHEN S9 =>
					STATE <= S0;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS(STATE)
	BEGIN
		CASE STATE IS

			WHEN S0 =>
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '1';
				ALU_OP			<= "0001";
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "01";
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				IR_WRITE		<= '1';

			WHEN S1 =>
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';

			WHEN S2 =>
				ALU_OP 			<= "0000";
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "00";
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';

			WHEN S3 =>
				ALU_OP 			<= "0000";
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "00";
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';

			WHEN S4 =>
				ALU_OP 			<= "0000";
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "00";
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';

			WHEN S5 =>
				ALU_OP 			<= "0000";
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "00";
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';
			
			WHEN S6 =>

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
						ALU_OP <= "1000";	--LUI
					ELSE
						ALU_OP <= "1111";	--SHOULD NEVER HAPPEN
					END IF;
					
				ELSE
					ALU_OP 			<= "0000"; 	--R_TYPE SEE FUNCT IN ALU_CTRL
					ALU_SRC_B		<= "00";
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
				ALU_OP 			<= "0000";
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "00";
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';

			WHEN S9 =>
				ALU_OP 			<= "0000";
				REG_DST			<= '0';
				REG_WRITE		<= '0';
				ALU_SRC_A		<= '0';
				ALU_SRC_B		<= "00";
				PC_SOURCE		<= "00";
				PC_WRITE_COND	<= '0';
				PC_WRITE		<= '0';
				I_OR_D			<= '0';
				MEM_READ		<= '1';
				MEM_WRITE		<= '0';
				MEM_TO_REG		<= '0';
				IR_WRITE		<= '0';

		END CASE;
	END PROCESS;

END BEHAV;
