--REG_IDEX.vhd
--This package implements a 16-bit pipeline register; using the behavioral ID-EX register.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE REG_IDEX is

COMPONENT reg_ID_EX
	GENERIC (n : INTEGER := 16);
	PORT (
			Clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isWriteDigit : in STD_LOGIC;
			ALUFunc : in STD_LOGIC_VECTOR(2 DOWNTO 0);
			R1Reg , R2Reg , immediate16 : IN STD_LOGIC_VECTOR(n-1 downto 0);
			R2AD, R1AD : IN STD_LOGIC_VECTOR(2 downto 0);
			jumpShortAddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX , isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isWriteDigit_IDEX : out STD_LOGIC;
			ALUFunc_IDEX : out STD_LOGIC_VECTOR(2 DOWNTO 0);
			R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX : OUT STD_LOGIC_VECTOR(n-1 downto 0);
			R2AD_IDEX , R1AD_IDEX : OUT STD_LOGIC_VECTOR(2 downto 0);
			jumpShortAddr_IDEX : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	 );
		END COMPONENT;
		
END PACKAGE REG_IDEX;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY reg_ID_EX IS 
	GENERIC (n : INTEGER := 16);
	PORT (
			Clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isWriteDigit : in STD_LOGIC;
			ALUFunc : in STD_LOGIC_VECTOR(2 DOWNTO 0);
			R1Reg , R2Reg , immediate16 : IN STD_LOGIC_VECTOR(n-1 downto 0);
			R2AD, R1AD : IN STD_LOGIC_VECTOR(2 downto 0);
			jumpShortAddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX , isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isWriteDigit_IDEX : out STD_LOGIC;
			ALUFunc_IDEX : out STD_LOGIC_VECTOR(2 DOWNTO 0);
			R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX : OUT STD_LOGIC_VECTOR(n-1 downto 0);
			R2AD_IDEX , R1AD_IDEX : OUT STD_LOGIC_VECTOR(2 downto 0);
			jumpShortAddr_IDEX : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	 );
END reg_ID_EX;

ARCHITECTURE StructuralArchUnit OF reg_ID_EX IS
	COMPONENT PipelineRegisterNo2
		GENERIC(n: INTEGER := 16);
		PORT (
			clk, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isWriteDigit : in STD_LOGIC;
			ALUFunc : in STD_LOGIC_VECTOR(2 DOWNTO 0);
			R1Reg , R2Reg , immediate16 : IN STD_LOGIC_VECTOR(n-1 downto 0);
			R2AD, R1AD : IN STD_LOGIC_VECTOR(2 downto 0);
			jumpShortAddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX , isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isWriteDigit_IDEX : out STD_LOGIC;
			ALUFunc_IDEX : out STD_LOGIC_VECTOR(2 DOWNTO 0);
			R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX : OUT STD_LOGIC_VECTOR(n-1 downto 0);
			R2AD_IDEX , R1AD_IDEX : OUT STD_LOGIC_VECTOR(2 downto 0);
			jumpShortAddr_IDEX : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	 );
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: PipelineRegisterNo2 PORT MAP(Clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isWriteDigit,ALUFunc ,R1Reg , R2Reg , immediate16 ,R2AD, R1AD ,jumpShortAddr ,isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX , isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isWriteDigit_IDEX ,ALUFunc_IDEX ,R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX ,R2AD_IDEX , R1AD_IDEX ,jumpShortAddr_IDEX);
END StructuralArchUnit;