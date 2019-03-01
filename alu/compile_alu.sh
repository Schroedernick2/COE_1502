#!/bin/bash

#Nicholas Schroeder
#BASH script to compile ALU Test Bench using GHDL

#syntax check
ghdl -s --ieee=synopsys *.vhdl

#compile
ghdl -a --ieee=synopsys *.vhdl

#inspect entity
ghdl -e --ieee=synopsys ALU_TB

