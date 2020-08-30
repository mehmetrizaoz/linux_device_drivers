#!/bin/sh
####################################################
# test.sh    : hello_world driver
# Usage      : sudo ./test.sh &
#
# Todo List  :
#
# Date       : 30/08/2020
# Author     : Mehmet Rıza ÖZ - mehmetrizaoz@gmail.com
#####################################################
clear
insmod hello_world_module.ko
cat /dev/myDevice
cat /dev/myDevice
cat /dev/myDevice
cat /dev/myDevice
cat /dev/myDevice
cat /dev/myDevice
cat /dev/myDevice
rmmod hello_world_module.ko
dmesg

