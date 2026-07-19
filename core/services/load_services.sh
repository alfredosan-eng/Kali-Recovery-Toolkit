#!/usr/bin/env bash

###############################################################################
#
# KRT Service Loader
#
###############################################################################

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

#
# Shared Services
#

source "${ROOT_DIR}/services/logger/logger.sh"

#
# Framework API
#

source "${ROOT_DIR}/core/framework/framework_api.sh"

#
# Future Services
#

# source "${ROOT_DIR}/services/report/report.sh"
# source "${ROOT_DIR}/services/ui/ui.sh"
# source "${ROOT_DIR}/services/validator/validator.sh"
# source "${ROOT_DIR}/core/modules/load_modules.sh"
