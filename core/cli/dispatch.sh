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
            echo "  --backup"
            echo "  --doctor"
            echo "  --recover"
            echo "  --efi" 
            ;;

        --version)

            echo "Kali Recovery Toolkit"
            echo "Version ${VERSION}"

            ;;

        --backup)

            source "${ROOT_DIR}/modules/backup/module.sh"

            run_backup

            ;;

        --doctor)

            source "${ROOT_DIR}/modules/doctor/module.sh"

            run_doctor

            ;;

        --recover)

            source "${ROOT_DIR}/modules/recovery/module.sh"

            run_recovery

                    --efi)

                        source "${ROOT_DIR}/modules/efi/module.sh"

                        run_efi

            ;;

        *)

            echo "Unknown command."

            echo "Use --help"

            ;;

    esac

}
