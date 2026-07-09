#!/usr/bin/env bash

###############################################################################
#
# KRT Logger Service
#
###############################################################################

log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[SUCCESS] $1"
}

log_warning() {
    echo "[WARNING] $1"
}

log_error() {
    echo "[ERROR] $1"
}

log_debug() {
    echo "[DEBUG] $1"
}
