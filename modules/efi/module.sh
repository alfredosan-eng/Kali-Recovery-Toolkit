#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# EFI Inspector
#
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"

run_efi() {

    log_info "Initializing EFI Inspector..."

    local EFI_MODE
    local EFI_PARTITION
    local EFI_STATUS

    if [[ -d /sys/firmware/efi ]]; then

        EFI_MODE="UEFI"

    else

        EFI_MODE="Legacy BIOS"

    fi

    EFI_PARTITION="$(collect_efi_partition)"

    if [[ -n "$EFI_PARTITION" ]]; then

        EFI_STATUS="PASS"

    else

        EFI_STATUS="ERROR"

    fi

    echo
    echo "=============================================================="
    echo "                    KRT EFI Inspector"
    echo "=============================================================="
    echo

    printf "%-20s %-30s %-10s\n" \
        "Boot Mode" \
        "$EFI_MODE" \
        "PASS"

    printf "%-20s %-30s %-10s\n" \
        "EFI Partition" \
        "${EFI_PARTITION:-Not Found}" \
        "$EFI_STATUS"
    echo

    report_init "efi_report.txt"

    report_header "EFI Inspector Report"

    report_section "Boot Mode" "$EFI_MODE"
    report_section "EFI Partition" "${EFI_PARTITION:-Not Found}"
    report_section "Status" "$EFI_STATUS"

    report_footer

    report_save

    echo
    echo "=============================================================="

    log_success "EFI inspection completed."

}
