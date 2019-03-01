#!/bin/bash

ghdl -a --ieee=synopsys *.vhdl
ghdl -e --ieee=synopsys HELLO_WORLD
