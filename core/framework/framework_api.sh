#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Framework API
#
###############################################################################

###############################################################################
# Core Libraries
###############################################################################

source "${ROOT_DIR}/core/lib/constants.sh"
source "${ROOT_DIR}/core/lib/common.sh"
source "${ROOT_DIR}/core/lib/validation.sh"

###############################################################################
# Project Information
###############################################################################

get_project_name() {

    echo "${KRT_NAME}"

}

get_project_version() {

    echo "${KRT_VERSION}"

}

get_project_author() {

    echo "${KRT_AUTHOR}"

}

get_project_license() {

    echo "${KRT_LICENSE}"

}

###############################################################################
# Framework Validation
###############################################################################

framework_validate() {

    validate_framework

}

###############################################################################
# Module API
###############################################################################

framework_run_backup() {

    source "${ROOT_DIR}/modules/backup/module.sh"

    run_backup

}

framework_run_doctor() {

    source "${ROOT_DIR}/modules/doctor/module.sh"

    run_doctor

}

framework_run_recovery() {

    source "${ROOT_DIR}/modules/recovery/module.sh"

    run_recovery

}

framework_run_boot() {

    source "${ROOT_DIR}/modules/boot/module.sh"

    run_boot

}

framework_run_efi() {

    source "${ROOT_DIR}/modules/efi/module.sh"

    run_efi

}

framework_run_grub() {

    source "${ROOT_DIR}/modules/grub/module.sh"

    run_grub

}

framework_run_kernel() {

    source "${ROOT_DIR}/modules/kernel/module.sh"

    run_kernel

}

framework_run_filesystem() {

    source "${ROOT_DIR}/modules/filesystem/module.sh"

    run_filesystem

}

###############################################################################
# Framework Information
###############################################################################

framework_version() {

    echo "Framework API v1.0"

}

###############################################################################
# END OF FILE
###############################################################################
