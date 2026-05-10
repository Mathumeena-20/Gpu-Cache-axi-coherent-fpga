#!/bin/bash

echo "======================================="
echo "Running Full Regression"
echo "======================================="

TESTS=(
tb_multi_core_gpu
tb_l1_cache
tb_l2_cache
tb_axi_ooo
tb_coherency_random
tb_directory_controller
tb_mshr
tb_noc_router
tb_prefetcher
tb_dram_controller
)

PASS=0
FAIL=0

for TEST in "${TESTS[@]}"
do

    echo "---------------------------------------"
    echo "Running $TEST"
    echo "---------------------------------------"

    vsim -c work.$TEST \
         -do "run -all; quit" \
         > ${TEST}.log

    if grep -i "error" ${TEST}.log
    then

        echo "[FAIL] $TEST"
        FAIL=$((FAIL+1))

    else

        echo "[PASS] $TEST"
        PASS=$((PASS+1))

    fi

done

echo "======================================="
echo "Regression Summary"
echo "======================================="

echo "PASS = $PASS"
echo "FAIL = $FAIL"