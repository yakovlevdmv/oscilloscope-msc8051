 /*******************************************************
 * Copyright (C) Hlib Nekrasov (email:ganekrasov@edu.hse.ru)
 *
 * This file is part of Oscilloscope on MCU intel8051 project.
 *
 * This project can not be copied and/or distributed without the express
 * permission of Hlib Nekrasov
 *******************************************************/

sbit CS at P2_0_bit;

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

const int LCD_X_LIMIT = 128;
const int LCD_Y_LIMIT = 64;
const float VREF = 4.096;

struct rcv_data {
       short first;
       short second;
       short third;
} *adc_data;



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

void writeSPI(int _data) {
     SPDR = _data;
}


int readSPI() {
    int _data;
    _data = SPDR;
    return _data;
}

struct rcv_data adc_get_data(int channel) {
         struct rcv_data _data;
         int SPI_init_data = 0b11000000;
         if(channel == 0) {
                    SPI_init_data += 0b00000000;
         } else if(channel == 1) {
                    SPI_init_data += 0b00001000;
         } else if(channel == 2) {
                    SPI_init_data += 0b00010000;
         } else if(channel == 3) {
                    SPI_init_data += 0b00011000;
         }
         P0 = SPI_init_data;
         CS = 0;


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

int parseADCValue(struct rcv_data *adc_data) {
    int result = 0b000000000000;
    int i = 0;
    //First byte
    result += getBit(0, adc_data->first);
    //Second byte
    for(i = 7; i >= 0; i--) {
          result <<= 1;
          result += getBit(i, adc_data->second);
    }
    //Third
    for (i = 7; i >=5; i--) {
        result <<= 1;
        result += getBit(i, adc_data->third);
    }

    return result;
}

void main() {
     char textBuffer[15];
     int adc_result;
     int y = 0;
     int x = 0;
     int speed = 1;
     int pressed = -1;
     int pause = 0;
     int pause_pressed = -1;

     CS = 1;
     P3=0;
     Delay_us(1);

     //LCD
     initSPI();
     displayOn();
     clear(0, 128);

     while(1) {
              if(pause == 1 && x == 127) {
                       if(P3_2_bit == 1) {
                              if (pause_pressed == -1) {
                                 if(pause == 0){
                                          pause = 1;
                                 } else {
                                        pause = 0;
                                 }
                              }
                              pause_pressed = 0;
                        } else if(P3_2_bit == 0){
                                pause_pressed = -1;
                        }
                       continue;
              } else {
              *adc_data = adc_get_data(0);
              adc_result = parseADCValue(adc_data);

              y = 64 - adc_result / LCD_Y_LIMIT;
              y = y - 1;
              drawPoint(x, y, 0);
              x = x + 1;
              if (x == 128) {
                    x = 0;
                    clear(0, 128);
              }
              
              if(P3_2_bit == 1) {
                    if (pause_pressed == -1) {
                       if(pause == 0){
                                pause = 1;
                       } else {
                              pause = 0;
                       }
                    }
                    pause_pressed = 0;
              } else if(P3_2_bit == 0){
                      pause_pressed = -1;
              }

              if(P3_0_bit == 1) {
                          if (pressed == -1) {
                                  speed = speed + 1;
                          }
                          pressed = 0;
              } else if(P3_0_bit == 0 && P3_1_bit != 1) {
                        pressed = -1;
              } else if(P3_1_bit == 1) {
                          if (pressed == -1 && speed > 0) {
                                  speed = speed - 1;
                          }
                          pressed = 0;
              } else if(P3_1_bit == 0) {
                        pressed = -1;
              } else {
                      pressed = -1;
              }
              
              Vdelay_ms(speed);
              }
     }
}