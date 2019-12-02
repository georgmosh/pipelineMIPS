--Sign_Extender.vhd
--This package implements a sign extention component; using the behavioral sign extender.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE Sign_Extender is

COMPONENT signExtender
	GENERIC(n: INTEGER := 16);
	PORT (immediate: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			extended: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE Sign_Extender;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY signExtender IS 
	GENERIC (n : INTEGER := 16);
	PORT (immediate: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			extended: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END signExtender;

ARCHITECTURE StructuralArchUnit OF signExtender IS
	COMPONENT SignExtenderNo1
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			 out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: SignExtenderNo1 PORT MAP(immediate, extended);
END StructuralArchUnit;