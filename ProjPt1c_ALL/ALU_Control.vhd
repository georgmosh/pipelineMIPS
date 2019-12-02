--ALU_Control.vhd
--This package implements an ALU Control panel; using various multiplexers required.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE ALU_Control is

COMPONENT ALUcontrol
	PORT (opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Operation, BInvert: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			AInvert, CarryIn: OUT STD_LOGIC);
		END COMPONENT;
		
END PACKAGE ALU_Control;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY ALUcontrol IS 
	PORT (opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Operation, BInvert: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			AInvert, CarryIn: OUT STD_LOGIC);
END ALUcontrol;

ARCHITECTURE StructuralArchUnit OF ALUcontrol IS

	--Required Muxes
	COMPONENT MPlexerNo3	
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT MPlexerNo4	
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MPlexerNo5	
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT MPlexerNo6
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC);
	END COMPONENT;
	
	BEGIN
	    		--Component instantiations statements
		A0: MPlexerNo3 PORT MAP(opcode, Operation);
		A1: MPlexerNo4 PORT MAP(opcode, Ainvert);
		A2: MPlexerNo5 PORT MAP(opcode, Binvert);
		A3: MPlexerNo6 PORT MAP(opcode, CarryIn);
	END StructuralArchUnit;