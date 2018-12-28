#
# Copyright (C) 2018 BBTech Lab
#

# define SHELL

LC_ALL		= C
LANG		= C
export SHELL	= /usr/bin/env bash

# define compiler
CC = gcc
CFLAGS =
LIBS =

# define subdirectories
TOP_DIR=$(shell pwd)
UPNP_DIR=$(TOP_DIR)/upnp

upnp: 
	make -C $(UPNP_DIR) CC=$(CC) CFLAGS=$(CFLAGS) LIBS=$(LIBS) all

upnp-clean:
	make -C $(UPNP_DIR) CC=$(CC) CFLAGS=$(CFLAGS) LIBS=$(LIBS) clean
	
clean: upnp-clean
	
.PHONY: clean upnp upnp-clean		