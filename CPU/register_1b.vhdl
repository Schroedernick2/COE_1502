--Nicholas Schroeder
-- 1-bit Register

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY REG_1B IS
	PORT(
		D		: IN STD_LOGIC;
		CLOCK	: IN STD_LOGIC;
		ENABLE	: IN STD_LOGIC;
		RESET	: IN STD_LOGIC;
		Q		: OUT STD_LOGIC
	);
END REG_1B;

ARCHITECTURE BEHAV OF REG_1B IS
BEGIN
	PROCESS(CLOCK,D,ENABLE,RESET)
	BEGIN
		IF(RESET = '1') THEN
			Q <= '0';
		ELSIF(RISING_EDGE(CLOCK) AND ENABLE = '1') THEN
			Q <= D;
		END IF;
	END PROCESS;
END BEHAV;
