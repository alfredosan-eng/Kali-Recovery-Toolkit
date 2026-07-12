#!/usr/bin/env bash

###############################################################################
# Kali Recovery Toolkit
# Health Service
###############################################################################

###############################################################################
# Status Constants
###############################################################################

STATUS_PASS="PASS"
STATUS_WARNING="WARNING"
STATUS_ERROR="ERROR"
STATUS_CRITICAL="CRITICAL"

###############################################################################
# Public API
###############################################################################

health_disk_usage() {

    local usage="$1"

    usage="${usage%\%}"

    if (( usage < 80 )); then
        echo "$STATUS_PASS"

    elif (( usage < 90 )); then
        echo "$STATUS_WARNING"

    elif (( usage < 95 )); then
        echo "$STATUS_ERROR"

    else
        echo "$STATUS_CRITICAL"
    fi
}

health_memory() {

    echo "$STATUS_PASS"

}

health_kernel() {

    echo "$STATUS_PASS"

}

health_distribution() {

    echo "$STATUS_PASS"

}
