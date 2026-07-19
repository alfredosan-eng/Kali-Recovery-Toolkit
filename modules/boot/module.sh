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
source "${ROOT_DIR}/services/inspector/inspector.sh"

run_boot() {

    log_info "Initializing Boot Inspector..."

    local BOOT_MODE
	local BOOT_DIR

	local EFI_DEVICE
	local EFI_UUID
	local EFI_FILESYSTEM
	local EFI_MOUNTPOINT
	local EFI_SIZE
	local EFI_USAGE

	local EFI_MOUNT

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

    EFI_DEVICE="$(collect_efi_device)"
	EFI_UUID="$(collect_efi_uuid)"
	EFI_FILESYSTEM="$(collect_efi_filesystem)"
	EFI_MOUNTPOINT="$(collect_efi_mountpoint)"
	EFI_SIZE="$(collect_efi_size)"
	EFI_USAGE="$(collect_efi_usage)"

	if [[ -n "$EFI_DEVICE" ]]; then
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

    inspector_header "KRT Boot Inspector"

    inspector_row \
        "Boot Mode" \
        "$BOOT_MODE" \
        "$MODE_STATUS"

    inspector_row \
        "EFI Mounted" \
        "$EFI_MOUNT" \
        "$MOUNT_STATUS"

    inspector_row \
        "EFI Device" \
        "$EFI_DEVICE" \
        "$PARTITION_STATUS"

    inspector_row \
        "Filesystem" \
        "$EFI_FILESYSTEM" \
        "PASS"

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

    inspector_row \
        "Boot Directory" \
        "$BOOT_DIR" \
        "$BOOT_STATUS"

    inspector_footer

    report_init "boot_report.txt"

    report_header "Boot Inspector Report"

    report_section "Boot Mode" "$BOOT_MODE"
    report_section "EFI Mounted" "$EFI_MOUNT"
    report_section "EFI Device" "$EFI_DEVICE"
	report_section "Filesystem" "$EFI_FILESYSTEM"
	report_section "Mount Point" "$EFI_MOUNTPOINT"
	report_section "Partition Size" "$EFI_SIZE"
	report_section "Space Used" "$EFI_USAGE"
    report_section "Boot Directory" "$BOOT_DIR"

    report_footer

    report_save

    log_success "Boot inspection completed."

}
