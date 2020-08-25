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
echo "------------------------------"

echo 13 > /sys/module/hello_world_module/parameters/cb_valueETX

echo "------------------------------"
dmesg
echo "------------------------------"
modinfo hello_world_module.ko
echo "------------------------------"
rmmod hello_world_module.ko

