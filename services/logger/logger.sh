#!/usr/bin/env bash

###############################################################################
#
# KRT Logger Service
#
###############################################################################

get_timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

log_info() {
    echo "[$(get_timestamp)] [INFO] $1"
}

log_success() {
    echo "[$(get_timestamp)] [SUCCESS] $1"
}

log_warning() {
    echo "[$(get_timestamp)] [WARNING] $1"
}

log_error() {
    echo "[$(get_timestamp)] [ERROR] $1"
}

log_debug() {
    echo "[$(get_timestamp)] [DEBUG] $1"
}
