#!/usr/bin/env bash

###############################################################################
#
# Kali Recovery Toolkit
# Collector Service
#
###############################################################################

###############################################################################
# SYSTEM
###############################################################################

collect_kernel() {

    uname -r

}

collect_hostname() {

    hostname

}

collect_distribution() {

    grep PRETTY_NAME /etc/os-release \
        | cut -d= -f2 \
        | tr -d '"'

}

collect_architecture() {

    uname -m

}

collect_shell() {

    if [[ -n "${SHELL:-}" ]]; then

        echo "$SHELL"

    else

        basename "$(getent passwd "$USER" | cut -d: -f7)"

    fi

}

collect_uptime() {

    uptime -p

}

###############################################################################
# HARDWARE
###############################################################################

collect_memory() {

    free -h \
        | awk '/Mem:/ {print $2}'

}

collect_cpu_model() {

    lscpu \
        | awk -F: '/Model name/ {
            gsub(/^[ \t]+/, "", $2)
            print $2
        }'

}

collect_cpu_cores() {

    nproc

}

###############################################################################
# STORAGE
###############################################################################

collect_disk_usage() {

    df -h / \
        | awk 'NR==2 {print $5}'

}

collect_block_devices() {

    lsblk \
        -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT

}

collect_mount_points() {

    mount

}

collect_fstab() {

    cat /etc/fstab

}

###############################################################################
# FILESYSTEM
###############################################################################

collect_root_device() {

    findmnt -n -o SOURCE /

}

collect_root_filesystem() {

    findmnt -n -o FSTYPE /

}

collect_root_size() {

    df -h / | awk 'NR==2 {print $2}'

}

collect_root_used() {

    df -h / | awk 'NR==2 {print $3}'

}

collect_root_available() {

    df -h / | awk 'NR==2 {print $4}'

}

collect_root_usage() {

    df -i / | awk 'NR==2 {print $5}'

}

collect_root_inode_available() {

    df -i / | awk 'NR==2 {print $4}'

}

collect_root_inode_usage() {

    df -i / | awk 'NR==2 {print $5}'

}

collect_mounted_filesystems() {

    df -hT \
        | awk 'NR==1 || $1 ~ "^/dev/"'

}

###############################################################################
# NETWORK
###############################################################################

collect_network_interfaces() {

    ip -o link show \
        | awk -F': ' '{print $2}' \
        | grep -v lo

}

collect_default_gateway() {

    ip route \
        | awk '/default/ {print $3}'

}

collect_dns_servers() {

    grep '^nameserver' /etc/resolv.conf \
        | awk '{print $2}'

}

###############################################################################
# BOOT
###############################################################################

collect_efi_partition() {

    lsblk -P \
        -o NAME,FSTYPE,LABEL,UUID,SIZE,FSUSE%,MOUNTPOINT \
        | grep 'MOUNTPOINT="/boot/efi"'

}

collect_grub_version() {

    grub-install --version 2>/dev/null \
        | head -n1

}

###############################################################################
# SOFTWARE
###############################################################################

collect_installed_kernels() {

    dpkg -l \
        | awk '/linux-image/ {print $2" "$3}'

}

collect_installed_packages() {

    dpkg-query -W 2>/dev/null

}

###############################################################################
# BACKWARD COMPATIBILITY
###############################################################################

collect_snapshot_kernel() {

    collect_kernel

}

collect_snapshot_hostname() {

    collect_hostname

}

collect_snapshot_distribution() {

    collect_distribution

}

collect_snapshot_architecture() {

    collect_architecture

}

collect_snapshot_memory() {

    collect_memory

}

collect_snapshot_disk() {

    collect_disk_usage

}

collect_snapshot_shell() {

    collect_shell

}

collect_snapshot_uptime() {

    collect_uptime

}

###############################################################################
# EFI API
###############################################################################

collect_efi_device() {

    lsblk -P \
        -o NAME,MOUNTPOINT \
        | awk -F'"' '/MOUNTPOINT="\/boot\/efi"/ {print $2}'

}

collect_efi_uuid() {

    lsblk -P \
        -o UUID,MOUNTPOINT \
        | awk -F'"' '/MOUNTPOINT="\/boot\/efi"/ {print $2}'

}

collect_efi_filesystem() {

    lsblk -P \
        -o FSTYPE,MOUNTPOINT \
        | awk -F'"' '/MOUNTPOINT="\/boot\/efi"/ {print $2}'

}

collect_efi_mountpoint() {

    echo "/boot/efi"

}

collect_efi_size() {

    lsblk -P \
        -o SIZE,MOUNTPOINT \
        | awk -F'"' '/MOUNTPOINT="\/boot\/efi"/ {print $2}'

}

collect_efi_usage() {

    lsblk -P \
        -o FSUSE%,MOUNTPOINT \
        | awk -F'"' '/MOUNTPOINT="\/boot\/efi"/ {print $2}'

}
###############################################################################
# INTERNAL HELPERS
###############################################################################

_command_exists() {

    command -v "$1" >/dev/null 2>&1

}

_safe_execute() {

    local command="$1"

    if eval "$command" 2>/dev/null; then

        return 0

    fi

    echo "N/A"

}

###############################################################################
# VALIDATION
###############################################################################

collector_self_test() {

    local missing=0

    echo
    echo "Collector Service Validation"
    echo "----------------------------------------"

    for cmd in \
        uname \
        hostname \
        grep \
        awk \
        free \
        df \
        mount \
        cat \
        ip \
        lsblk \
        dpkg-query
    do

        if _command_exists "$cmd"; then

            printf "[PASS] %-20s\n" "$cmd"

        else

            printf "[FAIL] %-20s\n" "$cmd"

            ((missing++))

        fi

    done

    if _command_exists grub-install; then

        printf "[PASS] %-20s\n" "grub-install"

    else

        printf "[WARN] %-20s\n" "grub-install"

    fi

    echo "----------------------------------------"

    if [[ "$missing" -eq 0 ]]; then

        echo "Collector validation successful."

    else

        echo "Collector validation finished with missing dependencies."

    fi

}

###############################################################################
# COLLECTOR VERSION
###############################################################################

collector_version() {

    echo "Collector API v2.0"

}

###############################################################################
# COLLECTOR INFORMATION
###############################################################################

collector_info() {

cat << EOF

Collector Service

Version : $(collector_version)

Functions available:

System
Hardware
Storage
Network
Boot
Software

EOF

}

###############################################################################
#
# EFI Mount Point
#
###############################################################################

collect_efi_mountpoint() {

    findmnt -n -o TARGET /boot/efi

}

###############################################################################
# ROADMAP
###############################################################################
#
# Future Collector API
#
# collect_secure_boot()
# collect_efi_boot_entries()
# collect_luks_devices()
# collect_btrfs_subvolumes()
# collect_zfs_pools()
# collect_swap_devices()
# collect_loaded_modules()
# collect_running_services()
# collect_open_ports()
# collect_firewall_rules()
# collect_network_routes()
# collect_users()
# collect_groups()
# collect_systemd_failed_units()
#
###############################################################################

###############################################################################
# END OF FILE
###############################################################################
