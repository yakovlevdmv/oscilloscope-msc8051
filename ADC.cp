#line 1 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
#line 1 "d:/program files (x86)/mikroc pro for 8051/include/stdio.h"
#line 1 "d:/program files (x86)/mikroc pro for 8051/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
int max(int a, int b);
int min(int a, int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "d:/program files (x86)/mikroc pro for 8051/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 6 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
sbit CS at P2_0_bit;


sbit LCD_CS1B at P2_2_bit;
sbit LCD_CS2B at P2_3_bit;
sbit LCD_RS at P2_4_bit;
sbit LCD_RW at P2_5_bit;
sbit LCD_EN at P2_6_bit;
sbit LCD_RST at P2_7_bit;

sbit LCD_D0 at P0_0_bit;
sbit LCD_D1 at P0_1_bit;
sbit LCD_D2 at P0_2_bit;
sbit LCD_D3 at P0_3_bit;
sbit LCD_D4 at P0_4_bit;
sbit LCD_D5 at P0_5_bit;
sbit LCD_D6 at P0_6_bit;
sbit LCD_D7 at P0_7_bit;

int mask1, mask2, mask, count, limit, _cs, buf;
#line 30 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void setXAddress(int x) {
 LCD_EN = 0;
 LCD_RS = 0;
 LCD_RW = 0;

 x = x + 0b10111000;

 P0 = x;
 LCD_EN = 1;
}
#line 44 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void setYAddress(int y) {
 LCD_EN = 0;
 LCD_RS = 0;
 LCD_RW = 0;

 y = y + 0b01000000;

 P0 = y;
 LCD_EN = 1;
}
#line 58 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void setZAddress(int z) {
 LCD_EN = 0;
 LCD_RS = 0;
 LCD_RW = 0;

 z = z + 0b11000000;

 P0 = z;
 LCD_EN = 1;
}
#line 72 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void writeData(char _data) {
 LCD_EN = 0;
 LCD_RS = 1;
 LCD_RW = 0;

 P0 = _data;
 LCD_EN = 1;
}
#line 86 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
int readData(int x, int y) {
 LCD_EN = 0;
 LCD_RS = 1;
 LCD_RW = 1;

 setXAddress(y/8);
 setZAddress(0);
 _cs = x / 64;

 if (_cs == 0 ) {
 LCD_CS1B = 0;
 LCD_CS2B = 1;
 setYAddress(x);
 } else {
 LCD_CS1B = 1;
 LCD_CS2B = 0;
 setYAddress(64 + (x % 64));
 }

 LCD_EN = 1;
 buf = P0;
 LCD_EN = 0;
 return buf;
}
#line 114 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void displayOn() {
 LCD_EN = 1;
 LCD_RS = 0;
 LCD_RW = 0;

 P0 = 0x3f;


 LCD_CS1B=0;
 LCD_CS2B=0;
}
#line 131 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void drawPoint(int x, int y) {
 mask = 0b00000001;
 setXAddress(y/8);
 _cs = x / 64;

 if (_cs == 0 ) {
 LCD_CS1B = 0;
 LCD_CS2B = 1;
 setYAddress(x);
 } else {
 LCD_CS1B = 1;
 LCD_CS2B = 0;
 setYAddress(64 + (x % 64));
 }
 setZAddress(0);
 limit = y % 8;
 for (count = 0; count < limit - 1; count++) {
 mask = mask << 1;
 }
 if(y > 0) {
 mask = mask << 1;
 }
 writeData(mask);
 LCD_EN = 0;
}
#line 168 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
struct rcv_data {
 short first;
 short second;
 short third;
} adc_data;
#line 178 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void initSPI() {
 SPCR = 0b01010001;

}
#line 188 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void rs232init() {
 PCON = 0x80;
 TMOD = 0x022;
 TCON = 0x40;
 SCON = 0x50;
 TH1 = 0x0F5;
 P3 = 0x003;
 TR1_bit=1;
}
#line 203 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void transmit(char b) {
 SBUF = b;
 while(TI_bit == 0) {}
 TI_bit = 0;

}

void transmitString(char* str) {
 char ch = str[0];
 char *p = &str[0];

 while (*p) {
 transmit(*(p++));
 }
}
#line 222 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void writeSPI(int _data) {
 SPDR = _data;
}
#line 229 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
int readSPI() {
 int _data;
 _data = SPDR;
 return _data;
}
#line 238 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
void delay() {
 Delay_ms(500);
}
#line 246 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
struct rcv_data adc_get_data(int channel) {
 struct rcv_data _data;
 int SPI_init_data = 0b11000000;
 if(channel == 0) {
 SPI_init_data += 0b00000000;
 } else if(channel == 1) {
 SPI_init_data += 0b00010000;
 } else if(channel == 2) {
 SPI_init_data += 0b00100000;
 } else if(channel == 3) {
 SPI_init_data += 0b00110000;
 }
 CS = 0;
#line 263 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
 writeSPI(SPI_init_data);
 while(SPIF_bit != 1) {}
 _data.first = readSPI();


 writeSPI(0b00000000);
 while(SPIF_bit != 1) {}
 _data.second = readSPI();


 writeSPI(0b00000000);
 while(SPIF_bit != 1) {}
 _data.third = readSPI();


 CS = 1;

 return _data;
}

int getBit(int position, int byte) {
 return (byte >> position) & 1;
}

int parseADCValue(struct rcv_data adc_data) {
 int result = 0b000000000000;
 int i = 0;

 result += getBit(0, adc_data.first);


 for(i = 7; i >= 0; i--) {
 result <<= 1;
 result += getBit(i, adc_data.second);
 }

 for (i = 7; i >=5; i--) {
 result <<= 1;
 result += getBit(i, adc_data.third);
 }

 return result;
}

union {
 int source;
 char tgt[sizeof(int)];
} converter;
#line 318 "D:/Projects/TUV/oscilloscope-msc8051/ADC.c"
 void reverse(char s[])
 {
 int i, j;
 char c;

 for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
 c = s[i];
 s[i] = s[j];
 s[j] = c;
 }
 }


 void itoa(int n, char s[])
 {
 int i, sign;

 if ((sign = n) < 0)
 n = -n;
 i = 0;
 do {
 s[i++] = n % 10 + '0';
 } while ((n /= 10) > 0);
 if (sign < 0)
 s[i++] = '-';
 s[i] = '\0';
 reverse(s);
 }

void main() {
 char ch0[] = "channel 1\n\0";
 char ch1[] = "channel 2\n\0";
 char buffer[10];
 int adc_result;
 char b;
 initSPI();
 rs232init();

 CS = 1;
 Delay_us(1);

 while(1) {
 adc_data = adc_get_data(0);
 transmitString(ch0);

 adc_result = parseADCValue(adc_data);
 itoa(adc_result, buffer);
 transmit(buffer);





 Delay_ms(5000);








 }
}
