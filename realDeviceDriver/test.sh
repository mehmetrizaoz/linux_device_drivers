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
chmod 777 /dev/etx_device
insmod hello_world_module.ko
echo -"------------------------------"
./test_app

dmesg | tail -10
#rmmod hello_world_module.ko


