#!/usr/bin/env bash

###############################################################################
#
# KRT Command Dispatcher
#
###############################################################################

dispatch_command() {

    case "$1" in

        --help|-h)

            echo "Kali Recovery Toolkit"
            echo
            echo "Available commands:"
            echo
            echo "  --help"
            echo "  --version"
            echo
            echo "Inspection Modules"
            echo "  --doctor"
            echo "  --efi"
            echo "  --grub"
            echo "  --boot"
            echo "  --kernel"
            echo
            echo "Recovery Modules"
            echo "  --backup"
            echo "  --recover"
            echo
            ;;

        --version)

            echo "Kali Recovery Toolkit"
            echo "Version ${VERSION}"
            ;;

        --doctor)

            source "${ROOT_DIR}/modules/doctor/module.sh"
            run_doctor
            ;;

        --backup)

            source "${ROOT_DIR}/modules/backup/module.sh"
            run_backup
            ;;

        --recover)

            source "${ROOT_DIR}/modules/recovery/module.sh"
            run_recovery
            ;;

        --efi)

            source "${ROOT_DIR}/modules/efi/module.sh"
            run_efi
            ;;

        --grub)

            source "${ROOT_DIR}/modules/grub/module.sh"
            run_grub
            ;;

        --boot)

            source "${ROOT_DIR}/modules/boot/module.sh"
            run_boot
            ;;

        --kernel)

            source "${ROOT_DIR}/modules/kernel/module.sh"
            run_kernel
            ;;

        *)

            echo "Unknown command."
            echo "Use ./krt --help"
            return 1
            ;;

    esac

}

