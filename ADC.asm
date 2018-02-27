
_setXAddress:
;ADC.c,26 :: 		void setXAddress(int x) {
;ADC.c,27 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,28 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,29 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,31 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,33 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,34 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,35 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,40 :: 		void setYAddress(int y) {
;ADC.c,41 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,42 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,43 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,45 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,47 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,48 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,49 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,54 :: 		void setZAddress(int z) {
;ADC.c,55 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,56 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,57 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,59 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,61 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,62 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,63 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,68 :: 		void writeData(char _data) {
;ADC.c,69 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,70 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,71 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,73 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,74 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,75 :: 		}
	RET
; end of _writeData

_readData:
;ADC.c,82 :: 		int readData(int x, int y) {
;ADC.c,83 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,84 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,85 :: 		LCD_RW = 1;
	SETB P2_5_bit+0
;ADC.c,87 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_readData_y+1
	MOV FARG_setXAddress_x+0, FARG_readData_y+0
	INC R0
	SJMP L__readData27
L__readData28:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData27:
	DJNZ R0, L__readData28
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,88 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,89 :: 		_cs = x / 64;
	MOV R0, #6
	MOV A, FARG_readData_x+1
	MOV R1, FARG_readData_x+0
	INC R0
	SJMP L__readData29
L__readData30:
	MOV C, #231
	RRC A
	XCH A, R1
	RRC A
	XCH A, R1
L__readData29:
	DJNZ R0, L__readData30
	MOV R2, A
	MOV __cs+0, 1
	MOV __cs+1, 2
;ADC.c,91 :: 		if (_cs == 0 ) {
	MOV A, R1
	ORL A, R2
	JNZ L_readData0
;ADC.c,92 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,93 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,94 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_readData_x+0
	MOV FARG_setYAddress_y+1, FARG_readData_x+1
	LCALL _setYAddress+0
;ADC.c,95 :: 		} else {
	SJMP L_readData1
L_readData0:
;ADC.c,96 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,97 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,98 :: 		setYAddress(64 + (x % 64));
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_readData_x+0
	MOV R1, FARG_readData_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #64
	ADD A, R0
	MOV FARG_setYAddress_y+0, A
	MOV A, #0
	ADDC A, R1
	MOV FARG_setYAddress_y+1, A
	LCALL _setYAddress+0
;ADC.c,99 :: 		}
L_readData1:
;ADC.c,101 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,102 :: 		buf = P0;
	MOV _buf+0, PCON+0
	CLR A
	MOV _buf+1, A
;ADC.c,103 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,104 :: 		return buf;
	MOV R0, _buf+0
	MOV R1, _buf+1
;ADC.c,105 :: 		}
	RET
; end of _readData

_displayOn:
;ADC.c,110 :: 		void displayOn() {
;ADC.c,111 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,112 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,113 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,115 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,118 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,119 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,120 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,127 :: 		void drawPoint(int x, int y) {
;ADC.c,128 :: 		mask = 0b00000001;
	MOV _mask+0, #1
	MOV _mask+1, #0
;ADC.c,129 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint31
L__drawPoint32:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint31:
	DJNZ R0, L__drawPoint32
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,130 :: 		_cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV R1, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint33
L__drawPoint34:
	MOV C, #231
	RRC A
	XCH A, R1
	RRC A
	XCH A, R1
L__drawPoint33:
	DJNZ R0, L__drawPoint34
	MOV R2, A
	MOV __cs+0, 1
	MOV __cs+1, 2
;ADC.c,132 :: 		if (_cs == 0 ) {
	MOV A, R1
	ORL A, R2
	JNZ L_drawPoint2
;ADC.c,133 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,134 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,135 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,136 :: 		} else {
	SJMP L_drawPoint3
L_drawPoint2:
;ADC.c,137 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,138 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,139 :: 		setYAddress(64 + (x % 64));
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_drawPoint_x+0
	MOV R1, FARG_drawPoint_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #64
	ADD A, R0
	MOV FARG_setYAddress_y+0, A
	MOV A, #0
	ADDC A, R1
	MOV FARG_setYAddress_y+1, A
	LCALL _setYAddress+0
;ADC.c,140 :: 		}
L_drawPoint3:
;ADC.c,141 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,142 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV _limit+0, 0
	MOV _limit+1, 1
;ADC.c,143 :: 		for (count = 0; count < limit - 1; count++) {
	MOV _count+0, #0
	MOV _count+1, #0
L_drawPoint4:
	CLR C
	MOV A, _limit+0
	SUBB A, #1
	MOV R1, A
	MOV A, _limit+1
	SUBB A, #0
	MOV R2, A
	CLR C
	MOV A, _count+0
	SUBB A, R1
	MOV A, R2
	XRL A, #128
	MOV R0, A
	MOV A, _count+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawPoint5
;ADC.c,144 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, _mask+0
	INC R0
	SJMP L__drawPoint35
L__drawPoint36:
	CLR C
	RLC A
	XCH A, _mask+1
	RLC A
	XCH A, _mask+1
L__drawPoint35:
	DJNZ R0, L__drawPoint36
	MOV _mask+0, A
;ADC.c,143 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, _count+0
	MOV _count+0, A
	MOV A, #0
	ADDC A, _count+1
	MOV _count+1, A
;ADC.c,145 :: 		}
	SJMP L_drawPoint4
L_drawPoint5:
;ADC.c,146 :: 		if(y > 0) {
	SETB C
	MOV A, FARG_drawPoint_y+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_drawPoint_y+1
	XRL A, #128
	SUBB A, R0
	JC L_drawPoint7
;ADC.c,147 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, _mask+0
	INC R0
	SJMP L__drawPoint37
L__drawPoint38:
	CLR C
	RLC A
	XCH A, _mask+1
	RLC A
	XCH A, _mask+1
L__drawPoint37:
	DJNZ R0, L__drawPoint38
	MOV _mask+0, A
;ADC.c,148 :: 		}
L_drawPoint7:
;ADC.c,149 :: 		writeData(mask);
	MOV FARG_writeData__data+0, _mask+0
	LCALL _writeData+0
;ADC.c,150 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,151 :: 		}
	RET
; end of _drawPoint

_initSPI:
;ADC.c,174 :: 		void initSPI() {
;ADC.c,175 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,177 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,184 :: 		void rs232init() {
;ADC.c,185 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,186 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,187 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,188 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,189 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,190 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,191 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,192 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,199 :: 		void transmit(char b) {
;ADC.c,200 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,201 :: 		while(TI_bit == 0) {}
L_transmit8:
	JB TI_bit+0, L_transmit9
	NOP
	SJMP L_transmit8
L_transmit9:
;ADC.c,202 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,204 :: 		}
	RET
; end of _transmit

_writeSPI:
;ADC.c,209 :: 		void writeSPI(int _data) {
;ADC.c,210 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,211 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,216 :: 		int readSPI() {
;ADC.c,218 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,219 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,220 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,225 :: 		void delay() {
;ADC.c,226 :: 		Delay_ms(500);
	MOV R5, 4
	MOV R6, 43
	MOV R7, 157
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,227 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,232 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,234 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,235 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data10
;ADC.c,236 :: 		SPI_init_data += 0b00000000;
;ADC.c,237 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data11
L_adc_get_data10:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data39
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data39:
	JNZ L_adc_get_data12
;ADC.c,238 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,239 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data13
L_adc_get_data12:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data40
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data40:
	JNZ L_adc_get_data14
;ADC.c,240 :: 		SPI_init_data += 0b00100000;
	MOV A, #32
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,241 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data15
L_adc_get_data14:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data41
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data41:
	JNZ L_adc_get_data16
;ADC.c,242 :: 		SPI_init_data += 0b00110000;
	MOV A, #48
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,243 :: 		}
L_adc_get_data16:
L_adc_get_data15:
L_adc_get_data13:
L_adc_get_data11:
;ADC.c,244 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,249 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,250 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data17:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data18
	NOP
	SJMP L_adc_get_data17
L_adc_get_data18:
;ADC.c,251 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,254 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,255 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data19:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data20
	NOP
	SJMP L_adc_get_data19
L_adc_get_data20:
;ADC.c,256 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,259 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,260 :: 		while(SPIF_bit != 1) {}
L_adc_get_data21:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data22
	NOP
	SJMP L_adc_get_data21
L_adc_get_data22:
;ADC.c,261 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,264 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,266 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data23:
	MOV A, @R1
	MOV @R0, A
	MOV R2, #1
	CLR C
	MOV A, R3
	SUBB A, R2
	MOV R3, A
	CLR A
	SUBB A, R3
	MOV R4, A
	INC R0
	INC R1
	MOV A, R3
	JNZ L_adc_get_data23
	MOV CS+0, adc_get_data__data_L0+0
	MOV CS+1, adc_get_data__data_L0+1
;ADC.c,267 :: 		}
	RET
; end of _adc_get_data

_main:
	MOV SP+0, #128
;ADC.c,269 :: 		void main() {
;ADC.c,271 :: 		initSPI();
	LCALL _initSPI+0
;ADC.c,272 :: 		rs232init();
	LCALL _rs232init+0
;ADC.c,274 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,275 :: 		Delay_us(1);
	NOP
;ADC.c,277 :: 		while(1) {
L_main24:
;ADC.c,278 :: 		adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, #_adc_data+0
	MOV R1, #FLOC__main+0
L_main26:
	MOV A, @R1
	MOV @R0, A
	MOV R2, #1
	CLR C
	MOV A, R3
	SUBB A, R2
	MOV R3, A
	CLR A
	SUBB A, R3
	MOV R4, A
	INC R0
	INC R1
	MOV A, R3
	JNZ L_main26
	MOV _adc_data+0, FLOC__main+0
	MOV _adc_data+1, FLOC__main+1
;ADC.c,280 :: 		transmit(adc_data.first);
	MOV FARG_transmit_b+0, _adc_data+0
	LCALL _transmit+0
;ADC.c,281 :: 		transmit(adc_data.second);
	MOV FARG_transmit_b+0, _adc_data+1
	LCALL _transmit+0
;ADC.c,282 :: 		transmit(adc_data.third);
	MOV FARG_transmit_b+0, _adc_data+2
	LCALL _transmit+0
;ADC.c,284 :: 		Delay_ms(2000);
	MOV R5, 13
	MOV R6, 171
	MOV R7, 124
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,285 :: 		}
	SJMP L_main24
;ADC.c,349 :: 		}
	SJMP #254
; end of _main
