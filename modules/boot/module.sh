#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Boot Inspector
#
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"

run_boot() {

    log_info "Initializing Boot Inspector..."

    local BOOT_MODE
    local EFI_PARTITION
    local EFI_MOUNT
    local BOOT_DIR

    if [[ -d /sys/firmware/efi ]]; then
        BOOT_MODE="UEFI"
        MODE_STATUS="PASS"
    else
        BOOT_MODE="Legacy BIOS"
        MODE_STATUS="INFO"
    fi

    if mount | grep -q "/boot/efi"; then
        EFI_MOUNT="Mounted"
        MOUNT_STATUS="PASS"
    else
        EFI_MOUNT="Not Mounted"
        MOUNT_STATUS="ERROR"
    fi

    EFI_PARTITION="$(collect_efi_partition)"

    if [[ -n "$EFI_PARTITION" ]]; then
        PARTITION_STATUS="PASS"
    else
        PARTITION_STATUS="ERROR"
    fi

    if [[ -d /boot ]]; then
        BOOT_DIR="Present"
        BOOT_STATUS="PASS"
    else
        BOOT_DIR="Missing"
        BOOT_STATUS="ERROR"
    fi
    echo
    echo "=============================================================="
    echo "                    KRT Boot Inspector"
    echo "=============================================================="
    echo

    printf "%-20s %-30s %-10s\n" \
        "Boot Mode" \
        "$BOOT_MODE" \
        "$MODE_STATUS"

    printf "%-20s %-30s %-10s\n" \
        "EFI Mounted" \
        "$EFI_MOUNT" \
        "$MOUNT_STATUS"

    printf "%-20s %-30s %-10s\n" \
        "EFI Partition" \
        "${EFI_PARTITION:-Not Found}" \
        "$PARTITION_STATUS"

    printf "%-20s %-30s %-10s\n" \
        "Boot Directory" \
        "$BOOT_DIR" \
        "$BOOT_STATUS"

    echo
    echo "=============================================================="

    report_init "boot_report.txt"

    report_header "Boot Inspector Report"

    report_section "Boot Mode" "$BOOT_MODE"
    report_section "EFI Mounted" "$EFI_MOUNT"
    report_section "EFI Partition" "${EFI_PARTITION:-Not Found}"
    report_section "Boot Directory" "$BOOT_DIR"

    report_footer

    report_save

    log_success "Boot inspection completed."

}
