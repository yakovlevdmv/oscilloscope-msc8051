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

int mask1, mask2, mask, count, limit, _cs, buf;

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
       char ch = str[0];
       char *p = &str[0];

       while (*p) {
            transmit(*(p++));
       }
}

void transmitStringln(char* str) {
       char ch = str[0];
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
     ��������� �������� ��������� �������������� int � ������
     �������� https://ru.wikipedia.org/wiki/Itoa_(��)
 */

 /* reverse:  �������������� ������ s �� ����� */
 void reverse(char s[]) {
     int i, j;
     char c;

     for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
         c = s[i];
         s[i] = s[j];
         s[j] = c;
     }
 }

 /* itoa:  ������������ n � ������� � s */
 void itoa(int n, char s[])
 {
     int i, sign;

     if ((sign = n) < 0)  /* ���������� ���� */
         n = -n;          /* ������ n ������������� ������ */
     i = 0;
     do {       /* ���������� ����� � �������� ������� */
         s[i++] = n % 10 + '0';   /* ����� ��������� ����� */
     } while ((n /= 10) > 0);     /* ������� */
     if (sign < 0)
         s[i++] = '-';
     s[i] = '\0';
     reverse(s);
 }
 
 /*
   ������ �������� �������� ��� �� ������ ��� �������� ������
 */
 float getInputValue(int _data) {
       float result;
       result = 4.096 * _data / 4096;
       return result;
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
       float k;
       k = 2 * _data / 1000;
       return k;
 }

void main() {
     char out_buffer[6]; // ��������� ��� - ������
     char in_buffer[6]; // ���� ��� - ������
     char k_buffer[6]; // ����������� ��������
     int adc_result; // ��������� ��� - �����
     float inputValue; // ���� ��� - �����
     float k; // ����������� �������� - �����

     initSPI(); //������������� SPI
     rs232init(); // ������������� RS232

     CS = 1;
     Delay_us(1);

     while(1) {
              /*
                ��������� 3 ���� ��� ��������� ������ ���
              */
              *adc_data = adc_get_data(0);
              /*
                ��������� �������� ����� � �� ������ � ���� �����
              */
              adc_result = parseADCValue(adc_data);
              /*
                �������� �������� �������� �� ������ ���������
              */
              inputValue = getInputValue(adc_result);
              
              transmitStringln("channel 0\0");

              itoa(adc_result, out_buffer); // ��������� ��� � ���������� �������������
              transmitString("ADC result: ");
              transmitStringln(out_buffer);   //�������� � RS232
              FloatToStr(inputValue, in_buffer);//����������� ������� �������� � ���������� �������������
              transmitString("ADC input: ");
              transmitStringln(in_buffer);        // �������� � RS232
              Delay_ms(1000);
              
              *adc_data = adc_get_data(1);
              adc_result = parseADCValue(adc_data);
              inputValue = getInputValue(adc_result);
              
              transmitStringln("channel 1 \0");

              itoa(adc_result, out_buffer);
              transmitString("ADC result: ");
              transmitStringln(out_buffer);
              FloatToStr(inputValue, in_buffer);
              transmitString("ADC input: ");
              transmitStringln(in_buffer);
              Delay_ms(1000);
     }
}