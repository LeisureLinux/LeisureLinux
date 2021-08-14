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

BUS () {
lspci -b -vv
lsusb 
lsusb -t
}

BIOS () {
	dmidecode
}

# Main Prog.
# DISK
# ROOT_PART=$(blkid -U $(cat /proc/cmdline |tr ' ' '\n'|awk -F= '/^root=/ {print $NF}'))
# Much easy way:
findmnt -n -o source /
# [ -n "$BLKID" ] && echo "$BLKID"
