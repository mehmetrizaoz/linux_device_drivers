#!/bin/sh
####################################################
# test.sh    : hello_world driver
# Usage      : sudo ./test.sh &
#
# Todo List  :
#
# Date       : 25/08/2020
# Author     : Mehmet Rıza ÖZ - mehmetrizaoz@gmail.com
#####################################################
clear
insmod hello_world_module.ko

ls -l /sys/kernel/etx_sysfs
echo "------------------------"
cat /sys/kernel/etx_sysfs/etx_value
echo "------------------------"
echo 123 > /sys/kernel/etx_sysfs/etx_value
cat /sys/kernel/etx_sysfs/etx_value
echo "------------------------"

rmmod hello_world_module.ko
#dmesg | tail -10

