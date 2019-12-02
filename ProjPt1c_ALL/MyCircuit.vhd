LIBRARY IEEE, my_func;
USE IEEE.std_logic_1164.all;
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_textio.all;
USE work.basic_func3.all;
USE work.ALU1bit.all;
USE work.DFF1bit.all;
USE work.ALU_16bit.all;
USE work.DFF_16bit.all;
USE work.REG0_16bit.all;
USE work.MUX_8To1.all;
USE work.DEC_3To8.all;
USE work.Sign_Extender.all;
USE work.UNIT_Forwarding.all;
USE work.MUX_ALUin.all;
USE work.ALU_ControlCircuit.all;
USE work.UNIT_Hazards.all;
USE work.UNIT_Traps.all;
USE work.UNC_Branch.all;
USE work.REG_IFID.all;
USE work.REG_IDEX.all;
USE work.REG_EXMEM.all;
USE work.REG_MEMWB.all;
USE work.REG_FILE.all;
USE work.MUX_JRopt.all;

--MyCircuit.vhd
--This package implements a limited operation simple processor; using all of the previous components.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)
ENTITY MyCircuit IS 
		GENERIC(n: INTEGER := 16);
		port(
			clock: in std_logic;
			clock2: in std_logic;
			-------------------------------------------------------
			-- Registers Out
			-------------------------------------------------------
			regOUT: out std_logic_vector(127+n downto 0); -- pros othoni (REGs + PC)
			-------------------------------------------------------
			-- Stage Write Out
			-------------------------------------------------------
			Result: out std_logic_vector(n-1 downto 0);
			-------------------------------------------------------
			-- Instruction Memory
			-------------------------------------------------------
			instructionAD : out std_logic_vector(n-1 downto 0);
			instr: in std_logic_vector(n-1 downto 0):= x"0000";
			-------------------------------------------------------
			-- Data Memory
			-------------------------------------------------------
			dataAD: out std_logic_vector(n-1 downto 0);
			fromData: in std_logic_vector(n-1 downto 0):= x"0000";
			toData: out std_logic_vector(n-1 downto 0);
			DataWriteFlag: out std_logic;
			-------------------------------------------------------
			-- Keyboard
			-------------------------------------------------------
			keyEnable : out std_logic;
			keyData   : in std_logic_vector(n-1 downto 0);
			-------------------------------------------------------
			-- Display Out
			-------------------------------------------------------
			printEnable: out std_logic;
			printCode  : out std_logic_vector(n-1 downto 0):= x"0000";
			printData  : out std_logic_vector(n-1 downto 0):= x"0000"
			);
END MyCircuit;

