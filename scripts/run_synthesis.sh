#!/bin/bash

echo "======================================="
echo "Running Synthesis"
echo "======================================="

yosys <<EOF

read_verilog ../rtl/common/*.sv
read_verilog ../rtl/core/*.sv
read_verilog ../rtl/pipeline/*.sv

read_verilog ../rtl/l1_cache/*.sv
read_verilog ../rtl/l2_cache/*.sv

read_verilog ../rtl/coherency/*.sv

read_verilog ../rtl/interconnect/*.sv
read_verilog ../rtl/axi/*.sv

read_verilog ../rtl/prefetch/*.sv
read_verilog ../rtl/memory/*.sv

read_verilog ../rtl/top/*.sv

hierarchy -top gpu_cache_system_top

proc
opt
fsm
memory
opt

stat

write_verilog synthesized_netlist.v

EOF

echo "======================================="
echo "Synthesis Complete"
echo "======================================="