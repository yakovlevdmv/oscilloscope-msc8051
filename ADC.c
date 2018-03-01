//������� ���������� ���
const float VREF = 4.096;

//��� chip select ��� ��� MCP3204
sbit CS at P2_0_bit;

//��������� ����� ��� GLCD ������
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
   ��������� ������ X GLCD ������
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
   ��������� ������ Y GLCD ������
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
   ��������� ������ Z GLCD ������
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
   ������ ������ � GLCD RAM �� �������� ������
*/
void writeData(char _data) {
    LCD_EN = 0;
    LCD_RS = 1;
    LCD_RW = 0;

    P0 = _data;
    LCD_EN = 1;
}

/*
   ������ ������ � GLCD RAM �� �������� ������

   PS.: �� ��������
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
  ��������� GLCD ������ (�������������)
*/
void displayOn() {
    LCD_EN = 1;
    LCD_RS = 0;
    LCD_RW = 0;

    P0 = 0x3f;

    //�������� ��� ���������
    LCD_CS1B=0;
    LCD_CS2B=0;
}

/*
  ������ ����� �� GLCD �� �����������
  x - �������,  0 - 128
  y - ��������, 0 - 64
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

/*
  ���������, ����������� ���������� ������ �� ���
  
  first  - 0bxxxxxxnd
  second - 0bdddddddd
  third  - 0bdddxxxxx
  , ��� x - ��� �� ������� ����������
        n - null ��� - ��������� ������ �������� ������,
            �� ��� ������� 12 ��� ���������� ������ ���
        d - ���, ���������� ��������� ������ ���
*/
struct rcv_data {
       short first;
       short second;
       short third;
} *adc_data;

/*
  ������������� ���.
  ��. ������������ MCP3204
*/
void initSPI() {
     SPCR = 0b01010001;
     //SPSR = 0b11000000;
}

/*
  ������������� ���������� RS232 (COM-����)
  
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
  ��������� ������ ����� ��������� RS232 (COM-����)

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
  ������ � SPI ���������
*/
void writeSPI(int _data) {
     SPDR = _data;
}

/*
  ������ �� SPI ����������
*/
int readSPI() {
    int _data;
    _data = SPDR;
    return _data;
}

/*
  ��������
*/
void delay() {
    Delay_ms(1000);
}

/*
  ��������� ���������� ������ ���
  �������� channel - ����� ������, ��� ����������
*/
struct rcv_data adc_get_data(int channel) {
         struct rcv_data _data; //���������, ��� �������� �������� ������
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
         CS = 0; //��������� ���

         /*
           �������� ������ ����� SPI ��� ��������� ������ � ������� ���
         */
         writeSPI(SPI_init_data);       //�������� ������ ��� ��������� ������ ���
         while(SPIF_bit != 1) {}     //���� ����� ��������
         _data.first = readSPI(); //������ ���������
         //transmit(_data.first);   //�������� ���������� � COM

         writeSPI(0b00000000); //�������� ������
         while(SPIF_bit != 1) {} //���� ����� ��������
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
  �������� n-�� ��� �� �����
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
   ������ �������� �������� ��� �� ������ ��� �������� ������
 */
 float getInputValue(int _data) {
       return 4.096 * _data / 4096;
 }
 /*
   ������ ������������ ��������.
   ������������ ������� ���������� 32�. ���� ��� ��������� 4 �������� (MCP3204).
   ��� = U���/U��. ������������ ��� ������ ����� ��� = 4�/32� = 1/8.
   ���� ��� ��������� 4 �������� => ���� �������� ���������� ����� ����������� �������� �� 2 (��� = 1/2).
   ��������, ��� ��� ���=8, �� ���� ��� �������� 4�, ��� ���=4, �� ���� ��� �������� 2� � �.�.
   ����� ������� ����. �������� ����������� �� ����. �������:
         ��� = 2 * ADC_OUT_CH1/1000
 */
 float getGain(int _data) {
       return 2 * _data / 1000;
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


void main() {
     char textBuffer[15];
     //char out_buffer[6]; // ��������� ��� - ������
     //char in_buffer[6]; // ���� ��� - ������
     //char k_buffer[6]; // ����������� ��������
     int adc_result; // ��������� ��� - �����
     float inputValue; // ���� ��� - �����
     float k; // ����������� �������� - �����
     
     //float numBuffer;

     initSPI(); //������������� SPI
     rs232init(); // ������������� RS232

     CS = 1;
     Delay_us(1);

     while(1) {
              /*
                ��������� 3 ���, ��� ��������� ������ ���
              */
              *adc_data = adc_get_data(0);
              /*
                ������ ���, ������� �������� ���������� � ���� �����
              */
              adc_result = parseADCValue(adc_data);
              
              inputValue = getInputValue(adc_result); //�������� �������� �������� �� ������ ���������
              
              /*
                ����� � COM ����� ������, ���������� �������� ���, ������������ ������� ��������
              */
              strConstCpy(textBuffer, ch0);           //"channel 0"
              transmitStringln(textBuffer);           //�������� ������ � RS232

              strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
              transmitString(textBuffer);
              
              IntToStr(adc_result, textBuffer);       //��������� ��� � ���������� �������������
              transmitString(textBuffer);             //�������� � RS232
              
              strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
              transmitString(textBuffer);
              
              FloatToStr(inputValue, textBuffer);     //����������� ������� �������� � ���������� �������������
              transmitStringln(textBuffer);

              Delay_ms(1000);                         //�������� � 1 �������
              
              /*
                ��������� 3 ���� ��� ��������� ������ ���
              */
              *adc_data = adc_get_data(1);
              /*
                ��������� �������� ����� � �� ������ � ���� �����
              */
              adc_result = parseADCValue(adc_data);

              /*
                �������� �������� �������� �� ������ ���������
              */
              inputValue = getInputValue(adc_result); //�������� �������� �������� �� ������ ���������
              k = getGain(adc_result);                //������ ������������ ��������
              
              /*
                ����� � COM ����� ������, ���������� �������� ���, ������������ ������� ��������, ������������ ����������� ��������
              */
              strConstCpy(textBuffer, ch1);           //"channel 1"
              transmitStringln(textBuffer);           //�������� ������ � RS232
              
              strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
              transmitString(textBuffer);

              IntToStr(adc_result, textBuffer);       //��������� ��� � ���������� �������������
              transmitString(textBuffer);
              
              strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
              transmitString(textBuffer);
              
              FloatToStr(inputValue, textBuffer);     //����������� ������� �������� � ���������� �������������
              transmitStringln(textBuffer);
              
              strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
              transmitString(textBuffer);
              
              FloatToStr(k, textBuffer);             //����������� ����������� �������� � ���������� �������������
              transmitStringln(textBuffer);
              
              Delay_ms(1000);                       //�������� 1 ���.
     }
}