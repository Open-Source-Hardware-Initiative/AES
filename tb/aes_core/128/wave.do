onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/round
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/mode
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/width_sel
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/round_key
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/data_in
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/data_out
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/accumulation_out
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/sbox_out
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/shiftRow_out
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/mixCol_out
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/sbox_in
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/ark_in_256
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/ark_in_128
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/ark_in_192
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/ark_in_mode
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/ark_in
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/AES_128_MODE
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/AES_192_MODE
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/AES_256_MODE
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/r0_flag
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/r14_flag
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/r10_flag
add wave -noupdate -expand -group rounddata /aes_core_gen_tb/dut/enc_data/r12_flag
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/round_complete
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/mode
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/clk
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/reset
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/start
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/enc_dec
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/roundAmount
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/round
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/dec_key_schedule_round
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/enc_dec_reg
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/dec_key_gen
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/radix_width_sel
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/done
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/CURRENT_STATE
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/NEXT_STATE
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/start_prev
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/mode_reg
add wave -noupdate -expand -group fsm /aes_core_gen_tb/dut/fsm/dec_key_schedule_round_next
add wave -noupdate -expand -group accumulation_reg /aes_core_gen_tb/dut/enc_data/stageon_accum/in
add wave -noupdate -expand -group accumulation_reg /aes_core_gen_tb/dut/enc_data/stageon_accum/clk
add wave -noupdate -expand -group accumulation_reg /aes_core_gen_tb/dut/enc_data/stageon_accum/enable
add wave -noupdate -expand -group accumulation_reg /aes_core_gen_tb/dut/enc_data/stageon_accum/out
add wave -noupdate -expand -group accumulation_reg /aes_core_gen_tb/dut/enc_data/stageon_accum/out_prev
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/round
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/mode
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/round_key
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/data_in
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/clk
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/width_sel
add wave -noupdate -expand -group dec_data /aes_core_gen_tb/dut/dec_data/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {560 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 302
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
WaveRestoreZoom {493 ns} {608 ns}
