--Nicholas Schroeder
-- Register File for 32-bit MIPS CPU

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY REGISTER_FILE IS
	PORT(
		CLOCK				: IN STD_LOGIC;
		REG_READ_1_ADDR		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		REG_READ_2_ADDR		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		REG_WRITE_ADDR		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		REG_WRITE			: IN STD_LOGIC;
		REG_WRITE_DATA		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		REG_READ_1_DATA		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		REG_READ_2_DATA		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END REGISTER_FILE;		

ARCHITECTURE BEHAV OF REGISTER_FILE IS

	TYPE REG_ARRAY IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

	SIGNAL REGISTERS: REG_ARRAY := (
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000",
		X"00000000",X"00000000",X"00000000",X"00000000" 
	);

	BEGIN

		REG_READ_1_DATA <= REGISTERS(CONV_INTEGER(UNSIGNED(REG_READ_1_ADDR)));
		REG_READ_2_DATA <= REGISTERS(CONV_INTEGER(UNSIGNED(REG_READ_2_ADDR)));

		REGISTER_PROC: PROCESS(CLOCK)
		
		BEGIN

			IF RISING_EDGE(CLOCK) AND REG_WRITE = '1' THEN
				REGISTERS(CONV_INTEGER(UNSIGNED(REG_WRITE_ADDR))) <= REG_WRITE_DATA;
			END IF;
		END PROCESS;
END BEHAV;
