#CC=gcc
#STRIP=strip
CC=aarch64-linux-gnu-gcc
STRIP=aarch64-linux-gnu-strip
CFLAGS=-Wall -Wextra -Werror -ansi -pedantic -std=gnu99 -Os -ffunction-sections -fdata-sections
LDFLAGS=-s -Wl,--gc-sections
EXEC=ubnt-fan-speed
SRC=$(wildcard *.c)
OBJ=$(SRC:.c=.o)

all: $(EXEC) clean

ubnt-fan-speed: $(OBJ)
	@$(CC) -o $@ $^ $(LDFLAGS)
	@$(STRIP) --strip-all --remove-section=.comment --remove-section=.note $(EXEC)

board.o: board.h cpu.h fan.h temperature.h util.h config.h
config.o: config.h
cpu.o: util.h
fan.o: fan.h util.h
main.o: board.h util.h fan.h cpu.h signal.h config.h
temperature.o: util.h
signal.o: board.h config.h

%.o: %.c
	@$(CC) -o $@ -c $< $(CFLAGS)

.PHONY: clean

clean:
	@rm -rf *.o
