#!/bin/bash

echo "======================================="
echo "Running GPU Cache Simulation"
echo "======================================="

cd ../sim

vsim -do compile.do
vsim -do run.do

echo "======================================="
echo "Simulation Complete"
echo "======================================="