/*
 * *************************************************************************************
 *
 * Filename     : Receiver.c
 *
 * Description  : Recive Multicast Datagram code example
 *
 * Version      : 1.0
 * Created      : 12/18/2018 02:02:55 PM
 * Revision     : none
 * Compiler     : gcc
 *
 * Author       : Bamboo Do, dovanquyen.vn@gmail.com, bamboo@bbtechlab.com
 * Copyright (c) 2018, Humax - All rights reserved.
 *
 * *************************************************************************************
 */
/*******************************************************************/
/**************************** Header Files *************************/
/*******************************************************************/
/* Start Including Header Files */
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
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
/* End static variable */


/*******************************************************************/
/******************** Global Functions ********************/
/*******************************************************************/
/* Start global functions */
struct sockaddr_in    localSock;
struct ip_mreq        group;
int                   sd;
int                   datalen;
char                  databuf[1024];
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

#define ___GLOBAL_FUNCTION_________________
int main (int argc, char *argv[])
{
    /*
    * Create a datagram socket on which to receive.
    *
    */
    sd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sd < 0)
    {
        perror("opening datagram socket");
        exit(1);
    }
    /*
    * Enable SO_REUSEADDR to allow multiple instances of this
    * application to receive copies of the multicast datagrams.
    *
    */
    {
        int reuse=1;

        if (setsockopt(sd, SOL_SOCKET, SO_REUSEADDR, (char *)&reuse, sizeof(reuse)) < 0)
        {
            perror("setting SO_REUSEADDR");
            close(sd);
            exit(1);
        }
    }

    /*
     * Bind to the proper port number with the IP address
     * specified as INADDR_ANY.
     *
     */
    memset((char *) &localSock, 0, sizeof(localSock));
    localSock.sin_family = AF_INET;
    localSock.sin_port = htons(1900);;
    localSock.sin_addr.s_addr  = INADDR_ANY;

    if (bind(sd, (struct sockaddr*)&localSock, sizeof(localSock)))
    {
        perror("binding datagram socket");
        close(sd);
        exit(1);
    }


    /*
    * Join the multicast group 239.255.255.250 on the local 192.168.0.35
    * interface.  Note that this IP_ADD_MEMBERSHIP option must be
    * called for each local interface over which the multicast
    * datagrams are to be received.
    *
    */
    group.imr_multiaddr.s_addr = inet_addr("239.255.255.250");
    group.imr_interface.s_addr = inet_addr("192.168.0.35");
    if (setsockopt(sd, IPPROTO_IP, IP_ADD_MEMBERSHIP, (char *)&group, sizeof(group)) < 0)
    {
        perror("adding multicast group");
        close(sd);
        exit(1);
    }

    /*
     * Read from the socket.
     */
    while(1)
    {
        datalen = sizeof(databuf);
        if (read(sd, databuf, datalen) < 0)
        {
            perror("reading datagram message");
            close(sd);
            exit(1);
        }
        else
        {
            printf("%s\n", databuf);
        }
    }

    return 0;
}

/*********************** End of File ******************************/


