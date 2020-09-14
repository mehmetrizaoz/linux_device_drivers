make clean
make

cat Module.symvers
insmod driver1.ko
insmod driver2.ko
dmesg
#check whether shared function and variable become the part of kernel's symbol table or not
cat /proc/kallsyms | grep etx_shared_func
cat /proc/kallsyms | grep etx_counter
cat /dev/myDevice2
dmesg

