# network_load event provider Makefile

CC = clang
CFLAGS = -O2 -Wall

SRC = network_load.c
BIN_DIR = bin
TARGET = $(BIN_DIR)/network_load

.PHONY: all clean

all: $(TARGET)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(TARGET): $(SRC) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -rf $(BIN_DIR)
