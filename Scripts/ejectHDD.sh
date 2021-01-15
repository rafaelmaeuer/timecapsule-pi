#!/bin/bash

param=$1

drive="{NameOfDrive}"
mount=`df -h | grep "$drive" | head -c 9`
disk=`echo "$mount" | head -c 8`

echo "stop netatalk service"
sudo service netatalk stop
sleep 1

echo "unmount $mount"
sudo udisksctl unmount -b "$mount"
sleep 1

echo "spindown $disk"
sudo udisksctl power-off -b "$disk"
sleep 1

if [ "$param" ==  "shutdown" ]; then
    echo "shutdown now"
    sleep 1
    sudo shutdown now
fi