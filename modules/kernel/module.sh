#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Kernel Inspector
#
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"

run_kernel() {

    log_info "Initializing Kernel Inspector..."

    local RUNNING_KERNEL
    local INSTALLED_KERNELS
    local INITRAMFS_STATUS
    local HEADER_STATUS

    RUNNING_KERNEL="$(collect_kernel)"
    INSTALLED_KERNELS="$(collect_installed_kernels | wc -l)"

    if ls /boot/initrd* >/dev/null 2>&1; then
        INITRAMFS_STATUS="PASS"
    else
        INITRAMFS_STATUS="ERROR"
    fi

    if dpkg -l | grep -q "linux-headers-$(uname -r)"; then
        HEADER_STATUS="PASS"
    else
        HEADER_STATUS="INFO"
    fi

    echo
    echo "=============================================================="
    echo "                  KRT Kernel Inspector"
    echo "=============================================================="
    echo

    printf "%-22s %-28s %-10s\n" \
        "Running Kernel" \
        "$RUNNING_KERNEL" \
        "PASS"

    printf "%-22s %-28s %-10s\n" \
        "Installed Kernels" \
        "$INSTALLED_KERNELS" \
        "INFO"

    printf "%-22s %-28s %-10s\n" \
        "Initramfs" \
        "Detected" \
        "$INITRAMFS_STATUS"

    printf "%-22s %-28s %-10s\n" \
        "Kernel Headers" \
        "Installed" \
        "$HEADER_STATUS"

    echo
    echo "=============================================================="

    report_init "kernel_report.txt"

    report_header "Kernel Inspector Report"

    report_section "Running Kernel" "$RUNNING_KERNEL"
    report_section "Installed Kernels" "$INSTALLED_KERNELS"
    report_section "Initramfs" "$INITRAMFS_STATUS"
    report_section "Kernel Headers" "$HEADER_STATUS"

    report_footer
    report_save

    log_success "Kernel inspection completed."

}
