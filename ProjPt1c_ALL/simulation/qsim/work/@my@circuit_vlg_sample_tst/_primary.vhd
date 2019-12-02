library verilog;
use verilog.vl_types.all;
entity MyCircuit_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        clock2          : in     vl_logic;
        fromData        : in     vl_logic_vector(15 downto 0);
        instr           : in     vl_logic_vector(15 downto 0);
        keyData         : in     vl_logic_vector(15 downto 0);
        sampler_tx      : out    vl_logic
    );
end MyCircuit_vlg_sample_tst;
