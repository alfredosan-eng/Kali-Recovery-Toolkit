#!/usr/bin/env bash

###############################################################################
# Kali Recovery Toolkit
# Doctor Module
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"
source "${ROOT_DIR}/services/inspector/inspector.sh"

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

            inspector_header "KRT Doctor"

    inspector_row \
        "User" \
        "$USERNAME" \
        "PASS"

    inspector_row \
        "Hostname" \
        "$HOSTNAME" \
        "$HOST_STATUS"

    inspector_row \
        "Distribution" \
        "$DISTRIBUTION" \
        "$DIST_STATUS"

    inspector_row \
        "Kernel" \
        "$KERNEL" \
        "$KERNEL_STATUS"

    inspector_row \
        "Architecture" \
        "$ARCHITECTURE" \
        "PASS"

    inspector_row \
        "Memory" \
        "$MEMORY" \
        "$MEMORY_STATUS"

    inspector_row \
        "Disk Usage" \
        "$DISK" \
        "$DISK_STATUS"

    inspector_row \
        "Uptime" \
        "$UPTIME" \
        "INFO"

    inspector_row \
        "Shell" \
        "$SHELL" \
        "PASS"

    inspector_footer

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
