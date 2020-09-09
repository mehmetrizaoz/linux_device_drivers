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
echo -"------------------------------"
cat /proc/devices | grep myDev
echo -"------------------------------"
ls -l /sys/class | grep myClass
echo -"------------------------------"
ls -l /dev | grep myDevice
echo -"------------------------------"


lsmod | grep hello_world_module
echo -"------------------------------"
dmesg | tail -10

rmmod hello_world_module.ko


