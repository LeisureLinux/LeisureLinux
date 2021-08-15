#!/bin/bash
# Grab Hardware Info
# 2021-8-14

CPU () {
    lscpu
    cpuid -1
}

#
DISK () {
    for d in $(lshw -class disk|awk '/logical name:/ {print $NF}')
    do
        smartctl --all $d
    done
    efibootmgr -uv
}

ROOT () {
    # ROOT_PART=$(blkid -U $(cat /proc/cmdline |tr ' ' '\n'|awk -F= '/^root=/ {print $NF}'))
    # Much easy way:
    findmnt -n -o source /
}

BUS () {
    lspci -b -vv
    lsusb
    lsusb -t
}

BIOS () {
    dmidecode
}

NETWORK () {
    netstat -nlpt
    netstat -nlpu
    netstat -nlpx
}

SERVICES () {
    systemctl list-machines
    systemctl --failed
    systemctl get-default
    systemctl --state=running
}


# Main Prog.
export LC_ALL=C
# DISK
# [ -n "$BLKID" ] && echo "$BLKID"
[ $(id -u) != 0 ] && echo "Error: Must be root to run this script." && exit 0
#
SERVICES
