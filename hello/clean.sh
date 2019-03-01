#!/bin/bash

#Nicholas Schroeder
#Script to remove non-vhdl, non-sh files

echo -ne "Cleaning...\n"

find . -type f ! -name "*.vhdl" ! -name "*.sh" -exec rm {} \;

echo -ne "Removed all non-vhdl and non-BASH files.\n"
