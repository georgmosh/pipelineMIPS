--UNIT_Hazards.vhd
--This package implements a pipeline hazzard detection unit; using the behavioral detector.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE UNIT_Hazards is

	COMPONENT hazardUnit
		PORT (isJR, isJump, wasJump, shouldBranch: IN STD_LOGIC;
				IF_ID_Flush, wasJumpOut: OUT STD_LOGIC;
				JROpCode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
		
END PACKAGE UNIT_Hazards;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY hazardUnit IS 
	PORT (isJR, isJump, wasJump, shouldBranch: IN STD_LOGIC;
				IF_ID_Flush, wasJumpOut: OUT STD_LOGIC;
				JROpCode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END hazardUnit;

ARCHITECTURE StructuralArchUnit OF hazardUnit IS
	COMPONENT HazzardDetector
		PORT (inJType, inJReg, inNextBranch, inPrevJType: IN STD_LOGIC;
				IF_ID_Flush, outPrevJType : OUT STD_LOGIC;
				reg_outJReg_address: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: HazzardDetector PORT MAP(isJR, isJump, shouldBranch, wasJump, IF_ID_Flush, wasJumpOut, JROpCode);
END StructuralArchUnit;