--MUX_8To1.vh
--This package implements an 16-bit inputs multiplexer; using the behavioral MUX circuit.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE MUX_8To1 is

COMPONENT mux8
	GENERIC(n: INTEGER := 16);
	PORT (Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				Choice : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE MUX_8To1;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY mux8 IS 
	GENERIC (n : INTEGER := 16);
	PORT (Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				Choice : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END mux8;

ARCHITECTURE StructuralArchUnit OF mux8 IS
	COMPONENT MPlexer8To1 
		GENERIC(n: INTEGER := 16);
		PORT (x1, x2, x3, x4, x5, x6, x7, x8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: MPlexer8To1 PORT MAP(Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8, Choice, Output);
END StructuralArchUnit;