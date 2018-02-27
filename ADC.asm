
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
	SJMP L__readData46
L__readData47:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData46:
	DJNZ R0, L__readData47
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
	SJMP L__readData48
L__readData49:
	MOV C, #231
	RRC A
	XCH A, R1
	RRC A
	XCH A, R1
L__readData48:
	DJNZ R0, L__readData49
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
	SJMP L__drawPoint50
L__drawPoint51:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint50:
	DJNZ R0, L__drawPoint51
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,130 :: 		_cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV R1, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint52
L__drawPoint53:
	MOV C, #231
	RRC A
	XCH A, R1
	RRC A
	XCH A, R1
L__drawPoint52:
	DJNZ R0, L__drawPoint53
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
	SJMP L__drawPoint54
L__drawPoint55:
	CLR C
	RLC A
	XCH A, _mask+1
	RLC A
	XCH A, _mask+1
L__drawPoint54:
	DJNZ R0, L__drawPoint55
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
	SJMP L__drawPoint56
L__drawPoint57:
	CLR C
	RLC A
	XCH A, _mask+1
	RLC A
	XCH A, _mask+1
L__drawPoint56:
	DJNZ R0, L__drawPoint57
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

_transmitString:
;ADC.c,206 :: 		void transmitString(char* str) {
;ADC.c,208 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,210 :: 		while (*p) {
L_transmitString10:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString11
;ADC.c,211 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,212 :: 		}
	SJMP L_transmitString10
L_transmitString11:
;ADC.c,213 :: 		}
	RET
; end of _transmitString

_transmitStringln:
;ADC.c,215 :: 		void transmitStringln(char* str) {
;ADC.c,217 :: 		char *p = &str[0];
	MOV transmitStringln_p_L0+0, FARG_transmitStringln_str+0
;ADC.c,219 :: 		while (*p) {
L_transmitStringln12:
	MOV R0, transmitStringln_p_L0+0
	MOV A, @R0
	JZ L_transmitStringln13
;ADC.c,220 :: 		transmit(*(p++));
	MOV R0, transmitStringln_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitStringln_p_L0+0
;ADC.c,221 :: 		}
	SJMP L_transmitStringln12
L_transmitStringln13:
;ADC.c,224 :: 		transmit('\r');
	MOV FARG_transmit_b+0, #13
	LCALL _transmit+0
;ADC.c,225 :: 		transmit('\n');
	MOV FARG_transmit_b+0, #10
	LCALL _transmit+0
;ADC.c,226 :: 		}
	RET
; end of _transmitStringln

_writeSPI:
;ADC.c,231 :: 		void writeSPI(int _data) {
;ADC.c,232 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,233 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,238 :: 		int readSPI() {
;ADC.c,240 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,241 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,242 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,247 :: 		void delay() {
;ADC.c,248 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,249 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,255 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,257 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,258 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data14
;ADC.c,259 :: 		SPI_init_data += 0b00000000;
;ADC.c,260 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data15
L_adc_get_data14:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data58
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data58:
	JNZ L_adc_get_data16
;ADC.c,261 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,262 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data17
L_adc_get_data16:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data59
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data59:
	JNZ L_adc_get_data18
;ADC.c,263 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,264 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data19
L_adc_get_data18:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data60
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data60:
	JNZ L_adc_get_data20
;ADC.c,265 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,266 :: 		}
L_adc_get_data20:
L_adc_get_data19:
L_adc_get_data17:
L_adc_get_data15:
;ADC.c,267 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,268 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,273 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,274 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data21:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data22
	NOP
	SJMP L_adc_get_data21
L_adc_get_data22:
;ADC.c,275 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,278 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,279 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data23:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data24
	NOP
	SJMP L_adc_get_data23
L_adc_get_data24:
;ADC.c,280 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,283 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,284 :: 		while(SPIF_bit != 1) {}
L_adc_get_data25:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data26
	NOP
	SJMP L_adc_get_data25
L_adc_get_data26:
;ADC.c,285 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,288 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,290 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data27:
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
	JNZ L_adc_get_data27
	MOV CS+0, adc_get_data__data_L0+0
	MOV CS+1, adc_get_data__data_L0+1
;ADC.c,291 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,296 :: 		int getBit(int position, int byte) {
;ADC.c,297 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit61
L__getBit62:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit61:
	DJNZ R2, L__getBit62
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,298 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,300 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,301 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,302 :: 		int i = 0;
;ADC.c,304 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,306 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue28:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue29
;ADC.c,307 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue63
L__parseADCValue64:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue63:
	DJNZ R0, L__parseADCValue64
	MOV parseADCValue_result_L0+0, A
;ADC.c,308 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,306 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,309 :: 		}
	SJMP L_parseADCValue28
L_parseADCValue29:
;ADC.c,311 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue31:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue32
;ADC.c,312 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue65
L__parseADCValue66:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue65:
	DJNZ R0, L__parseADCValue66
	MOV parseADCValue_result_L0+0, A
;ADC.c,313 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,311 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,314 :: 		}
	SJMP L_parseADCValue31
L_parseADCValue32:
;ADC.c,316 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,317 :: 		}
	RET
