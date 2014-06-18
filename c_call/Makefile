CC = gcc
CFLAGS = -Wall -I../include
LIBS = -L../lib -llua
TARGET = c_call_lua

all: $(TARGET)

$(TARGET).o: $(TARGET).c

$(TARGET): $(TARGET).o
	$(CC) $+ $(LIBS) -o $@ 
