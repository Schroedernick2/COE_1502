--Nicholas Schroeder
-- 32-bit Register to store data read from register file

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY READ_REG IS
	PORT(
		DATA_IN		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		CLOCK		: IN STD_LOGIC
	);
END READ_REG;

ARCHITECTURE BEHAV OF READ_REG IS
BEGIN
	PROCESS(CLOCK,DATA_IN)
	BEGIN
		IF(RISING_EDGE(CLOCK)) THEN
			DATA_OUT <= DATA_IN;
		END IF;
	END PROCESS;
END BEHAV;
