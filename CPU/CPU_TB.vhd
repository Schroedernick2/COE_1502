--
-- VHDL Entity cpu_lib.CPU_TB.arch_name
--
-- Created:
--          by - nis102.UNKNOWN (COELABS31)
--          at - 19:28:57 03/ 1/2019
--
-- using Mentor Graphics HDL Designer(TM) 2011.1 (Build 18)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY CPU_TB IS
END ENTITY CPU_TB;

  ARCHITECTURE BEHAV OF CPU_TB IS
  SIGNAL CLOCK          : STD_LOGIC;
  SIGNAL RESET          : STD_LOGIC;
  SIGNAL MEM_WAIT       : STD_LOGIC;
  SIGNAL DATA_OUT       : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL MEM_DATA_OUT   : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL MEM_ADDR       : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL MEM_WRITE      : STD_LOGIC;
  SIGNAL NICK_SCHROEDER : STD_LOGIC := '1';
  
  COMPONENT CPU
    	PORT(
    		RESET			: IN STD_LOGIC := '0';
    		CLOCK			: IN STD_LOGIC := '0';
    		DATA_MEM_ADDR	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    		DATA_MEM_READ	: OUT STD_LOGIC;
    		DATA_MEM_WRITE	: OUT STD_LOGIC;
    		DATA_MEM_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    		DATA_MEM_WAIT	: IN STD_LOGIC;
    		DATA_MEM_IN 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	   );
	END COMPONENT;
	
	COMPONENT COE1502_MEMORY
	     PORT( 
          Clk      : IN     std_logic;
          MemWrite : IN     std_logic;
          addr     : IN     std_logic_vector (31 DOWNTO 0);
          dataIn   : IN     std_logic_vector (31 DOWNTO 0);
          MemWait  : OUT    std_logic;
          dataOut  : OUT    std_logic_vector (31 DOWNTO 0)
        );
  END COMPONENT;
  
BEGIN
  
  MEM_0: COE1502_MEMORY
  PORT MAP(
    Clk => CLOCK,
    MemWrite => MEM_WRITE,
    addr => MEM_ADDR,
    dataIn => MEM_DATA_OUT,
    MemWait => MEM_WAIT,
    dataOut => DATA_OUT
  );
  
  CPU_0: CPU 
  PORT MAP(
    RESET => RESET,
    CLOCK => CLOCK,
    DATA_MEM_ADDR => MEM_ADDR,
    DATA_MEM_WRITE => MEM_WRITE,
    DATA_MEM_OUT => MEM_DATA_OUT,
    DATA_MEM_WAIT => MEM_WAIT,
    DATA_MEM_IN => DATA_OUT
  );  
  
  PROCESS 
  BEGIN
    CLOCK <= '0';
    WAIT FOR 1 NS;
    CLOCK <= '1';
    WAIT FOR 1 NS;  
  END PROCESS;
END BEHAV;