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

            ;;

        --version)

            echo "Kali Recovery Toolkit"
            echo "Version 0.1.0"

            ;;

        --backup)

            echo "Backup module not implemented yet."

            ;;

        *)

            echo "Unknown command."

            echo "Use --help"

            ;;
    esac

}
