#!/bin/sh
####################################################
# test.sh    : hello_world driver
# Usage      : sh drive.sh &
#
# Todo List  :
#
# Date       : 25/08/2020
# Author     : Mehmet Rıza ÖZ - mehmetrizaoz@gmail.com
#####################################################

insmod hello_world_module.ko
rmmod hello_world_module.ko
dmesg
echo "------------------------------"
modinfo hello_world_module.ko


