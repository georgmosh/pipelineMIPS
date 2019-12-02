--basic_func3.vhd
--This package implements all the basic components (logical gates) for digital design.
--ONLY for these basic functions; code style uses behavioral architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE basic_func3 is
	COMPONENT MPlexerNo1 
		PORT (x, s : IN STD_LOGIC; 
				outm : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT MPlexerNo2	
		PORT (x1, x2, x3, x4: IN STD_LOGIC;
				s	: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				res : OUT STD_LOGIC);
	END COMPONENT;
	
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
	
	COMPONENT MPlexerNo9 
		PORT (x : IN STD_LOGIC; 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MPlexerNo10
		GENERIC(n: INTEGER := 16);
		PORT (regAddress, regAD_MEM, regAD_WB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT MPlexerNo11
		GENERIC(n: INTEGER := 16);
		PORT (jumpAddress, branchAddress, PCP2AD : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT MPlexer8To1 
		GENERIC(n: INTEGER := 16);
		PORT (x1, x2, x3, x4, x5, x6, x7, x8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT DCoder3To8
		PORT (s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ControlCircuit
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				IF_ID_Flush: IN STD_LOGIC;
				outMPFC, outJType, outReadDig, outWriteDig, outRType, outLdWord, outStWord, outBranch, outJReg : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT HazzardDetector
		PORT (inJType, inJReg, inNextBranch, inPrevJType: IN STD_LOGIC;
				IF_ID_Flush, outPrevJType : OUT STD_LOGIC;
				reg_outJReg_address: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT DummiesTrapper
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				endOfRunning : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT ForwarderNo1
		PORT (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT AdderNo1 
		PORT (x1, x2, cin: IN STD_LOGIC;
				out2, cout : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT ComparerNo1
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC;
				out2 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ReseterNo1
		GENERIC(n: INTEGER := 16);
		PORT (out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT SignExtenderNo1
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			 out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT UnconditionalBranchTargetFinder
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
				instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 EjumpAD: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT PipelineRegisterNo1
		GENERIC(n: INTEGER := 16);
		PORT (clk, IF_Flush, IF_ID_Enable: IN STD_LOGIC;
				PCin, command: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				PCout, commandout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
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
	
	COMPONENT PipelineRegisterNo3
		GENERIC(n: INTEGER := 16);
		PORT (clk, isLW, WriteEnable, ReadDigit, WriteDigit : IN STD_LOGIC;
				R2Reg, Result : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM : OUT STD_LOGIC;
				R2Reg_EXMEM, Result_EXMEM : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD_EXMEM : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
	END COMPONENT;

	COMPONENT PipelineRegisterNo4
		GENERIC(n: INTEGER := 16);
		PORT (clk: IN STD_LOGIC;
				regaddress: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				res: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				regaddressout: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
				out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
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
	
	COMPONENT MYNAND2
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MYNOT1
		PORT ( x1: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END COMPONENT;
	
END PACKAGE basic_func3;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY MPlexerNo1 is 
		PORT (x, s : IN STD_LOGIC; 
				outm : OUT STD_LOGIC);
	END MPlexerNo1;
	ARCHITECTURE FunctUnitLogic OF MPlexerNo1 IS
		BEGIN
			WITH s SELECT
				outm <= x WHEN '0',
						NOT x WHEN OTHERS;
	END FunctUnitLogic;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo2 is 
		PORT (x1, x2, x3, x4: IN STD_LOGIC;
				s	: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0) ;
				res : OUT STD_LOGIC);
	END MPlexerNo2;
	ARCHITECTURE FunctUnitLogic2 OF MPlexerNo2 IS
		BEGIN
			WITH s SELECT
				res <= x1 WHEN "00",
						x2 WHEN "01",
						x4 WHEN "10",
						x3 WHEN OTHERS;
	END FunctUnitLogic2;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo3 is 
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END MPlexerNo3;
	ARCHITECTURE FunctUnitLogic3 OF MPlexerNo3 IS
		BEGIN
			WITH s SELECT
				res <= "00" WHEN "010",
						"01" WHEN "011",
						"11" WHEN "000",
						"11" WHEN "001",
						"00" WHEN "101",
						"00" WHEN "111",
						"10" WHEN "110",
						"--" WHEN OTHERS;
	END FunctUnitLogic3;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo4 is 
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC);
	END MPlexerNo4;
	ARCHITECTURE FunctUnitLogic4 OF MPlexerNo4 IS
		BEGIN
			WITH s SELECT
				res <= '0' WHEN "010",
						'0' WHEN "011",
						'0' WHEN "000",
						'0' WHEN "001",
						'0' WHEN "110",
						'0' WHEN "100",
						'1' WHEN "101",
						'1' WHEN "111",
						'-' WHEN OTHERS;
	END FunctUnitLogic4;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo5 is 
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END MPlexerNo5;
	ARCHITECTURE FunctUnitLogic5 OF MPlexerNo5 IS
		BEGIN
			WITH s SELECT
				res <= "00" WHEN "010",
						"00" WHEN "011",
						"00" WHEN "000",
						"00" WHEN "110",
						"10" WHEN "101",
						"01" WHEN "001",
						"01" WHEN "111",
						"--" WHEN OTHERS;
	END FunctUnitLogic5;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo6 is 
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				res : OUT STD_LOGIC);
	END MPlexerNo6;
	ARCHITECTURE FunctUnitLogic6 OF MPlexerNo6 IS
		BEGIN
			WITH s SELECT
				res <= '0' WHEN "000",
						'1' WHEN "001",
						'-' WHEN OTHERS;
	END FunctUnitLogic6;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo7 is 
		PORT (s	: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				opt : OUT STD_LOGIC);
	END MPlexerNo7;
	ARCHITECTURE FunctUnitLogic7 OF MPlexerNo7 IS
		BEGIN
			WITH s SELECT
				opt <= '0' WHEN "010",
						'0' WHEN "011",
						'0' WHEN "000",
						'0' WHEN "111",
						'0' WHEN "101",
						'0' WHEN "110",
						'0' WHEN "001",
						'1' WHEN "100",
						'-' WHEN OTHERS;
	END FunctUnitLogic7;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MPlexerNo8 is 
		GENERIC(n: INTEGER := 16);
		PORT (s	: IN STD_LOGIC;
				ALURes, compRes: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				res : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END MPlexerNo8;
	ARCHITECTURE FunctUnitLogic8 OF MPlexerNo8 IS
		BEGIN
			WITH s SELECT
				res <= ALURes WHEN '0',
						compRes WHEN OTHERS;
	END FunctUnitLogic8;
	
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY MPlexerNo9 is 
		PORT (x : IN STD_LOGIC; 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC);
	END MPlexerNo9;
	ARCHITECTURE FunctUnitLogic9 OF MPlexerNo9 IS
		BEGIN
			WITH s SELECT
				outm <= x WHEN "00",
						NOT x WHEN "01",
						'1' WHEN "10",
						'-' WHEN OTHERS;
	END FunctUnitLogic9;
	
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY MPlexerNo10 is 
		GENERIC(n: INTEGER := 16);
		PORT (regAddress, regAD_MEM, regAD_WB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END MPlexerNo10;
	ARCHITECTURE FunctUnitLogic10 OF MPlexerNo10 IS
		BEGIN
			WITH s SELECT
				outm <= regAddress WHEN "00",
						regAD_MEM WHEN "10",
						regAD_WB WHEN "01",
						"0000000000000000" WHEN OTHERS;
	END FunctUnitLogic10;
	
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY MPlexerNo11 is 
		GENERIC(n: INTEGER := 16);
		PORT (jumpAddress, branchAddress, PCP2AD : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END MPlexerNo11;
	ARCHITECTURE FunctUnitLogic11 OF MPlexerNo11 IS
		BEGIN
			WITH s SELECT
				outm <= PCP2AD WHEN "00",
						branchAddress WHEN "10",
						jumpAddress WHEN "01",
						"0000000000000000" WHEN OTHERS;
	END FunctUnitLogic11;
	
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY MPlexer8To1 is 
		GENERIC(n: INTEGER := 16);
		PORT (x1, x2, x3, x4, x5, x6, x7, x8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END MPlexer8To1;
	ARCHITECTURE FunctUnitLogicMux8To1 OF MPlexer8To1 IS
		BEGIN
			WITH s SELECT
				outm <= x1 WHEN "000",
						x2 WHEN "001",
						x3 WHEN "010",
						x4 WHEN "011",
						x5 WHEN "100",
						x6 WHEN "101",
						x7 WHEN "110",
						x8 WHEN "111",
						"----------------" WHEN OTHERS;
	END FunctUnitLogicMux8To1;
	
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
	ENTITY DCoder3To8 is 
		PORT (s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				outm : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END DCoder3To8;
	ARCHITECTURE FunctUnitLogicDec3To8 OF DCoder3To8 IS
		BEGIN
			WITH s SELECT
				outm <= "00000001" WHEN "000",
						"00000010" WHEN "001",
						"00000100" WHEN "010",
						"00001000" WHEN "011",
						"00010000" WHEN "100",
						"00100000" WHEN "101",
						"01000000" WHEN "110",
						"10000000" WHEN "111",
						"--------" WHEN OTHERS;
	END FunctUnitLogicDec3To8;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY ControlCircuit is 
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				IF_ID_Flush: IN STD_LOGIC;
				outMPFC, outJType, outReadDig, outWriteDig, outRType, outLdWord, outStWord, outBranch, outJReg : OUT STD_LOGIC);
	END ControlCircuit;
	ARCHITECTURE FunctUnitLogicCPanel OF ControlCircuit IS
		BEGIN
			get_result: PROCESS(IF_ID_Flush, Funct, OpCode)
			BEGIN
				IF(IF_ID_Flush = '1') THEN
					outRType <= '0';
					outLdWord <= '0';
					outStWord <= '0';
					outMPFC <= '0';
					outBranch <= '0';
					outReadDig <= '0';
					outWriteDig <= '0';
					outJReg <= '0';
					outJType <= '0';
				ELSIF (IF_ID_Flush = '0') THEN 
					IF(OpCode = "0000") THEN
						outRType <= '1';
						IF(Funct = "111") THEN
							outMPFC <= '1'; --$RD = $PC
						ELSE outMPFC <= '0';
						END IF;
						outLdWord <= '0';
						outStWord <= '0';
						outBranch <= '0';
						outReadDig <= '0';
						outWriteDig <= '0';
						outJReg <= '0';
						outJType <= '0';
					ELSIF(OpCode = "0001") THEN
						outLdWord <= '1';
						outRType <= '0';
						outStWord <= '0';
						outMPFC <= '0';
						outBranch <= '0';
						outReadDig <= '0';
						outWriteDig <= '0';
						outJReg <= '0';
						outJType <= '0';
					ELSIF(OpCode = "0010") THEN
						outStWord <= '1';
						outRType <= '0';
						outLdWord <= '0';
						outMPFC <= '0';
						outBranch <= '0';
						outReadDig <= '0';
						outWriteDig <= '0';
						outJReg <= '0';
						outJType <= '0';
					ELSIF(OpCode = "0100") THEN
						outBranch <= '1';
						outRType <= '0';
						outLdWord <= '0';
						outStWord <= '0';
						outMPFC <= '0';
						outReadDig <= '0';
						outWriteDig <= '0';
						outJReg <= '0';
						outJType <= '0';
					ELSIF(OpCode = "0110") THEN
						outReadDig <= '1';
						outRType <= '0';
						outLdWord <= '0';
						outStWord <= '0';
						outMPFC <= '0';
						outBranch <= '0';
						outWriteDig <= '0';
						outJReg <= '0';
						outJType <= '0';
					ELSIF(OpCode = "0111") THEN
						outWriteDig <= '1';
						outRType <= '0';
						outLdWord <= '0';
						outStWord <= '0';
						outMPFC <= '0';
						outBranch <= '0';
						outReadDig <= '0';
						outJReg <= '0';
						outJType <= '0';
					ELSIF(OpCode = "1101") THEN
						outJReg <= '1';
						outRType <= '0';
						outLdWord <= '0';
						outStWord <= '0';
						outMPFC <= '0';
						outBranch <= '0';
						outReadDig <= '0';
						outWriteDig <= '0';
						outJType <= '0';
					ELSIF(OpCode = "1111") THEN
						outJType <= '1';
						outRType <= '0';
						outLdWord <= '0';
						outStWord <= '0';
						outMPFC <= '0';
						outBranch <= '0';
						outReadDig <= '0';
						outWriteDig <= '0';
						outJReg <= '0';
					END IF;
				END IF;
			END PROCESS;
	END FunctUnitLogicCPanel;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY HazzardDetector is 
		PORT (inJType, inJReg, inNextBranch, inPrevJType: IN STD_LOGIC;
				IF_ID_Flush, outPrevJType : OUT STD_LOGIC;
				reg_outJReg_address: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END HazzardDetector;
	ARCHITECTURE FunctUnitLogicHaz OF HazzardDetector IS
		BEGIN
			PROCESS(inJReg, inJType, inPrevJType, inNextBranch)
			BEGIN 
				IF(inJType = '1') THEN
					IF_ID_Flush <= '1';
					reg_outJReg_address <= "01";
				ELSIF(inNextBranch = '1') THEN
					IF_ID_Flush <= '1';
					reg_outJReg_address <= "10";
				ELSE
					IF (inJReg = '1' OR inPrevJType = '1' ) THEN IF_ID_Flush <= '1';
					ELSE IF_ID_Flush <= '0';
					END IF;
					reg_outJReg_address <= "00";
				END IF;
			END PROCESS;
			outPrevJType <= inJType;
	END FunctUnitLogicHaz;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY DummiesTrapper is 
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				endOfRunning : OUT STD_LOGIC);
	END DummiesTrapper;
	ARCHITECTURE FunctUnitLogicTrap OF DummiesTrapper IS
		BEGIN
			PROCESS(OpCode)
			BEGIN 
				IF(OpCode = "1110") THEN
					endOfRunning <= '1';
				ELSE
					endOfRunning <= '0';
				END IF;
			END PROCESS;
	END FunctUnitLogicTrap;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY ForwarderNo1 is 
		PORT (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END ForwarderNo1;
	ARCHITECTURE FunctUnitLogicFwd OF ForwarderNo1 IS
		BEGIN
			PROCESS(regRD_EX_address, regRD_MEM_address, regRS_address, regRT_address)
			BEGIN
				--FORWARDING DATA TO REGISTER RS
				IF (regRS_address = regRD_EX_address) THEN
					--Hazzard in EX stage:
					-- if (EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 0)	and (EX/MEM.RegisterRd =  ID/EX.RegisterRs))	
					-- ForwardA = 10
					ForwardA <= "10";
				ELSIF (regRS_address = regRD_MEM_address) THEN 
					--Hazzard in MEM stage:
					-- if (MEM/WB.RegWrite and (MEM/WB.RegisterRd ≠ 0)	and (MEM/WB.RegisterRd = ID/EX.RegisterRs))	
					-- ForwardA = 01
					ForwardA <= "01";
				ELSE ForwardA <= "00";
				END IF;
				--FORWARDING DATA TO REGISTER RT
				IF (regRT_address = regRD_EX_address) THEN
					--Hazzard in EX stage:
					-- if (EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 0)	and (EX/MEM.RegisterRd =  ID/EX.RegisterRt))	
					-- ForwardB = 10
					ForwardB <= "10";
				ELSIF (regRT_address = regRD_MEM_address) THEN
					--Hazzard in MEM stage:
					-- if (MEM/WB.RegWrite and (MEM/WB.RegisterRd ≠ 0)	and (MEM/WB.RegisterRd = ID/EX.RegisterRt))	
					-- ForwardB = 01
					ForwardB <= "01";
				ELSE ForwardB <= "00";
				END IF;
			END PROCESS;
	END FunctUnitLogicFwd;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.numeric_std.all;
	ENTITY AdderNo1 is 
		PORT (x1, x2, cin: IN STD_LOGIC;
				out2, cout : OUT STD_LOGIC);
	END AdderNo1;
	ARCHITECTURE FunctUnitLogicAdd OF AdderNo1 IS
		BEGIN
			out2 <= (x1 XOR x2) XOR cin;
			cout <= (x2 AND cin) OR (x1 AND cin) OR (x1 AND x2) ;
	END FunctUnitLogicAdd;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY ComparerNo1 is 
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC;
				out2 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END ComparerNo1;
	ARCHITECTURE FunctUnitLogicComp OF ComparerNo1 IS
		BEGIN
			out2 <= "0000000000000000" WHEN (x1 = '1') ELSE "1000000000000000";
	END FunctUnitLogicComp;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY ReseterNo1 is
		GENERIC(n: INTEGER := 16);
		PORT (out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END ReseterNo1;
	ARCHITECTURE FunctUnitLogicRes OF ReseterNo1 IS
		BEGIN
			out2 <= (OTHERS => '0');
	END FunctUnitLogicRes;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY SignExtenderNo1 is
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			 out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END SignExtenderNo1;
	ARCHITECTURE FunctUnitLogicExt OF SignExtenderNo1 IS
		BEGIN
			out2 <= (n-1 DOWNTO 6 => x1(5)) & (x1); --SIGNAL CONCATENATION
	END FunctUnitLogicExt;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
	ENTITY UnconditionalBranchTargetFinder is
		GENERIC(n: INTEGER := 16);
		PORT (x1: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
				instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 EjumpAD: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END UnconditionalBranchTargetFinder;
	ARCHITECTURE FunctUnitLogicBUnc OF UnconditionalBranchTargetFinder IS
		SIGNAL SigExtOffset, MultSigExtOffset: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		BEGIN
			SigExtOffset <= (n-1 DOWNTO 12 => x1(11)) & (x1); --SIGNAL CONCATENATION
			PROCESS (instrP2AD)
			BEGIN
				MultSigExtOffset <= SigExtOffset(n-2 DOWNTO 0) & '0'; --14 MSBs CONCATENATION
				EjumpAD <= STD_LOGIC_VECTOR(UNSIGNED(MultSigExtOffset) + UNSIGNED(instrP2AD));
			END PROCESS;
	END FunctUnitLogicBUnc;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
	ENTITY PipelineRegisterNo1 is
		GENERIC(n: INTEGER := 16);
		PORT (clk, IF_Flush, IF_ID_Enable: IN STD_LOGIC;
				PCin, command: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				PCout, commandout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END PipelineRegisterNo1;
	ARCHITECTURE FunctUnitLogicPR1 OF PipelineRegisterNo1 IS
		BEGIN
			PCupdate: PROCESS (clk)
			BEGIN
				IF (IF_ID_Enable = '1' AND clk = '1') THEN --ALL UPDATES PERFORM IN CLK RISING EDGE
					PCout <= STD_LOGIC_VECTOR(SIGNED(PCin) + 2);
					commandout <= command;
				ELSIF (IF_Flush = '1' AND clk = '1') THEN --DATA, LOAD-USE, CONTROL HAZZARD REDEMPTION
					commandout <= (OTHERS => '0'); --NO OPERATION
					PCout <= (OTHERS => '0');
				END IF;
			END PROCESS;
	END FunctUnitLogicPR1;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
	ENTITY PipelineRegisterNo2 is
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
	END PipelineRegisterNo2;
	ARCHITECTURE FunctUnitLogicPR2 OF PipelineRegisterNo2 IS
		BEGIN
			DATAupdate: PROCESS (clk)
			BEGIN
				IF (clk = '1') THEN --ALL UPDATES PERFORM IN CLK RISING EDGE
					isEOR_IDEX <= isEOR;
					wasJumpOut_IDEX <= wasJumpOut;
					isJump_IDEX <= isJump;
					isJR_IDEX <= isJR;
					isBranch_IDEX <= isBranch;
					isR_IDEX <= isR;
					isMFPC_IDEX <= isMFPC;
					isLW_IDEX <= isLW;
					isSW_IDEX <= isSW;
					isReadDigit_IDEX <= isReadDigit;
					isWriteDigit_IDEX <= isWriteDigit;
					ALUFunc_IDEX <= ALUFunc;
					R1Reg_IDEX <= R1Reg;
					R2Reg_IDEX <= R2Reg;
					immediate16_IDEX <= immediate16;
					R2AD_IDEX <= R2AD;
					R1AD_IDEX <= R1AD;
					jumpShortAddr_IDEX <= jumpShortAddr;
				END IF;
			END PROCESS;
	END FunctUnitLogicPR2;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
	ENTITY PipelineRegisterNo3 is
		GENERIC(n: INTEGER := 16);
		PORT (clk, isLW, WriteEnable, ReadDigit, WriteDigit : IN STD_LOGIC;
				R2Reg, Result : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, WriteDigit_EXMEM : OUT STD_LOGIC;
				R2Reg_EXMEM, Result_EXMEM : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD_EXMEM : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
	END PipelineRegisterNo3;
	ARCHITECTURE FunctUnitLogicPR3 OF PipelineRegisterNo3 IS
		BEGIN
			DATAupdate: PROCESS (clk)
			BEGIN
				IF (clk = '1') THEN --ALL UPDATES PERFORM IN CLK RISING EDGE
					isLW_EXMEM <= isLW;
					WriteEnable_EXMEM <= WriteEnable;
					ReadDigit_EXMEM <= ReadDigit;
					WriteDigit_EXMEM <= WriteDigit;
					R2Reg_EXMEM <= R2Reg;
					Result_EXMEM <= Result;
					RegAD_EXMEM <= RegAD;
				END IF;
			END PROCESS;
	END FunctUnitLogicPR3;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
	ENTITY PipelineRegisterNo4 is
		GENERIC(n: INTEGER := 16);
		PORT (clk: IN STD_LOGIC;
				regaddress: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				res: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				regaddressout: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
				out2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END PipelineRegisterNo4;
	ARCHITECTURE FunctUnitLogicPR4 OF PipelineRegisterNo4 IS
		BEGIN
			PCupdate: PROCESS (clk)
			BEGIN
				IF (clk = '1') THEN --ALL UPDATES PERFORM IN CLK RISING EDGE
					out2 <= res;
					regaddressout <= regaddress;
				END IF;
			END PROCESS;
	END FunctUnitLogicPR4;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MYAND2 is 
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END MYAND2;
	ARCHITECTURE FunctUnitLogicAnd2 OF MYAND2 IS
		BEGIN
			compOut <= x1 AND x2;
	END FunctUnitLogicAnd2;
	
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MYOR2 is 
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END MYOR2;
	ARCHITECTURE FunctUnitLogicOr2 OF MYOR2 IS
		BEGIN
			compOut <= x1 OR x2;
	END FunctUnitLogicOr2;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MYXOR2 is 
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END MYXOR2;
	ARCHITECTURE FunctUnitLogicXor2 OF MYXOR2 IS
		BEGIN
			compOut <= x1 XOR x2;
	END FunctUnitLogicXor2;
	
	LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MYNAND2 is 
		PORT ( x1, x2: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END MYNAND2;
	ARCHITECTURE FunctUnitLogicNand2 OF MYNAND2 IS
		BEGIN
			compOut <= NOT(x1 AND x2);
	END FunctUnitLogicNand2;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
	ENTITY MYNOT1 is 
		PORT ( x1: IN STD_LOGIC;
				 compOut: OUT STD_LOGIC);
	END MYNOT1;
	ARCHITECTURE FunctUnitLogicNot1 OF MYNOT1 IS
		BEGIN
			compOut <= NOT x1;
	END FunctUnitLogicNot1;