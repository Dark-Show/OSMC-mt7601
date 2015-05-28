#!/bin/bash

set -- $(cat /proc/cmdline) && for x in "$@"; do case "$x" in osmcdev=*) mypi=${x#osmcdev=}; ;; esac; done

module_bin="./kernel/${mypi}-$(uname -r)/mt7601Usta.ko"
module_dir="/lib/modules/$(uname -r)/kernel/drivers/net/wireless"

if [ -f ${module_bin} ]; then
    echo "Found Kernel Module!"
    echo "Installing!"
    sudo mkdir -p /etc/Wireless/RT2870STA/
    sudo cp RT2870STA.dat /etc/Wireless/RT2870STA/
    sudo cp 95-ralink.rules /etc/udev/rules.d/
    sudo install -p -m 644 $module_bin $module_dir
    sudo depmod $kernel
    echo "Please Reboot!"
else
    echo "Kernel Module Not Found!"
    echo "Please Run Compile Script!"
fi