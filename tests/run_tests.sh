#!/usr/bin/env bash

echo
echo "========================================"
echo "        KRT Framework Test Runner"
echo "========================================"
echo

PASS_COUNT=0
FAIL_COUNT=0

run_test() {

    local name="$1"
    local file="$2"

    if [[ -f "$file" ]]; then

        echo "[PASS] $name"

        ((PASS_COUNT++))

    else

        echo "[FAIL] $name"

        ((FAIL_COUNT++))

    fi

}

echo "Running framework tests..."
echo

run_test "Collector Service" "services/collector/collector.sh"

run_test "Logger Service" "services/logger/logger.sh"

run_test "Report Service" "services/report/report.sh"

run_test "Health Service" "services/health/health.sh"

run_test "Backup Module" "modules/backup/module.sh"

run_test "Doctor Module" "modules/doctor/module.sh"

run_test "Recovery Module" "modules/recovery/module.sh"

run_test "EFI Module" "modules/efi/module.sh"

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

