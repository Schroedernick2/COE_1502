--Nicholas Schroeder
-- 1.10.2019
-- HELLO_WORLD PROGAM VHDL

--Compiled with ghdl
		--$ghdl -a hello.vhdl
		--$ghdl -e HELLO_WORLD
		--$./hello_world

USE STD.TEXTIO.ALL;

ENTITY HELLO_WORLD IS
END HELLO_WORLD;

ARCHITECTURE BEHAV OF HELLO_WORLD IS
BEGIN
	PROCESS
		VARIABLE L	: LINE;
	BEGIN
		WRITE(L, STRING'("HELLO WORLD!"));
		WRITELINE(OUTPUT,L);

		WAIT;
	END PROCESS;
END BEHAV;
