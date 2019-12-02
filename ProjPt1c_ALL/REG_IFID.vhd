--REG_IFID.vhd
--This package implements a 16-bit pipeline register; using the behavioral IF-ID register.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE REG_IFID is

COMPONENT reg_IF_ID
	GENERIC (n : INTEGER := 16);
	PORT (PCin, Command: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Clock, IF_Flush, IF_ID_Enable: IN STD_LOGIC;
				PCout, Commandout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE REG_IFID;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY reg_IF_ID IS 
	GENERIC (n : INTEGER := 16);
	PORT (PCin, Command: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Clock, IF_Flush, IF_ID_Enable: IN STD_LOGIC;
				PCout, Commandout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END reg_IF_ID;

ARCHITECTURE StructuralArchUnit OF reg_IF_ID IS
	COMPONENT PipelineRegisterNo1
		GENERIC(n: INTEGER := 16);
		PORT (clk, IF_Flush, IF_ID_Enable: IN STD_LOGIC;
				PCin, command: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				PCout, commandout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: PipelineRegisterNo1 PORT MAP(Clock, IF_Flush, IF_ID_Enable, PCin, command, PCout, commandout);
END StructuralArchUnit;