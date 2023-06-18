CURPATH := $(shell pwd)
CC ?= gcc
CFLAGS += -Wall -Werror -O2 -g
INCPATH ?= $(CURPATH)/../lib/out/usr/include/
LIBPATH ?= $(CURPATH)/../lib/out/usr/lib/
SHARED_LDFLAGS += -L$(LIBPATH) -lmy_libshared
STATIC_LDFLAGS += -L$(LIBPATH) -lmy_libstatic
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)
TARGETS = $(SOURCES:.c=)

all: clean $(TARGETS)_libstatic $(TARGETS)_libshared

$(TARGETS)_libstatic:
	$(CC) -o $@ $(SOURCES) $(CFLAGS) -I$(INCPATH) $(STATIC_LDFLAGS)

$(TARGETS)_libshared:
	$(CC) -o $@ $(SOURCES) $(CFLAGS) -I$(INCPATH) $(SHARED_LDFLAGS)

clean:
	@rm -f *.o $(TARGETS)_libstatic $(TARGETS)_libshared

.PHONY: all