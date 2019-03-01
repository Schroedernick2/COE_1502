--Nicholas Schroeder
-- Testbench for 32-bit Ripple Carry Adder

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ADDER_TB IS
END ADDER_TB;

ARCHITECTURE BEHAV OF ADDER_TB IS

COMPONENT ADDER_32
PORT(
	 A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	 B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	 CIN		: IN STD_LOGIC;
	 COUT	: OUT STD_LOGIC;
	 S		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	 OFL		: OUT STD_LOGIC
);
END COMPONENT;

SIGNAL A		: STD_LOGIC_VECTOR(31 DOWNTO 0) 	:= X"00000000";
SIGNAL B		: STD_LOGIC_VECTOR(31 DOWNTO 0) 	:= X"00000000";
SIGNAL CIN	: STD_LOGIC				  	:= '0';
SIGNAL COUT	: STD_LOGIC;
SIGNAL S		: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL OFL	: STD_LOGIC;

BEGIN

	ADDER_32_0: ADDER_32 PORT MAP(A=>A,B=>B,CIN=>CIN,COUT=>COUT,S=>S,OFL=>OFL);

	TEST_PROC0: PROCESS
	BEGIN

	A 	<= X"00000101";
	B	<= X"00000000";
	CIN	<= '0';

	WAIT FOR 10 NS;
	ASSERT(S=X"00000101" AND OFL = '0' AND COUT = '0') REPORT "ADDITION FAILED" SEVERITY FAILURE;

	A 	<= X"00000003";
	B	<= X"00000002";
	CIN	<= '1';

	WAIT FOR 10 NS;
	ASSERT(S=X"00000006" AND OFL = '0' AND COUT = '0') REPORT "ADDITION WITH CIN FAILED" SEVERITY FAILURE;

	A	<= "01111111111111111111111111111111";
	B	<= "00000000000000000000000000000001";
	CIN	<= '0';

	WAIT FOR 10 NS;
	ASSERT(S="10000000000000000000000000000000" AND OFL = '1' AND COUT = '0') REPORT "ADDITION WITH OVERFLOW FAILED" SEVERITY FAILURE;

	A	<= "11111111111111111111111111111111";
	B	<= "00000000000000000000000000000001";
	CIN	<= '1';

	WAIT FOR 10 NS;
	ASSERT(S=X"00000001" AND COUT = '1' AND OFL = '0') REPORT "COUT FAILURE" SEVERITY FAILURE;

	REPORT "TESTING COMPLETE.";
	REPORT "ALL TESTS PASSED";

	WAIT;
	END PROCESS;
END BEHAV;