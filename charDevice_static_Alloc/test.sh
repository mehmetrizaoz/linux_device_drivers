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
cat /proc/devices | grep MyDevice
echo -"------------------------------"
lsmod | grep hello_world_module
echo -"------------------------------"


rmmod hello_world_module.ko


