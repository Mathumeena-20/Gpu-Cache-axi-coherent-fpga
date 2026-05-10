# ==========================================
# Source Setup
# ==========================================

source dc_setup.tcl

# ==========================================
# Analyze RTL
# ==========================================

analyze -format sverilog ../rtl/common/*.sv
analyze -format sverilog ../rtl/core/*.sv
analyze -format sverilog ../rtl/pipeline/*.sv

analyze -format sverilog ../rtl/l1_cache/*.sv
analyze -format sverilog ../rtl/l2_cache/*.sv

analyze -format sverilog ../rtl/coherency/*.sv

analyze -format sverilog ../rtl/interconnect/*.sv
analyze -format sverilog ../rtl/axi/*.sv

analyze -format sverilog ../rtl/prefetch/*.sv
analyze -format sverilog ../rtl/memory/*.sv

analyze -format sverilog ../rtl/top/*.sv

# ==========================================
# Elaborate
# ==========================================

elaborate $TOP

current_design $TOP

link

# ==========================================
# Read Constraints
# ==========================================

read_sdc constraints.sdc

# ==========================================
# Check Design
# ==========================================

check_design

# ==========================================
# Compile
# ==========================================

compile_ultra

# ==========================================
# Reports
# ==========================================

report_timing \
    > reports/timing.rpt

report_area \
    > reports/area.rpt

report_power \
    > reports/power.rpt

report_qor \
    > reports/qor.rpt

# ==========================================
# Write Netlist
# ==========================================

write -format verilog \
      -hierarchy \
      -output netlist/gpu_cache_system_top.v

# ==========================================
# Write DDC
# ==========================================

write -format ddc \
      -hierarchy \
      -output netlist/gpu_cache_system_top.ddc

# ==========================================
# Exit
# ==========================================

quit