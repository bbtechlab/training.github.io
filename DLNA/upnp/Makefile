#
# Copyright (C) 2018 BBTech Lab
#

# define SHELL

LC_ALL		= C
LANG		= C
export SHELL	= /usr/bin/env bash

PROGS = Receiver

all: $(PROGS)

Receiver: Receiver.o
	$(CC) $(CFLAGS) -o $@ $< $(LIB)
	
clean:
	rm -rf $(PROGS)
	
.PHONY: all