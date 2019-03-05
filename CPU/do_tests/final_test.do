--(CLO FILE)
onerror {resume}
quietly WaveActivateNextPane {} 0
--CHANGE TO FIT YOUR TEAM NAME
add wave -noupdate /cpu_tb/nick_schroeder
add wave -noupdate /cpu_tb/clock
add wave -noupdate /cpu_tb/reset
add wave -noupdate -divider {Memory Interface}
add wave -noupdate -radix hexadecimal /cpu_tb/mem_addr
add wave -noupdate -radix hexadecimal /cpu_tb/data_out
add wave -noupdate -radix hexadecimal /cpu_tb/mem_data_out
add wave -noupdate -radix hexadecimal /cpu_tb/mem_write
add wave -noupdate -radix hexadecimal -expand -subitemconfig {/cpu_tb/mem_0/mw_u_0ram_table(7) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(6) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(5) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(4) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(3) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(2) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(1) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(0) {-radix hexadecimal}} /cpu_tb/mem_0/mw_u_0ram_table
add wave -noupdate -divider {Data Memory}
--add wave -noupdate -radix hexadecimal -expand -subitemconfig {/cpu_tb/mem_0/mw_u_0ram_table(8) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(9) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(10) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(11) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(12) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(13) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(14) {-radix hexadecimal} /cpu_tb/mem_0/mw_u_0ram_table(15) {-radix hexadecimal}} /cpu_tb/mem_0/mw_u_0ram_table
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
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00EB5824"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"ACEB000F"        
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000" 

run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test0.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00EB5822"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"aceb000f"        
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000" 

run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test1.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00EB5821"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"ACEB000F"        
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000" 
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test2.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00075843"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"ACEB000F"        
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000" 
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test3.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00E75804"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"ACEB000F"        
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000" 
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test4.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"28EB003F"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"ACEB000F"        
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000" 
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test5.ps"


restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"15670003"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"20010002"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"20010001" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"ACE1000F"        
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test6.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"3C011001"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"342D0020"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"3C010123"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"34294567"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"ADA90000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"85AB0002" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"ADAB0010"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000"

run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test7.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"3C011001"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"342D0020"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"2009FFD3"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"71205021"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"ADAA0000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00000000"

run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test8.ps"

restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"3C011001"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"3403FF0F"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"AC230020"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"3405BBBB"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"8C220020" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00452024" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"AC240024"        
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test9.ps"


restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"200BFFFD"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"05700003"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"08000007"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"00000000"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"03E00008" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00000000" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"AC1F0020"       
run 100 ns
force reset 0
run 5000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test10.ps"


restart -f
force reset 1       
force -freeze clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(0) X"20070011"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(1) X"3c110002"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(2) X"3631c305"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(3) X"3c12043a"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(4) X"36524463"
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(5) X"02320019" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(6) X"00004010" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(7) X"00004812"       
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(8) X"ace80017" 
force -freeze sim:/cpu_tb/mem_0/mw_u_0ram_table(9) X"ace9001b" 
run 100 ns
force reset 0
run 15000ns   
write wave -start 0ns -end 5000ns -perpage 400ns "Test11.ps"