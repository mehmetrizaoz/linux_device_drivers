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
chmod 777 /sys/kernel/mySysfs/etx_value
chmod 777 /dev/myDevice
cat /sys/kernel/mySysfs/etx_value

#change etx_value
echo 5 > /sys/kernel/mySysfs/etx_value
cat /sys/kernel/mySysfs/etx_value
#add value in etx_value every esc keypress to linked list
echo "press esc"
#traverse linked list
cat /dev/myDevice

echo "********************************"
echo "********************************"
echo "********************************"
echo "lsmod | grep hello"
lsmod | grep hello
echo "********************************"
echo "ls -al /dev/myDevice"
chmod 777 /dev/myDevice
ls -al /dev/myDevice
echo "********************************"
echo "cat /proc/interrupts | grep my"
cat /proc/interrupts | grep my
echo "********************************"
echo "ls -al /sys/kernel/mySysfs/"
chmod 777 /sys/kernel/mySysfs/
chmod 777 /sys/kernel/mySysfs/etx_value
ls -al /sys/kernel/mySysfs/
echo "********************************"
echo "cat /sys/kernel/mySysfs/etx_value"
cat /sys/kernel/mySysfs/etx_value
echo "\n********************************"
echo "ls -al /sys/class/myClass/"
ls -al /sys/class/myClass/
echo "********************************"
echo "cat /proc/devices | grep my"
cat /proc/devices | grep my
#rmmod hello_world_module.ko
#dmesg

