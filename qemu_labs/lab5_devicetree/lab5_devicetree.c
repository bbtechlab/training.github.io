/*
 * *************************************************************************************
 *
 * Filename     : lab5_devicetree.c
 *
 * Description  : 
 *
 * Version      : 1.0
 * Created      : 03/15/2021 09:35:45 PM
 * Revision     : none
 * Compiler     : gcc
 *
 * Author       : Bamboo Do (vqdo), dovanquyen.vn@gmail.com
 * Copyright (c) 2021, bbtechlab - All rights reserved.
 *
 * *************************************************************************************
 */
/*******************************************************************/
/**************************** Header Files *************************/
/*******************************************************************/
/* Start Including Header Files */
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/of.h>
/* End Including Headers */

/*******************************************************************/
/****************************** define *****************************/
/*******************************************************************/
/* Start #define */
/* End #define */

/*******************************************************************/
/*********************** Type Defination ***************************/
/*******************************************************************/
/* Start typedef */
/* End typedef */


/*******************************************************************/
/*********************** Global Variables **************************/
/*******************************************************************/
/* Start global variable */
/* End global variable */


/*******************************************************************/
/*********************** Static Variables **************************/
/*******************************************************************/
/* Start static variable */
static struct of_device_id lab5_devtree_ids[] = {
    {.compatible = "BBTECHLAB, lab5_devicetree"},
    {},
};
MODULE_DEVICE_TABLE(of, lab5_devtree_ids);
/* End static variable */


/*******************************************************************/
/******************** Global Functions ********************/
/*******************************************************************/
/* Start global functions */
/* End global functions */


/*******************************************************************/
/*********************** Static Functions **************************/
/*******************************************************************/
/* Start static functions */
static int lab5_devtree_probe(struct platform_device *drv);
static int lab5_devtree_remove(struct platform_device *drv);
/* End static functions */


/*******************************************************************/
/*********************** Function Description***********************/
/*******************************************************************/
#define ___STATIC_FUNCTION_________________
static struct platform_driver plab5_devtreedrv = {
    .probe = lab5_devtree_probe,
    .remove = lab5_devtree_remove,
    .driver = {
        .name = "Dummy_lab5_devtreedrv",
        .of_match_table = of_match_ptr(lab5_devtree_ids),
        .owner = THIS_MODULE,
    },
};

#define ___GLOBAL_FUNCTION_________________
static int 
lab5_devtree_probe(struct platform_device *drv)
{
    const char *pucString = NULL;
    int iVal = 0;
    struct device_node *pDevNode = drv->dev.of_node;

    printk("++ Enter lab5_devtree_probe\n");
    
    if (pDevNode)
    {
        printk("Dummy DTB compatible name: %s\n", drv->name);

        of_property_read_string(pDevNode, "string-property", &pucString);
        printk("Dummy string property from DTB: %s\n", pucString);

        of_property_read_u32(pDevNode, "number_property", &iVal);
        printk("Dummy number property from DTB: %d", iVal);
    }

    printk("-- Exit lab5_devtree_probe\n");

    return 0;
}
static int
lab5_devtree_remove(struct platform_device *drv)
{
    struct device_node *pDevNode = drv->dev.of_node;

    printk("++ Enter lab5_devtree_remove\n");
    
    if(pDevNode)
    {
        printk("Trying to remove DTB compatible name: %s\n", drv->name);
    }
    
    printk("-- Exit lab5_devtree_remove\n");

    return 0;
}

module_platform_driver(plab5_devtreedrv);

MODULE_AUTHOR("Bamboo Do - BBTECHLAB");
MODULE_DESCRIPTION("Example");
MODULE_LICENSE("GPL");
MODULE_VERSION("1.0");

/*********************** End of File ******************************/
