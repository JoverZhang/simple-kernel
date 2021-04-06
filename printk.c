#include "string.c"

#define VIDEO_PTR 0xb8000
#define CLR 0x07
#define HEIGHT 25
#define WIDTH 80
#define DW 2 * WIDTH


char *vptr = (char*) VIDEO_PTR;
int h = 0, w = 0;


void init_printk()
{
	memset(vptr, 0, HEIGHT * DW);
}

void putchar(int ch)
{
	// wrap
	if (ch == '\n' || w >= DW - 2) {
		w = 0;

		if (h < HEIGHT - 1)
			h++;
		else {
			int last_line_offset = DW * (HEIGHT - 1);
			memcpy(vptr, vptr + DW, last_line_offset);
			memset(vptr + last_line_offset, 0, DW);
		}
	}
	else {
		vptr[h * DW + w * 2] = ch;
		vptr[h * DW + w * 2 + 1] = CLR;
		w++;
	}
}

void puts(const char *str)
{
	while (*str)
		putchar(*str++);
}

void printk(const char *str)
{
	puts(str);
}

