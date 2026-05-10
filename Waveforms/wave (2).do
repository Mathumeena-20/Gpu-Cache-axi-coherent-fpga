onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_directory_controller/clk
add wave -noupdate /tb_directory_controller/rst
add wave -noupdate /tb_directory_controller/req_valid
add wave -noupdate /tb_directory_controller/req_addr
add wave -noupdate /tb_directory_controller/req_type
add wave -noupdate /tb_directory_controller/req_core
add wave -noupdate /tb_directory_controller/grant
add wave -noupdate /tb_directory_controller/send_invalidate
add wave -noupdate /tb_directory_controller/invalidate_vector
add wave -noupdate /tb_directory_controller/read_count
add wave -noupdate /tb_directory_controller/write_count
add wave -noupdate /tb_directory_controller/core0_count
add wave -noupdate /tb_directory_controller/core1_count
add wave -noupdate /tb_directory_controller/invalidate_count
add wave -noupdate /tb_directory_controller/dut/clk
add wave -noupdate /tb_directory_controller/dut/rst
add wave -noupdate /tb_directory_controller/dut/req_valid
add wave -noupdate /tb_directory_controller/dut/req_addr
add wave -noupdate /tb_directory_controller/dut/req_type
add wave -noupdate /tb_directory_controller/dut/req_core
add wave -noupdate /tb_directory_controller/dut/grant
add wave -noupdate /tb_directory_controller/dut/send_invalidate
add wave -noupdate /tb_directory_controller/dut/invalidate_vector
add wave -noupdate /tb_directory_controller/dut/index
add wave -noupdate /tb_directory_controller/dut/i
add wave -noupdate /tb_directory_controller/sva/clk
add wave -noupdate /tb_directory_controller/sva/rst
add wave -noupdate /tb_directory_controller/sva/req_valid
add wave -noupdate /tb_directory_controller/sva/req_type
add wave -noupdate /tb_directory_controller/sva/send_invalidate
add wave -noupdate /tb_directory_controller/sva/invalidate_vector
add wave -noupdate /tb_directory_controller/sva/state
add wave -noupdate /tb_directory_controller/sva/sharers
add wave -noupdate /tb_directory_controller/dut/clk
add wave -noupdate /tb_directory_controller/dut/rst
add wave -noupdate /tb_directory_controller/dut/req_valid
add wave -noupdate /tb_directory_controller/dut/req_addr
add wave -noupdate /tb_directory_controller/dut/req_type
add wave -noupdate /tb_directory_controller/dut/req_core
add wave -noupdate /tb_directory_controller/dut/grant
add wave -noupdate /tb_directory_controller/dut/send_invalidate
add wave -noupdate /tb_directory_controller/dut/invalidate_vector
add wave -noupdate /tb_directory_controller/dut/index
add wave -noupdate /tb_directory_controller/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {152250 ps}
