--DFF_16bit.vhd
--This package implements a 16-bit memory register; using the 1-bit DFFs from DFF1bit.vhd
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE DFF_16bit is

COMPONENT reg
	GENERIC(n: INTEGER := 16);
	PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Enable, Clock: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE DFF_16bit;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY reg IS 
	GENERIC (n : INTEGER := 16);
	PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Enable, Clock: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END reg;

ARCHITECTURE StructuralArchUnit OF reg IS

	--1bit DFF
	COMPONENT DFF1
		PORT (input, Clock, Enable : IN STD_LOGIC;
			output : OUT STD_LOGIC);
		END COMPONENT;
	
	BEGIN
	    		--Component instantiations statements
		U0: DFF1 PORT MAP(Input(0), Clock, Enable, Output(0));
		U1: DFF1 PORT MAP(Input(1), Clock, Enable, Output(1));
		U2: DFF1 PORT MAP(Input(2), Clock, Enable, Output(2));
		U3: DFF1 PORT MAP(Input(3), Clock, Enable, Output(3));
		U4: DFF1 PORT MAP(Input(4), Clock, Enable, Output(4));
		U5: DFF1 PORT MAP(Input(5), Clock, Enable, Output(5));
		U6: DFF1 PORT MAP(Input(6), Clock, Enable, Output(6));
		U7: DFF1 PORT MAP(Input(7), Clock, Enable, Output(7));
		U8: DFF1 PORT MAP(Input(8), Clock, Enable, Output(8));
		U9: DFF1 PORT MAP(Input(9), Clock, Enable, Output(9));
		U10: DFF1 PORT MAP(Input(10), Clock, Enable, Output(10));
		U11: DFF1 PORT MAP(Input(11), Clock, Enable, Output(11));
		U12: DFF1 PORT MAP(Input(12), Clock, Enable, Output(12));
		U13: DFF1 PORT MAP(Input(13), Clock, Enable, Output(13));
		U14: DFF1 PORT MAP(Input(14), Clock, Enable, Output(14));
		U15: DFF1 PORT MAP(Input(15), Clock, Enable, Output(15));
	END StructuralArchUnit;