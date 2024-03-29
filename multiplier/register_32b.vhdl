--Nicholas Schroeder
-- 32-bit Register

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY REG_32B IS
	PORT(
		D		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		CLOCK	: IN STD_LOGIC;
		ENABLE	: IN STD_LOGIC;
		RESET	: IN STD_LOGIC;
		Q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END REG_32B;

ARCHITECTURE BEHAV OF REG_32B IS
	COMPONENT REG_4B
		PORT(
			D		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			CLOCK	: IN STD_LOGIC;
			ENABLE	: IN STD_LOGIC;
			RESET	: IN STD_LOGIC;
			Q		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

BEGIN

	REG_4B_0:	REG_4B PORT MAP(D(3 DOWNTO 0),CLOCK,ENABLE,RESET,Q(3 DOWNTO 0));
	REG_4B_1: REG_4B PORT MAP(D(7 DOWNTO 4),CLOCK,ENABLE,RESET,Q(7 DOWNTO 4));
	REG_4B_2:	REG_4B PORT MAP(D(11 DOWNTO 8),CLOCK,ENABLE,RESET,Q(11 DOWNTO 8));
	REG_4B_3: REG_4B PORT MAP(D(15 DOWNTO 12),CLOCK,ENABLE,RESET,Q(15 DOWNTO 12));
	REG_4B_4:	REG_4B PORT MAP(D(19 DOWNTO 16),CLOCK,ENABLE,RESET,Q(19 DOWNTO 16));
	REG_4B_5: REG_4B PORT MAP(D(23 DOWNTO 20),CLOCK,ENABLE,RESET,Q(23 DOWNTO 20));
	REG_4B_6:	REG_4B PORT MAP(D(27 DOWNTO 24),CLOCK,ENABLE,RESET,Q(27 DOWNTO 24));
	REG_4B_7: REG_4B PORT MAP(D(31 DOWNTO 28),CLOCK,ENABLE,RESET,Q(31 DOWNTO 28));

END BEHAV;
