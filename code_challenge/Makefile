CC=g++
CFLAGS=-c -Wall -g
LDFLAGS=
SOURCES=$(wildcard *.cpp)
OBJECTS=$(SOURCES:.cpp=.o)
TARGETS=$(SOURCES:.cpp=)

#rule
all: $(TARGETS)

%: %.o
	$(CC) $(LDFLAGS) $< -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	@rm -rf $(OBJECTS) $(TARGETS)
