--REG0_16bit.vhd
--This package implements a 16-bit memory pseudoregister; using the behavioral reset circuit.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE REG0_16bit is

COMPONENT reg0
	GENERIC(n: INTEGER := 16);
	PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Enable, Clock: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE REG0_16bit;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY reg0 IS 
	GENERIC (n : INTEGER := 16);
	PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Enable, Clock: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END reg0;

ARCHITECTURE StructuralArchUnit OF reg0 IS
	COMPONENT ReseterNo1
		GENERIC(n: INTEGER := 16);
		PORT (out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: ReseterNo1 PORT MAP(Output);
END StructuralArchUnit;