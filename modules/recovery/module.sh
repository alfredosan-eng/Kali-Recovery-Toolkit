#!/usr/bin/env bash

###############################################################################
# Kali Recovery Toolkit
# Recovery Module
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"

###############################################################################
# Public API
###############################################################################

run_recovery() {

    log_info "Initializing Recovery Module..."

    _find_latest_snapshot

    _load_snapshot

    _collect_current_state

    _compare_kernel
    _compare_hostname
    _compare_distribution
    _compare_architecture

    _print_summary

    _generate_report

    log_success "Recovery analysis completed."

}

###############################################################################
# Snapshot Discovery
###############################################################################

_find_latest_snapshot() {

    SNAPSHOT_DIR="$(find backups -mindepth 1 -maxdepth 1 -type d | sort | tail -n1)"

    if [[ -z "$SNAPSHOT_DIR" ]]; then

        log_error "No snapshot found."

        exit 1

    fi

}

###############################################################################
# Snapshot Loader
###############################################################################

_load_snapshot() {

    SNAPSHOT_KERNEL="$(<"${SNAPSHOT_DIR}/metadata/kernel.txt")"

    SNAPSHOT_HOSTNAME="$(<"${SNAPSHOT_DIR}/metadata/hostname.txt")"

    SNAPSHOT_DISTRIBUTION="$(<"${SNAPSHOT_DIR}/metadata/distribution.txt")"

    SNAPSHOT_ARCHITECTURE="$(<"${SNAPSHOT_DIR}/metadata/architecture.txt")"

}

###############################################################################
# Current System
###############################################################################

_collect_current_state() {

    CURRENT_KERNEL="$(collect_snapshot_kernel)"

    CURRENT_HOSTNAME="$(collect_snapshot_hostname)"

    CURRENT_DISTRIBUTION="$(collect_snapshot_distribution)"

    CURRENT_ARCHITECTURE="$(collect_snapshot_architecture)"

}

###############################################################################
# Comparison Engine
###############################################################################

_compare_kernel() {

    if [[ "$CURRENT_KERNEL" == "$SNAPSHOT_KERNEL" ]]; then

        KERNEL_STATUS="PASS"

    else

        KERNEL_STATUS="ERROR"

    fi

}

_compare_hostname() {

    if [[ "$CURRENT_HOSTNAME" == "$SNAPSHOT_HOSTNAME" ]]; then

        HOSTNAME_STATUS="PASS"

    else

        HOSTNAME_STATUS="ERROR"

    fi

}

_compare_distribution() {

    if [[ "$CURRENT_DISTRIBUTION" == "$SNAPSHOT_DISTRIBUTION" ]]; then

        DISTRIBUTION_STATUS="PASS"

    else

        DISTRIBUTION_STATUS="ERROR"

    fi

}

_compare_architecture() {

    if [[ "$CURRENT_ARCHITECTURE" == "$SNAPSHOT_ARCHITECTURE" ]]; then

        ARCHITECTURE_STATUS="PASS"

    else

        ARCHITECTURE_STATUS="ERROR"

    fi

}
###############################################################################
# Console Report
###############################################################################

_print_summary() {

    echo
    echo "=============================================================="
    echo "                     KRT Recovery"
    echo "=============================================================="
    echo

    _print_item \
        "Kernel" \
        "$SNAPSHOT_KERNEL" \
        "$CURRENT_KERNEL" \
        "$KERNEL_STATUS"

    _print_item \
        "Hostname" \
        "$SNAPSHOT_HOSTNAME" \
        "$CURRENT_HOSTNAME" \
        "$HOSTNAME_STATUS"

    _print_item \
        "Distribution" \
        "$SNAPSHOT_DISTRIBUTION" \
        "$CURRENT_DISTRIBUTION" \
        "$DISTRIBUTION_STATUS"

    _print_item \
        "Architecture" \
        "$SNAPSHOT_ARCHITECTURE" \
        "$CURRENT_ARCHITECTURE" \
        "$ARCHITECTURE_STATUS"

}

###############################################################################
# Print Component
###############################################################################

_print_item() {

    local component="$1"
    local snapshot="$2"
    local current="$3"
    local status="$4"

    echo "--------------------------------------------------------------"
    echo "$component"
    echo
    echo "Snapshot : $snapshot"
    echo "Current  : $current"
    echo "Status   : $status"

    if [[ "$status" == "ERROR" ]]; then

        echo
        echo "Recommendation: $(_recommendation "$component")"

    fi

    echo

}

###############################################################################
# Recommendation Engine
###############################################################################

_recommendation() {

    case "$1" in

        Kernel)

            echo "Verify installed kernel packages."
            ;;

        Hostname)

            echo "Check hostname configuration."
            ;;

        Distribution)

            echo "Verify operating system release."
            ;;

        Architecture)

            echo "Verify system architecture."
            ;;

        *)

            echo "Review system configuration."
            ;;

    esac

}

###############################################################################
# Report Generator
###############################################################################

_generate_report() {

    report_init "recovery_report.txt"

    report_header "Recovery Report"

    report_section "Snapshot Directory" "$SNAPSHOT_DIR"

    report_message ""

    _write_report_item \
        "Kernel" \
        "$SNAPSHOT_KERNEL" \
        "$CURRENT_KERNEL" \
        "$KERNEL_STATUS"

    _write_report_item \
        "Hostname" \
        "$SNAPSHOT_HOSTNAME" \
        "$CURRENT_HOSTNAME" \
        "$HOSTNAME_STATUS"

    _write_report_item \
        "Distribution" \
        "$SNAPSHOT_DISTRIBUTION" \
        "$CURRENT_DISTRIBUTION" \
        "$DISTRIBUTION_STATUS"

    _write_report_item \
        "Architecture" \
        "$SNAPSHOT_ARCHITECTURE" \
        "$CURRENT_ARCHITECTURE" \
        "$ARCHITECTURE_STATUS"

    report_footer

    report_save

}

###############################################################################
# Report Writer
###############################################################################

_write_report_item() {

    local component="$1"
    local snapshot="$2"
    local current="$3"
    local status="$4"

    report_message "------------------------------------------------------------"
    report_message "$component"
    report_message ""
    report_message "Snapshot : $snapshot"
    report_message "Current  : $current"
    report_message "Status   : $status"

    if [[ "$status" == "ERROR" ]]; then

        report_message ""
        report_message "Recommendation:"
        report_message "$(_recommendation "$component")"

    fi

    report_message ""

}
