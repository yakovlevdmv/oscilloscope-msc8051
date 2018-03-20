

 /*******************************************************
 * Copyright (C) Hlib Nekrasov (email:ganekrasov@edu.hse.ru)
 *
 * This file is part of Oscilloscope on MCU intel8051 project.
 *
 * This project can not be copied and/or distributed without the express
 * permission of Hlib Nekrasov
 *******************************************************/

sbit CS at P2_0_bit;

const short LCD_X_LIMIT = 128;
const short LCD_Y_LIMIT = 64;
const float VREF = 4.096;

short first, second, third;

sbit LCD_CS1B at P2_2_bit;
sbit LCD_CS2B at P2_3_bit;
sbit LCD_RS   at P2_4_bit;
sbit LCD_RW   at P2_5_bit;
sbit LCD_EN   at P2_6_bit;
sbit LCD_RST  at P2_7_bit;


sbit LCD_D0 at P0_0_bit;
sbit LCD_D1 at P0_1_bit;
sbit LCD_D2 at P0_2_bit;
sbit LCD_D3 at P0_3_bit;
sbit LCD_D4 at P0_4_bit;
sbit LCD_D5 at P0_5_bit;
sbit LCD_D6 at P0_6_bit;
sbit LCD_D7 at P0_7_bit;

void setXAddress(int x) {
     LCD_EN = 0;
     LCD_RS = 0;
     LCD_RW = 0;

     x = x + 0b10111000;

     P0 = x;
     LCD_EN = 1;
}

void setYAddress(int y) {
     LCD_EN = 0;
     LCD_RS = 0;
     LCD_RW = 0;

     y = y + 0b01000000;

     P0 = y;
     LCD_EN = 1;
}

void setZAddress(int z) {
     LCD_EN = 0;
     LCD_RS = 0;
     LCD_RW = 0;

     z = z + 0b11000000;

     P0 = z;
     LCD_EN = 1;
}

void writeData(char _data) {
    LCD_EN = 0;
    LCD_RS = 1;
    LCD_RW = 0;

    P0 = _data;
    LCD_EN = 1;
}

void displayOn() {
    LCD_EN = 1;
    LCD_RS = 0;
    LCD_RW = 0;

    P0 = 0x3f;

    LCD_CS1B=0;
    LCD_CS2B=0;
}

