--Nicholas Schroeder
-- 32-bit ALU

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ALU IS
	PORT(
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SHAMT	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ALUOP	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		OVERFLOW	: OUT STD_LOGIC;
		ZERO		: OUT STD_LOGIC;
		R		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ALU;

ARCHITECTURE BEHAV OF ALU IS

	SIGNAL ARITHMETIC_R : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL LOGICAL_R	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL COMPARISON_R : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SHIFTER_R	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL A_SIGN		: STD_LOGIC;
	SIGNAL B_SIGN		: STD_LOGIC;
	SIGNAL R_SIGN		: STD_LOGIC;
	SIGNAL COUT		: STD_LOGIC;

	COMPONENT ARITHMETIC_UNIT
	PORT(
		ALUOP		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		A			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		COUT			: OUT STD_LOGIC;
		OVERFLOW		: OUT STD_LOGIC;
		ZERO			: OUT STD_LOGIC;
		ARITHMETIC_R	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT COMPARISON_UNIT
	PORT(
		ALUOP		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		COUT			: IN STD_LOGIC;
		A_SIGN		: IN STD_LOGIC;
		B_SIGN		: IN STD_LOGIC;
		R_SIGN		: IN STD_LOGIC;
		COMPARISON_R	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT LOGICAL_UNIT
	PORT(
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALUOP	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		LOGICAL_R : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT SHIFTER
	PORT(
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SHAMT	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ALUOP	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		SHIFTER_R	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT MUX_32
	PORT(
		ALUOP		: IN STD_LOGIC_VECTOR(3 DOWNTO 2);
		LOGICAL_R		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ARITHMETIC_R	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		COMPARISON_R	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SHIFTER_R		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		R			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

BEGIN

	A_SIGN <= A(31);
	B_SIGN <= B(31);
	R_SIGN <= ARITHMETIC_R(31);

	U_1: ARITHMETIC_UNIT
		PORT MAP(
			ALUOP		=> ALUOP(1 DOWNTO 0),
			A			=> A,
			B			=> B,
			COUT			=> COUT,
			OVERFLOW		=> OVERFLOW,
			ZERO			=> ZERO,
			ARITHMETIC_R	=> ARITHMETIC_R
		);

	U_2: COMPARISON_UNIT
		PORT MAP(
			ALUOP		=> ALUOP(1 DOWNTO 0),
			COUT			=> COUT,
			A_SIGN		=> A_SIGN,
			B_SIGN		=> B_SIGN,
			R_SIGN		=> R_SIGN,
			COMPARISON_R	=> COMPARISON_R
		);

	U_0: LOGICAL_UNIT
		PORT MAP(
			A		=> A,
			B		=> B,
			ALUOP	=> ALUOP(1 DOWNTO 0),
			LOGICAL_R => LOGICAL_R
		);

	U_3: SHIFTER
		PORT MAP(
			A		=> A,
			SHAMT	=> SHAMT,
			ALUOP	=> ALUOP(1 DOWNTO 0),
			SHIFTER_R => SHIFTER_R
		);

	U_4: MUX_32
		PORT MAP(
			ALUOP		=> ALUOP(3 DOWNTO 2),
			LOGICAL_R		=> LOGICAL_R,
			ARITHMETIC_R	=> ARITHMETIC_R,
			COMPARISON_R	=> COMPARISON_R,
			SHIFTER_R		=> SHIFTER_R,
			R			=> R
		);

END BEHAV;	
