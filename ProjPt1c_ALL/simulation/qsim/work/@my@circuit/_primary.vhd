library verilog;
use verilog.vl_types.all;
entity MyCircuit is
    port(
        clock           : in     vl_logic;
        clock2          : in     vl_logic;
        regOUT          : out    vl_logic_vector(143 downto 0);
        Result          : out    vl_logic_vector(15 downto 0);
        instructionAD   : out    vl_logic_vector(15 downto 0);
        instr           : in     vl_logic_vector(15 downto 0);
        dataAD          : out    vl_logic_vector(15 downto 0);
        fromData        : in     vl_logic_vector(15 downto 0);
        toData          : out    vl_logic_vector(15 downto 0);
        DataWriteFlag   : out    vl_logic;
        keyEnable       : out    vl_logic;
        keyData         : in     vl_logic_vector(15 downto 0);
        printEnable     : out    vl_logic;
        printCode       : out    vl_logic_vector(15 downto 0);
        printData       : out    vl_logic_vector(15 downto 0)
    );
end MyCircuit;
