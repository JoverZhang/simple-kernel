NASM	=nasm
CC		=gcc
QEMU	=qemu-system-x86_64
LD		=ld -m elf_i386

CFLAGS	=-m32 -c -Iinclude

.c.o:
	$(CC) $(CFLAGS) -c -o $*.o $<

clean_and_run: clean run

run: all
	$(QEMU) -kernel Image

all: Image

Image: boot/boot lib/lib.o kernel/kernel.o init/main.o
	$(LD) -T boot/wakeup.ld -o Image \
    	boot/boot lib/lib.o kernel/kernel.o init/main.o

boot/boot:
	$(NASM) -f elf32 boot/entry.S -o boot/boot

kernel/kernel.o:
	$(CC) $(CFLAGS) -o kernel/kernel.o kernel/printk.c

lib/lib.o:
	$(CC) $(CFLAGS) -o lib/lib.o lib/string.c

clean:
	-@rm Image boot/boot init/*.o kernel/*.o lib/*.o

#### Dependencies:
init/main.o: init/main.c include/kernel/kernel.h \
	include/string.h
