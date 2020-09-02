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
echo "0***-"
lsmod | grep hello

echo "1***-"
chmod 777 /dev/myDevice
ls -al /dev/myDevice

echo "2***-"
cat /proc/interrupts | grep my

echo "3***-"
chmod 777 /sys/kernel/mySysfs/
chmod 777 /sys/kernel/mySysfs/etx_value
ls -al /sys/kernel/mySysfs/

echo "4***-"
cat /sys/kernel/mySysfs/etx_value

echo "\n5***-"
ls -al /sys/class/myClass/

echo "\6***-"
cat /proc/devices | grep my


#rmmod hello_world_module.ko
#dmesg

