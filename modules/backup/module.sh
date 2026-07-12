#!/usr/bin/env bash

###############################################################################
# Kali Recovery Toolkit
# Backup Module
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"

###############################################################################
# Public API
###############################################################################

run_backup() {

    log_info "Initializing Backup Module..."

    BACKUP_ID="$(date +"%Y-%m-%d_%H-%M-%S")"
    BACKUP_DIR="backups/${BACKUP_ID}"

    create_snapshot
    collect_snapshot_metadata
    copy_reports
    generate_backup_report

    log_success "Backup initialized."

}

###############################################################################
# Snapshot Creation
###############################################################################

create_snapshot() {

    log_info "Creating snapshot structure..."

    mkdir -p "${BACKUP_DIR}"

    mkdir -p "${BACKUP_DIR}/metadata"

    mkdir -p "${BACKUP_DIR}/reports"

    mkdir -p "${BACKUP_DIR}/config"

}

###############################################################################
# Metadata Collection
###############################################################################

collect_snapshot_metadata() {

    log_info "Collecting system metadata..."

    collect_snapshot_kernel \
        > "${BACKUP_DIR}/metadata/kernel.txt"

    collect_snapshot_hostname \
        > "${BACKUP_DIR}/metadata/hostname.txt"

    collect_snapshot_distribution \
        > "${BACKUP_DIR}/metadata/distribution.txt"

    collect_snapshot_architecture \
        > "${BACKUP_DIR}/metadata/architecture.txt"

    collect_snapshot_memory \
        > "${BACKUP_DIR}/metadata/memory.txt"

    collect_snapshot_disk \
        > "${BACKUP_DIR}/metadata/disk_usage.txt"

    collect_snapshot_uptime \
        > "${BACKUP_DIR}/metadata/uptime.txt"

    collect_snapshot_shell \
        > "${BACKUP_DIR}/metadata/shell.txt"

}

###############################################################################
# Copy Existing Reports
###############################################################################

copy_reports() {

    if [[ -f reports/doctor_report.txt ]]; then

        cp reports/doctor_report.txt \
           "${BACKUP_DIR}/reports/"

    fi

}

###############################################################################
# Backup Report
###############################################################################

generate_backup_report() {

    report_init "${BACKUP_DIR}/backup.log"

    report_header "Backup Report"

    report_section "Snapshot ID" "$BACKUP_ID"

    report_section "Execution Time" "$(date)"

    report_section "User" "$(get_current_user)"

    report_section "Hostname" "$(get_hostname)"

    report_section "Kernel" "$(get_kernel)"

    report_section "Status" "SUCCESS"

    report_footer

    report_save

}
