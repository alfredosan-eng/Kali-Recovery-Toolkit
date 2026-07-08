#!/usr/bin/env bash

###############################################################################
#
# KRT Core Initialization
#
###############################################################################

set -euo pipefail

CONFIG_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/config/krt.conf"


load_configuration() {

    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
        echo "[INFO] Configuration loaded."
    else
        echo "[ERROR] Configuration file not found."
        exit 1
    fi

}

initialize_framework() {

    echo "[INFO] Initializing KRT Framework..."

    load_configuration

    echo "[INFO] Project: ${PROJECT_NAME}"
    echo "[INFO] Version: ${VERSION}"

    echo "[INFO] Logger not implemented yet."

    echo "[INFO] Module loader not implemented yet."

    echo "[INFO] User interface not implemented yet."

    echo "[SUCCESS] Framework initialized."

}
