#!/usr/bin/env bash

###############################################################################
#
# Filesystem Inspector
#
###############################################################################

	source "${ROOT_DIR}/services/collector/collector.sh"
	source "${ROOT_DIR}/services/report/report.sh"
	source "${ROOT_DIR}/services/health/health.sh"
	source "${ROOT_DIR}/services/inspector/inspector.sh"

    run_filesystem() {

    log_info "Initializing Filesystem Inspector..."

    local ROOT_DEVICE
    local FILESYSTEM
    local MOUNTPOINT
    local SIZE
    local USED
    local AVAILABLE
    local USAGE
	local DISK_STATUS
	local EFI_MOUNT
	local EFI_STATUS
	local INODE_USAGE
	local INODE_AVAILABLE
	local INODE_STATUS

    ROOT_DEVICE="$(collect_root_device)"
	FILESYSTEM="$(collect_root_filesystem)"
	MOUNTPOINT="/"
	SIZE="$(collect_root_size)"
	USED="$(collect_root_used)"
	INODE_USAGE="$(collect_root_inode_usage)"
	INODE_AVAILABLE="$(collect_root_inode_available)"
	AVAILABLE="$(collect_root_available)"
	USAGE="$(collect_root_usage)"

	DISK_STATUS="$(health_disk_usage "$USAGE")"
	EFI_MOUNT="$(collect_efi_mountpoint)"
	EFI_STATUS="$(health_mountpoint "$EFI_MOUNT")"
	INODE_STATUS="$(health_inode_usage "$INODE_USAGE")"

    inspector_header "KRT Filesystem Inspector"
	inspector_section "Storage"

    inspector_row \
        "Root Device" \
        "$ROOT_DEVICE" \
        "PASS"

    inspector_row \
        "Filesystem" \
        "$FILESYSTEM" \
        "PASS"

    inspector_row \
        "Mount Point" \
        "$MOUNTPOINT" \
        "PASS"

    inspector_row \
        "Partition Size" \
        "$SIZE" \
        "INFO"

    inspector_row \
        "Used Space" \
        "$USED" \
        "INFO"

    inspector_row \
        "Available Space" \
        "$AVAILABLE" \
        "PASS"

    inspector_row \
    "Disk Usage" \
    "$USAGE" \
    "$DISK_STATUS"
	
	inspector_row \
	"EFI Mount" \
    "${EFI_MOUNT:-Not mounted}" \
    "$EFI_STATUS"

	echo

	inspector_section "Inodes"

	inspector_row \
    "Inode Usage" \
    "$INODE_USAGE" \
    "$INODE_STATUS"

	inspector_row \
    "Available Inodes" \
    "$INODE_AVAILABLE" \
    "INFO"

    inspector_footer

	echo

    inspector_section "Mounted Filesystems"

    collect_mounted_filesystems

    report_init "filesystem_report.txt"

    report_header "Filesystem Inspector Report"

    report_section "Root Device" "$ROOT_DEVICE"
    report_section "Filesystem" "$FILESYSTEM"
    report_section "Mount Point" "$MOUNTPOINT"
    report_section "Partition Size" "$SIZE"
    report_section "Used Space" "$USED"
    report_section "Available Space" "$AVAILABLE"
    report_section "Disk Usage" "$USAGE ($DISK_STATUS)"

    report_footer

    report_save

    log_success "Filesystem inspection completed."

}