void drawPoint(int x, int y, int flag) {
     int count = 0;
     int limit = 0;
     int mask = 0b00000001;
     int _cs = x / 64;
     if (flag == 1) {
          mask = 0b00000000;
     }
     setXAddress(y/8);

     if (_cs == 0 ) {
        LCD_CS1B = 0;
        LCD_CS2B = 1;
        setYAddress(x);
     } else {
        LCD_CS1B = 1;
        LCD_CS2B = 0;
        setYAddress(x % 64);
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
     //Delay_ms(1000);
     LCD_EN = 0;
}

void drawMask(int x, int y, int mask) {
     int _cs = x / 64;
     setXAddress(y/8);

     if (_cs == 0 ) {
        LCD_CS1B = 0;
        LCD_CS2B = 1;
        setYAddress(x);
     } else {
        LCD_CS1B = 1;
        LCD_CS2B = 0;
        setYAddress(x % 64);
     }
     setZAddress(0);
     writeData(mask);
     LCD_EN = 0;
}

void drawVLine(int column) {
     int count = 0;
     int mask = 0b11111111;
     int _cs = column / 64;

     for(count = 0; count < 8; count++) {
       if (_cs == 0 ) {
          LCD_CS1B = 0;
          LCD_CS2B = 1;
          setYAddress(column);
       } else {
          LCD_CS1B = 1;
          LCD_CS2B = 0;
          setYAddress(column % 64);
       }
       setXAddress(count);
       setZAddress(0);
       writeData(mask);
     }

     LCD_EN = 0;
}

int clear(int limit_left, int limit_right) {
     int x,y;
     if (limit_left >= limit_right) return -1;

     for(x = limit_left; x < limit_right; x++) {
           for(y = 0; y <=64; y=y+8) {
//                  drawPoint(x, y, 1);
                    drawMask(x,y, 0b00000000);
           }
     }
     return 0;
}



void initSPI() {
     SPCR = 0b01010011;
}

void rs232init() {
     PCON = 0x80;
     TMOD = 0x022;
     TCON = 0x40;
     SCON = 0x50;
     TH1 = 0x0F5;
     P3 = 0x003;
     TR1_bit=1;
}

void transmit(char b) {
     SBUF = b;
     while(TI_bit == 0) {}
     TI_bit = 0;

}

void transmitString(char* str) {
       char *p = &str[0];

       while (*p) {
            transmit(*(p++));
       }
}

void writeSPI(int _data) {
     SPDR = _data;
}


int readSPI() {
    int _data;
    _data = SPDR;
    return _data;
}

void delay() {
    Delay_ms(1000);
}

short adc_get_data() {

         CS = 0;

         SPDR = 0b11000000;
         while(SPIF_bit != 1) {}
         first = SPDR;

         SPDR = 0b00000000;
         while(SPIF_bit != 1) {}
         second = SPDR;

         SPDR = 0b00000000;
         while(SPIF_bit != 1) {}
         third = SPDR;

         CS = 1;

         first  = first & 0b00000001;
         //second = 0b11111111;
         third  = third & 0b11100000;
         asm {
               MOV R0, _first+0
               MOV R1, _second+0
               MOV R2, _third+0
               MOV R3, #5

               ;Сдвиг первого байта вправо на 1
               MOV A, R0 ; R0 -> A
               RRC A     ; Сдвиг A вправо
               MOV R0, A
               SHIFT: ;Сдвиг
                   MOV A, R1 ;
                   RRC A     ;
                   MOV R1, A
                   MOV A, R2 ;
                   RRC A      ;
                   MOV R2, A  ;
                   MOV A, R3
                   DEC A
                   MOV R3, A
               JNZ SHIFT

               MOV _first, R0
               MOV _second, R1
               MOV _third, R2
           }
           return LCD_Y_LIMIT - ((second * 256 + third) / LCD_Y_LIMIT);//Деленное на LCD limit = 64 ==>> 256/64 = 4

}

int Abs(int num) {
	if(num < 0)
		return -num;
	else
		return num;
}

void Brezenhem(int x0, int y0, int x1, int y1)
{
     int A, B, sign, signa, signb;
     int x, y;
     int f = 0;
     A = y1 - y0;
     B = x0 - x1;
     if (abs(A) > abs(B))
	sign = 1;
     else
	sign = -1;
     if (A < 0)
	  signa = -1;
     else
	  signa = 1;
     if (B < 0)
	  signb = -1;
     else
	  signb = 1;
     drawPoint(x0,y0, 0);
     x = x0;
     y = y0;
     if (sign == -1)
     {
      do {
         f += A*signa;
         if (f > 0)
         {
            f -= B*signb;
            y += signa;
         }
         x -= signb;
         drawPoint(x, y, 0);
    } while (x != x1 || y != y1);
  }
  else
  {
    do {
      f += B*signb;
      if (f > 0) {
        f -= A*signa;
        x -= signb;
      }
      y += signa;
      drawPoint(x, y, 0);
    } while (x != x1 || y != y1);
  }
}

void main() {
     idata unsigned short adc_buffer[128];
     char buffer[15];
     short adc_result;
     short y = 0;
     unsigned short x = 0;
     
     int prevx;
     int prevy;

     prevx=0;
     prevy=0;

     initSPI();

     CS = 1;
     Delay_us(1);

     //LCD
     displayOn();
     clear(0, 128);
     
     while(1) {
              if(x < 128) {
                   P3_1_bit = 1;
                   adc_buffer[x] = adc_get_data();
                   x = x + 1;
                   P3_1_bit = 0;
              } else {
                   x = 0;
                   for(; x < 128; x++) {
                        y = adc_buffer[x];
                        y = y - 1;
                        if(x == 0) {
                             prevx = x;
                             prevy = y;
                        } else if (x > 0) {
                             Brezenhem(prevx, prevy, x, y);
                             prevx = x;
                             prevy = y;
                        }
                   }
                   Delay_ms(500);
                   x = 0;
                   clear(0, 128);
              }
     }
}