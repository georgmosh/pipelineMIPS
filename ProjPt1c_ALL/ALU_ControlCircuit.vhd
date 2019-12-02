--ALU_ControlCircuit.vhd
--This package implements a pipeline forwarding unit; using the behavioral forwarder.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE ALU_ControlCircuit is

	COMPONENT control
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				IF_ID_Flush: IN STD_LOGIC;
				isMPFC, isJType, isReadDig, isWriteDig, idRType, isLdWord, isStWord, isBranch, isJReg : OUT STD_LOGIC);
	END COMPONENT;
		
END PACKAGE ALU_ControlCircuit;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY control IS 
	PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				IF_ID_Flush: IN STD_LOGIC;
				isMPFC, isJType, isReadDig, isWriteDig, idRType, isLdWord, isStWord, isBranch, isJReg : OUT STD_LOGIC);
END control;

ARCHITECTURE StructuralArchUnit OF control IS
	COMPONENT ControlCircuit
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				IF_ID_Flush: IN STD_LOGIC;
				outMPFC, outJType, outReadDig, outWriteDig, outRType, outLdWord, outStWord, outBranch, outJReg : OUT STD_LOGIC);
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: ControlCircuit PORT MAP(OpCode, Funct, IF_ID_Flush, isMPFC, isJType, isReadDig, isWriteDig, idRType, isLdWord, isStWord, isBranch, isJReg);
END StructuralArchUnit;