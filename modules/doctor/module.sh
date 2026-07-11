#!/usr/bin/env bash

###############################################################################
# KRT Doctor Module
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"

run_doctor() {

    echo
    echo "========================================"
    echo "           KRT Doctor"
    echo "========================================"
    echo

    printf "%-22s %s\n" "User:"            "$(get_current_user)"
    printf "%-22s %s\n" "Hostname:"        "$(get_hostname)"
    printf "%-22s %s\n" "Distribution:"    "$(collect_distribution)"
    printf "%-22s %s\n" "Kernel:"          "$(get_kernel)"
    printf "%-22s %s\n" "Architecture:"    "$(get_architecture)"
    printf "%-22s %s\n" "Memory:"          "$(collect_memory_total)"
    printf "%-22s %s\n" "Disk Usage:"      "$(collect_disk_usage)"
    printf "%-22s %s\n" "Uptime:"          "$(collect_uptime)"
    printf "%-22s %s\n" "Shell:"           "$(collect_shell)"

    echo
    echo "========================================"
}
