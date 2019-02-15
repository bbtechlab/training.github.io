# Define a variable for classpath
CLASS_PATH = $(shell pwd)/bin

# Define include
CFLAGS = -I"${JAVA_HOME}/include" -I"${JAVA_HOME}/include/linux"

# Define a virtual path for .class in the bin directory
vpath %.class $(CLASS_PATH)

all : libHelloJNI.so

# $@ matches the target, $< matches the first dependency
libHelloJNI.so : HelloJNI.o
	gcc -fPIC -shared -o $@ $<

# $@ matches the target, $< matches the first dependency
HelloJNI.o : HelloJNI.c HelloJNI.h
	gcc -fPIC $(CFLAGS) -c $< -o $@
	
# $* matches the target filename without the extension
HelloJNI.h : HelloJNI.class
	javah $*
	
HelloJNI.class : HelloJNI.java
	javac $<

clean :
	rm -rf *.o
	rm -rf *.so
	rm -rf *.class
	
.PHONY: clean all	
