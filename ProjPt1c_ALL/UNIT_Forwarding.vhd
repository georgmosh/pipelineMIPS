--UNIT_Forwarding.vhd
--This package implements a pipeline forwarding unit; using the behavioral forwarder.
--Single structural operations are being implemented exploiting the logic from basic_func3.vhd
--All of the implemented operations in this file are styled in structural architecture.
--Authors: Georgios M. Moschovis (p3150113@aueb.gr)
--         Dimitrios Vetsis (p3120019@aueb.gr)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

PACKAGE UNIT_Forwarding is

	COMPONENT forwarder
		PORT (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
					ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
		
END PACKAGE UNIT_Forwarding;

--package body declarations
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--package body
ENTITY forwarder IS 
	PORT (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END forwarder;

ARCHITECTURE StructuralArchUnit OF forwarder IS
	COMPONENT ForwarderNo1
		PORT (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
	END COMPONENT;
	
	BEGIN
		    	--Component instantiations statements
		U0: ForwarderNo1 PORT MAP(regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address, ForwardA, ForwardB);
END StructuralArchUnit;