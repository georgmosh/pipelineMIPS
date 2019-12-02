library verilog;
use verilog.vl_types.all;
entity MyCircuit_vlg_check_tst is
    port(
        dataAD          : in     vl_logic_vector(15 downto 0);
        DataWriteFlag   : in     vl_logic;
        instructionAD   : in     vl_logic_vector(15 downto 0);
        keyEnable       : in     vl_logic;
        printCode       : in     vl_logic_vector(15 downto 0);
        printData       : in     vl_logic_vector(15 downto 0);
        printEnable     : in     vl_logic;
        regOUT          : in     vl_logic_vector(143 downto 0);
        Result          : in     vl_logic_vector(15 downto 0);
        toData          : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end MyCircuit_vlg_check_tst;
