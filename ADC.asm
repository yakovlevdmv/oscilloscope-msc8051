
_setXAddress:
;ADC.c,30 :: 		void setXAddress(int x) {
;ADC.c,31 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,32 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,33 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,35 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,37 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,38 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,39 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,44 :: 		void setYAddress(int y) {
;ADC.c,45 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,46 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,47 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,49 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,51 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,52 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,53 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,58 :: 		void setZAddress(int z) {
;ADC.c,59 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,60 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,61 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,63 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,65 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,66 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,67 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,72 :: 		void writeData(char _data) {
;ADC.c,73 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,74 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,75 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,77 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,78 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,79 :: 		}
	RET
; end of _writeData

_readData:
;ADC.c,86 :: 		int readData(int x, int y) {
;ADC.c,87 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,88 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,89 :: 		LCD_RW = 1;
	SETB P2_5_bit+0
;ADC.c,91 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_readData_y+1
	MOV FARG_setXAddress_x+0, FARG_readData_y+0
	INC R0
	SJMP L__readData43
L__readData44:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData43:
	DJNZ R0, L__readData44
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,92 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,93 :: 		_cs = x / 64;
	MOV R0, #6
	MOV A, FARG_readData_x+1
	MOV R1, FARG_readData_x+0
	INC R0
	SJMP L__readData45
L__readData46:
	MOV C, #231
	RRC A
	XCH A, R1
	RRC A
	XCH A, R1
L__readData45:
	DJNZ R0, L__readData46
	MOV R2, A
	MOV __cs+0, 1
	MOV __cs+1, 2
;ADC.c,95 :: 		if (_cs == 0 ) {
	MOV A, R1
	ORL A, R2
	JNZ L_readData0
;ADC.c,96 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,97 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,98 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_readData_x+0
	MOV FARG_setYAddress_y+1, FARG_readData_x+1
	LCALL _setYAddress+0
;ADC.c,99 :: 		} else {
	SJMP L_readData1
L_readData0:
;ADC.c,100 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,101 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,102 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,103 :: 		}
L_readData1:
;ADC.c,105 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,106 :: 		buf = P0;
	MOV _buf+0, PCON+0
	CLR A
	MOV _buf+1, A
;ADC.c,107 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,108 :: 		return buf;
	MOV R0, _buf+0
	MOV R1, _buf+1
;ADC.c,109 :: 		}
	RET
; end of _readData

_displayOn:
;ADC.c,114 :: 		void displayOn() {
;ADC.c,115 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,116 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,117 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,119 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,122 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,123 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,124 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,131 :: 		void drawPoint(int x, int y) {
;ADC.c,132 :: 		mask = 0b00000001;
	MOV _mask+0, #1
	MOV _mask+1, #0
;ADC.c,133 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint47
L__drawPoint48:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint47:
	DJNZ R0, L__drawPoint48
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,134 :: 		_cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV R1, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint49
L__drawPoint50:
	MOV C, #231
	RRC A
	XCH A, R1
	RRC A
	XCH A, R1
L__drawPoint49:
	DJNZ R0, L__drawPoint50
	MOV R2, A
	MOV __cs+0, 1
	MOV __cs+1, 2
;ADC.c,136 :: 		if (_cs == 0 ) {
	MOV A, R1
	ORL A, R2
	JNZ L_drawPoint2
;ADC.c,137 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,138 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,139 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,140 :: 		} else {
	SJMP L_drawPoint3
L_drawPoint2:
;ADC.c,141 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,142 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,143 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,144 :: 		}
L_drawPoint3:
;ADC.c,145 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,146 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV _limit+0, 0
	MOV _limit+1, 1
;ADC.c,147 :: 		for (count = 0; count < limit - 1; count++) {
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
;ADC.c,148 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, _mask+0
	INC R0
	SJMP L__drawPoint51
L__drawPoint52:
	CLR C
	RLC A
	XCH A, _mask+1
	RLC A
	XCH A, _mask+1
L__drawPoint51:
	DJNZ R0, L__drawPoint52
	MOV _mask+0, A
;ADC.c,147 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, _count+0
	MOV _count+0, A
	MOV A, #0
	ADDC A, _count+1
	MOV _count+1, A
;ADC.c,149 :: 		}
	SJMP L_drawPoint4
L_drawPoint5:
;ADC.c,150 :: 		if(y > 0) {
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
;ADC.c,151 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, _mask+0
	INC R0
	SJMP L__drawPoint53
L__drawPoint54:
	CLR C
	RLC A
	XCH A, _mask+1
	RLC A
	XCH A, _mask+1
L__drawPoint53:
	DJNZ R0, L__drawPoint54
	MOV _mask+0, A
;ADC.c,152 :: 		}
L_drawPoint7:
;ADC.c,153 :: 		writeData(mask);
	MOV FARG_writeData__data+0, _mask+0
	LCALL _writeData+0
;ADC.c,154 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,155 :: 		}
	RET
; end of _drawPoint

_initSPI:
;ADC.c,178 :: 		void initSPI() {
;ADC.c,179 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,181 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,188 :: 		void rs232init() {
;ADC.c,189 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,190 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,191 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,192 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,193 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,194 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,195 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,196 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,203 :: 		void transmit(char b) {
;ADC.c,204 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,205 :: 		while(TI_bit == 0) {}
L_transmit8:
	JB TI_bit+0, L_transmit9
	NOP
	SJMP L_transmit8
L_transmit9:
;ADC.c,206 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,208 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,210 :: 		void transmitString(char* str) {
;ADC.c,212 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,214 :: 		while (*p) {
L_transmitString10:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString11
;ADC.c,215 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,216 :: 		}
	SJMP L_transmitString10
L_transmitString11:
;ADC.c,217 :: 		}
	RET
; end of _transmitString

_writeSPI:
;ADC.c,222 :: 		void writeSPI(int _data) {
;ADC.c,223 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,224 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,229 :: 		int readSPI() {
;ADC.c,231 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,232 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,233 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,238 :: 		void delay() {
;ADC.c,239 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,240 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,246 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,248 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,249 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data12
;ADC.c,250 :: 		SPI_init_data += 0b00000000;
;ADC.c,251 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data13
L_adc_get_data12:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data55
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data55:
	JNZ L_adc_get_data14
;ADC.c,252 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,253 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data15
L_adc_get_data14:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data56
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data56:
	JNZ L_adc_get_data16
;ADC.c,254 :: 		SPI_init_data += 0b00100000;
	MOV A, #32
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,255 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data17
L_adc_get_data16:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data57
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data57:
	JNZ L_adc_get_data18
;ADC.c,256 :: 		SPI_init_data += 0b00110000;
	MOV A, #48
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,257 :: 		}
L_adc_get_data18:
L_adc_get_data17:
L_adc_get_data15:
L_adc_get_data13:
;ADC.c,258 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,263 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,264 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data19:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data20
	NOP
	SJMP L_adc_get_data19
L_adc_get_data20:
;ADC.c,265 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,268 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,269 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data21:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data22
	NOP
	SJMP L_adc_get_data21
L_adc_get_data22:
;ADC.c,270 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,273 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,274 :: 		while(SPIF_bit != 1) {}
L_adc_get_data23:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data24
	NOP
	SJMP L_adc_get_data23
L_adc_get_data24:
;ADC.c,275 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,278 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,280 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data25:
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
	JNZ L_adc_get_data25
	MOV CS+0, adc_get_data__data_L0+0
	MOV CS+1, adc_get_data__data_L0+1
;ADC.c,281 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,283 :: 		int getBit(int position, int byte) {
;ADC.c,284 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit58
L__getBit59:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit58:
	DJNZ R2, L__getBit59
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,285 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,287 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,288 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,289 :: 		int i = 0;
;ADC.c,291 :: 		result += getBit(0, adc_data->first);
	MOV FARG_getBit_position+0, #0
	MOV FARG_getBit_position+1, #0
	MOV R0, FARG_parseADCValue_adc_data+0
	MOV 1, @R0
	MOV FARG_getBit_byte+0, 1
	MOV A, R1
	RLC A
	CLR A
	SUBB A, 224
	MOV FARG_getBit_byte+1, A
	LCALL _getBit+0
	MOV A, parseADCValue_result_L0+0
	ADD A, R0
	MOV parseADCValue_result_L0+0, A
	MOV A, parseADCValue_result_L0+1
	ADDC A, R1
	MOV parseADCValue_result_L0+1, A
;ADC.c,294 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue26:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue27
;ADC.c,295 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue60
L__parseADCValue61:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue60:
	DJNZ R0, L__parseADCValue61
	MOV parseADCValue_result_L0+0, A
;ADC.c,296 :: 		result += getBit(i, adc_data->second);
	MOV FARG_getBit_position+0, parseADCValue_i_L0+0
	MOV FARG_getBit_position+1, parseADCValue_i_L0+1
	MOV A, FARG_parseADCValue_adc_data+0
	ADD A, #1
	MOV R0, A
	MOV FARG_getBit_byte+0, @R0
	MOV A, @R0
	RLC A
	CLR A
	SUBB A, 224
	MOV FARG_getBit_byte+1, A
	LCALL _getBit+0
	MOV A, parseADCValue_result_L0+0
	ADD A, R0
	MOV parseADCValue_result_L0+0, A
	MOV A, parseADCValue_result_L0+1
	ADDC A, R1
	MOV parseADCValue_result_L0+1, A
;ADC.c,294 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,297 :: 		}
	SJMP L_parseADCValue26
L_parseADCValue27:
;ADC.c,299 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue29:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue30
;ADC.c,300 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue62
L__parseADCValue63:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue62:
	DJNZ R0, L__parseADCValue63
	MOV parseADCValue_result_L0+0, A
;ADC.c,301 :: 		result += getBit(i, adc_data->third);
	MOV FARG_getBit_position+0, parseADCValue_i_L0+0
	MOV FARG_getBit_position+1, parseADCValue_i_L0+1
	MOV A, FARG_parseADCValue_adc_data+0
	ADD A, #2
	MOV R0, A
	MOV FARG_getBit_byte+0, @R0
	MOV A, @R0
	RLC A
	CLR A
	SUBB A, 224
	MOV FARG_getBit_byte+1, A
	LCALL _getBit+0
	MOV A, parseADCValue_result_L0+0
	ADD A, R0
	MOV parseADCValue_result_L0+0, A
	MOV A, parseADCValue_result_L0+1
	ADDC A, R1
	MOV parseADCValue_result_L0+1, A
;ADC.c,299 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,302 :: 		}
	SJMP L_parseADCValue29
L_parseADCValue30:
;ADC.c,304 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,305 :: 		}
	RET
; end of _parseADCValue

_reverse:
;ADC.c,318 :: 		void reverse(char s[])
;ADC.c,323 :: 		for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
	MOV reverse_i_L0+0, #0
	MOV reverse_i_L0+1, #0
	MOV FARG_strlen_s+0, FARG_reverse_s+0
	LCALL _strlen+0
	CLR C
	MOV A, R0
	SUBB A, #1
	MOV reverse_j_L0+0, A
	MOV A, R1
	SUBB A, #0
	MOV reverse_j_L0+1, A
L_reverse32:
	CLR C
	MOV A, reverse_i_L0+0
	SUBB A, reverse_j_L0+0
	MOV A, reverse_j_L0+1
	XRL A, #128
	MOV R0, A
	MOV A, reverse_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_reverse33
;ADC.c,324 :: 		c = s[i];
	MOV A, FARG_reverse_s+0
	ADD A, reverse_i_L0+0
	MOV R0, A
	MOV reverse_c_L0+0, @R0
;ADC.c,325 :: 		s[i] = s[j];
	MOV A, FARG_reverse_s+0
	ADD A, reverse_j_L0+0
	MOV R1, A
	MOV A, @R1
	MOV @R0, A
;ADC.c,326 :: 		s[j] = c;
	MOV A, FARG_reverse_s+0
	ADD A, reverse_j_L0+0
	MOV R0, A
	MOV @R0, reverse_c_L0+0
;ADC.c,323 :: 		for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
	MOV A, #1
	ADD A, reverse_i_L0+0
	MOV reverse_i_L0+0, A
	MOV A, #0
	ADDC A, reverse_i_L0+1
	MOV reverse_i_L0+1, A
	CLR C
	MOV A, reverse_j_L0+0
	SUBB A, #1
	MOV reverse_j_L0+0, A
	MOV A, reverse_j_L0+1
	SUBB A, #0
	MOV reverse_j_L0+1, A
;ADC.c,327 :: 		}
	SJMP L_reverse32
L_reverse33:
;ADC.c,328 :: 		}
	RET
; end of _reverse

_itoa:
;ADC.c,331 :: 		void itoa(int n, char s[])
;ADC.c,335 :: 		if ((sign = n) < 0)  /* записываем знак */
	MOV itoa_sign_L0+0, FARG_itoa_n+0
	MOV itoa_sign_L0+1, FARG_itoa_n+1
	CLR C
	MOV A, FARG_itoa_n+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_itoa_n+1
	XRL A, #128
	SUBB A, R0
	JNC L_itoa35
;ADC.c,336 :: 		n = -n;          /* делаем n положительным числом */
	CLR C
	MOV A, #0
	SUBB A, FARG_itoa_n+0
	MOV FARG_itoa_n+0, A
	MOV A, #0
	SUBB A, FARG_itoa_n+1
	MOV FARG_itoa_n+1, A
L_itoa35:
;ADC.c,337 :: 		i = 0;
	MOV itoa_i_L0+0, #0
	MOV itoa_i_L0+1, #0
;ADC.c,338 :: 		do {       /* генерируем цифры в обратном порядке */
L_itoa36:
;ADC.c,339 :: 		s[i++] = n % 10 + '0';   /* берем следующую цифру */
	MOV A, FARG_itoa_s+0
	ADD A, itoa_i_L0+0
	MOV R0, A
	MOV FLOC__itoa+0, 0
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_itoa_n+0
	MOV R1, FARG_itoa_n+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV R1, A
	MOV R0, FLOC__itoa+0
	MOV @R0, 1
	MOV A, #1
	ADD A, itoa_i_L0+0
	MOV itoa_i_L0+0, A
	MOV A, #0
	ADDC A, itoa_i_L0+1
	MOV itoa_i_L0+1, A
;ADC.c,340 :: 		} while ((n /= 10) > 0);     /* удаляем */
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_itoa_n+0
	MOV R1, FARG_itoa_n+1
	LCALL _Div_16x16_S+0
	MOV FARG_itoa_n+0, 0
	MOV FARG_itoa_n+1, 1
	SETB C
	MOV A, R0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R2, A
	MOV A, R1
	XRL A, #128
	SUBB A, R2
	JNC L_itoa36
;ADC.c,341 :: 		if (sign < 0)
	CLR C
	MOV A, itoa_sign_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, itoa_sign_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_itoa39
;ADC.c,342 :: 		s[i++] = '-';
	MOV A, FARG_itoa_s+0
	ADD A, itoa_i_L0+0
	MOV R0, A
	MOV @R0, #45
	MOV A, #1
	ADD A, itoa_i_L0+0
	MOV itoa_i_L0+0, A
	MOV A, #0
	ADDC A, itoa_i_L0+1
	MOV itoa_i_L0+1, A
L_itoa39:
;ADC.c,343 :: 		s[i] = '\0';
	MOV A, FARG_itoa_s+0
	ADD A, itoa_i_L0+0
	MOV R0, A
	MOV @R0, #0
;ADC.c,344 :: 		reverse(s);
	MOV FARG_reverse_s+0, FARG_itoa_s+0
	LCALL _reverse+0
;ADC.c,345 :: 		}
	RET
; end of _itoa

_main:
	MOV SP+0, #128
;ADC.c,347 :: 		void main() {
;ADC.c,351 :: 		initSPI();
	LCALL _initSPI+0
;ADC.c,352 :: 		rs232init();
	LCALL _rs232init+0
;ADC.c,354 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,355 :: 		Delay_us(1);
	NOP
;ADC.c,357 :: 		while(1) {
L_main40:
;ADC.c,358 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main42:
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
	JNZ L_main42
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,359 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,361 :: 		transmitString("channel 1 \0");
	MOV FARG_transmitString_str+0, #?lstr1_ADC+0
	LCALL _transmitString+0
;ADC.c,363 :: 		itoa(adc_result, buffer);
	MOV FARG_itoa_n+0, main_adc_result_L0+0
	MOV FARG_itoa_n+1, main_adc_result_L0+1
	MOV FARG_itoa_s+0, #main_buffer_L0+0
	LCALL _itoa+0
;ADC.c,364 :: 		transmitString(buffer);
	MOV FARG_transmitString_str+0, #main_buffer_L0+0
	LCALL _transmitString+0
;ADC.c,365 :: 		Delay_ms(1100);
	MOV R5, 7
	MOV R6, 248
	MOV R7, 93
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,397 :: 		}
	SJMP L_main40
;ADC.c,398 :: 		}
	SJMP #254
; end of _main
