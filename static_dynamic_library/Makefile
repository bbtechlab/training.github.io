CURPATH := $(shell pwd)
CC ?= gcc
AR ?= ar

all: library test

library:
	$(MAKE) -C $(CURPATH)/lib/src CC=$(CC) AR=$(AR) all

test:
	$(MAKE) -C $(CURPATH)/test CC=$(CC) AR=$(AR) all

.PHONY: all