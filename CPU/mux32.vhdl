--Nicholas Schroeder
-- 2-bit Select 32-bit data Multiplexer

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MUX_32 IS
	PORT(
		ALUOP			: IN STD_LOGIC_VECTOR(3 DOWNTO 2);
		LOGICAL_R		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ARITHMETIC_R	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		COMPARISON_R	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SHIFTER_R		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		R				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MUX_32;

ARCHITECTURE BEHAV OF MUX_32 IS
BEGIN
	R 	<=	LOGICAL_R		WHEN ALUOP = "00" ELSE
			ARITHMETIC_R 	WHEN ALUOP = "01" ELSE
			COMPARISON_R	WHEN ALUOP = "10" ELSE
			SHIFTER_R;
END BEHAV;
