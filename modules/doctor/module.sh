#!/usr/bin/env bash

###############################################################################
# Kali Recovery Toolkit
# Doctor Module
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"

###############################################################################
# Public API
###############################################################################

run_doctor() {

    local user hostname distribution kernel architecture
    local memory disk uptime shell
    local disk_status

    user="$(get_current_user)"
    hostname="$(get_hostname)"
    distribution="$(collect_distribution)"
    kernel="$(get_kernel)"
    architecture="$(get_architecture)"
    memory="$(collect_memory_total)"
    disk="$(collect_disk_usage)"
    uptime="$(collect_uptime)"
    shell="$(collect_shell)"

    disk_status="$(health_disk_usage "$disk")"

    ###########################################################################
    # Terminal
    ###########################################################################

    echo
    echo "=============================================================="
    echo "                       KRT Doctor"
    echo "=============================================================="
    echo

    printf "%-18s %-30s %-10s\n" "Component" "Value" "Status"
    printf "%-18s %-30s %-10s\n" "---------" "-----" "------"

    printf "%-18s %-30s %-10s\n" "User" "$user" "PASS"
    printf "%-18s %-30s %-10s\n" "Hostname" "$hostname" "PASS"
    printf "%-18s %-30s %-10s\n" "Distribution" "$distribution" "$(health_distribution)"
    printf "%-18s %-30s %-10s\n" "Kernel" "$kernel" "$(health_kernel)"
    printf "%-18s %-30s %-10s\n" "Architecture" "$architecture" "PASS"
    printf "%-18s %-30s %-10s\n" "Memory" "$memory" "$(health_memory)"
    printf "%-18s %-30s %-10s\n" "Disk Usage" "$disk" "$disk_status"
    printf "%-18s %-30s %-10s\n" "Uptime" "$uptime" "PASS"
    printf "%-18s %-30s %-10s\n" "Shell" "$shell" "PASS"

    echo
    echo "=============================================================="

    ###########################################################################
    # Report
    ###########################################################################

    report_init "doctor_report.txt"

    report_header "Doctor Report"

    report_section "User" "$user"
    report_section "Hostname" "$hostname"
    report_section "Distribution" "$distribution"
    report_section "Kernel" "$kernel"
    report_section "Architecture" "$architecture"
    report_section "Memory" "$memory"
    report_section "Disk Usage" "$disk ($disk_status)"
    report_section "Uptime" "$uptime"
    report_section "Shell" "$shell"

    report_footer

    report_save
}
