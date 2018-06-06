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
 * Copyright (c) 2018, Bamboo Do - All rights reserved.
 *
 * *************************************************************************************
 */
/*******************************************************************/
/**************************** Header Files *************************/
/*******************************************************************/
/* Start Including Header Files */
#include <stdio.h>
/* End Including Headers */

/*******************************************************************/
/****************************** define *****************************/
/*******************************************************************/
/* Start #define */
/* UserInput Key definitions. */
#define USER_INPUT_KEY_SELECT                (0xE001U)
#define USER_INPUT_KEY_HELP                  (0xE009U)
#define USER_INPUT_KEY_CANCEL                (0xE00DU)
#define USER_INPUT_KEY_INFO                  (0xE00EU)
#define USER_INPUT_KEY_UP                    (0xE100U)
#define USER_INPUT_KEY_DOWN                  (0xE101U)
#define USER_INPUT_KEY_NUMERIC_ZERO          (0xE300U)
#define USER_INPUT_KEY_NUMERIC_ONE           (0xE301U)
#define USER_INPUT_KEY_NUMERIC_TWO           (0xE302U)
#define USER_INPUT_KEY_NUMERIC_THREE         (0xE303U)
#define USER_INPUT_KEY_NUMERIC_FOUR          (0xE304U)
#define USER_INPUT_KEY_NUMERIC_FIVE          (0xE305U)
#define USER_INPUT_KEY_NUMERIC_SIX           (0xE306U)
#define USER_INPUT_KEY_NUMERIC_SEVEN         (0xE307U)
#define USER_INPUT_KEY_NUMERIC_EIGHT         (0xE308U)
#define USER_INPUT_KEY_NUMERIC_NINE          (0xE309U)

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
	if( ch == 0x1b ) 	// Function Key Input
	{
		// read dummy 2nd byte
		local_Getch();

		// read  3rd byte
		ch = local_Getch();
		switch(ch)
		{
			case 0x41 :
				ret_code = USER_INPUT_KEY_UP;
				break;

			case 0x42 :
				ret_code = USER_INPUT_KEY_DOWN;
				break;

			case 0x43 :
				ret_code = USER_INPUT_KEY_RIGHT;
				break;

			case 0x44 :
				ret_code = USER_INPUT_KEY_LEFT;
				break;
				
			case 0x6f : 	// o
				ret_code = USER_INPUT_KEY_SELECT;
				break;

			case 0x69 : 	// i
				ret_code = USER_INPUT_KEY_INFO;
				break;
				
			case 0x6d : 	// m
				ret_code = USER_INPUT_KEY_HELP;
				break;
				
			case 0x78 : 	// x
				ret_code = USER_INPUT_KEY_CANCEL;
				break;
			default :
				printf( " unknown key!\n");
		}
	}
	else if( (ch>='0') && (ch<='9') )
	{
		ret_code = USER_INPUT_KEY_NUMERIC_ZERO + ch - '0';
	}

	return ret_code;
}

static int local_TerminalKeyInput()
{
	int no;
	static int end_flg;
		
	printf("Start terminal input key program.\n");

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
	
	printf("End program.\n");

	return(0);
}

#define ___GLOBAL_FUNCTION_________________
int main(int argc, char *argv[])
{
	printf("\n\n\n ================================================\n");
	printf("   Start Example test application !!\n");
	printf("   Build date : %s \n", g_strAppBuildDate);
	printf("   Build user : %s \n", g_strAppBuildUser);
	printf("================================================\n\n\n");
	
	local_TerminalKeyInput();
	
    return 0;
}
/*********************** End of File ******************************/


