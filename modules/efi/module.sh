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
source "${ROOT_DIR}/services/inspector/inspector.sh"

run_efi() {

    log_info "Initializing EFI Inspector..."

    local EFI_MODE
    local EFI_STATUS
    local EFI_DEVICE
    local EFI_UUID
    local EFI_FILESYSTEM
    local EFI_MOUNTPOINT
    local EFI_SIZE
    local EFI_USAGE

    if [[ -d /sys/firmware/efi ]]; then

        EFI_MODE="UEFI"

    else

        EFI_MODE="Legacy BIOS"

    fi

    EFI_DEVICE="$(collect_efi_device)"
    EFI_UUID="$(collect_efi_uuid)"
    EFI_FILESYSTEM="$(collect_efi_filesystem)"
    EFI_MOUNTPOINT="$(collect_efi_mountpoint)"
    EFI_SIZE="$(collect_efi_size)"
    EFI_USAGE="$(collect_efi_usage)"

if [[ -n "$EFI_DEVICE" ]]; then

    EFI_STATUS="PASS"

else

    EFI_STATUS="ERROR"

fi

        inspector_header "KRT EFI Inspector"

    inspector_row \
        "Boot Mode" \
        "$EFI_MODE" \
        "PASS"

    inspector_row \
        "EFI Device" \
        "$EFI_DEVICE" \
        "$EFI_STATUS"

    inspector_row \
        "Filesystem" \
        "$EFI_FILESYSTEM" \
        "PASS"

    inspector_row \
        "UUID" \
        "$EFI_UUID" \
        "INFO"

    inspector_row \
        "Mount Point" \
        "$EFI_MOUNTPOINT" \
        "PASS"

    inspector_row \
        "Partition Size" \
        "$EFI_SIZE" \
        "INFO"

    inspector_row \
        "Space Used" \
        "$EFI_USAGE" \
        "PASS"

    inspector_footer

    report_init "efi_report.txt"

    report_header "EFI Inspector Report"

    report_section "Boot Mode" "$EFI_MODE"
    report_section "EFI Device" "$EFI_DEVICE"
    report_section "Filesystem" "$EFI_FILESYSTEM"
    report_section "UUID" "$EFI_UUID"
    report_section "Mount Point" "$EFI_MOUNTPOINT"
    report_section "Partition Size" "$EFI_SIZE"
    report_section "Space Used" "$EFI_USAGE"
    report_section "Status" "$EFI_STATUS"

    report_footer

    report_save

    log_success "EFI inspection completed."

}
