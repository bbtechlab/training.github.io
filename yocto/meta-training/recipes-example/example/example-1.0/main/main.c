/*
 * *************************************************************************************
 *
 * Filename     : main.c
 *
 * Description  : 
 *
 * Version      : 1.0
 * Created      : 06/04/2018 10:19:03 AM
 * Revision     : none
 * Compiler     : gcc
 *
 * Author       : Bamboo Do, dovanquyen.vn@gmail.com
 * Copyright (c) 2018, BBTECH Lab - All rights reserved.
 *
 * *************************************************************************************
 */
/*******************************************************************/
/**************************** Header Files *************************/
/*******************************************************************/
/* Start Including Header Files */
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
/* End Including Headers */

/*******************************************************************/
/****************************** define *****************************/
/*******************************************************************/
/* Start #define */
/* Default color logs */
#define BBLOG_DEFAULT_COLOR_NONE         	"\033[0m"   /* NONE */
#define BBLOG_DEFAULT_COLOR_TRACE        	"\033[0m"   /* NONE */
#define BBLOG_DEFAULT_COLOR_MSG          	"\033[0m"   /* NONE */
#define BBLOG_DEFAULT_COLOR_DBG          	"\033[35m"  /* MAGENTA */
#define BBLOG_DEFAULT_COLOR_WRN          	"\033[34m"  /* BLUE */
#define BBLOG_DEFAULT_COLOR_ERR          	"\033[31m"  /* RED */
#define BB_ERR(fmt, ...)    				fprintf(stdout, BBLOG_DEFAULT_COLOR_ERR fmt  BBLOG_DEFAULT_COLOR_NONE "",  ## __VA_ARGS__)
#define BB_WRN(fmt, ...)    				fprintf(stdout, BBLOG_DEFAULT_COLOR_WRN fmt  BBLOG_DEFAULT_COLOR_NONE "", ## __VA_ARGS__)
#define BB_DBG(fmt, ...)    				fprintf(stdout, BBLOG_DEFAULT_COLOR_DBG fmt  BBLOG_DEFAULT_COLOR_NONE "",  ## __VA_ARGS__)
#define BB_MSG(fmt, ...)    				fprintf(stdout, BBLOG_DEFAULT_COLOR_MSG fmt  BBLOG_DEFAULT_COLOR_NONE "",  ## __VA_ARGS__)
#define BB_TRACE(fmt, ...)  				fprintf(stdout, BBLOG_DEFAULT_COLOR_TRACE fmt  BBLOG_DEFAULT_COLOR_NONE "",  ## __VA_ARGS__)

/* UserInput Key definitions. */
#define USER_INPUT_KEY_SELECT                (0x6f)
#define USER_INPUT_KEY_HELP                  (0x6d)
#define USER_INPUT_KEY_CANCEL                (0x78)
#define USER_INPUT_KEY_INFO                  (0x69)
#define USER_INPUT_KEY_UP                    (0x41)
#define USER_INPUT_KEY_DOWN                  (0x42)
#define USER_INPUT_KEY_LEFT                  (0x44)
#define USER_INPUT_KEY_RIGHT                 (0x43)
#define USER_INPUT_KEY_NUMERIC_ZERO          (0x30)
#define USER_INPUT_KEY_NUMERIC_ONE           (0x31)
#define USER_INPUT_KEY_NUMERIC_TWO           (0x32)
#define USER_INPUT_KEY_NUMERIC_THREE         (0x33)
#define USER_INPUT_KEY_NUMERIC_FOUR          (0x34)
#define USER_INPUT_KEY_NUMERIC_FIVE          (0x35)
#define USER_INPUT_KEY_NUMERIC_SIX           (0x36)
#define USER_INPUT_KEY_NUMERIC_SEVEN         (0x37)
#define USER_INPUT_KEY_NUMERIC_EIGHT         (0x38)
#define USER_INPUT_KEY_NUMERIC_NINE          (0x39)

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
/* End static variable */


