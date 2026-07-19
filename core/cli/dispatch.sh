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

            framework_run_doctor
            ;;

        --backup)

            framework_run_backup
            ;;

        --recover)

            framework_run_recovery
            ;;

        --efi)

            framework_run_efi
            ;;

        --grub)

            framework_run_grub
            ;;

        --boot)

            framework_run_boot
            ;;

        --kernel)

            framework_run_kernel
            ;;
			
        --filesystem)

            framework_run_filesystem
            ;;

        *)

            echo "Unknown command."
            echo "Use ./krt --help"
            return 1
            ;;

    esac

}

