all: entry.o kernel.o
	ld -m elf_i386 -T wakeup.ld -o kernel entry.o kernel.o

kernel.o: entry.o
	gcc -fno-stack-protector -m32 -c kernel.c

entry.o:
	nasm -f elf32 entry.S

run: all
	qemu-system-x86_64 -kernel kernel

clean:
	-@rm kernel.o entry.o kernel

