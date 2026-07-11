#!/usr/bin/env bash

###############################################################################
#
# KRT Backup Module
#
###############################################################################

run_backup() {

    log_info "Initializing Backup Module..."

    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

    BACKUP_DIR="${ROOT_DIR}/backups/${TIMESTAMP}"

    mkdir -p "${BACKUP_DIR}"

    touch "${BACKUP_DIR}/backup.log"

    log_info "Backup directory created."

    log_success "Backup initialized."

}
