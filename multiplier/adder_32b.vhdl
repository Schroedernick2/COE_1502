--Nicholas Schroeder
-- 32-bit Ripple Carry Adder

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ADDER_32 IS
	PORT(
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		CIN		: IN STD_LOGIC;
		COUT 	: OUT STD_LOGIC;
		S		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ADDER_32;

ARCHITECTURE BEHAV OF ADDER_32 IS
	COMPONENT ADDER_4
		PORT(
			A	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			B	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			CIN	: IN STD_LOGIC;
			COUT	: OUT STD_LOGIC;
			S	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL C			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL COUT_TEMP	: STD_LOGIC;
	SIGNAL S_TEMP		: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	ADDER_4_0: ADDER_4 PORT MAP(A(3 DOWNTO 0),B(3 DOWNTO 0),CIN,C(0),S_TEMP(3 DOWNTO 0));
	ADDER_4_1: ADDER_4 PORT MAP(A(7 DOWNTO 4),B(7 DOWNTO 4),C(0),C(1),S_TEMP(7 DOWNTO 4));
	ADDER_4_2: ADDER_4 PORT MAP(A(11 DOWNTO 8),B(11 DOWNTO 8),C(1),C(2),S_TEMP(11 DOWNTO 8));
	ADDER_4_3: ADDER_4 PORT MAP(A(15 DOWNTO 12),B(15 DOWNTO 12),C(2),C(3),S_TEMP(15 DOWNTO 12));
	ADDER_4_4: ADDER_4 PORT MAP(A(19 DOWNTO 16),B(19 DOWNTO 16),C(3),C(4),S_TEMP(19 DOWNTO 16));
	ADDER_4_5: ADDER_4 PORT MAP(A(23 DOWNTO 20),B(23 DOWNTO 20),C(4),C(5),S_TEMP(23 DOWNTO 20));
	ADDER_4_6: ADDER_4 PORT MAP(A(27 DOWNTO 24),B(27 DOWNTO 24),C(5),C(6),S_TEMP(27 DOWNTO 24));
	ADDER_4_7: ADDER_4 PORT MAP(A(31 DOWNTO 28),B(31 DOWNTO 28),C(6),COUT_TEMP,S_TEMP(31 DOWNTO 28));

	S 		<= S_TEMP;
	COUT		<= COUT_TEMP;	

END BEHAV;
