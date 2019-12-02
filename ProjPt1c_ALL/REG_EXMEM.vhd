--REG_EXMEM.vhd
--This package implements a 16-bit pipeline register; using the behavioral EX-MEM register.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE REG_EXMEM is

COMPONENT reg_EX_MEM
	GENERIC (n : INTEGER := 16);
	PORT (Clock, isLW, WriteEnable, ReadDigit, WriteDigit : IN STD_LOGIC;
				R2Reg, Result : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM : OUT STD_LOGIC;
				R2Reg_EXMEM, Result_EXMEM : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD_EXMEM : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE REG_EXMEM;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY reg_EX_MEM IS 
	GENERIC (n : INTEGER := 16);
	PORT (Clock, isLW, WriteEnable, ReadDigit, WriteDigit : IN STD_LOGIC;
				R2Reg, Result : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM : OUT STD_LOGIC;
				R2Reg_EXMEM, Result_EXMEM : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD_EXMEM : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END reg_EX_MEM;

ARCHITECTURE StructuralArchUnit OF reg_EX_MEM IS
	COMPONENT PipelineRegisterNo3
		GENERIC(n: INTEGER := 16);
		PORT (clk, isLW, WriteEnable, ReadDigit, WriteDigit : IN STD_LOGIC;
				R2Reg, Result : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, WriteDigit_EXMEM : OUT STD_LOGIC;
				R2Reg_EXMEM, Result_EXMEM : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD_EXMEM : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: PipelineRegisterNo3 PORT MAP(Clock, isLW, WriteEnable, ReadDigit, WriteDigit ,R2Reg, Result ,RegAD ,isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM ,R2Reg_EXMEM, Result_EXMEM ,RegAD_EXMEM);
END StructuralArchUnit;