#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# GRUB Inspector
#
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"

run_grub() {

    log_info "Initializing GRUB Inspector..."

    local GRUB_VERSION
    local GRUB_DIRECTORY
    local GRUB_CONFIG
    local INSTALLED_KERNELS

    GRUB_VERSION="$(collect_grub_version)"

    if [[ -d /boot/grub ]]; then
        GRUB_DIRECTORY="Present"
        DIR_STATUS="PASS"
    else
        GRUB_DIRECTORY="Missing"
        DIR_STATUS="ERROR"
    fi

    if [[ -f /boot/grub/grub.cfg ]]; then
        GRUB_CONFIG="Present"
        CFG_STATUS="PASS"
    else
        GRUB_CONFIG="Missing"
        CFG_STATUS="ERROR"
    fi

    INSTALLED_KERNELS="$(collect_installed_kernels | wc -l)"
    echo
    echo "=============================================================="
    echo "                    KRT GRUB Inspector"
    echo "=============================================================="
    echo

    printf "%-20s %-30s %-10s\n" \
        "GRUB Version" \
        "${GRUB_VERSION:-Unknown}" \
        "PASS"

    printf "%-20s %-30s %-10s\n" \
        "GRUB Directory" \
        "$GRUB_DIRECTORY" \
        "$DIR_STATUS"

    printf "%-20s %-30s %-10s\n" \
        "grub.cfg" \
        "$GRUB_CONFIG" \
        "$CFG_STATUS"

    printf "%-20s %-30s %-10s\n" \
        "Installed Kernels" \
        "$INSTALLED_KERNELS" \
        "INFO"

    echo
    echo "=============================================================="

    report_init "grub_report.txt"

    report_header "GRUB Inspector Report"

    report_section "GRUB Version" "${GRUB_VERSION:-Unknown}"
    report_section "GRUB Directory" "$GRUB_DIRECTORY"
    report_section "grub.cfg" "$GRUB_CONFIG"
    report_section "Installed Kernels" "$INSTALLED_KERNELS"

    report_footer

    report_save

    log_success "GRUB inspection completed."

}
