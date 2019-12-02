--UNIT_Traps.vhd
--This package implements a processor trap unit; using the behavioral dummy instructions trapper.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE UNIT_Traps is

	COMPONENT trapUnit
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				endOfRunning : OUT STD_LOGIC);
	END COMPONENT;
		
END PACKAGE UNIT_Traps;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY trapUnit IS 
	PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				endOfRunning : OUT STD_LOGIC);
END trapUnit;

ARCHITECTURE StructuralArchUnit OF trapUnit IS
	COMPONENT DummiesTrapper
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				endOfRunning : OUT STD_LOGIC);
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: DummiesTrapper PORT MAP(OpCode, endOfRunning);
END StructuralArchUnit;