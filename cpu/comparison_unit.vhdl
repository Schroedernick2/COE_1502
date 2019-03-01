--Nicholas Schroeder
-- Comparison Unit for 32-bit ALU

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY COMPARISON_UNIT IS
	PORT(
		ALUOP		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		COUT			: IN STD_LOGIC;
		A_SIGN		: IN STD_LOGIC;
		B_SIGN		: IN STD_LOGIC;
		R_SIGN		: IN STD_LOGIC;
		COMPARISON_R	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPARISON_UNIT;

ARCHITECTURE BEHAV OF COMPARISON_UNIT IS
BEGIN

	COMPARE_PROC0: PROCESS(ALUOP,COUT,A_SIGN,B_SIGN,R_SIGN)

   	BEGIN

     	IF (ALUOP(1 DOWNTO 0) = "00") THEN
         		COMPARISON_R <= "00000000000000000000000000000000";
      	ELSIF (ALUOP(1 DOWNTO 0) = "01") THEN
         		COMPARISON_R <= "00000000000000000000000000000000";
      	ELSIF (ALUOP(1 DOWNTO 0) = "10") AND (A_SIGN = '0') AND (B_SIGN = '0') AND (R_SIGN = '0') THEN
         		COMPARISON_R <= "00000000000000000000000000000000";
      	ELSIF (ALUOP(1 DOWNTO 0) = "10") AND (A_SIGN = '0') AND (B_SIGN = '0') AND (R_SIGN = '1') THEN
         		COMPARISON_R <= "00000000000000000000000000000001";
      	ELSIF (ALUOP(1 DOWNTO 0) = "10") AND (A_SIGN = '1') AND (B_SIGN = '1') AND (R_SIGN = '0') THEN
         		COMPARISON_R <= "00000000000000000000000000000000";
      	ELSIF (ALUOP(1 DOWNTO 0) = "10") AND (A_SIGN = '1') AND (B_SIGN = '1') AND (R_SIGN = '1') THEN
         		COMPARISON_R <= "00000000000000000000000000000001";
      	ELSIF (ALUOP(1 DOWNTO 0) = "10") AND (A_SIGN = '1') AND (B_SIGN = '0') THEN
         		COMPARISON_R <= "00000000000000000000000000000001";
      	ELSIF (ALUOP(1 DOWNTO 0) = "10") AND (A_SIGN = '0') AND (B_SIGN = '1') THEN
         		COMPARISON_R <= "00000000000000000000000000000000";
      	ELSIF (ALUOP(1 DOWNTO 0) = "11") AND (COUT = '1') THEN
         		COMPARISON_R <= "00000000000000000000000000000000";
      	ELSIF (ALUOP(1 DOWNTO 0) = "11") AND (COUT = '0') THEN
         		COMPARISON_R <= "00000000000000000000000000000001";
      	END IF;

   	END PROCESS COMPARE_PROC0;
END BEHAV;