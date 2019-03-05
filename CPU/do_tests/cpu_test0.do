--TEST 0--

onerror {resume}
quietly WaveActivateNextPane {} 0
---------------------------------------------------------------------
-- Use this file to test your CPU. In order to use this, you will
-- need to create a new component "cpu_tb" in which you instantiate
-- your CPU component, and also the provided memory component in COELib.
-- Add a dummy signal with your team name in this new component, so
-- that we can see the owner of the waveform, on the waveform.
---------------------------------------------------------------------
add wave -noupdate /cpu_tb/NICHOLAS_SCHROEDER
add wave -noupdate /cpu_tb/clock
add wave -noupdate /cpu_tb/reset
add wave -noupdate -divider {Data Memory Interface}
add wave -noupdate -radix hexadecimal /cpu_tb/MemoryAddress
add wave -noupdate -radix hexadecimal /cpu_tb/dataOut
add wave -noupdate -radix hexadecimal /cpu_tb/MemoryDataOut
add wave -noupdate -radix hexadecimal /cpu_tb/MemWrite
--add wave -noupdate /cpu_tb/memread
add wave -noupdate /cpu_tb/memwrite
add wave -noupdate /cpu_tb/memwait
add wave -noupdate -divider {Memory}
add wave -noupdate -radix hexadecimal -expand -subitemconfig {/cpu_tb/u_1/mw_u_0ram_table(7) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(6) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(5) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(4) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(3) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(2) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(1) {-radix hexadecimal} /cpu_tb/u_1/mw_u_0ram_table(0) {-radix hexadecimal}} /cpu_tb/u_1/mw_u_0ram_table
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {389 ns} 0}
configure wave -namecolwidth 268
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

restart -f
force reset 1
force -freeze clock 1 0, 0 {50 ns} -r 100
---------------------------------------------------------------------
-- Here we initialize instructions in the combined memory
-- Each appearance of u_1 refers to the name of the specific
-- instance of the COE1502_Memory component used in the top-level
-- design. Your instance may have a different label (e.g. u_0)
-- If so, replace each u_1 label with the appropriate label
-- for the instance in your design.
-- MODIFY the data in quotes to the assembled programs you want to run.
---------------------------------------------------------------------
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00EB5824"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"ACEB000F"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000"
-- This is the data memory (addresses 8 - 15).

--Use force -freeze prevents a signal from changing until it is forced again or
--explicitly unforced with noforce

--force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(8) X"AAAAAAAA"

run 100 ns
force reset 0
run 2500ns

update
WaveRestoreZoom {103 ns} {1258 ns}