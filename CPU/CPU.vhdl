--Nicholas Schroeder
-- MIPS 32-bit CPU

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY CPU IS
	PORT(
		RESET			: IN STD_LOGIC;
		CLOCK			: IN STD_LOGIC;
		DATA_MEM_ADDR	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA_MEM_READ	: OUT STD_LOGIC;
		DATA_MEM_WRITE	: OUT STD_LOGIC;
		DATA_MEM_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA_MEM_WAIT	: IN STD_LOGIC;
		DATA_MEM_IN 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAV OF CPU IS
	COMPONENT PC
		PORT(
			CLOCK	: IN STD_LOGIC;
			RESET	: IN STD_LOGIC;
			PC_IN	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ENABLE	: IN STD_LOGIC;
			PC_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT REGISTER_FILE
		PORT(
			CLOCK				: IN STD_LOGIC;
			REG_READ_1_ADDR		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			REG_READ_2_ADDR		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			REG_WRITE_ADDR		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			REG_WRITE			: IN STD_LOGIC;
			REG_WRITE_DATA		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			REG_READ_1_DATA		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			REG_READ_2_DATA		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT INSTRUCTION_REG
		PORT(
			MEM_DATA		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			IR_WRITE		: IN STD_LOGIC;
			CLOCK			: IN STD_LOGIC;
			IR_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT MEMORY_REG
		PORT(
			MEM_DATA		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			READ   : IN STD_LOGIC;
			CLOCK			: IN STD_LOGIC;
			MR_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ALU
		PORT(
			A			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SHAMT		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			ALUOP		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			OVERFLOW	: OUT STD_LOGIC;
			ZERO		: OUT STD_LOGIC;
			R			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT CONTROL
		PORT(
			OP_CODE			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			ALU_OP			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			REG_DST			: OUT STD_LOGIC;
			REG_WRITE		: OUT STD_LOGIC;
			ALU_SRC_A		: OUT STD_LOGIC;
			ALU_SRC_B		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			PC_SOURCE		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			PC_WRITE_COND	: OUT STD_LOGIC;
			PC_WRITE		: OUT STD_LOGIC;
			I_OR_D			: OUT STD_LOGIC;
			MEM_READ		: OUT STD_LOGIC;
			MEM_WRITE		: OUT STD_LOGIC;
			MEM_TO_REG		: OUT STD_LOGIC;
			IR_WRITE		: OUT STD_LOGIC;
			NOT_ZERO      : OUT STD_LOGIC;
			LUI  : OUT STD_LOGIC;
			LH : OUT STD_LOGIC;
			STORE_PC : OUT STD_LOGIC;
			NEGATIVE : OUT STD_LOGIC;
			MULTIPLY : OUT STD_LOGIC;
			RESET_MULT : OUT STD_LOGIC;
			ZERO_EXTEND : OUT STD_LOGIC;
			MULT_DONE : IN STD_LOGIC;
			MULT_WRITE : OUT STD_LOGIC;
			WRITE_HI : OUT STD_LOGIC;
			WRITE_LO : OUT STD_LOGIC;
			FUNCT   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			CLOCK			: IN STD_LOGIC;
			RESET			: IN STD_LOGIC
		);
	END COMPONENT;

	COMPONENT ALU_CONTROL
		PORT(
			ALU_OP_IN	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			FUNCT		: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			ALU_OP		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			SHIFT_SRC : OUT STD_LOGIC;
			SHIFTING : OUT STD_LOGIC;
			CLO      : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT REG_32B
	  	PORT(
    		D		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    		CLOCK	: IN STD_LOGIC;
    		ENABLE	: IN STD_LOGIC;
    		RESET	: IN STD_LOGIC;
    		Q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	   );
	END COMPONENT;
	
	COMPONENT MULTIPLIER_32
	  	PORT(
      		MC			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      		MP			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      		RESET		: IN STD_LOGIC;
      		START 	: IN STD_LOGIC;
      		CLOCK		: IN STD_LOGIC;
      		PRODUCT	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      		DONE		: OUT STD_LOGIC
    	);
 	END COMPONENT;

	COMPONENT READ_REG
		PORT(
			DATA_IN		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			DATA_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			CLOCK		: IN STD_LOGIC
		);
	END COMPONENT;

	COMPONENT ALU_OUT_REG
		PORT(
			REG_IN		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			REG_OUT		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			CLOCK		: IN STD_LOGIC
		);
	END COMPONENT;

	SIGNAL PC_IN			: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL PC_OUT			: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL IR_WRITE 		: STD_LOGIC := '0';
	SIGNAL INSTRUCTION 		: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL REG_DST			: STD_LOGIC := '0';
	SIGNAL REG_WRITE_ADDR 	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	SIGNAL REG_WRITE		: STD_LOGIC := '0';
	SIGNAL REG_WRITE_DATA	: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL MEM_TO_REG		: STD_LOGIC := '0';
	SIGNAL MEM_REG_OUT		: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL ALU_OUT			: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL REG_READ1		: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL REG_READ2		: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL ALU_OP_IN		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	SIGNAL ALU_OP			: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	SIGNAL ZERO				: STD_LOGIC := '0';
	SIGNAL ALU_OFL			: STD_LOGIC := '0';
	SIGNAL SHAMT			: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	SIGNAL I_OR_D			: STD_LOGIC := '0';
	SIGNAL PC_WRITE			: STD_LOGIC := '0';
	SIGNAL PC_WRITE_COND	: STD_LOGIC := '0';
	SIGNAL PC_WRITE_ENABLE	: STD_LOGIC := '0';
	SIGNAL PC_SOURCE		: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL ALU_SRC_A		: STD_LOGIC := '0';
	SIGNAL ALU_SRC_B		: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL A				: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL B				: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL ALU_A			: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL ALU_B			: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL EXTENDED_IL		: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL EXTENDED_IL_SL	: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL ALU_REG_OUT		: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL NEXT_PC			: STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	SIGNAL WRITE_TO_MEM		: STD_LOGIC := '0';
	SIGNAL MEM_ADDR			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SHIFT_SRC : STD_LOGIC;
	SIGNAL SHIFTING : STD_LOGIC;
	SIGNAL FINAL_SRC_A : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL LUI : STD_LOGIC;
	SIGNAL LH : STD_LOGIC;
	SIGNAL NOT_ZERO : STD_LOGIC;
	SIGNAL MEM_READ : STD_LOGIC;
	SIGNAL CLO : STD_LOGIC;
	SIGNAL STORE_PC : STD_LOGIC;
	SIGNAL NEGATIVE : STD_LOGIC;
	SIGNAL L_ONES : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MULT_OUT : STD_LOGIC_VECTOR(63 DOWNTO 0);
	SIGNAL MULT_DONE : STD_LOGIC;
	SIGNAL MULTIPLY : STD_LOGIC;
	SIGNAL HI_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL LO_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ZERO_EXTEND : STD_LOGIC;
	SIGNAL MULT_WRITE : STD_LOGIC;
	SIGNAL RESET_MULT : STD_LOGIC;
	SIGNAL WRITE_HI : STD_LOGIC;
	SIGNAL WRITE_LO : STD_LOGIC;

BEGIN
	PC_0: PC PORT MAP(
			CLOCK => CLOCK,
			RESET => RESET,
			PC_IN => PC_IN,
			ENABLE => PC_WRITE_ENABLE,
			PC_OUT => PC_OUT
	);
	
	MULT_32: MULTIPLIER_32 PORT MAP(
	  MC => A,
		MP => B,
		RESET => RESET_MULT,
		START => MULTIPLY,
		CLOCK => CLOCK,
		PRODUCT => MULT_OUT,
		DONE => MULT_DONE
	);
	
	HI: REG_32B PORT MAP(
		D	      => MULT_OUT(63 DOWNTO 32),
		CLOCK	  => CLOCK,
		ENABLE  => MULT_WRITE,
		RESET   => RESET,
		Q	      => HI_OUT
	);

  LO: REG_32B PORT MAP(
 		D	      => MULT_OUT(31 DOWNTO 0),
		CLOCK	  => CLOCK,
		ENABLE  => MULT_WRITE,
		RESET   => RESET,
		Q	      => LO_OUT
	);   

	INSTR_REG_0: INSTRUCTION_REG PORT MAP(
			MEM_DATA => DATA_MEM_IN,
			IR_WRITE => IR_WRITE,
			CLOCK => CLOCK,
			IR_OUT => INSTRUCTION
	);

	REG_FILE_0: REGISTER_FILE PORT MAP(
			CLOCK => CLOCK,	
			REG_READ_1_ADDR => INSTRUCTION(25 DOWNTO 21),	
			REG_READ_2_ADDR	=> INSTRUCTION(20 DOWNTO 16),
			REG_WRITE_ADDR	=> REG_WRITE_ADDR,
			REG_WRITE => REG_WRITE,			
			REG_WRITE_DATA => REG_WRITE_DATA,		
			REG_READ_1_DATA	=> REG_READ1,
			REG_READ_2_DATA	=> REG_READ2 
	);

	MEM_REG_0: MEMORY_REG PORT MAP(
			MEM_DATA => DATA_MEM_IN,
			READ => MEM_READ,
			CLOCK => CLOCK,
			MR_OUT => MEM_REG_OUT 
	); 

	ALU_CONTROL_0: ALU_CONTROL PORT MAP(
			ALU_OP_IN => ALU_OP_IN,
			FUNCT => INSTRUCTION(5 DOWNTO 0),
			ALU_OP => ALU_OP,
			SHIFT_SRC => SHIFT_SRC,
			SHIFTING => SHIFTING,
			CLO      => CLO
	);

	ALU_0: ALU PORT MAP(
			A => ALU_A,
			B => ALU_B,
			SHAMT => SHAMT,
			ALUOP => ALU_OP,
			OVERFLOW => ALU_OFL,
			ZERO => ZERO,
			R => ALU_OUT
	);

	CONTROL_0: CONTROL PORT MAP(
			OP_CODE	=> INSTRUCTION(31 DOWNTO 26),
			ALU_OP => ALU_OP_IN,
			REG_DST	=> REG_DST,	
			REG_WRITE => REG_WRITE,
			ALU_SRC_A => ALU_SRC_A,
			ALU_SRC_B => ALU_SRC_B,
			PC_SOURCE => PC_SOURCE,
			PC_WRITE_COND => PC_WRITE_COND,
			PC_WRITE => PC_WRITE,
			I_OR_D => I_OR_D,
			MEM_READ => MEM_READ,
			MEM_WRITE => WRITE_TO_MEM,
			MEM_TO_REG => MEM_TO_REG,
			IR_WRITE => IR_WRITE,
			NOT_ZERO => NOT_ZERO,
			LUI => LUI,
			LH => LH,
			NEGATIVE => NEGATIVE,
			STORE_PC => STORE_PC,
			MULTIPLY => MULTIPLY,
			ZERO_EXTEND => ZERO_EXTEND,
			FUNCT => INSTRUCTION(5 DOWNTO 0),
			MULT_DONE => MULT_DONE,
			RESET_MULT => RESET_MULT,
			MULT_WRITE => MULT_WRITE,
			WRITE_LO => WRITE_LO,
			WRITE_HI => WRITE_HI,
			CLOCK => CLOCK,
			RESET => RESET		
	);

	READ_REG_A: READ_REG PORT MAP(
		DATA_IN => REG_READ1,
		DATA_OUT => A,
		CLOCK => CLOCK
	);

	READ_REG_B: READ_REG PORT MAP(
		DATA_IN => REG_READ2,
		DATA_OUT => B,
		CLOCK => CLOCK
	);

	ALU_REG: ALU_OUT_REG PORT MAP(
		REG_IN => ALU_OUT,
		REG_OUT => ALU_REG_OUT,
		CLOCK => CLOCK
	);

  DATA_MEM_READ <= MEM_READ;

	REG_WRITE_ADDR 	<= 	INSTRUCTION(15 DOWNTO 11) WHEN REG_DST = '0' AND STORE_PC = '0' ELSE
					 	INSTRUCTION(20 DOWNTO 16) WHEN REG_DST = '1' AND STORE_PC = '0' ELSE
					 	"11111";

	PC_WRITE_ENABLE <= PC_WRITE OR (PC_WRITE_COND AND NOT_ZERO) OR (PC_WRITE_COND AND NEGATIVE AND ALU_OUT(31));

	MEM_ADDR 		<= 	PC_OUT WHEN I_OR_D = '0' ELSE
						     ALU_REG_OUT;

	REG_WRITE_DATA 	<=	ALU_REG_OUT WHEN (MEM_TO_REG = '0' AND LUI='0' AND LH='0' AND CLO='0' AND WRITE_HI ='0' AND WRITE_LO ='0' AND STORE_PC='0') ELSE
						          MEM_REG_OUT WHEN (MEM_TO_REG ='1' AND LUI='0' AND LH='0' AND CLO='0' AND STORE_PC='0' AND WRITE_HI ='0' AND WRITE_LO ='0') ELSE
						          ALU_REG_OUT(15 DOWNTO 0) & X"0000" WHEN LUI='1' AND CLO='0' AND WRITE_HI ='0' AND WRITE_LO ='0' ELSE
						          L_ONES WHEN CLO='1' AND WRITE_HI ='0' AND WRITE_LO ='0' ELSE
						          PC_OUT WHEN STORE_PC = '1' AND WRITE_HI ='0' AND WRITE_LO ='0' ELSE
						          HI_OUT WHEN WRITE_HI = '1' AND WRITE_LO = '0' ELSE
						          LO_OUT WHEN WRITE_LO = '1' AND WRITE_HI = '0' ELSE
						          X"0000" & MEM_REG_OUT(31 DOWNTO 16) WHEN LH='1' AND CONV_INTEGER(UNSIGNED(MEM_ADDR)) MOD 4 = 0 ELSE
						          X"0000" & MEM_REG_OUT(15 DOWNTO 0);

  SHAMT <= INSTRUCTION(10 DOWNTO 6) WHEN SHIFT_SRC ='0' ELSE
           B(4 DOWNTO 0);

	DATA_MEM_WRITE	<= WRITE_TO_MEM;
	
	FINAL_SRC_A(1) <= SHIFTING;
	FINAL_SRC_A(0) <= ALU_SRC_A;
	
	ALU_A <= PC_OUT WHEN FINAL_SRC_A = "00" ELSE
	         A WHEN FINAL_SRC_A = "01" ELSE
	         B;

	EXTENDED_IL(15 DOWNTO 0) <= INSTRUCTION(15 DOWNTO 0);

	EXTENDED_IL(31 DOWNTO 16) <= 	X"0000" WHEN INSTRUCTION(15) = '0' OR ZERO_EXTEND='1' ELSE
									X"FFFF";

	DATA_MEM_OUT <= B;

	EXTENDED_IL_SL 	<= EXTENDED_IL(29 DOWNTO 0) & "00";

	ALU_B 	<=	B WHEN ALU_SRC_B = "00" ELSE
				X"00000004" WHEN ALU_SRC_B = "01" ELSE
				EXTENDED_IL WHEN ALU_SRC_B = "10" ELSE
				EXTENDED_IL_SL;

	NEXT_PC(27 DOWNTO 2) 	<= INSTRUCTION(25 DOWNTO 0);
	NEXT_PC(1 DOWNTO 0) 	<= "00";
	NEXT_PC(31 DOWNTO 28) 	<= PC_OUT(31 DOWNTO 28);

	PC_IN <=	ALU_OUT WHEN PC_SOURCE = "00" ELSE
				ALU_REG_OUT WHEN PC_SOURCE = "01" ELSE
				NEXT_PC WHEN PC_SOURCE = "10" ELSE
				A;	

	DATA_MEM_ADDR <= MEM_ADDR;
	
PROCESS(CLOCK)
VARIABLE ONES : INTEGER := 0;
BEGIN
    ONES := 0;
    FOR I IN 31 DOWNTO 0 LOOP
      IF(ALU_A(I) = '1') THEN
        ONES := ONES + 1;
      ELSE
        EXIT;
      END IF;
    END LOOP;
    
    L_ONES <= CONV_STD_LOGIC_VECTOR(ONES,L_ONES'LENGTH);

END PROCESS;

END BEHAV;
