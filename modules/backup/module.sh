run_backup() {
    ###############################################################################
    # Services
    ###############################################################################

    source "${ROOT_DIR}/services/collector/collector.sh"
    source "${ROOT_DIR}/core/framework/framework_api.sh"
    log_info "Initializing Backup Module..."

    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

    BACKUP_DIR="${ROOT_DIR}/backups/${TIMESTAMP}"

    mkdir -p "${BACKUP_DIR}"

    BACKUP_LOG="${BACKUP_DIR}/backup.log"
    ###############################################################################
    # Backup Structure
    ###############################################################################

    mkdir -p "${BACKUP_DIR}/metadata"
    mkdir -p "${BACKUP_DIR}/reports"
    mkdir -p "${BACKUP_DIR}/config"

    log_info "Creating backup directory..."

    cat > "${BACKUP_LOG}" << EOF
======================================================
Kali Recovery Toolkit
Backup Report
======================================================

Backup ID:
${TIMESTAMP}

Execution Time:
$(get_execution_time)

User:
$(get_current_user)

Hostname:
$(get_hostname)

Kernel:
$(get_kernel)

Architecture:
$(get_architecture)

KRT Version:
$(get_project_version)

Status:
SUCCESS

======================================================
EOF
    log_info "Backup report created."

    log_info "Metadata directory created."

    log_info "Configuration directory created."

    log_success "Backup initialized."

}
