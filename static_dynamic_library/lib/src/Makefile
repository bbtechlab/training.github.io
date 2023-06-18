CURPATH := $(shell pwd)
CC ?= gcc
AR ?= ar
INSTALL ?= @install
INCPATH ?= $(CURPATH)
PREFIX ?= $(CURPATH)/../out
INCDIR = $(PREFIX)/usr/include/
LIBDIR = $(PREFIX)/usr/lib/
CFLAGS += -Wall -Werror -O2 -fPIC -g

SOURCES = $(wildcard *.c)
HEADERS = $(SOURCES:.c=.h)
OBJECTS = $(SOURCES:.c=.o)

all: clean install

libmy_libshared.so: $(OBJECTS)
	@echo "linking ... $< $@"
	$(CC) -shared -o $@ $<
	@chmod a+x $@

libmy_libstatic.a: $(OBJECTS)
	@echo "linking ... $< $@"
	$(AR) -rsv $@ $<
	@chmod a+x $@

.c.o:
	@echo "compiling ... $<"
	$(CC) -c $(CFLAGS) -I$(INCPATH) $< -o $@

install: libmy_libshared.so libmy_libstatic.a
	@echo "installing ... $(HEADERS)"
	$(INSTALL) -D $(HEADERS) $(INCDIR)
	@echo "installing ... $^"
	$(INSTALL) -D $^ $(LIBDIR)

clean:
	@rm -f $(LIBDIR)/*.so $(LIBDIR)/*.a
	@rm -f $(INCDIR)/*.h
	@rm -f $(CURPATH)/*.so $(CURPATH)/*.a
	@rm -f $(CURPATH)/*.o

.PHONY: all
