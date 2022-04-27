onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group all /aes_core_gen_tb/dut/start
add wave -noupdate -group all /aes_core_gen_tb/dut/clk
add wave -noupdate -group all /aes_core_gen_tb/dut/reset
add wave -noupdate -group all /aes_core_gen_tb/dut/enc_dec
add wave -noupdate -group all /aes_core_gen_tb/dut/mode
add wave -noupdate -group all /aes_core_gen_tb/dut/key
add wave -noupdate -group all /aes_core_gen_tb/dut/data_in
add wave -noupdate -group all /aes_core_gen_tb/dut/data_out
add wave -noupdate -group all /aes_core_gen_tb/dut/done
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/mode
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/start
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/clk
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/reset
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/round_key
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/data_in
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/data_out
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/done
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/round_key_out
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/round_key_reg
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/round_data_reg
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/round_data_out
add wave -noupdate -group all /aes_core_gen_tb/dut/enc/valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {179 ns} {254 ns}
