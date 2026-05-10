#!/bin/bash

echo "======================================="
echo "Generating Coverage"
echo "======================================="

vcover merge merged.ucdb *.ucdb

vcover report merged.ucdb \
    -details \
    -output coverage_report.txt

echo "======================================="
echo "Coverage Report Generated"
echo "======================================="