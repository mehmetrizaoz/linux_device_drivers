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
echo "------------------------------"
modinfo hello_world_module.ko 
insmod hello_world_module.ko valueETX=14 nameETX="ahmet" arr_valueETX=100,102,104,106
echo "------------------------------"
lsmod | grep hello_world
echo "------------------------------"
echo 8 > /sys/module/hello_world_module/parameters/cb_valueETX
echo 9 > /sys/module/hello_world_module/parameters/valueETX
echo 10,11,12,13 > /sys/module/hello_world_module/parameters/arr_valueETX
echo "mehmet" > /sys/module/hello_world_module/parameters/nameETX
echo "------------------------------"
dmesg | tail  -10
echo "------------------------------"
cat /sys/module/hello_world_module/parameters/cb_valueETX
cat /sys/module/hello_world_module/parameters/valueETX
cat /sys/module/hello_world_module/parameters/arr_valueETX
cat /sys/module/hello_world_module/parameters/nameETX
echo "------------------------------"
rmmod hello_world_module.ko

