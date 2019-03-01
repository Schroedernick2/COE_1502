#!/bin/bash

#Nicholas Schroeder
#Script to compile hello.vhdl using ghdl

ghdl -a --ieee=synopsys *.vhdl
ghdl -e --ieee=synopsys HELLO_WORLD
