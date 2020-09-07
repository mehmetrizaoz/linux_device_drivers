obj-m += hello_world_module.o
KDIR = /lib/modules/$(shell uname -r)/build
 
all:
	make -C $(KDIR)  M=$(shell pwd) modules
	gcc -o test_app test_app.c
clean:
	make -C $(KDIR)  M=$(shell pwd) clean
	rm test_app
