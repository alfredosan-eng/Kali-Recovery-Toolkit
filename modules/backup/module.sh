run_backup() {

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
$(date)

User:
$(whoami)

Hostname:
$(hostname)

Kernel:
$(uname -r)

Architecture:
$(uname -m)

KRT Version:
${VERSION}

Status:
SUCCESS

======================================================
EOF
    log_info "Backup report created."

    log_info "Metadata directory created."

    log_info "Configuration directory created."

    log_success "Backup initialized."

}
