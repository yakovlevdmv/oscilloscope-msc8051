 /*******************************************************
 * Copyright (C) Hlib Nekrasov (email:ganekrasov@edu.hse.ru)
 *
 * This file is part of Oscilloscope on MCU intel8051 project.
 *
 * This project can not be copied and/or distributed without the express
 * permission of Hlib Nekrasov
 *******************************************************/

//Îïîðíîå íàïðÿæåíèå ÀÖÏ
const float VREF = 4.096;

//Áèò chip select äëÿ ÀÖÏ MCP3204
sbit CS at P2_0_bit;

//Óñòàíîâêà áèòîâ äëÿ GLCD ýêðàíà
sbit LCD_CS1B at P2_2_bit; //+
sbit LCD_CS2B at P2_3_bit; //+
sbit LCD_RS   at P2_4_bit; //+
sbit LCD_RW   at P2_5_bit; //+
sbit LCD_EN   at P2_6_bit; //+
sbit LCD_RST  at P2_7_bit; //0

sbit LCD_D0 at P0_0_bit;
sbit LCD_D1 at P0_1_bit;
sbit LCD_D2 at P0_2_bit;
sbit LCD_D3 at P0_3_bit;
sbit LCD_D4 at P0_4_bit;
sbit LCD_D5 at P0_5_bit;
sbit LCD_D6 at P0_6_bit;
sbit LCD_D7 at P0_7_bit;

/*
   Óñòàíîâêà àäðåñà X GLCD ýêðàíà
*/
void setXAddress(int x) {
     LCD_EN = 0;
     LCD_RS = 0;
     LCD_RW = 0;

     x = x + 0b10111000;

     P0 = x;
     LCD_EN = 1;
}

/*
   Óñòàíîâêà àäðåñà Y GLCD ýêðàíà
*/
void setYAddress(int y) {
     LCD_EN = 0;
     LCD_RS = 0;
     LCD_RW = 0;

     y = y + 0b01000000;

     P0 = y;
     LCD_EN = 1;
}

/*
   Óñòàíîâêà àäðåñà Z GLCD ýêðàíà
*/
void setZAddress(int z) {
     LCD_EN = 0;
     LCD_RS = 0;
     LCD_RW = 0;

     z = z + 0b11000000;

     P0 = z;
     LCD_EN = 1;
}

/*
   Çàïèñü äàííûé â GLCD RAM ïî òåêóùåìó àäðåñó
*/
void writeData(char _data) {
    LCD_EN = 0;
    LCD_RS = 1;
    LCD_RW = 0;

    P0 = _data;
    LCD_EN = 1;
}

