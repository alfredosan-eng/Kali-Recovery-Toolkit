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

    log_info "Initializing Doctor Module..."

    local USERNAME
    local HOSTNAME
    local DISTRIBUTION
    local KERNEL
    local ARCHITECTURE
    local MEMORY
    local DISK
    local UPTIME
    local SHELL

    USERNAME="$(whoami)"
    HOSTNAME="$(collect_hostname)"
    DISTRIBUTION="$(collect_distribution)"
    KERNEL="$(collect_kernel)"
    ARCHITECTURE="$(collect_architecture)"
    MEMORY="$(collect_memory)"
    DISK="$(collect_disk_usage)"
    UPTIME="$(collect_uptime)"
    SHELL="$(collect_shell)"

    local HOST_STATUS
    local DIST_STATUS
    local KERNEL_STATUS
    local MEMORY_STATUS
    local DISK_STATUS

    HOST_STATUS="$(health_hostname "$HOSTNAME")"
    DIST_STATUS="$(health_distribution "$DISTRIBUTION")"
    KERNEL_STATUS="$(health_kernel "$KERNEL")"
    MEMORY_STATUS="$(health_memory "$MEMORY")"
    DISK_STATUS="$(health_disk_usage "$DISK")"

    echo
    echo "=============================================================="
    echo "                       KRT Doctor"
    echo "=============================================================="
    echo

    printf "%-18s %-25s %-10s\n" "User" "$USERNAME" "PASS"
    printf "%-18s %-25s %-10s\n" "Hostname" "$HOSTNAME" "$HOST_STATUS"
    printf "%-18s %-25s %-10s\n" "Distribution" "$DISTRIBUTION" "$DIST_STATUS"
    printf "%-18s %-25s %-10s\n" "Kernel" "$KERNEL" "$KERNEL_STATUS"
    printf "%-18s %-25s %-10s\n" "Architecture" "$ARCHITECTURE" "PASS"
    printf "%-18s %-25s %-10s\n" "Memory" "$MEMORY" "$MEMORY_STATUS"
    printf "%-18s %-25s %-10s\n" "Disk Usage" "$DISK" "$DISK_STATUS"
    printf "%-18s %-25s %-10s\n" "Uptime" "$UPTIME" "INFO"
    printf "%-18s %-25s %-10s\n" "Shell" "$SHELL" "PASS"

    echo
    echo "=============================================================="

    report_init "doctor_report.txt"

    report_header "Doctor Report"

    report_section "User" "$USERNAME"
    report_section "Hostname" "$HOSTNAME ($HOST_STATUS)"
    report_section "Distribution" "$DISTRIBUTION ($DIST_STATUS)"
    report_section "Kernel" "$KERNEL ($KERNEL_STATUS)"
    report_section "Architecture" "$ARCHITECTURE"
    report_section "Memory" "$MEMORY ($MEMORY_STATUS)"
    report_section "Disk Usage" "$DISK ($DISK_STATUS)"
    report_section "Uptime" "$UPTIME"
    report_section "Shell" "$SHELL"

    report_footer

    report_save

    log_success "Doctor analysis completed."

}
