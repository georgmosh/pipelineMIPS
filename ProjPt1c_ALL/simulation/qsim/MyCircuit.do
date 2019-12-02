onerror {quit -f}
vlib work
vlog -work work MyCircuit.vo
vlog -work work MyCircuit.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.MyCircuit_vlg_vec_tst
vcd file -direction MyCircuit.msim.vcd
vcd add -internal MyCircuit_vlg_vec_tst/*
vcd add -internal MyCircuit_vlg_vec_tst/i1/*
add wave /*
run -all
