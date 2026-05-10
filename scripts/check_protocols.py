#!/usr/bin/env python3

import re
import sys

LOG_FILE = "simulation.log"

def check_axi_protocol(log_data):

    violations = []

    if "VALID dropped early" in log_data:
        violations.append(
            "AXI VALID/READY violation"
        )

    return violations


def check_coherency(log_data):

    violations = []

    if "owner invalid" in log_data:
        violations.append(
            "Coherency ownership violation"
        )

    return violations


def check_deadlock(log_data):

    violations = []

    if "deadlock detected" in log_data:
        violations.append(
            "Deadlock violation"
        )

    return violations


def main():

    try:

        with open(LOG_FILE, "r") as f:
            log_data = f.read()

    except FileNotFoundError:

        print(f"ERROR: {LOG_FILE} not found")
        sys.exit(1)

    violations = []

    violations += check_axi_protocol(log_data)
    violations += check_coherency(log_data)
    violations += check_deadlock(log_data)

    print("===================================")
    print("Protocol Check Report")
    print("===================================")

    if len(violations) == 0:

        print("No protocol violations detected")

    else:

        for v in violations:
            print(f"[VIOLATION] {v}")

    print("===================================")


if __name__ == "__main__":
    main()