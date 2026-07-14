#!/usr/bin/env bash

###############################################################################
#
# --force Inspector
#
###############################################################################

source "${ROOT_DIR}/services/collector/collector.sh"
source "${ROOT_DIR}/services/report/report.sh"
source "${ROOT_DIR}/services/health/health.sh"

run_--force() {

    log_info "Initializing --force Inspector..."

    echo
    echo "=============================================================="
    echo "                  --force Inspector"
    echo "=============================================================="
    echo

    log_success "--force Inspector completed."

}
