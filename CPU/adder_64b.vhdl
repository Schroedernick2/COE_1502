--Nicholas Schroeder 
-- 64-bit Adder

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ADDER_64 IS
	PORT(
		A		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		CIN		: IN STD_LOGIC;
		COUT	: OUT STD_LOGIC;
		S		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END ADDER_64;

ARCHITECTURE BEHAV OF ADDER_64 IS
	COMPONENT ADDER_32
		PORT(
			A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			CIN		: IN STD_LOGIC;
			COUT	: OUT STD_LOGIC;
			S		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL C : STD_LOGIC;

	BEGIN

		ADDER_32_0: ADDER_32 PORT MAP(A(31 DOWNTO 0),B(31 DOWNTO 0),CIN,C,S(31 DOWNTO 0));
		ADDER_32_1: ADDER_32 PORT MAP(A(63 DOWNTO 32),B(63 DOWNTO 32),C,COUT,S(63 DOWNTO 32));

END BEHAV;
