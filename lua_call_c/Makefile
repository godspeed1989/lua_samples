CC = gcc
CFLAGS = -Wall -I../../include
LIBS = -L../../lib -llua52
LDFLAGS = -fPIC
TARGET = mylib

all: $(TARGET).dll run_lua

$(TARGET).o: $(TARGET).c
run_lua.o:   run_lua.c

$(TARGET).dll: $(TARGET).o
	$(CC) -shared $(LDFLAGS) $+ $(LIBS) -o $@

run_lua: run_lua.o
	$(CC) $+ $(LIBS) -o $@
