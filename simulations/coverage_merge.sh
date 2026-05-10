#!/bin/bash

echo "===================================="
echo "Coverage Merge"
echo "===================================="

vcover merge merged.ucdb *.ucdb

vcover report merged.ucdb \
    -details \
    -output coverage_report.txt

echo "Coverage Report Generated"