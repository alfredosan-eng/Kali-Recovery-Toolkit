#!/usr/bin/env bash

###############################################################################
#
# KRT Core Initialization
#
###############################################################################

set -euo pipefail

CONFIG_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/config/krt.conf"
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/services/logger/logger.sh"

load_configuration() {

    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
        log_info "Configuration loaded."
    else
        echo "[ERROR] Configuration file not found."
        exit 1
    fi

}

initialize_framework() {

    log_info "Initializing KRT Framework..."

    load_configuration

    log_info "Project: ${PROJECT_NAME}"
    log_info "Version: ${VERSION}"

    log_info "Logger initialized."

    log_info "Module Loader not implemented yet."

    log_info "User Interface not implemented yet."

    log_success "Framework initialized."

}
