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

insmod hello_world_module.ko
echo -"------------------------------"
cat /proc/devices
echo -"------------------------------"
lsmod
echo -"------------------------------"


rmmod hello_world_module.ko


