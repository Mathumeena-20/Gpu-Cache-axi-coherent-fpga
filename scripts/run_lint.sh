#!/bin/bash

echo "======================================="
echo "Running RTL Lint"
echo "======================================="

verilator --lint-only \
    ../rtl/common/*.sv \
    ../rtl/core/*.sv \
    ../rtl/pipeline/*.sv \
    ../rtl/l1_cache/*.sv \
    ../rtl/l2_cache/*.sv \
    ../rtl/coherency/*.sv \
    ../rtl/interconnect/*.sv \
    ../rtl/axi/*.sv \
    ../rtl/prefetch/*.sv \
    ../rtl/memory/*.sv \
    ../rtl/top/*.sv

echo "======================================="
echo "Lint Complete"
echo "======================================="