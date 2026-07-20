#!/usr/bin/env bash

###############################################################################
#
# KRT Common Utilities
#
###############################################################################

file_exists() {
    [[ -f "$1" ]]
}

directory_exists() {
    [[ -d "$1" ]]
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

###############################################################################
# FORMATTERS
###############################################################################

format_size_kb() {

    local kb="${1:-0}"

    if (( kb >= 1073741824 )); then

        awk "BEGIN {printf \"%.2f TiB\", $kb/1073741824}"

    elif (( kb >= 1048576 )); then

        awk "BEGIN {printf \"%.2f GiB\", $kb/1048576}"

    elif (( kb >= 1024 )); then

        awk "BEGIN {printf \"%.2f MiB\", $kb/1024}"

    else

        printf "%s KiB" "$kb"

    fi

}
