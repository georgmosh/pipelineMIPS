--ALU_16bit.vhd
--This package implements a 16-bit ALU slice; using the 1-bit slices from ALU1bit.vhd
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE ALU_16bit is

	COMPONENT ALU
	GENERIC(n: INTEGER := 16);
	PORT (A, B: IN std_LOGIC_VECTOR(n-1 DOWNTO 0);
			opcode: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0) ;
			Result: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Overflow: OUT STD_LOGIC);
		END COMPONENT;
		
END PACKAGE ALU_16bit;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY ALU IS 
	GENERIC(n: INTEGER := 16);
	PORT (A, B: IN std_LOGIC_VECTOR(n-1 DOWNTO 0);
			opcode: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0) ;
			Result: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Overflow: OUT STD_LOGIC);
END ALU;

ARCHITECTURE StructuralArchUnit OF ALU IS
	
	COMPONENT MPlexerNo7
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				opt : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MPlexerNo8	
	GENERIC(n: INTEGER := 16);
		PORT (s	: IN STD_LOGIC;
				ALURes, compRes: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				res : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ComparerNo1 
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC;
				out2 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT MYXOR2 
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;

	--1bit ALU
	COMPONENT ALU1 is
		PORT (a, b : IN STD_LOGIC;
			opcode: STD_LOGIC_VECTOR(2 DOWNTO 0);
			CarryOut, Result : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT ALU2 
		PORT (a, b, CarryIn : IN STD_LOGIC;
			opcode: STD_LOGIC_VECTOR(2 DOWNTO 0);
			CarryOut, Result : OUT STD_LOGIC);
	END COMPONENT;
	
	--declaration of signals used to interconnect gates
	SIGNAL CarryOut, TempResult, TempResult2: std_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL SrcResult: STD_LOGIC;
	
	BEGIN
	    		--Component instantiations statements
		U0: ALU1 PORT MAP(A(0), B(0), opcode, CarryOut(0), TempResult(0));
		U1: ALU2 PORT MAP(A(1), B(1), CarryOut(0), opcode, CarryOut(1), TempResult(1));
		U2: ALU2 PORT MAP(A(2), B(2), CarryOut(1), opcode, CarryOut(2), TempResult(2));
		U3: ALU2 PORT MAP(A(3), B(3), CarryOut(2), opcode, CarryOut(3), TempResult(3));
		U4: ALU2 PORT MAP(A(4), B(4), CarryOut(3), opcode, CarryOut(4), TempResult(4));
		U5: ALU2 PORT MAP(A(5), B(5), CarryOut(4), opcode, CarryOut(5), TempResult(5));
		U6: ALU2 PORT MAP(A(6), B(6), CarryOut(5), opcode, CarryOut(6), TempResult(6));
		U7: ALU2 PORT MAP(A(7), B(7), CarryOut(6), opcode, CarryOut(7), TempResult(7));
		U8: ALU2 PORT MAP(A(8), B(8), CarryOut(7), opcode, CarryOut(8), TempResult(8));
		U9: ALU2 PORT MAP(A(9), B(9), CarryOut(8), opcode, CarryOut(9), TempResult(9));
		U10: ALU2 PORT MAP(A(10), B(10), CarryOut(9), opcode, CarryOut(10), TempResult(10));
		U11: ALU2 PORT MAP(A(11), B(11), CarryOut(10), opcode, CarryOut(11), TempResult(11));
		U12: ALU2 PORT MAP(A(12), B(12), CarryOut(11), opcode, CarryOut(12), TempResult(12));
		U13: ALU2 PORT MAP(A(13), B(13), CarryOut(12), opcode, CarryOut(13), TempResult(13));
		U14: ALU2 PORT MAP(A(14), B(14), CarryOut(13), opcode, CarryOut(14), TempResult(14));
		U15: ALU2 PORT MAP(A(15), B(15), CarryOut(14), opcode, CarryOut(15), TempResult(15));
		U16: MYXOR2 PORT MAP(CarryOut(14), CarryOut(15), Overflow);
		U17: MPlexerNo7 PORT MAP(opcode, SrcResult);
		U18: ComparerNo1 PORT MAP(A(15), TempResult2);
		U19: MPlexerNo8 PORT MAP(SrcResult, TempResult, TempResult2, Result);
	END StructuralArchUnit;