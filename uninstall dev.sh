#!/bin/bash

module_bin="/lib/modules/$(uname -r)/kernel/drivers/net/wireless/mt7601Usta.ko"

if [ -f ${module_bin} ]; then
    echo Module Found!
    echo Uninstalling...
    sudo rmmod mt7601Usta
    sudo rm /etc/Wireless/RT2870STA/RT2870STA.dat
    sudo rm /etc/Wireless/RT2870STA/
    sudo rm /etc/udev/rules.d/95-ralink.rules
    echo Uninstall Complete!
    echo You may need to restart.
else
    echo Module Not Found!
fi