/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Galal/Downloads/master1.v";
static const char *ng1 = "G:/test.txt";
static const char *ng2 = "data:";
static int ng3[] = {0, 0};
static int ng4[] = {7, 0};
static const char *ng5 = "%d:%h";
static int ng6[] = {1, 0};



static void Initial_162_0(char *t0)
{
    char *t1;

LAB0:    xsi_set_current_line(162, ng0);
    t1 = (t0 + 736);
    xsi_vlogfile_readmemb(ng1, 0, t1, 0, 0, 0, 0);

LAB1:    return;
}

static void Initial_164_1(char *t0)
{
    char t5[8];
    char t18[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(164, ng0);

LAB2:    xsi_set_current_line(165, ng0);
    xsi_vlogfile_write(1, 0, 0, ng2, 1, t0);
    xsi_set_current_line(166, ng0);
    xsi_set_current_line(166, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 828);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);

LAB3:    t1 = (t0 + 828);
    t2 = (t1 + 36U);
    t3 = *((char **)t2);
    t4 = ((char*)((ng4)));
    memset(t5, 0, 8);
    xsi_vlog_signed_less(t5, 32, t3, 32, t4, 32);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB4;

LAB5:
LAB1:    return;
LAB4:    xsi_set_current_line(167, ng0);
    t12 = (t0 + 828);
    t13 = (t12 + 36U);
    t14 = *((char **)t13);
    t15 = (t0 + 736);
    t16 = (t15 + 36U);
    t17 = *((char **)t16);
    t19 = (t0 + 736);
    t20 = (t19 + 44U);
    t21 = *((char **)t20);
    t22 = (t0 + 736);
    t23 = (t22 + 40U);
    t24 = *((char **)t23);
    t25 = (t0 + 828);
    t26 = (t25 + 36U);
    t27 = *((char **)t26);
    xsi_vlog_generic_get_array_select_value(t18, 8, t17, t21, t24, 2, 1, t27, 32, 1);
    xsi_vlogfile_write(1, 0, 0, ng5, 3, t0, (char)119, t14, 32, (char)118, t18, 8);
    xsi_set_current_line(166, ng0);
    t1 = (t0 + 828);
    t2 = (t1 + 36U);
    t3 = *((char **)t2);
    t4 = ((char*)((ng6)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t3, 32, t4, 32);
    t6 = (t0 + 828);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    goto LAB3;

}


extern void work_m_00000000002215070582_1526828028_init()
{
	static char *pe[] = {(void *)Initial_162_0,(void *)Initial_164_1};
	xsi_register_didat("work_m_00000000002215070582_1526828028", "isim/file_read_isim_beh.exe.sim/work/m_00000000002215070582_1526828028.didat");
	xsi_register_executes(pe);
}
