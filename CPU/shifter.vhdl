--Nicholas Schroeder
-- Shifter for 32-bit ALU

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY SHIFTER IS
	PORT(
		A			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SHAMT		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ALUOP		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		SHIFTER_R	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END SHIFTER;

ARCHITECTURE BEHAV OF SHIFTER IS
BEGIN

	PROCESS_PROC0: PROCESS(A,SHAMT,ALUOP)

	VARIABLE LEFT_ONE		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE LEFT_TWO		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE LEFT_FOUR		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE LEFT_EIGHT 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE RIGHT_ONE		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE RIGHT_TWO		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE RIGHT_FOUR 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE RIGHT_EIGHT	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE FILL			: STD_LOGIC_VECTOR(15 DOWNTO 0);

	BEGIN
      	IF ALUOP(1) = '0' THEN
     		IF SHAMT(0) = '1' THEN
        		LEFT_ONE(31 DOWNTO 0) := A(30 DOWNTO 0) & '0';
     		ELSE
        		LEFT_ONE(31 DOWNTO 0) := A(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(1) = '1' THEN
        		LEFT_TWO(31 DOWNTO 0) := LEFT_ONE(29 DOWNTO 0) & "00";
     		ELSE
        		LEFT_TWO(31 DOWNTO 0) := LEFT_ONE(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(2) = '1' THEN
        		LEFT_FOUR(31 DOWNTO 0) := LEFT_TWO(27 DOWNTO 0) & "0000";
     		ELSE
        		LEFT_FOUR(31 DOWNTO 0) := LEFT_TWO(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(3) = '1' THEN
        		LEFT_EIGHT(31 DOWNTO 0) := LEFT_FOUR(23 DOWNTO 0) & "00000000";
     		ELSE
        		LEFT_EIGHT(31 DOWNTO 0) := LEFT_FOUR(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(4) = '1' THEN
        		SHIFTER_R(31 DOWNTO 0) <= LEFT_EIGHT(15 DOWNTO 0) & "0000000000000000";
    		ELSE
        		SHIFTER_R(31 DOWNTO 0) <= LEFT_EIGHT(31 DOWNTO 0);
     		END IF;
      	ELSE
     		FILL_LOOP: FOR i IN 0 TO 15 LOOP
        		FILL(i) := ALUOP(0) AND A(31);
     		END LOOP FILL_LOOP;

     		IF SHAMT(0) = '1' THEN
        		RIGHT_ONE(31 DOWNTO 0) := FILL(0) & A(31 DOWNTO 1);
     		ELSE
        		RIGHT_ONE(31 DOWNTO 0) := A(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(1) = '1' THEN
        		RIGHT_TWO(31 DOWNTO 0) := FILL(1 DOWNTO 0) & RIGHT_ONE(31 DOWNTO 2);
     		ELSE
        		RIGHT_TWO(31 DOWNTO 0) := RIGHT_ONE(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(2) = '1' THEN
        		RIGHT_FOUR(31 DOWNTO 0) := FILL(3 DOWNTO 0) & RIGHT_TWO(31 DOWNTO 4);
     		ELSE
        		RIGHT_FOUR(31 DOWNTO 0) := RIGHT_TWO(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(3) = '1' THEN
        		RIGHT_EIGHT(31 DOWNTO 0) := FILL(7 DOWNTO 0) & RIGHT_FOUR(31 DOWNTO 8);
     		ELSE
        		RIGHT_EIGHT(31 DOWNTO 0) := RIGHT_FOUR(31 DOWNTO 0);
     		END IF;

     		IF SHAMT(4) = '1' THEN
        		SHIFTER_R(31 DOWNTO 0) <= FILL(15 DOWNTO 0) & RIGHT_EIGHT(31 DOWNTO 16);
     		ELSE
        		SHIFTER_R(31 DOWNTO 0) <= RIGHT_EIGHT(31 DOWNTO 0);
     		END IF;
      	END IF;
	END PROCESS PROCESS_PROC0;
END BEHAV;
