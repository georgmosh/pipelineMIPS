--MUX_JRopt.vhd
--This package implements a selector for the Branch Offsets; using a behavioral multiplexer.
--Conditional (I-Type) as well as Unconditional Branches (J-Type) with different offsets are supported.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE MUX_JRopt is

	COMPONENT JRSelector 
		GENERIC(n: INTEGER := 16);
		PORT (jumpAD, branchAd,PCP2AD: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				JROpCode: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				Result: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
		
END PACKAGE MUX_JRopt;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY JRSelector IS 
	GENERIC(n: INTEGER := 16);
		PORT (jumpAD, branchAd,PCP2AD: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				JROpCode: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				Result: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END JRSelector;

ARCHITECTURE StructuralArchUnit OF JRSelector IS
	COMPONENT MPlexerNo11
		GENERIC(n: INTEGER := 16);
		PORT (jumpAddress, branchAddress, PCP2AD : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: MPlexerNo11 PORT MAP(jumpAD, branchAd,PCP2AD, JROpCode, Result);
END StructuralArchUnit;