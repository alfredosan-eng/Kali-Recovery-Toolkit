#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Sprint Installer
#
# SP-014
# Boot + Kernel Integration
#
###############################################################################

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo
echo "=============================================================="
echo "        Kali Recovery Toolkit - Sprint Installer"
echo "=============================================================="
echo
echo "Installing SP-014 Boot & Kernel..."
echo

###############################################################################
# Validate modules
###############################################################################

validate_module() {

    local MODULE="$1"

    if [[ ! -f "${ROOT_DIR}/modules/${MODULE}/module.sh" ]]; then
        echo "[ERROR] Missing module.sh for ${MODULE}"
        exit 1
    fi

    if [[ ! -f "${ROOT_DIR}/modules/${MODULE}/module.conf" ]]; then
        echo "[ERROR] Missing module.conf for ${MODULE}"
        exit 1
    fi

    if [[ ! -f "${ROOT_DIR}/modules/${MODULE}/README.md" ]]; then
        echo "[ERROR] Missing README.md for ${MODULE}"
        exit 1
    fi

}

validate_module boot
validate_module kernel

echo "[ OK ] Boot module"
echo "[ OK ] Kernel module"
echo

###############################################################################
# Updating Dispatcher
###############################################################################

echo "Updating core/cli/dispatch.sh..."
echo

###############################################################################
# Rebuild Dispatcher
###############################################################################

cat > "${ROOT_DIR}/core/cli/dispatch.sh" <<'EOF'
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

EOF

echo "[ OK ] Dispatcher updated."
echo

###############################################################################
# Rebuild Test Runner
###############################################################################

echo "Updating tests/run_tests.sh..."
echo

cat > "${ROOT_DIR}/tests/run_tests.sh" <<'EOF'
#!/usr/bin/env bash

echo
echo "========================================"
echo "        KRT Framework Test Runner"
echo "========================================"
echo

PASS_COUNT=0
FAIL_COUNT=0

run_test() {

    local NAME="$1"
    local FILE="$2"

    if [[ -f "$FILE" ]]; then

        echo "[PASS] $NAME"
        ((PASS_COUNT++))

    else

        echo "[FAIL] $NAME"
        ((FAIL_COUNT++))

    fi

}

echo "Running framework tests..."
echo

###############################################################################
# Services
###############################################################################

run_test "Collector Service" "services/collector/collector.sh"
run_test "Logger Service" "services/logger/logger.sh"
run_test "Report Service" "services/report/report.sh"
run_test "Health Service" "services/health/health.sh"

###############################################################################
# Modules
###############################################################################

run_test "Backup Module" "modules/backup/module.sh"
run_test "Doctor Module" "modules/doctor/module.sh"
run_test "Recovery Module" "modules/recovery/module.sh"
run_test "EFI Module" "modules/efi/module.sh"
run_test "GRUB Module" "modules/grub/module.sh"
run_test "Boot Module" "modules/boot/module.sh"
run_test "Kernel Module" "modules/kernel/module.sh"

echo
echo "----------------------------------------"
echo "PASS : $PASS_COUNT"
echo "FAIL : $FAIL_COUNT"
echo "----------------------------------------"

if [[ "$FAIL_COUNT" -eq 0 ]]; then

    echo
    echo "Framework validation completed successfully."

else

    echo
    echo "Framework validation failed."

fi

EOF

chmod +x "${ROOT_DIR}/tests/run_tests.sh"

echo "[ OK ] Test Runner updated."
echo

###############################################################################
# Syntax Validation
###############################################################################

echo "Validating Bash syntax..."
echo

validate_script() {

    local FILE="$1"

    if bash -n "$FILE"; then

        printf "[ OK ] %s\n" "$FILE"

    else

        printf "[FAIL] %s\n" "$FILE"
        echo
        echo "Installation aborted due to syntax errors."
        exit 1

    fi

}

validate_script "${ROOT_DIR}/core/cli/dispatch.sh"
validate_script "${ROOT_DIR}/modules/boot/module.sh"
validate_script "${ROOT_DIR}/modules/kernel/module.sh"
validate_script "${ROOT_DIR}/tests/run_tests.sh"

echo
echo "[ OK ] All scripts validated successfully."
echo

###############################################################################
# Permissions
###############################################################################

echo "Updating executable permissions..."
echo

chmod +x "${ROOT_DIR}/modules/boot/module.sh"
chmod +x "${ROOT_DIR}/modules/kernel/module.sh"
chmod +x "${ROOT_DIR}/tests/run_tests.sh"

echo "[ OK ] Permissions updated."
echo

###############################################################################
# Installation Summary
###############################################################################

echo "=============================================================="
echo "Boot & Kernel Installation Summary"
echo "=============================================================="
echo

echo "[ OK ] modules/boot"
echo "[ OK ] modules/kernel"
echo "[ OK ] core/cli/dispatch.sh"
echo "[ OK ] tests/run_tests.sh"

echo
echo "=============================================================="
echo "SP-014 Installation Completed Successfully"
echo "=============================================================="
echo

echo "New commands available:"
echo
echo "    ./krt --boot"
echo "    ./krt --kernel"
echo

echo "Run the following validation:"
echo
echo "    ./krt --boot"
echo "    ./krt --kernel"
echo "    ./krt --doctor"
echo "    ./krt --backup"
echo "    ./krt --recover"
echo "    ./krt --efi"
echo "    ./krt --grub"
echo "    ./tests/run_tests.sh"
echo

exit 0
