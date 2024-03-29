--Nicholas Schroeder
-- Multiplicand Register

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY MC_REG IS
	PORT(
		MC		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		START	: IN STD_LOGIC;
		STOP	: IN STD_LOGIC;
		RESET	: IN STD_LOGIC;
		CLOCK	: IN STD_LOGIC;
		SHIFT	: IN STD_LOGIC;
		CONTENT	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END MC_REG;

ARCHITECTURE BEHAV OF MC_REG IS
	COMPONENT REG_64B
		PORT(
			D		: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
			CLOCK	: IN STD_LOGIC;
			ENABLE	: IN STD_LOGIC;
			RESET	: IN STD_LOGIC;
			Q		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL EXTENDED_MC 		: STD_LOGIC_VECTOR(63 DOWNTO 0);
	SIGNAL ENABLE			: STD_LOGIC;
	SIGNAL DATA				: STD_LOGIC_VECTOR(63 DOWNTO 0);
	SIGNAL SHIFTED_CONTENT 	: STD_LOGIC_VECTOR(63 DOWNTO 0);
	SIGNAL Q				: STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN

REG_64B_0: REG_64B PORT MAP(D=>DATA,CLOCK=>CLOCK,ENABLE=>ENABLE,RESET=>RESET,Q=>Q);	

	PROCESS (CLOCK,RESET,START,STOP,SHIFT)
	BEGIN
		
		EXTENDED_MC(63 DOWNTO 32) 	<= X"00000000";
		EXTENDED_MC(31 DOWNTO 0) 	<= MC(31 DOWNTO 0);
		ENABLE <= (SHIFT OR START) AND (NOT STOP);

		SHIFTED_CONTENT <= Q(62 DOWNTO 0)&'0';

		IF(ENABLE='1') THEN
			IF(SHIFT='0') THEN
				DATA <= EXTENDED_MC;
			ELSE
				DATA <= SHIFTED_CONTENT;
			END IF;
		END IF;

		CONTENT <= Q;

END PROCESS;
END BEHAV;
