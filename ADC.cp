#line 1 "C:/Generator/ADC.c"

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
#line 26 "C:/Generator/ADC.c"
void setXAddress(int x) {
 LCD_EN = 0;
 LCD_RS = 0;
 LCD_RW = 0;

 x = x + 0b10111000;

 P0 = x;
 LCD_EN = 1;
}
#line 40 "C:/Generator/ADC.c"
void setYAddress(int y) {
 LCD_EN = 0;
 LCD_RS = 0;
 LCD_RW = 0;

 y = y + 0b01000000;

 P0 = y;
 LCD_EN = 1;
}
#line 54 "C:/Generator/ADC.c"
void setZAddress(int z) {
 LCD_EN = 0;
 LCD_RS = 0;
 LCD_RW = 0;

 z = z + 0b11000000;

 P0 = z;
 LCD_EN = 1;
}
#line 68 "C:/Generator/ADC.c"
void writeData(char _data) {
 LCD_EN = 0;
 LCD_RS = 1;
 LCD_RW = 0;

 P0 = _data;
 LCD_EN = 1;
}
#line 82 "C:/Generator/ADC.c"
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
#line 110 "C:/Generator/ADC.c"
void displayOn() {
 LCD_EN = 1;
 LCD_RS = 0;
 LCD_RW = 0;

 P0 = 0x3f;


 LCD_CS1B=0;
 LCD_CS2B=0;
}
#line 127 "C:/Generator/ADC.c"
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
#line 164 "C:/Generator/ADC.c"
struct rcv_data {
 short first;
 short second;
 short third;
} adc_data;
#line 174 "C:/Generator/ADC.c"
void initSPI() {
 SPCR = 0b01010001;

}
#line 184 "C:/Generator/ADC.c"
void rs232init() {
 PCON = 0x80;
 TMOD = 0x022;
 TCON = 0x40;
 SCON = 0x50;
 TH1 = 0x0F5;
 P3 = 0x003;
 TR1_bit=1;
}
#line 199 "C:/Generator/ADC.c"
void transmit(char b) {
 SBUF = b;
 while(TI_bit == 0) {}
 TI_bit = 0;

}
#line 209 "C:/Generator/ADC.c"
void writeSPI(int _data) {
 SPDR = _data;
}
#line 216 "C:/Generator/ADC.c"
int readSPI() {
 int _data;
 _data = SPDR;
 return _data;
}
#line 225 "C:/Generator/ADC.c"
void delay() {
 Delay_ms(500);
}
#line 232 "C:/Generator/ADC.c"
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
#line 249 "C:/Generator/ADC.c"
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

void main() {
 char b;
 initSPI();
 rs232init();

 CS = 1;
 Delay_us(1);

 while(1) {
 adc_data = adc_get_data(0);

 transmit(adc_data.first);
 transmit(adc_data.second);
 transmit(adc_data.third);

 Delay_ms(2000);
 }
#line 349 "C:/Generator/ADC.c"
}
