--REG_FILE.vhd
--This package implements a register file; using the 8-To-1 MUX, 3-To-8 decoder, DFF & pseudoregister.
--Single structural operations are being implemented exploiting the logic from various files accordingly.
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE REG_FILE is

	COMPONENT regFile
		GENERIC (n : INTEGER := 16);
		PORT (Clock: IN STD_LOGIC;
				Write1: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Write1AD, Read1AD, Read2AD: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Read1, Read2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Output: OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
	END COMPONENT;
		
END PACKAGE REG_FILE;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY regFile IS 
	GENERIC (n : INTEGER := 16);
	PORT (Clock: IN STD_LOGIC;
			Write1: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Write1AD, Read1AD, Read2AD: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Read1, Read2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Output: OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
END regFile;

ARCHITECTURE StructuralArchUnit OF regFile IS
	COMPONENT reg0
		GENERIC(n: INTEGER := 16);
		PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Clock, Enable: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT reg
		GENERIC(n: INTEGER := 16);
		PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Clock, Enable: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT mux8
		GENERIC(n: INTEGER := 16);
		PORT (Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				Choice : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT decode3to8
		PORT (Input: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
		END COMPONENT;
		
	SIGNAL Enable: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL Result0, Result1, Result2, Result3, Result4, Result5, Result6, Result7: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	
	BEGIN
		    	--Component instantiations statements
		U0: decode3to8 PORT MAP(Write1AD, Enable);
		U1: reg0 PORT MAP(Write1, Enable(0), Clock, Result0);
		U2: reg PORT MAP(Write1, Enable(1), Clock, Result1);
		U3: reg PORT MAP(Write1, Enable(2), Clock, Result2);
		U4: reg PORT MAP(Write1, Enable(3), Clock, Result3);
		U5: reg PORT MAP(Write1, Enable(4), Clock, Result4);
		U6: reg PORT MAP(Write1, Enable(5), Clock, Result5);
		U7: reg PORT MAP(Write1, Enable(6), Clock, Result6);
		U8: reg PORT MAP(Write1, Enable(7), Clock, Result7);
		U9: mux8 PORT MAP(Result0, Result1, Result2, Result3, Result4, Result5, Result6, Result7, Read1AD, Read1);
		U10: mux8 PORT MAP(Result0, Result1, Result2, Result3, Result4, Result5, Result6, Result7, Read2AD, Read2);
		Output <= Result7 & Result6 & Result5 & Result4 & Result3 & Result2 & Result1 & Result0;
END StructuralArchUnit;