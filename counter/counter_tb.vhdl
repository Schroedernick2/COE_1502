--Nicholas Schroeder
-- Testbench file for 4-bit counter

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY COUNTER_TB IS
END COUNTER_TB;

ARCHITECTURE TEST OF COUNTER_TB IS

	COMPONENT COUNTER
		PORT(
			UP_DOWN	: IN STD_LOGIC;
			ENABLE	: IN STD_LOGIC;
			RESET	: IN STD_LOGIC;
			CLOCK 	: IN STD_LOGIC;
			Q		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL UP_DOWN		: STD_LOGIC := '0';
	SIGNAL ENABLE		: STD_LOGIC := '0';
	SIGNAL RESET		: STD_LOGIC := '0';
	SIGNAL CLOCK		: STD_LOGIC := '0';
	SIGNAL Q			: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	COUNTER_0: COUNTER PORT MAP(
						UP_DOWN 	=> UP_DOWN,
						ENABLE 	=> ENABLE,
						RESET	=> RESET,
						CLOCK	=> CLOCK,
						Q		=> Q );

	CLOCK_GENERATION: PROCESS
	BEGIN
		CLOCK <= '0';
		WAIT FOR 5 NS;
		CLOCK <= '1';
		WAIT FOR 5 NS;
	END PROCESS CLOCK_GENERATION;

	SIMULATE: PROCESS
	BEGIN
		--TEST NORMAL FORWARD COUNT--
		WAIT FOR 20 NS;
		ENABLE <= '1';
		WAIT FOR 1000 NS;

		--TEST PAUSE WHEN ENABLE = 0--
		ENABLE <= '0';
		WAIT FOR 20 NS;

		--TEST REST--
		ENABLE <= '1';
		WAIT FOR 10 NS;
		RESET <= '1';
		ENABLE <= '0';
		WAIT FOR 30 NS;

		--TEST PAUSE AGAIN--
		ENABLE <= '1';
		RESET <= '0';
		WAIT FOR 20 NS;
		ENABLE <= '0';
		WAIT FOR 50 NS;

		--TEST REVERSE COUNT--
		ENABLE <= '1';
		RESET <= '0';
		UP_DOWN <= '1';
		WAIT FOR 1000 NS;
		
		ENABLE <= '0';
		WAIT FOR 20 NS;

		REPORT "TESTING COMPLETE";
		REPORT "ALL PASSED";

		WAIT;
	END PROCESS SIMULATE;
END TEST;













































