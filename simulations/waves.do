# ==========================================
# Add Top Signals
# ==========================================

add wave -divider "TOP"

add wave sim:/tb_multi_core_gpu/*

# ==========================================
# Add Cache Signals
# ==========================================

add wave -divider "L1_CACHE"

add wave sim:/tb_multi_core_gpu/dut/*

# ==========================================
# Add AXI Signals
# ==========================================

add wave -divider "AXI"

add wave sim:/tb_multi_core_gpu/dut/arvalid
add wave sim:/tb_multi_core_gpu/dut/araddr

# ==========================================
# Add Coherency Signals
# ==========================================

add wave -divider "COHERENCY"

add wave sim:/tb_multi_core_gpu/dut/grant

# ==========================================
# Configure View
# ==========================================

configure wave -timelineunits ns

wave zoom full