--Nicholas Schroeder
-- Control unit

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MULT_CONTROL IS
	PORT(
		MP			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		CLOCK		: IN STD_LOGIC;
		START		: IN STD_LOGIC;
		RESET		: IN STD_LOGIC;
		PROD_WRITE	: OUT STD_LOGIC;
		SHIFT_MC		: OUT STD_LOGIC;
		LOAD			: OUT STD_LOGIC;
		SHIFT_MP		: OUT STD_LOGIC;
		STOP			: OUT STD_LOGIC
	);
END MULT_CONTROL;

ARCHITECTURE BEHAV OF MULT_CONTROL IS
	TYPE STATE_TYPE IS (S0,S1,S2,S3,S4);
	SIGNAL STATE : STATE_TYPE;
BEGIN
	PROCESS(CLOCK,RESET)
	VARIABLE COUNT : INTEGER;
	BEGIN

		IF(RESET='1') THEN
			STATE <= S0;

		ELSIF(RISING_EDGE(CLOCK)) THEN
			CASE STATE IS
				WHEN S0 =>
					IF(START='1') THEN
						COUNT := 0;
						STATE <= S1;
					ELSE
						STATE <= S0;
					END IF;
				WHEN S1 =>
					STATE <= S2;
				WHEN S2 =>
					IF(MP(0)='0') THEN
						STATE <= S4;
					ELSE
						STATE <= S3;
					END IF;
				WHEN S3 =>
					STATE <= S4;
				WHEN S4 =>
					IF (COUNT = 31) THEN
						STATE <= S0;
					ELSE
						COUNT := COUNT+1;
						STATE <= S2;
					END IF;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS(STATE)
	BEGIN
		CASE STATE IS
			WHEN S0 =>
				STOP <= '1';
				LOAD	<= '0';
				PROD_WRITE <= '0';
				SHIFT_MC <= '0';
				SHIFT_MP <= '0';
			WHEN S1 =>
				STOP <= '0';
				PROD_WRITE <= '0';
				LOAD	<= '1';
				SHIFT_MC <= '0';
				SHIFT_MP <= '0';				
			WHEN S2 =>
				STOP <= '0';
				LOAD	<= '0';
				PROD_WRITE <= '0';
				SHIFT_MC <= '0';
				SHIFT_MP <= '0';
			WHEN S3 =>
				LOAD	<= '0';
				STOP <= '0';
				PROD_WRITE <= '1';
				SHIFT_MC <= '0';
				SHIFT_MP <= '0';	
			WHEN S4 =>
				LOAD	<= '0';
				STOP <= '0';
				PROD_WRITE <= '0';
				SHIFT_MC <= '1';
				SHIFT_MP <= '1';
		END CASE;
	END PROCESS;

END BEHAV;
