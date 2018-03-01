//Опорное напряжение АЦП
const float VREF = 4.096;

//Бит chip select для АЦП MCP3204
sbit CS at P2_0_bit;

//Установка битов для GLCD экрана
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
   Установка адреса X GLCD экрана
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
   Установка адреса Y GLCD экрана
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
   Установка адреса Z GLCD экрана
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
   Запись данный в GLCD RAM по текущему адресу
*/
void writeData(char _data) {
    LCD_EN = 0;
    LCD_RS = 1;
    LCD_RW = 0;

    P0 = _data;
    LCD_EN = 1;
}

/*
   Чтение данный в GLCD RAM по текущему адресу

   PS.: Не работает
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
  Включение GLCD экрана (инициализация)
*/
void displayOn() {
    LCD_EN = 1;
    LCD_RS = 0;
    LCD_RW = 0;

    P0 = 0x3f;

    //Включаем две половинки
    LCD_CS1B=0;
    LCD_CS2B=0;
}

/*
  Рисуем точку на GLCD по координатам
  x - абцисса,  0 - 128
  y - ордината, 0 - 64
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
  Структура, описывающая получаемые данные из АЦП
  
  first  - 0bxxxxxxnd
  second - 0bdddddddd
  third  - 0bdddxxxxx
  , где x - бит не несущий информации
        n - null бит - индикатор начала полезных данных,
            за ним следует 12 бит результата работы АЦП
        d - бит, содержащий результат работы АЦП
*/
struct rcv_data {
       short first;
       short second;
       short third;
} *adc_data;

/*
  Инициализация АЦП.
  см. Спецификацию MCP3204
*/
void initSPI() {
     SPCR = 0b01010001;
     //SPSR = 0b11000000;
}

/*
  Инициализация интерфейса RS232 (COM-порт)
  
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
  Пересылка данных через интерфейс RS232 (COM-порт)

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
  Запись в SPI интерфейс
*/
void writeSPI(int _data) {
     SPDR = _data;
}

/*
  Чтение из SPI интерфейса
*/
int readSPI() {
    int _data;
    _data = SPDR;
    return _data;
}

/*
  Задержка
*/
void delay() {
    Delay_ms(1000);
}

/*
  Получение результата работы АЦП
  Аргумент channel - номер канала, для считывания
*/
struct rcv_data adc_get_data(int channel) {
         struct rcv_data _data; //Структура, для хранения поленных данных
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
         CS = 0; //Включение АЦП

         /*
           Отправка данных через SPI для установки режима и запуска АЦП
         */
         writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
         while(SPIF_bit != 1) {}     //Ждем конца отправки
         _data.first = readSPI(); //Читаем результат
         //transmit(_data.first);   //Отапрвка результата в COM

         writeSPI(0b00000000); //Отправка данных
         while(SPIF_bit != 1) {} //Ждем конца отправки
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
  Получить n-ый бит из байта
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
   Расчет входного значения АЦП на основе его выходных данных
 */
 float getInputValue(int _data) {
       return 4.096 * _data / 4096;
 }
 /*
   Расчет коэффициента усиления.
   Максимальное входное напряжение 32В. Вход АЦП ограничен 4 вольтами (MCP3204).
   Кус = Uвых/Uвх. Максимальный для данной схемы Кус = 4В/32В = 1/8.
   Вход АЦП ограничен 4 вольтами => коэф усиления пропускаем через резистивный делитель на 2 (Кус = 1/2).
   Получаем, что при Кус=8, на вход АЦП подается 4В, при Кус=4, на вход АЦП подается 2В и т.д.
   Таким образом коэф. усиления расчитываем по след. формуле:
         Кус = 2 * ADC_OUT_CH1/1000
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
     //char out_buffer[6]; // Результат АЦП - строка
     //char in_buffer[6]; // Вход АЦП - строка
     //char k_buffer[6]; // Коэффициент усиления
     int adc_result; // Результат АЦП - число
     float inputValue; // Вход АЦП - число
     float k; // Коэффициент усиления - число
     
     //float numBuffer;

     initSPI(); //Инициализация SPI
     rs232init(); // Инициализация RS232

     CS = 1;
     Delay_us(1);

     while(1) {
              /*
                Получение 3 бит, как результат работы АЦП
              */
              *adc_data = adc_get_data(0);
              /*
                Запись бит, несущих полезную информацию в одно число
              */
              adc_result = parseADCValue(adc_data);
              
              inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
              
              /*
                Вывод в COM номер канала, полученное значение АЦП, рассчитанное входное значение
              */
              strConstCpy(textBuffer, ch0);           //"channel 0"
              transmitStringln(textBuffer);           //Отправка строки в RS232

              strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
              transmitString(textBuffer);
              
              IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
              transmitString(textBuffer);             //Передача в RS232
              
              strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
              transmitString(textBuffer);
              
              FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
              transmitStringln(textBuffer);

              Delay_ms(1000);                         //Задержка в 1 секунду
              
              /*
                Получение 3 бита как результат работы АЦП
              */
              *adc_data = adc_get_data(1);
              /*
                Получение полезных битов и их запись в одно число
              */
              adc_result = parseADCValue(adc_data);

              /*
                Пересчет входного значения на основе выходного
              */
              inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
              k = getGain(adc_result);                //Расчет коэффициента усиления
              
              /*
                Вывод в COM номер канала, полученное значение АЦП, рассчитанное входное значение, рассчитанный коэффициент усиления
              */
              strConstCpy(textBuffer, ch1);           //"channel 1"
              transmitStringln(textBuffer);           //Отправка строки в RS232
              
              strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
              transmitString(textBuffer);

              IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
              transmitString(textBuffer);
              
              strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
              transmitString(textBuffer);
              
              FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
              transmitStringln(textBuffer);
              
              strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
              transmitString(textBuffer);
              
              FloatToStr(k, textBuffer);             //Расчитанный коэффициент усиления к строковому представлению
              transmitStringln(textBuffer);
              
              Delay_ms(1000);                       //Задержка 1 сек.
     }
}