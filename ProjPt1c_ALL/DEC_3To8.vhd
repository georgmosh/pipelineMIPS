--DEC_3To8.vh
--This package implements a 3bit To 8bit inputs decoder; using the behavioral decode circuit.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE DEC_3To8 is

COMPONENT decode3to8
	PORT (Input: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE DEC_3To8;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY decode3to8 IS 
	PORT (Input: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END decode3to8;

ARCHITECTURE StructuralArchUnit OF decode3to8 IS
	COMPONENT DCoder3To8
		PORT (s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: DCoder3To8 PORT MAP(Input, Output);
END StructuralArchUnit;