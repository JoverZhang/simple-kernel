all: entry.o kernel.o
	ld -m elf_i386 -T wakeup.ld -o kernel entry.o kernel.o

kernel.o:
	gcc -m32 -c kernel.c string.c printk.c

entry.o:
	nasm -f elf32 entry.S

run: all
	qemu-system-x86_64 -kernel kernel

clean:
	-@rm kernel.o entry.o string.o printk.o kernel

