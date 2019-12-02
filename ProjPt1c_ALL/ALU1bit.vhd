--ALU1bit.vhd
--This package implements a n-bit ALU slice; computing expected results per bit.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE ALU1bit is

	COMPONENT ALU1
		PORT (a, b : IN STD_LOGIC;
			opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			CarryOut, Result : OUT STD_LOGIC);
		END COMPONENT;
		
	COMPONENT ALU2 
		PORT (a, b, CarryIn : IN STD_LOGIC;
			opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			CarryOut, Result : OUT STD_LOGIC);
		END COMPONENT;

END PACKAGE ALU1bit;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY ALU1 is 
		PORT (a, b : IN STD_LOGIC;
			opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			CarryOut, Result : OUT STD_LOGIC);
	END ALU1;
	
	
	ARCHITECTURE StructuralArchUnit OF ALU1 IS
	
	COMPONENT MPlexerNo1 
		PORT (x, s : IN STD_LOGIC; 
				outm : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT MPlexerNo2	
		PORT (x1, x2, x3, x4: IN STD_LOGIC;
				s	: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				res : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT ALUcontrol
	PORT (opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Operation, BInvert: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			AInvert, CarryIn: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MPlexerNo9 
		PORT (x : IN STD_LOGIC; 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT AdderNo1
		PORT (x1, x2, cin: IN STD_LOGIC;
				out2, cout : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYAND2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYOR2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYXOR2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	--declaration of signals used to interconnect gates
	SIGNAL Ainvert, CarryIn, outa, outb, out0, out1, out2, out3: std_LOGIC;
	SIGNAL Binvert, Operation: STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	BEGIN
			--Component instantiations statements
		A0: ALUcontrol PORT MAP(opcode, Operation, Binvert, Ainvert, CarryIn);
		U0: MPlexerNo1 PORT MAP(a, Ainvert, outa);
		U1: MPlexerNo9 PORT MAP(b, Binvert, outb);
		U2: MYAND2 PORT MAP(outa, outb, out0);
		U3: MYOR2 PORT MAP(outa, outb, out1);
		U4: AdderNo1 PORT MAP(outa, outb, CarryIn, out2, CarryOut);
		U5: MYXOR2 PORT MAP(outa, outb, out3);
		U6: MPlexerNo2 PORT MAP(out0, out1, out2, out3, Operation, Result);
	END StructuralArchUnit; 
	
	--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body basic_func is
	ENTITY ALU2 is 
		PORT (a, b, CarryIn : IN STD_LOGIC;
			opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			CarryOut, Result : OUT STD_LOGIC);
	END ALU2;
	
	ARCHITECTURE StructuralArchUnit2 OF ALU2 IS
	COMPONENT MPlexerNo1 
		PORT (x, s : IN STD_LOGIC; 
				outm : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT MPlexerNo2	
		PORT (x1, x2, x3, x4: IN STD_LOGIC;
				s	: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				res : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT ALUcontrol
	PORT (opcode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Operation, BInvert: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			AInvert, CarryIn: OUT STD_LOGIC);
		END COMPONENT;
	
	COMPONENT MPlexerNo9 
		PORT (x : IN STD_LOGIC; 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT AdderNo1
		PORT (x1, x2, cin: IN STD_LOGIC;
				out2, cout : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYAND2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYOR2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYXOR2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	--declaration of signals used to interconnect gates
	SIGNAL Ainvert, outa, outb, out0, out1, out2, out3, internal: std_LOGIC;
	SIGNAL Binvert, Operation: STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	BEGIN
			--Component instantiations statements
		A0: ALUcontrol PORT MAP(opcode, Operation, Binvert, Ainvert, internal);
		U0: MPlexerNo1 PORT MAP(a, Ainvert, outa);
		U1: MPlexerNo9 PORT MAP(b, Binvert, outb);
		U2: MYAND2 PORT MAP(outa, outb, out0);
		U3: MYOR2 PORT MAP(outa, outb, out1);
		U4: AdderNo1 PORT MAP(outa, outb, CarryIn, out2, CarryOut);
		U5: MYXOR2 PORT MAP(outa, outb, out3);
		U6: MPlexerNo2 PORT MAP(out0, out1, out2, out3, Operation, Result);
	END StructuralArchUnit2; 