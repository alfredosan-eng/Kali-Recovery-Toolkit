#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Validation Library
#
###############################################################################

require_command() {

    local cmd="$1"

    if ! command -v "$cmd" >/dev/null 2>&1; then

        echo "[ERROR] Required command not found: $cmd"

        return 1

    fi

    return 0

}

require_file() {

    local file="$1"

    [[ -f "$file" ]]

}

require_directory() {

    local dir="$1"

    [[ -d "$dir" ]]

}

require_root() {

    [[ "$EUID" -eq 0 ]]

}

validate_framework() {

    require_directory "$KRT_MODULES_DIR" || return 1
    require_directory "$KRT_SERVICES_DIR" || return 1
    require_directory "$KRT_CORE_DIR" || return 1

    return 0

}

###############################################################################
# END OF FILE
###############################################################################
