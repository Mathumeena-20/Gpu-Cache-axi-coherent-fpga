# ==========================================
# Clock Definition
# ==========================================

create_clock \
    -name core_clk \
    -period 2.0 \
    [get_ports clk]

# ==========================================
# Clock Uncertainty
# ==========================================

set_clock_uncertainty 0.1 \
    [get_clocks core_clk]

# ==========================================
# Input Delays
# ==========================================

set_input_delay 0.2 \
    -clock core_clk \
    [all_inputs]

# ==========================================
# Output Delays
# ==========================================

set_output_delay 0.2 \
    -clock core_clk \
    [all_outputs]

# ==========================================
# Driving Cell
# ==========================================

set_driving_cell \
    -lib_cell INVX1 \
    [all_inputs]

# ==========================================
# Output Load
# ==========================================

set_load 0.05 \
    [all_outputs]

# ==========================================
# False Paths
# ==========================================

set_false_path \
    -from [get_ports rst]

# ==========================================
# Max Fanout
# ==========================================

set_max_fanout 16 \
    [current_design]

# ==========================================
# Max Transition
# ==========================================

set_max_transition 0.2 \
    [current_design]