#!/bin/sh
echo "1>"
iverilog -o out -y ./ tb.v dpd.v dco.v
echo "2>"
vvp -n out -lxt2
echo "3>"
cp wave.vcd wave.lxt

