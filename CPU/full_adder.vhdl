--Nicholas Schroeder
-- Full Adder 

--Analyze with GHDL
	--$ghdl -a --ieee=synopsys adder_32.vhdl
	--$ghdl -e --ieee=synopsys adder_32.vhdl

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY FULL_ADDER IS
	PORT(
		A		: IN STD_LOGIC;
		B		: IN STD_LOGIC;
		CIN 	: IN STD_LOGIC;
		COUT 	: OUT STD_LOGIC;
		S		: OUT STD_LOGIC
	);
END FULL_ADDER;

ARCHITECTURE BEHAV OF FULL_ADDER IS
BEGIN
	S 	<= CIN XOR (A XOR B);
	COUT <= (A AND B) OR (CIN AND (A XOR B)); 
END BEHAV;