/*******************************************************************/
/******************** Global Functions ********************/
/*******************************************************************/
/* Start global functions */
extern const char *g_strAppBuildDate;
extern const char *g_strAppBuildUser;
/* End global functions */


/*******************************************************************/
/*********************** Static Functions **************************/
/*******************************************************************/
/* Start static functions */
/* End static functions */


/*******************************************************************/
/*********************** Function Description***********************/
/*******************************************************************/
#define ___STATIC_FUNCTION_________________
static unsigned char local_Getch(void)
{
	int ch;

	while(1)
	{
		ch = getchar(); // standard getchar call //
		if(ch != EOF||ch!=-1)
		break;
	}

	return (unsigned char)(ch & 0xff); /*return received char */
}

static int local_GetFromConsole(void)
{
	int		ret_code = -1;
	unsigned char ch;

	ch = local_Getch();
	
	if( (ch>='0') && (ch<='9') )
	{
		ret_code = USER_INPUT_KEY_NUMERIC_ZERO + ch - '0';
	}
	else
	{
		switch(ch)
		{
			case USER_INPUT_KEY_UP :
				ret_code = USER_INPUT_KEY_UP;
				BB_MSG("Up Key down!\n");
				break;

			case 0x42 :
				ret_code = USER_INPUT_KEY_DOWN;
				BB_MSG("Down Key down!\n");
				break;

			case 0x43 :
				ret_code = USER_INPUT_KEY_RIGHT;
				BB_MSG("Right Key down!\n");
				break;

			case 0x44 :
				ret_code = USER_INPUT_KEY_LEFT;
				BB_MSG("Left Key down!\n");
				break;
				
			case 0x6f : 	// o
				ret_code = USER_INPUT_KEY_SELECT;
				BB_MSG("Select Key down!\n");
				break;

			case 0x69 : 	// i
				ret_code = USER_INPUT_KEY_INFO;
				BB_MSG("Info Key down!\n");
				break;
				
			case 0x6d : 	// m
				ret_code = USER_INPUT_KEY_HELP;
				BB_MSG("Help Key down!\n");
				break;
				
			case 0x78 : 	// x
				ret_code = USER_INPUT_KEY_CANCEL;
				BB_MSG("Cancel Key down!\n");
				break;
			default :
				BB_WRN( " Unknown Key!\n");
		}
	}
	
	return ret_code;
}

static int local_TerminalKeyInput()
{
	int no;
	static int end_flg;
		
	BB_MSG("Start terminal input key program.\n");

	end_flg = 0;
	while (end_flg == 0)
	{
		printf( "\nmenu\n");
		printf( "  ARROW : Up/Down/Left/Right key\n");
		printf( "  NUM   : 0~9 key\n");
		printf( "  o     : OK key\n");
		printf( "  i     : Info key\n");
		printf( "  u     : Ch UP key\n");
		printf( "  d     : Ch Down key\n");
		printf( "  m     : help\n");
		printf( "  x     : Exit\n\n");
		no = local_GetFromConsole();
		if( no > 0 )
		{
			if( no == USER_INPUT_KEY_CANCEL )
			{
				/* Infinitvie loop */
				end_flg = 1;				
			}
			else if (no == USER_INPUT_KEY_HELP)
			{
			}
			else
			{
			}
		}
	}
	
	BB_MSG("End program.\n");

	return(0);
}

#define ___GLOBAL_FUNCTION_________________
int main(int argc, char *argv[])
{
	BB_DBG("\n\n\n ================================================\n");
	BB_DBG("   Start Example-1.0 test application !!\n");
	BB_DBG("   Build date : %s \n", g_strAppBuildDate);
	BB_DBG("   Build user : %s \n", g_strAppBuildUser);
	BB_DBG("================================================\n\n\n");
	
	local_TerminalKeyInput();
	
    return 0;
}
/*********************** End of File ******************************/