; end of _parseADCValue

_reverse:
;ADC.c,325 :: 		void reverse(char s[]) {
;ADC.c,329 :: 		for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
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
L_reverse34:
	CLR C
	MOV A, reverse_i_L0+0
	SUBB A, reverse_j_L0+0
	MOV A, reverse_j_L0+1
	XRL A, #128
	MOV R0, A
	MOV A, reverse_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_reverse35
;ADC.c,330 :: 		c = s[i];
	MOV A, FARG_reverse_s+0
	ADD A, reverse_i_L0+0
	MOV R0, A
	MOV reverse_c_L0+0, @R0
;ADC.c,331 :: 		s[i] = s[j];
	MOV A, FARG_reverse_s+0
	ADD A, reverse_j_L0+0
	MOV R1, A
	MOV A, @R1
	MOV @R0, A
;ADC.c,332 :: 		s[j] = c;
	MOV A, FARG_reverse_s+0
	ADD A, reverse_j_L0+0
	MOV R0, A
	MOV @R0, reverse_c_L0+0
;ADC.c,329 :: 		for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
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
;ADC.c,333 :: 		}
	SJMP L_reverse34
L_reverse35:
;ADC.c,334 :: 		}
	RET
; end of _reverse

_itoa:
;ADC.c,337 :: 		void itoa(int n, char s[])
;ADC.c,341 :: 		if ((sign = n) < 0)  /* записываем знак */
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
	JNC L_itoa37
;ADC.c,342 :: 		n = -n;          /* делаем n положительным числом */
	CLR C
	MOV A, #0
	SUBB A, FARG_itoa_n+0
	MOV FARG_itoa_n+0, A
	MOV A, #0
	SUBB A, FARG_itoa_n+1
	MOV FARG_itoa_n+1, A
L_itoa37:
;ADC.c,343 :: 		i = 0;
	MOV itoa_i_L0+0, #0
	MOV itoa_i_L0+1, #0
;ADC.c,344 :: 		do {       /* генерируем цифры в обратном порядке */
L_itoa38:
;ADC.c,345 :: 		s[i++] = n % 10 + '0';   /* берем следующую цифру */
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
;ADC.c,346 :: 		} while ((n /= 10) > 0);     /* удаляем */
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
	JNC L_itoa38
;ADC.c,347 :: 		if (sign < 0)
	CLR C
	MOV A, itoa_sign_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, itoa_sign_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_itoa41
;ADC.c,348 :: 		s[i++] = '-';
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
L_itoa41:
;ADC.c,349 :: 		s[i] = '\0';
	MOV A, FARG_itoa_s+0
	ADD A, itoa_i_L0+0
	MOV R0, A
	MOV @R0, #0
;ADC.c,350 :: 		reverse(s);
	MOV FARG_reverse_s+0, FARG_itoa_s+0
	LCALL _reverse+0
;ADC.c,351 :: 		}
	RET
; end of _itoa

