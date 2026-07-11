#!/usr/bin/env bash

###############################################################################
#
# KRT Collector Service
#
###############################################################################

get_current_user() {
    whoami
}

get_hostname() {
    hostname
}

get_kernel() {
    uname -r
}

get_architecture() {
    uname -m
}

get_execution_time() {
    date
}

###############################################################################
# Extended Collector API
###############################################################################

collect_distribution() {
    if [[ -f /etc/os-release ]]; then
        grep "^PRETTY_NAME=" /etc/os-release | cut -d= -f2 | tr -d '"'
    else
        echo "Unknown"
    fi
}

collect_uptime() {
    uptime -p
}

collect_memory_total() {
    free -h | awk '/^Mem:/ {print $2}'
}

collect_disk_usage() {
    df -h / | awk 'NR==2 {print $5}'
}

collect_shell() {
    echo "$SHELL"
}