/*
   ×òåíèå äàííûé â GLCD RAM ïî òåêóùåìó àäðåñó

   PS.: Íå ðàáîòàåò
*/
int readData(int x, int y) {
    int buf = 0;
    int _cs = x / 64;
    LCD_EN = 0;
    LCD_RS = 1;
    LCD_RW = 1;

    setXAddress(y/8);
    setZAddress(0);

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

/*
  Âêëþ÷åíèå GLCD ýêðàíà (èíèöèàëèçàöèÿ)
*/
void displayOn() {
    LCD_EN = 1;
    LCD_RS = 0;
    LCD_RW = 0;

    P0 = 0x3f;

    //Âêëþ÷àåì äâå ïîëîâèíêè
    LCD_CS1B=0;
    LCD_CS2B=0;
}

/*
  Ðèñóåì òî÷êó íà GLCD ïî êîîðäèíàòàì
  x - àáöèññà,  0 - 128
  y - îðäèíàòà, 0 - 64
*/
void drawPoint(int x, int y) {
     int count = 0;
     int limit = 0;
     int mask = 0b00000001;
     int _cs = x / 64;
     setXAddress(y/8);

     if (_cs == 0 ) {
        LCD_CS1B = 0;
        LCD_CS2B = 1;
        setYAddress(x);
     } else {
        LCD_CS1B = 1;
        LCD_CS2B = 0;
//        setYAddress(64 + (x % 64));
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

void drawPointCS2(int x, int y) {
     int count = 0;
     int limit = 0;
     int mask = 0b00000001;
     //int _cs = x / 64;
     setXAddress(y/8);

     LCD_CS1B = 1;
     LCD_CS2B = 0;
     setYAddress(x % 64);
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

void resetPoint(int x, int y) {
     int count = 0;
     int limit = 0;
     int mask = 0b00000000;
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
     limit = y % 8;
//     for (count = 0; count < limit - 1; count++) {
//          mask = mask << 1;
//     }
//     if(y > 0) {
//         mask = mask << 1;
//     }
     writeData(mask);
     LCD_EN = 0;
}

/*
  Ñòðóêòóðà, îïèñûâàþùàÿ ïîëó÷àåìûå äàííûå èç ÀÖÏ
  
  first  - 0bxxxxxxnd
  second - 0bdddddddd
  third  - 0bdddxxxxx
  , ãäå x - áèò íå íåñóùèé èíôîðìàöèè
        n - null áèò - èíäèêàòîð íà÷àëà ïîëåçíûõ äàííûõ,
            çà íèì ñëåäóåò 12 áèò ðåçóëüòàòà ðàáîòû ÀÖÏ
        d - áèò, ñîäåðæàùèé ðåçóëüòàò ðàáîòû ÀÖÏ
*/
struct rcv_data {
       short first;
       short second;
       short third;
} *adc_data;

/*
  Èíèöèàëèçàöèÿ ÀÖÏ.
  ñì. Ñïåöèôèêàöèþ MCP3204
*/
void initSPI() {
     SPCR = 0b01010001;
     //SPSR = 0b11000000;
}

/*
  Èíèöèàëèçàöèÿ èíòåðôåéñà RS232 (COM-ïîðò)
  
  Copyright Palanjyan Zhorzhik
*/
void rs232init() {
     PCON = 0x80;
     TMOD = 0x022;
     TCON = 0x40;
     SCON = 0x50;
     TH1 = 0x0F5;
     P3 = 0x003;
     TR1_bit=1;
}

/*
  Ïåðåñûëêà äàííûõ ÷åðåç èíòåðôåéñ RS232 (COM-ïîðò)

  Copyright Palanjyan Zhorzhik
*/
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

void transmitStringln(char* str) {
       char *p = &str[0];

       while (*p) {
            transmit(*(p++));
       }
       
       //New line CRLF
       transmit('\r');
       transmit('\n');
}

/*
  Çàïèñü â SPI èíòåðôåéñ
*/
void writeSPI(int _data) {
     SPDR = _data;
}

/*
  ×òåíèå èç SPI èíòåðôåéñà
*/
int readSPI() {
    int _data;
    _data = SPDR;
    return _data;
}

/*
  Çàäåðæêà
*/
void delay() {
    Delay_ms(1000);
}

/*
  Ïîëó÷åíèå ðåçóëüòàòà ðàáîòû ÀÖÏ
  Àðãóìåíò channel - íîìåð êàíàëà, äëÿ ñ÷èòûâàíèÿ
*/
struct rcv_data adc_get_data(int channel) {
         struct rcv_data _data; //Ñòðóêòóðà, äëÿ õðàíåíèÿ ïîëåííûõ äàííûõ
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
         CS = 0; //Âêëþ÷åíèå ÀÖÏ

         /*
           Îòïðàâêà äàííûõ ÷åðåç SPI äëÿ óñòàíîâêè ðåæèìà è çàïóñêà ÀÖÏ
         */
         writeSPI(SPI_init_data);       //Îòïðàâêà äàííûõ äëÿ óñòàíîâêè ðåæèìà ÀÖÏ
         while(SPIF_bit != 1) {}     //Æäåì êîíöà îòïðàâêè
         _data.first = readSPI(); //×èòàåì ðåçóëüòàò
         //transmit(_data.first);   //Îòàïðâêà ðåçóëüòàòà â COM

         writeSPI(0b00000000); //Îòïðàâêà äàííûõ
         while(SPIF_bit != 1) {} //Æäåì êîíöà îòïðàâêè
         _data.second = readSPI();
         //transmit(_data.second);

         writeSPI(0b00000000);
         while(SPIF_bit != 1) {}
         _data.third = readSPI();
         //transmit(_data.third);

         CS = 1;

         return _data;
}

/*
  Ïîëó÷èòü n-ûé áèò èç áàéòà
*/
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

 /*
   Ðàñ÷åò âõîäíîãî çíà÷åíèÿ ÀÖÏ íà îñíîâå åãî âûõîäíûõ äàííûõ
 */
 float getInputValue(int _data) {
       return 4.096 * _data / 4096;
 }
 /*
   Ðàñ÷åò êîýôôèöèåíòà óñèëåíèÿ.
   Ìàêñèìàëüíîå âõîäíîå íàïðÿæåíèå 32Â. Âõîä ÀÖÏ îãðàíè÷åí 4 âîëüòàìè (MCP3204).
   Êóñ = Uâûõ/Uâõ. Ìàêñèìàëüíûé äëÿ äàííîé ñõåìû Êóñ = 4Â/32Â = 1/8.
   Âõîä ÀÖÏ îãðàíè÷åí 4 âîëüòàìè => êîýô óñèëåíèÿ ïðîïóñêàåì ÷åðåç ðåçèñòèâíûé äåëèòåëü íà 2 (Êóñ = 1/2).
   Ïîëó÷àåì, ÷òî ïðè Êóñ=8, íà âõîä ÀÖÏ ïîäàåòñÿ 4Â, ïðè Êóñ=4, íà âõîä ÀÖÏ ïîäàåòñÿ 2Â è ò.ä.
   Òàêèì îáðàçîì êîýô. óñèëåíèÿ ðàñ÷èòûâàåì ïî ñëåä. ôîðìóëå:
         Êóñ = 2 * ADC_OUT_CH1/1000
 */
 float getGain(int _data) {
       return 2. * (_data / 1000.);
 }
 
 float getMainSignalValue(float gain, float ) {
 
 }
 
/*
  Most of the Microcontrolleres having limited RAM, For Avoiding the Errors Not Enough RAM and Strings problem (const truncated) .
  You have to move the strings to ROM (FLASH program) memory, and there by save RAM.

  In MikroC
  if the string is declared as constant - compiler will move it to ROM
  This is the way in which const truncated problem can be solved if
  great number of strings was used that was located in RAM.

  Source: http://www.shibuvarkala.com/2009/02/how-to-use-rom-for-storing-data-in.html
*/
// Copying strings from ROM to RAM
void strConstCpy(char *dest, const char *source) {
  while(*source)
  *dest++ = *source++ ;

  *dest = 0 ;
}

const char *ch0 = "channel 0";
const char *ch1 = "channel 1";
const char *RESULT_STR = "ADC result: ";
const char *INPUT_STR = "ADC input: ";
const char *GAIN_STR = "Gain: ";
const char *CRLF = "\r\n";

const int LCD_X_LIMIT = 128;
const int LCD_Y_LIMIT = 64;

void debugADC() {

     char textBuffer[15];
     //char out_buffer[6]; // Ðåçóëüòàò ÀÖÏ - ñòðîêà
     //char in_buffer[6]; // Âõîä ÀÖÏ - ñòðîêà
     //char k_buffer[6]; // Êîýôôèöèåíò óñèëåíèÿ
     int adc_result; // Ðåçóëüòàò ÀÖÏ - ÷èñëî
     float inputValue; // Âõîä ÀÖÏ - ÷èñëî
     float k; // Êîýôôèöèåíò óñèëåíèÿ - ÷èñëî
     float mainInputSignal;
              /*
                Ïîëó÷åíèå 3 áèò, êàê ðåçóëüòàò ðàáîòû ÀÖÏ
              */
              *adc_data = adc_get_data(0);
              /*
                Çàïèñü áèò, íåñóùèõ ïîëåçíóþ èíôîðìàöèþ â îäíî ÷èñëî
              */
              adc_result = parseADCValue(adc_data);

              inputValue = getInputValue(adc_result); //Ïåðåñ÷åò âõîäíîãî çíà÷åíèÿ íà îñíîâå âûõîäíîãî

              /*
                Âûâîä â COM íîìåð êàíàëà, ïîëó÷åííîå çíà÷åíèå ÀÖÏ, ðàññ÷èòàííîå âõîäíîå çíà÷åíèå
              */
              strConstCpy(textBuffer, ch0);         //"channel 0"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232

              /*
                New line
              */
              strConstCpy(textBuffer, CRLF);        //"\r\n"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
              /*
                New Line ending
              */

              strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
              transmitString(textBuffer);

              IntToStr(adc_result, textBuffer);       //Ðåçóëüòàò ÀÖÏ ê ñòðîêîâîìó ïðåäñòàâëåíèþ
              transmitString(textBuffer);             //Ïåðåäà÷à â RS232

              /*
                New line
              */
              strConstCpy(textBuffer, CRLF);        //"\r\n"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
              /*
                New Line ending
              */

              strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
              transmitString(textBuffer);

              FloatToStr(inputValue, textBuffer);     //Ðàñ÷èòàííîå âõîäíîå çíà÷åíèå ê ñòðîêîâîìó ïðåäñòàâëåíèþ
              transmitStringln(textBuffer);

              Delay_ms(1000);                         //Çàäåðæêà â 1 ñåêóíäó

              /*
                Ïîëó÷åíèå 3 áèòà êàê ðåçóëüòàò ðàáîòû ÀÖÏ
              */
              *adc_data = adc_get_data(1);
              /*
                Ïîëó÷åíèå ïîëåçíûõ áèòîâ è èõ çàïèñü â îäíî ÷èñëî
              */
              adc_result = parseADCValue(adc_data);

              /*
                Ïåðåñ÷åò âõîäíîãî çíà÷åíèÿ íà îñíîâå âûõîäíîãî
              */
              inputValue = getInputValue(adc_result); //Ïåðåñ÷åò âõîäíîãî çíà÷åíèÿ íà îñíîâå âûõîäíîãî
              k = getGain(adc_result);                //Ðàñ÷åò êîýôôèöèåíòà óñèëåíèÿ

              /*
                Âûâîä â COM íîìåð êàíàëà, ïîëó÷åííîå çíà÷åíèå ÀÖÏ, ðàññ÷èòàííîå âõîäíîå çíà÷åíèå, ðàññ÷èòàííûé êîýôôèöèåíò óñèëåíèÿ
              */

              /*
                New line
              */
              strConstCpy(textBuffer, CRLF);        //"\r\n"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
              /*
                New Line ending
              */
              strConstCpy(textBuffer, ch1);           //"channel 1"
              transmitStringln(textBuffer);           //Îòïðàâêà ñòðîêè â RS232

              strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
              transmitString(textBuffer);

              IntToStr(adc_result, textBuffer);       //Ðåçóëüòàò ÀÖÏ ê ñòðîêîâîìó ïðåäñòàâëåíèþ
              transmitString(textBuffer);

              /*
                New line
              */
              strConstCpy(textBuffer, CRLF);        //"\r\n"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
              /*
                New Line ending
              */

              strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
              transmitString(textBuffer);

              FloatToStr(inputValue, textBuffer);     //Ðàñ÷èòàííîå âõîäíîå çíà÷åíèå ê ñòðîêîâîìó ïðåäñòàâëåíèþ
              transmitString(textBuffer);

              /*
                New line
              */
              strConstCpy(textBuffer, CRLF);        //"\r\n"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
              /*
                New Line ending
              */

              strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
              transmitString(textBuffer);

              FloatToStr(k, textBuffer);             //Ðàñ÷èòàííûé êîýôôèöèåíò óñèëåíèÿ ê ñòðîêîâîìó ïðåäñòàâëåíèþ
              transmitString(textBuffer);

              /*
                New line
              */
              strConstCpy(textBuffer, CRLF);        //"\r\n"
              transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
              transmitString(textBuffer);
              /*
                New Line ending
              */

              Delay_ms(1000);                       //Çàäåðæêà 1 ñåê.
}

 void FillBrightness(int brightness) {
     int x,y;
     for(x = 0; x <=128; x++) {
           for(y = 0; y <=64; y++) {
                  resetPoint(x,y);
           }
     }
//     for(y=0;y<=64;y++) {
//         for(x = 0; x <= 8; x++) {
//               setYAddress(y);
//               Delay_ms(500);
//               setXAddress(x);
//               Delay_ms(500);
//               setZAddress(0);
//               Delay_ms(500);
//               writeData(brightness);
//               Delay_ms(100);
//         }
//     }
}

void clear() {
     FillBrightness(0);
}

void fill() {
     FillBrightness(255);
}

void main() {
     char textBuffer[15];
     int adc_result, x, y; // Ðåçóëüòàò ÀÖÏ - ÷èñëî
     int flag = 0;

     initSPI(); //Èíèöèàëèçàöèÿ SPI
     rs232init(); // Èíèöèàëèçàöèÿ RS232

     CS = 1;
     Delay_us(1);
     y = 0;
     x = 0;
     //LCD
     displayOn();
     clear();
     while(1) {
//              if (flag == 0) {
                     /*
                      Ïîëó÷åíèå 3 áèò, êàê ðåçóëüòàò ðàáîòû ÀÖÏ
                    */
                    *adc_data = adc_get_data(0);
                    /*
                      Çàïèñü áèò, íåñóùèõ ïîëåçíóþ èíôîðìàöèþ â îäíî ÷èñëî
                    */
                    adc_result = parseADCValue(adc_data);

                    strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
                    transmitString(textBuffer);

                    IntToStr(adc_result, textBuffer);       //Ðåçóëüòàò ÀÖÏ ê ñòðîêîâîìó ïðåäñòàâëåíèþ
                    transmitString(textBuffer);             //Ïåðåäà÷à â RS232

                    /*
                      New line
                    */
                    strConstCpy(textBuffer, CRLF);        //"\r\n"
                    transmitString(textBuffer);           //Îòïðàâêà ñòðîêè â RS232
                    /*
                      New Line ending
                    */

                    y = 64 - adc_result / LCD_Y_LIMIT;
                    drawPoint(x, y);
                    x = x + 1;
                    if (x == 128) {
//                       flag = 1;
                       x = 0;
                       clear();
                    }

//              }
              //drawPoint(0,0);
              //drawPoint(1,1);
              //drawPoint(2,2);
              //Delay_ms(1000);
     }
}
