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
            ;;

        --version)

            echo "Kali Recovery Toolkit"
            echo "Version 0.1.0"

            ;;

        --backup)

    source "${ROOT_DIR}/modules/backup/module.sh"

    run_backup

    ;;
--doctor)

    source "${ROOT_DIR}/modules/doctor/module.sh"

    run_doctor

    ;;
        *)

            echo "Unknown command."

            echo "Use --help"

            ;;
    esac

}
