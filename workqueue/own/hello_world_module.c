#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kdev_t.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/slab.h>     //kmalloc()
#include <linux/uaccess.h>  //copy_to/from_user()
#include <linux/sysfs.h> 
#include <linux/kobject.h> 
#include <linux/interrupt.h>
#include <asm/io.h>
#include <linux/workqueue.h>   // Required for workqueues

#define IRQ_NO 1

static struct workqueue_struct *own_workqueue;
static void workqueue_fn(struct work_struct *work); 
static DECLARE_WORK(work, workqueue_fn);
 
/*Workqueue Function*/
static void workqueue_fn(struct work_struct *work){
    printk(KERN_INFO "Executing Workqueue Function\n");
    return;    
} 
 
static irqreturn_t irq_handler(int irq, void *dev_id, struct pt_regs *regs){
    static unsigned char scancode, status;
    status   = inb(0x64);
    scancode = inb(0x60);
    switch (scancode){
      case 0x01:  
         printk (KERN_INFO "! You pressed Esc ...\n");
         queue_work(own_workqueue, &work);    
      break;
      
      case 0x3B:  
         printk (KERN_INFO "! You pressed F1 ...\n");
      break;
      
      case 0x3C:  
         printk (KERN_INFO "! You pressed F2 ...\n");
      break;
      
      default: break;
    }
    return IRQ_HANDLED;
} 
 
volatile int etx_value = 0;
 
dev_t dev = 0;
static struct class *dev_class;
static struct cdev etx_cdev;
struct kobject *kobj_ref;
 
static int __init etx_driver_init(void);
static void __exit etx_driver_exit(void);
 
/*************** Driver Fuctions **********************/
static int etx_open(struct inode *inode, struct file *file);
static int etx_release(struct inode *inode, struct file *file);
static ssize_t etx_read(struct file *filp, char __user *buf, size_t len,loff_t * off);
static ssize_t etx_write(struct file *filp, const char *buf, size_t len, loff_t * off);
 
/*************** Sysfs Fuctions **********************/
static ssize_t sysfs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf);
static ssize_t sysfs_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count);
 
struct kobj_attribute etx_attr = __ATTR(etx_value, 0660, sysfs_show, sysfs_store);
 
static struct file_operations fops ={
    .owner      = THIS_MODULE,
    .read       = etx_read,
    .write      = etx_write,
    .open       = etx_open,
    .release    = etx_release,
};
 
static ssize_t sysfs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){
    printk(KERN_INFO "Sysfs - Read!!!\n");
    return sprintf(buf, "%d", etx_value);
}
 
static ssize_t sysfs_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count){
    printk(KERN_INFO "Sysfs - Write!!!\n");
    sscanf(buf,"%d",&etx_value);
    return count;
}
 
static int etx_open(struct inode *inode, struct file *file){
    printk(KERN_INFO "Device File Opened...!!!\n");
    return 0;
}
 
static int etx_release(struct inode *inode, struct file *file){
    printk(KERN_INFO "Device File Closed...!!!\n");
    return 0;
}
 
static ssize_t etx_read(struct file *filp, char __user *buf, size_t len, loff_t *off){
    printk(KERN_INFO "Read function\n");
    return 0;
}
 
static ssize_t etx_write(struct file *filp, const char __user *buf, size_t len, loff_t *off){
    printk(KERN_INFO "Write Function\n");
    return 0;
}
 
static int __init etx_driver_init(void){
    /*Allocating Major number*/
    if((alloc_chrdev_region(&dev, 0, 1, "myDev")) <0){
       printk(KERN_INFO "Cannot allocate major number\n");
       return -1;
    }
    printk(KERN_INFO "Major = %d Minor = %d \n",MAJOR(dev), MINOR(dev));
 
    /*Creating cdev structure*/
    cdev_init(&etx_cdev,&fops);
 
    /*Adding character device to the system*/
    if((cdev_add(&etx_cdev,dev,1)) < 0){
       printk(KERN_INFO "Cannot add the device to the system\n");
       goto r_class;
    }
 
    /*Creating struct class*/
    if((dev_class = class_create(THIS_MODULE,"myClass")) == NULL){
       printk(KERN_INFO "Cannot create the struct class\n");
       goto r_class;
    }
 
    /*Creating device*/
    if((device_create(dev_class,NULL,dev,NULL,"myDevice")) == NULL){
       printk(KERN_INFO "Cannot create the Device 1\n");
       goto r_device;
    }
 
    /*Creating a directory in /sys/kernel/ */
    kobj_ref = kobject_create_and_add("mySysfs",kernel_kobj);
 
    /*Creating sysfs file for etx_value*/
    if(sysfs_create_file(kobj_ref,&etx_attr.attr)){
       printk(KERN_INFO"Cannot create sysfs file......\n");
       goto r_sysfs;
    }
    
    if(request_irq (IRQ_NO, (irq_handler_t)irq_handler, IRQF_SHARED, "myDevice", (void*)(irq_handler))) {
       printk(KERN_INFO "my_device: cannot register IRQ ");
       goto irq;
    }
    
    /*Creating workqueue */
    own_workqueue = create_workqueue("own_wq");    
    
    printk(KERN_INFO "Device Driver Insert...Done!!!\n");
    return 0;
 
irq:
    free_irq(IRQ_NO,(void *)(irq_handler));
 
r_sysfs:
    kobject_put(kobj_ref); 
    sysfs_remove_file(kernel_kobj, &etx_attr.attr);
 
r_device:
    class_destroy(dev_class);
r_class:
    unregister_chrdev_region(dev,1);
    cdev_del(&etx_cdev);
    return -1;
}
 
void __exit etx_driver_exit(void){
    destroy_workqueue(own_workqueue);
    free_irq(IRQ_NO,(void *)(irq_handler));
    kobject_put(kobj_ref); 
    sysfs_remove_file(kernel_kobj, &etx_attr.attr);
    device_destroy(dev_class,dev);
    class_destroy(dev_class);
    cdev_del(&etx_cdev);
    unregister_chrdev_region(dev, 1);
    printk(KERN_INFO "Device Driver Remove...Done!!!\n");
}
 
module_init(etx_driver_init);
module_exit(etx_driver_exit);
 
MODULE_LICENSE("GPL");
MODULE_AUTHOR("<mehmetrizaoz@gmail.com>");
MODULE_DESCRIPTION("A simple device driver - Interrupts");
MODULE_VERSION("1.9");