ARCHITECTURE StructuralArchUnit OF MyCircuit IS
	
	--declaration of components used to implement processor
	COMPONENT regFile
		GENERIC (n : INTEGER := 16);
		PORT (Clock: IN STD_LOGIC;
				Write1: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Write1AD, Read1AD, Read2AD: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Read1, Read2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Output: OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ALU
		GENERIC(n: INTEGER := 16);
		PORT (A, B: IN std_LOGIC_VECTOR(n-1 DOWNTO 0);
			opcode: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0) ;
			Result: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Overflow: OUT STD_LOGIC);
		END COMPONENT;
		
	COMPONENT decode3to8
		PORT (Input: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT reg
		GENERIC(n: INTEGER := 16);
		PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Enable, Clock: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT reg0
		GENERIC(n: INTEGER := 16);
		PORT (Input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Enable, Clock: IN STD_LOGIC;
			Output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT mux8
		GENERIC(n: INTEGER := 16);
		PORT (Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				Choice : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT reg_IF_ID
		GENERIC (n : INTEGER := 16);
		PORT (PCin, Command: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				Clock, IF_Flush, IF_ID_Enable: IN STD_LOGIC;
				PCout, Commandout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
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
		
	COMPONENT reg_EX_MEM
		GENERIC (n : INTEGER := 16);
		PORT (Clock, isLW, WriteEnable, ReadDigit, WriteDigit : IN STD_LOGIC;
				R2Reg, Result : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM : OUT STD_LOGIC;
				R2Reg_EXMEM, Result_EXMEM : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				RegAD_EXMEM : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT reg_MEM_WB
		GENERIC (n : INTEGER := 16);
		PORT (Result: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				regAddress: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				Clock: IN STD_LOGIC;
				writeData: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				writeAddress: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT signExtender
		GENERIC(n: INTEGER := 16);
		PORT (immediate: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
				extended: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT jumpAD
	GENERIC(n: INTEGER := 16);
	PORT (jumpADR: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
				instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 EjumpAD: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
		END COMPONENT;
		
	COMPONENT trapUnit
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				endOfRunning : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT control
		PORT (OpCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				IF_ID_Flush: IN STD_LOGIC;
				isMPFC, isJType, isReadDig, isWriteDig, idRType, isLdWord, isStWord, isBranch, isJReg : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT forwarder
		PORT (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
					ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT hazardUnit
		PORT (isJR, isJump, wasJump, shouldBranch: IN STD_LOGIC;
				IF_ID_Flush, wasJumpOut: OUT STD_LOGIC;
				JROpCode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT selector
		GENERIC(n: INTEGER := 16);
		PORT (regAddress, regAD_MEM, regAD_WB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				operation : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT JRSelector 
		GENERIC(n: INTEGER := 16);
		PORT (jumpAD, branchAd,PCP2AD: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				JROpCode: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				Result: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
		
		--declaration of signals used to interconnect gates
		signal PCresult: STD_LOGIC_VECTOR(15 DOWNTO 0):= x"0000";
		signal outIFID_PC, outIFID_Instr, JROutput, immediate16, immediate16_IDEX,  
				  Jump_AD, writeData, Result_MEMWB, R1Reg, R2Reg, R1Reg_IDEX, R2Reg_IDEX, 
				  R2Reg_EXMEM, S1Output, S2Output : STD_LOGIC_VECTOR(15 DOWNTO 0);
		signal JRopcode, S1opcode, S2opcode : STD_LOGIC_VECTOR(1 DOWNTO 0):="00";

		signal isEOR_IDEX : STD_LOGIC:='0';

		signal writeAD, RegAD_EXMEM : STD_LOGIC_VECTOR (2 downto 0);

		signal wasJump : STD_LOGIC;
		signal Flush_hazard, wasJumpOut, isEOR  : STD_LOGIC;

		signal IF_Flush							:STD_LOGIC:='0';
		signal IF_Enable						:STD_LOGIC:='1';

		signal opcode							:STD_LOGIC_VECTOR(3 DOWNTO 0):= outIFID_Instr(15 DOWNTO 12);
		signal RD								:STD_LOGIC_VECTOR(2 DOWNTO 0):= outIFID_Instr(11 DOWNTO 9);
		signal R1AD								:STD_LOGIC_VECTOR(2 DOWNTO 0):= outIFID_Instr(8 DOWNTO 6);
		signal RT								:STD_LOGIC_VECTOR(2 DOWNTO 0):= outIFID_Instr(5 DOWNTO 3);
		signal func								:STD_LOGIC_VECTOR(2 DOWNTO 0):= outIFID_Instr(2 DOWNTO 0);
		signal immediate						:STD_LOGIC_VECTOR(5 DOWNTO 0):= outIFID_Instr(5 DOWNTO 0);
		signal jumpShortAddr					:STD_LOGIC_VECTOR(11 DOWNTO 0):= outIFID_Instr(11 DOWNTO 0);

		signal jumpShortAddr_IDEX				:STD_LOGIC_VECTOR(11 DOWNTO 0);

		signal R2AD, R2AD_IDEX, R1AD_IDEX   	:STD_LOGIC_VECTOR(2 DOWNTO 0); --:= outInstr(5 DOWNTO 3);

		signal ALUFunc, ALUFunc_IDEX			:STD_LOGIC_VECTOR(2 DOWNTO 0);
		signal allRegOut						:STD_LOGIC_VECTOR(127 DOWNTO 0);

		--------------------- CONTROLLER SIGNALS ----------------------
		signal isMFPC, isJump, isReadDigit, isPrintDigit, isR, isLW, isSW, isLW_IDEX, 
				 isSW_IDEX, isBranch, isJR, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX,isBranch_IDEX,
				 isR_IDEX, isMFPC_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX,
				 isLW_EXMEM, ReadDigit_EXMEM :STD_LOGIC;

		--------------------- ALU SIGNALS ----------------------
		signal ALUInput1, ALUInput2, ALUOutput, Result_EXMEM : STD_LOGIC_VECTOR(15 DOWNTO 0);
		signal ALUCarryin, ALUCarryout : STD_LOGIC;
		signal ALUOperation : STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		BEGIN
		PC: reg port map(JROutput, isEOR NOR isEOR_IDEX, clock, PCresult);
		IFIDREG: reg_IF_ID PORT map(PCresult, instr, clock, IF_Flush, IF_Enable, outIFID_PC,
                                  outIFID_Instr);
		SignExtend: signExtender port map(immediate, immediate16);
		JR: JRSelector port map(Jump_AD, immediate16_IDEX, outIFID_PC, JRopcode, JROutput);
		Hazard: hazardUnit port map(isJR, isJump, wasJump, isBranch_IDEX AND ALUCarryout, Flush_hazard,
									  wasJumpOut, JRopcode);
		Trap: trapUnit port map(opcode, isEOR);
		--ALUController embedded in ALU unified circuit.
		Controler: control port map(opcode, func, Flush_hazard OR isEOR_IDEX,
			isMFPC, isJump, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR);
			
		selectRegister : process(isR) begin
			case isR is
				when '1'  =>
					R2AD <= RT;
				when '0'  => 
					R2AD <= RD;
				when others => 
					R2AD <= RD;
			end case;
		end process;

		RegisterFile: regFile port map(clock2, writeData, writeAD, R1AD, R2AD, R1Reg, R2Reg, allRegOut);

		IDEXREG: reg_ID_EX port map(clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR,
				  isMFPC, isLW, isSW, isReadDigit, isPrintDigit, func, R1Reg , R2Reg , immediate16,
				  R2AD, R1AD, jumpShortAddr, isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, 
				  isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX,	isSW_IDEX, isReadDigit_IDEX, 
				  isPrintDigit_IDEX, ALUFunc_IDEX, R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX, 
					R2AD_IDEX , R1AD_IDEX, jumpShortAddr_IDEX);
																	
		Selector1: selector port map(R1Reg_IDEX, Result_MEMWB, writeData, S1opcode, S1Output);
		Selector2: selector port map(R2Reg_IDEX, Result_MEMWB, writeData, S2opcode, S2Output);

		ForwardUnit: forwarder port map(R1AD_IDEX, R2AD_IDEX, RegAD_EXMEM, writeAD, S1opcode, S2opcode);

		-- ALUSrc, EX_MEM_regwrite, MEM_WB_regwrite : IN STD_LOGIC;

		ALUMuxes : process(isMFPC_IDEX, isR_IDEX) begin
			IF (isMFPC_IDEX = '1') then
				ALUInput1 <= S1Output;
			ELSE 
				ALUInput1 <= outIFID_PC;
			END IF;
			IF (isR_IDEX = '1') then
				ALUInput2 <= immediate16_IDEX;
			ELSE 
				ALUInput2 <= S2Output;
			END IF;
		end process;

		ALU16: ALU port map(ALUInput1, ALUInput2, ALUFunc_IDEX, ALUOutput, ALUCarryout); --ALUCarryin automatically detected and set.

		EXMEMREG: reg_EX_MEM port map(clock, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, 
							isPrintDigit_IDEX, R2Reg_IDEX, ALUOutput, R2AD_IDEX,
							isLW_EXMEM, DataWriteFlag, ReadDigit_EXMEM, printEnable,
							R2Reg_EXMEM, Result_EXMEM, RegAD_EXMEM);

		selectMEMWBResult : process(isLW_EXMEM, ReadDigit_EXMEM) begin
			IF (isLW_EXMEM = '1') then
				Result_MEMWB <= fromData;
			ELSIF (ReadDigit_EXMEM = '1') then
				Result_MEMWB <= keyData;
			ELSE 
				Result_MEMWB <= Result_EXMEM;
			END IF;
		end process;

		MEMWBREG: reg_MEM_WB port map(Result_MEMWB, RegAD_EXMEM, clock, writeData, writeAD);

		--- behavioral signals ---
		printData <= Result_EXMEM;
		toData <= Result_EXMEM;
		printCode <= R2Reg_EXMEM;
		keyEnable <= ReadDigit_EXMEM;
		dataAD <= R2Reg_EXMEM;
		Jump_AD <= (15 downto 12 => jumpShortAddr_IDEX(11)) & (jumpShortAddr_IDEX); --extend jumpShortAddr_IDEX to 16 bits
		instructionAD <= PCresult;
		RegOut <=  PCresult & allRegOut;
		Result <= writeData;
		
	END StructuralArchUnit;