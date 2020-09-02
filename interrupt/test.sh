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
#insmod hello_world_module.ko
echo "********************************"
lsmod | grep hello
echo "********************************"
chmod 777 /dev/myDevice
ls -al /dev/myDevice
echo "********************************"
cat /proc/interrupts | grep my
echo "********************************"
chmod 777 /sys/kernel/mySysfs/
chmod 777 /sys/kernel/mySysfs/etx_value
ls -al /sys/kernel/mySysfs/
echo "********************************"
cat /sys/kernel/mySysfs/etx_value
echo "\n********************************"
ls -al /sys/class/myClass/
echo "********************************"
cat /proc/devices | grep my
#rmmod hello_world_module.ko
#dmesg

