#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Inspector Framework
#
###############################################################################

###############################################################################
# Header
###############################################################################

inspector_header() {

    local TITLE="$1"

    echo
    echo "=============================================================="
    printf "%30s\n" "$TITLE"
    echo "=============================================================="
    echo

}

###############################################################################
# Row
###############################################################################

inspector_row() {

    local LABEL="$1"
    local VALUE="$2"
    local STATUS="$3"

    printf "%-22s %-30s %-10s\n" \
        "$LABEL" \
        "$VALUE" \
        "$STATUS"

}

###############################################################################
# Section
###############################################################################

inspector_section() {

    local TITLE="$1"

    echo
    echo "--------------------------------------------------------------"
    echo "$TITLE"
    echo

}

###############################################################################
# Footer
###############################################################################

inspector_footer() {

    echo
    echo "=============================================================="

}

###############################################################################
# MEMORY INSPECTOR
###############################################################################

inspector_memory() {

    echo
    echo "==================== Memory ===================="

    printf "%-25s %s\n" "Total RAM:"      "$(format_size_kb "$MEMORY_TOTAL")"
    printf "%-25s %s\n" "Used RAM:"       "$(format_size_kb "$MEMORY_USED")"
    printf "%-25s %s\n" "Available RAM:"  "$(format_size_kb "$MEMORY_AVAILABLE")"
    printf "%-25s %s\n" "Cached:"         "$(format_size_kb "$MEMORY_CACHED")"
    printf "%-25s %s\n" "Buffers:"        "$(format_size_kb "$MEMORY_BUFFERS")"

    printf "%-25s %s%%\n" "Memory Usage:" "$MEMORY_USAGE_PERCENT"
    printf "%-25s %s\n"   "Memory Status:" "$MEMORY_STATUS"

    echo

    printf "%-25s %s\n" "Swap Total:"     "$(format_size_kb "$SWAP_TOTAL")"
    printf "%-25s %s\n" "Swap Used:"      "$(format_size_kb "$SWAP_USED")"
    printf "%-25s %s%%\n" "Swap Usage:"   "$SWAP_USAGE_PERCENT"
    printf "%-25s %s\n"   "Swap Status:"  "$SWAP_STATUS"

    echo "==============================================="
    echo
}
