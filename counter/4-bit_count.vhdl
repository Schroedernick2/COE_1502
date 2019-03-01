--Nicholas Schroeder
-- 4-bit Synchronous Greycode Counter

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY COUNTER IS
	PORT(
		UP_DOWN	: IN STD_LOGIC;
		ENABLE	: IN STD_LOGIC;
		RESET	: IN STD_LOGIC;
		CLOCK 	: IN STD_LOGIC;
		Q		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COUNTER;

ARCHITECTURE BEHAV OF COUNTER IS

	TYPE STATE_TYPE IS ( S0,S1,S2,S3,S4,S5,S6,S7,
					 S8,S9,S10,S11,S12,S13,S14,S15 );

	SIGNAL STATE : STATE_TYPE;

BEGIN

	PROCESS (CLOCK, RESET, UP_DOWN)
	BEGIN
		IF RESET = '1' THEN
			STATE <= S0;
		ELSIF ((RISING_EDGE(CLOCK) AND ENABLE = '1')) THEN
			CASE STATE IS
				WHEN S0=>
					IF UP_DOWN = '0' THEN
						STATE <= S1;
					ELSE
						STATE <= S15;
					END IF;
				WHEN S1=>
					IF UP_DOWN = '0' THEN
						STATE <= S2;
					ELSE
						STATE <= S0;
					END IF;
				WHEN S2=>
					IF UP_DOWN = '0' THEN
						STATE <= S3;
					ELSE
						STATE <= S1;
					END IF;
				WHEN S3=>
					IF UP_DOWN = '0' THEN
						STATE <= S4;
					ELSE
						STATE <= S2;
					END IF;
				WHEN S4=>
					IF UP_DOWN = '0' THEN
						STATE <= S5;
					ELSE
						STATE <= S3;
					END IF;
				WHEN S5=>
					IF UP_DOWN = '0' THEN
						STATE <= S6;
					ELSE
						STATE <= S4;
					END IF;					 
				WHEN S6=>
					IF UP_DOWN = '0' THEN
						STATE <= S7;
					ELSE
						STATE <= S5;
					END IF;
				WHEN S7=>
					IF UP_DOWN = '0' THEN
						STATE <= S8;
					ELSE
						STATE <= S6;
					END IF;
				WHEN S8=>
					IF UP_DOWN = '0' THEN
						STATE <= S9;
					ELSE
						STATE <= S7;
					END IF;	
				WHEN S9=>
					IF UP_DOWN = '0' THEN
						STATE <= S10;
					ELSE
						STATE <= S8;
					END IF;
				WHEN S10=>
					IF UP_DOWN = '0' THEN
						STATE <= S11;
					ELSE
						STATE <= S9;
					END IF;
				WHEN S11=>
					IF UP_DOWN = '0' THEN
						STATE <= S12;
					ELSE
						STATE <= S10;
					END IF;	
				WHEN S12=>
					IF UP_DOWN = '0' THEN
						STATE <= S13;
					ELSE
						STATE <= S11;
					END IF;
				WHEN S13=>
					IF UP_DOWN = '0' THEN
						STATE <= S14;
					ELSE
						STATE <= S12;
					END IF;
				WHEN S14=>
					IF UP_DOWN = '0' THEN
						STATE <= S15;
					ELSE
						STATE <= S13;
					END IF;	
				WHEN S15=>
					IF UP_DOWN = '0' THEN
						STATE <= S0;
					ELSE
						STATE <= S14;
					END IF;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS (STATE)
	BEGIN
		CASE STATE IS
			WHEN S0 =>
				Q <= "0000";
			WHEN S1 =>
				Q <= "0001";
			WHEN S2 =>
				Q <= "0011";
			WHEN S3 =>
				Q <= "0010";
			WHEN S4 =>
				Q <= "0110";
			WHEN S5 =>
				Q <= "0111";
			WHEN S6 =>
				Q <= "0101";
			WHEN S7 =>
				Q <= "0100";
			WHEN S8 =>
				Q <= "1100";
			WHEN S9 =>
				Q <= "1101";
			WHEN S10 =>
				Q <= "1111";
			WHEN S11 =>
				Q <= "1110";
			WHEN S12 =>
				Q <= "1010";
			WHEN S13 =>
				Q <= "1011";
			WHEN S14 =>
				Q <= "1001";
			WHEN S15 =>
				Q <= "1000";
		END CASE;
	END PROCESS;
END BEHAV;