_getInputValue:
;ADC.c,356 :: 		float getInputValue(int _data) {
;ADC.c,358 :: 		result = 4.096 * _data / 4096;
	MOV R0, FARG_getInputValue__data+0
	MOV R1, FARG_getInputValue__data+1
	LCALL _Int2Double+0
	MOV R4, #111
	MOV R5, #18
	MOV R6, #131
	MOV 7, #64
	LCALL _Mul_32x32_FP+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #128
	MOV 7, #69
	LCALL _Div_32x32_FP+0
;ADC.c,359 :: 		return result;
;ADC.c,360 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,370 :: 		float getGain(int _data) {
;ADC.c,372 :: 		k = 2 * _data / 1000;
	MOV R2, #1
	MOV R1, FARG_getGain__data+1
	MOV A, FARG_getGain__data+0
	INC R2
	SJMP L__getGain67
L__getGain68:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__getGain67:
	DJNZ R2, L__getGain68
	MOV R0, A
	MOV R4, #232
	MOV R5, #3
	LCALL _Div_16x16_S+0
	LCALL _Int2Double+0
;ADC.c,373 :: 		return k;
;ADC.c,374 :: 		}
	RET
; end of _getGain

_main:
	MOV SP+0, #128
;ADC.c,376 :: 		void main() {
;ADC.c,385 :: 		initSPI(); //Инициализация SPI
	LCALL _initSPI+0
;ADC.c,386 :: 		rs232init(); // Инициализация RS232
	LCALL _rs232init+0
;ADC.c,388 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,389 :: 		Delay_us(1);
	NOP
;ADC.c,391 :: 		while(1) {
L_main42:
;ADC.c,395 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main44:
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
	JNZ L_main44
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,399 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,403 :: 		inputValue = getInputValue(adc_result);
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV main_inputValue_L0+0, 0
	MOV main_inputValue_L0+1, 1
	MOV main_inputValue_L0+2, 2
	MOV main_inputValue_L0+3, 3
;ADC.c,405 :: 		transmitStringln("channel 0\0");
	MOV FARG_transmitStringln_str+0, #?lstr1_ADC+0
	LCALL _transmitStringln+0
;ADC.c,408 :: 		itoa(adc_result, buffer);
	MOV FARG_itoa_n+0, main_adc_result_L0+0
	MOV FARG_itoa_n+1, main_adc_result_L0+1
	MOV FARG_itoa_s+0, #main_buffer_L0+0
	LCALL _itoa+0
;ADC.c,409 :: 		transmitString("ADC result: ");
	MOV FARG_transmitString_str+0, #?lstr2_ADC+0
	LCALL _transmitString+0
;ADC.c,411 :: 		transmitStringln(buffer);
	MOV FARG_transmitStringln_str+0, #main_buffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,413 :: 		FloatToStr(inputValue, buffer);
	MOV FARG_FloatToStr_fnum+0, main_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, main_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, main_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, main_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #main_buffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,414 :: 		transmitString("ADC input: ");
	MOV FARG_transmitString_str+0, #?lstr3_ADC+0
	LCALL _transmitString+0
;ADC.c,416 :: 		transmitStringln(buffer);
	MOV FARG_transmitStringln_str+0, #main_buffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,417 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,419 :: 		*adc_data = adc_get_data(1);
	MOV FARG_adc_get_data_channel+0, #1
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main45:
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
	JNZ L_main45
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,420 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,421 :: 		inputValue = getInputValue(adc_result);
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV main_inputValue_L0+0, 0
	MOV main_inputValue_L0+1, 1
	MOV main_inputValue_L0+2, 2
	MOV main_inputValue_L0+3, 3
;ADC.c,423 :: 		transmitStringln("channel 1 \0");
	MOV FARG_transmitStringln_str+0, #?lstr4_ADC+0
	LCALL _transmitStringln+0
;ADC.c,426 :: 		itoa(adc_result, buffer);
	MOV FARG_itoa_n+0, main_adc_result_L0+0
	MOV FARG_itoa_n+1, main_adc_result_L0+1
	MOV FARG_itoa_s+0, #main_buffer_L0+0
	LCALL _itoa+0
;ADC.c,427 :: 		transmitString("ADC result: ");
	MOV FARG_transmitString_str+0, #?lstr5_ADC+0
	LCALL _transmitString+0
;ADC.c,429 :: 		transmitStringln(buffer);
	MOV FARG_transmitStringln_str+0, #main_buffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,431 :: 		FloatToStr(inputValue, buffer);
	MOV FARG_FloatToStr_fnum+0, main_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, main_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, main_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, main_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #main_buffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,432 :: 		transmitString("ADC input: ");
	MOV FARG_transmitString_str+0, #?lstr6_ADC+0
	LCALL _transmitString+0
;ADC.c,434 :: 		transmitStringln(buffer);
	MOV FARG_transmitStringln_str+0, #main_buffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,435 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,436 :: 		}
	LJMP L_main42
;ADC.c,437 :: 		}
	SJMP #254
; end of _main
