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
chmod 777 /proc/myProc
echo -"------------------------------"
cat /proc/myProc
echo "my________ device" > /proc/myProc
echo -"------------------------------"
cat /proc/myProc
rmmod hello_world_module.ko


