--UNC_Branch.vhd
--This package implements an unconditional branch target finder; using the behavioral circuit.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE UNC_Branch is

COMPONENT jumpAD
	GENERIC(n: INTEGER := 16);
	PORT (jumpADR: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
				instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 EjumpAD: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
END PACKAGE UNC_Branch;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY jumpAD IS 
	GENERIC (n : INTEGER := 16);
	PORT (jumpADR: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
				instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 EjumpAD: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END jumpAD;

ARCHITECTURE StructuralArchUnit OF jumpAD IS
	COMPONENT UnconditionalBranchTargetFinder
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
				instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 EjumpAD: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: UnconditionalBranchTargetFinder PORT MAP(jumpADR, instrP2AD, EjumpAD);
END StructuralArchUnit;