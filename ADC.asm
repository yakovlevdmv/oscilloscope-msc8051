
_setXAddress:
;ADC.c,24 :: 		void setXAddress(int x) {
;ADC.c,25 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,26 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,27 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,29 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,31 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,32 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,33 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,38 :: 		void setYAddress(int y) {
;ADC.c,39 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,40 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,41 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,43 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,45 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,46 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,47 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,52 :: 		void setZAddress(int z) {
;ADC.c,53 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,54 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,55 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,57 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,59 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,60 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,61 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,66 :: 		void writeData(char _data) {
;ADC.c,67 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,68 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,69 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,71 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,72 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,73 :: 		}
	RET
; end of _writeData

_readData:
;ADC.c,80 :: 		int readData(int x, int y) {
;ADC.c,81 :: 		int buf = 0;
	MOV readData_buf_L0+0, #0
	MOV readData_buf_L0+1, #0
;ADC.c,82 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_readData_x+1
	MOV readData__cs_L0+0, FARG_readData_x+0
	INC R0
	SJMP L__readData40
L__readData41:
	MOV C, #231
	RRC A
	XCH A, readData__cs_L0+0
	RRC A
	XCH A, readData__cs_L0+0
L__readData40:
	DJNZ R0, L__readData41
	MOV readData__cs_L0+1, A
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
	SJMP L__readData42
L__readData43:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData42:
	DJNZ R0, L__readData43
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,88 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,90 :: 		if (_cs == 0 ) {
	MOV A, readData__cs_L0+0
	ORL A, readData__cs_L0+1
	JNZ L_readData0
;ADC.c,91 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,92 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,93 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_readData_x+0
	MOV FARG_setYAddress_y+1, FARG_readData_x+1
	LCALL _setYAddress+0
;ADC.c,94 :: 		} else {
	SJMP L_readData1
L_readData0:
;ADC.c,95 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,96 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,97 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,98 :: 		}
L_readData1:
;ADC.c,100 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,101 :: 		buf = P0;
	MOV readData_buf_L0+0, PCON+0
	CLR A
	MOV readData_buf_L0+1, A
;ADC.c,102 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,103 :: 		return buf;
	MOV R0, readData_buf_L0+0
	MOV R1, readData_buf_L0+1
;ADC.c,104 :: 		}
	RET
; end of _readData

_displayOn:
;ADC.c,109 :: 		void displayOn() {
;ADC.c,110 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,111 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,112 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,114 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,117 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,118 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,119 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,126 :: 		void drawPoint(int x, int y) {
;ADC.c,127 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,128 :: 		int limit = 0;
;ADC.c,129 :: 		int mask = 0b00000001;
;ADC.c,130 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint44
L__drawPoint45:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint44:
	DJNZ R0, L__drawPoint45
	MOV drawPoint__cs_L0+1, A
;ADC.c,131 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint46
L__drawPoint47:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint46:
	DJNZ R0, L__drawPoint47
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,133 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
	JNZ L_drawPoint2
;ADC.c,134 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,135 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,136 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,137 :: 		} else {
	SJMP L_drawPoint3
L_drawPoint2:
;ADC.c,138 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,139 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,140 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,141 :: 		}
L_drawPoint3:
;ADC.c,142 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,143 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,144 :: 		for (count = 0; count < limit - 1; count++) {
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
L_drawPoint4:
	CLR C
	MOV A, drawPoint_limit_L0+0
	SUBB A, #1
	MOV R1, A
	MOV A, drawPoint_limit_L0+1
	SUBB A, #0
	MOV R2, A
	CLR C
	MOV A, drawPoint_count_L0+0
	SUBB A, R1
	MOV A, R2
	XRL A, #128
	MOV R0, A
	MOV A, drawPoint_count_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawPoint5
;ADC.c,145 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint48
L__drawPoint49:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint48:
	DJNZ R0, L__drawPoint49
	MOV drawPoint_mask_L0+0, A
;ADC.c,144 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,146 :: 		}
	SJMP L_drawPoint4
L_drawPoint5:
;ADC.c,147 :: 		if(y > 0) {
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
;ADC.c,148 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint50
L__drawPoint51:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint50:
	DJNZ R0, L__drawPoint51
	MOV drawPoint_mask_L0+0, A
;ADC.c,149 :: 		}
L_drawPoint7:
;ADC.c,150 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,151 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,152 :: 		}
	RET
; end of _drawPoint

_initSPI:
;ADC.c,175 :: 		void initSPI() {
;ADC.c,176 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,178 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,185 :: 		void rs232init() {
;ADC.c,186 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,187 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,188 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,189 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,190 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,191 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,192 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,193 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,200 :: 		void transmit(char b) {
;ADC.c,201 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,202 :: 		while(TI_bit == 0) {}
L_transmit8:
	JB TI_bit+0, L_transmit9
	NOP
	SJMP L_transmit8
L_transmit9:
;ADC.c,203 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,205 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,207 :: 		void transmitString(char* str) {
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
;ADC.c,216 :: 		char *p = &str[0];
	MOV transmitStringln_p_L0+0, FARG_transmitStringln_str+0
;ADC.c,218 :: 		while (*p) {
L_transmitStringln12:
	MOV R0, transmitStringln_p_L0+0
	MOV A, @R0
	JZ L_transmitStringln13
;ADC.c,219 :: 		transmit(*(p++));
	MOV R0, transmitStringln_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitStringln_p_L0+0
;ADC.c,220 :: 		}
	SJMP L_transmitStringln12
L_transmitStringln13:
;ADC.c,223 :: 		transmit('\r');
	MOV FARG_transmit_b+0, #13
	LCALL _transmit+0
;ADC.c,224 :: 		transmit('\n');
	MOV FARG_transmit_b+0, #10
	LCALL _transmit+0
;ADC.c,225 :: 		}
	RET
; end of _transmitStringln

_writeSPI:
;ADC.c,230 :: 		void writeSPI(int _data) {
;ADC.c,231 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,232 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,237 :: 		int readSPI() {
;ADC.c,239 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,240 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,241 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,246 :: 		void delay() {
;ADC.c,247 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,248 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,254 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,256 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,257 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data14
;ADC.c,258 :: 		SPI_init_data += 0b00000000;
;ADC.c,259 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data15
L_adc_get_data14:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data52
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data52:
	JNZ L_adc_get_data16
;ADC.c,260 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,261 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data17
L_adc_get_data16:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data53
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data53:
	JNZ L_adc_get_data18
;ADC.c,262 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,263 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data19
L_adc_get_data18:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data54
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data54:
	JNZ L_adc_get_data20
;ADC.c,264 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,265 :: 		}
L_adc_get_data20:
L_adc_get_data19:
L_adc_get_data17:
L_adc_get_data15:
;ADC.c,266 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,267 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,272 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,273 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data21:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data22
	NOP
	SJMP L_adc_get_data21
L_adc_get_data22:
;ADC.c,274 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,277 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,278 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data23:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data24
	NOP
	SJMP L_adc_get_data23
L_adc_get_data24:
;ADC.c,279 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,282 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,283 :: 		while(SPIF_bit != 1) {}
L_adc_get_data25:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data26
	NOP
	SJMP L_adc_get_data25
L_adc_get_data26:
;ADC.c,284 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,287 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,289 :: 		return _data;
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
	MOV ?lstr_1_ADC+0, adc_get_data__data_L0+0
	MOV ?lstr_1_ADC+1, adc_get_data__data_L0+1
;ADC.c,290 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,295 :: 		int getBit(int position, int byte) {
;ADC.c,296 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit55
L__getBit56:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit55:
	DJNZ R2, L__getBit56
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,297 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,299 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,300 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,301 :: 		int i = 0;
;ADC.c,303 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,305 :: 		for(i = 7; i >= 0; i--) {
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
;ADC.c,306 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue57
L__parseADCValue58:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue57:
	DJNZ R0, L__parseADCValue58
	MOV parseADCValue_result_L0+0, A
;ADC.c,307 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,305 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,308 :: 		}
	SJMP L_parseADCValue28
L_parseADCValue29:
;ADC.c,310 :: 		for (i = 7; i >=5; i--) {
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
;ADC.c,311 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue59
L__parseADCValue60:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue59:
	DJNZ R0, L__parseADCValue60
	MOV parseADCValue_result_L0+0, A
;ADC.c,312 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,310 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,313 :: 		}
	SJMP L_parseADCValue31
L_parseADCValue32:
;ADC.c,315 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,316 :: 		}
	RET
; end of _parseADCValue

_getInputValue:
;ADC.c,321 :: 		float getInputValue(int _data) {
;ADC.c,322 :: 		return 4.096 * _data / 4096;
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
;ADC.c,323 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,333 :: 		float getGain(int _data) {
;ADC.c,334 :: 		return 2 * _data / 1000;
	MOV R2, #1
	MOV R1, FARG_getGain__data+1
	MOV A, FARG_getGain__data+0
	INC R2
	SJMP L__getGain61
L__getGain62:
	CLR C
	RLC A
	XCH A, R1
	RLC A
	XCH A, R1
L__getGain61:
	DJNZ R2, L__getGain62
	MOV R0, A
	MOV R4, #232
	MOV R5, #3
	LCALL _Div_16x16_S+0
	LCALL _Int2Double+0
;ADC.c,335 :: 		}
	RET
; end of _getGain

_strConstCpy:
;ADC.c,349 :: 		void strConstCpy(char *dest, const char *source) {
;ADC.c,350 :: 		while(*source)
L_strConstCpy34:
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	JZ L_strConstCpy35
;ADC.c,351 :: 		*dest++ = *source++ ;
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R1, A
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, 1
	INC FARG_strConstCpy_dest+0
	MOV A, #1
	ADD A, FARG_strConstCpy_source+0
	MOV FARG_strConstCpy_source+0, A
	MOV A, #0
	ADDC A, FARG_strConstCpy_source+1
	MOV FARG_strConstCpy_source+1, A
	SJMP L_strConstCpy34
L_strConstCpy35:
;ADC.c,353 :: 		*dest = 0 ;
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, #0
;ADC.c,354 :: 		}
	RET
; end of _strConstCpy

_main:
	MOV SP+0, #128
;ADC.c,362 :: 		void main() {
;ADC.c,373 :: 		initSPI(); //Инициализация SPI
	LCALL _initSPI+0
;ADC.c,374 :: 		rs232init(); // Инициализация RS232
	LCALL _rs232init+0
;ADC.c,376 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,377 :: 		Delay_us(1);
	NOP
;ADC.c,379 :: 		while(1) {
L_main36:
;ADC.c,383 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main38:
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
	JNZ L_main38
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,387 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,389 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV main_inputValue_L0+0, 0
	MOV main_inputValue_L0+1, 1
	MOV main_inputValue_L0+2, 2
	MOV main_inputValue_L0+3, 3
;ADC.c,394 :: 		strConstCpy(textBuffer, ch0);           //"channel 0"
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch0+0
	MOV FARG_strConstCpy_source+1, _ch0+1
	LCALL _strConstCpy+0
;ADC.c,395 :: 		transmitStringln(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitStringln_str+0, #main_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,397 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,398 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,400 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, main_adc_result_L0+0
	MOV FARG_IntToStr_input+1, main_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #main_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,401 :: 		transmitString(textBuffer);             //Передача в RS232
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,403 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,404 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,406 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, main_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, main_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, main_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, main_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #main_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,407 :: 		transmitStringln(textBuffer);
	MOV FARG_transmitStringln_str+0, #main_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,409 :: 		Delay_ms(1000);                         //Задержка в 1 секунду
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,414 :: 		*adc_data = adc_get_data(1);
	MOV FARG_adc_get_data_channel+0, #1
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main39:
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
	JNZ L_main39
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,418 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,422 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV main_inputValue_L0+0, 0
	MOV main_inputValue_L0+1, 1
	MOV main_inputValue_L0+2, 2
	MOV main_inputValue_L0+3, 3
;ADC.c,423 :: 		k = getGain(adc_result);                //Расчет коэффициента усиления
	MOV FARG_getGain__data+0, main_adc_result_L0+0
	MOV FARG_getGain__data+1, main_adc_result_L0+1
	LCALL _getGain+0
	MOV main_k_L0+0, 0
	MOV main_k_L0+1, 1
	MOV main_k_L0+2, 2
	MOV main_k_L0+3, 3
;ADC.c,428 :: 		strConstCpy(textBuffer, ch1);           //"channel 1"
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch1+0
	MOV FARG_strConstCpy_source+1, _ch1+1
	LCALL _strConstCpy+0
;ADC.c,429 :: 		transmitStringln(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitStringln_str+0, #main_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,431 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,432 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,434 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, main_adc_result_L0+0
	MOV FARG_IntToStr_input+1, main_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #main_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,435 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,437 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,438 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,440 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, main_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, main_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, main_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, main_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #main_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,441 :: 		transmitStringln(textBuffer);
	MOV FARG_transmitStringln_str+0, #main_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,443 :: 		strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _GAIN_STR+0
	MOV FARG_strConstCpy_source+1, _GAIN_STR+1
	LCALL _strConstCpy+0
;ADC.c,444 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,446 :: 		FloatToStr(k, textBuffer);             //Расчитанный коэффициент усиления к строковому представлению
	MOV FARG_FloatToStr_fnum+0, main_k_L0+0
	MOV FARG_FloatToStr_fnum+1, main_k_L0+1
	MOV FARG_FloatToStr_fnum+2, main_k_L0+2
	MOV FARG_FloatToStr_fnum+3, main_k_L0+3
	MOV FARG_FloatToStr_str+0, #main_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,447 :: 		transmitStringln(textBuffer);
	MOV FARG_transmitStringln_str+0, #main_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,449 :: 		Delay_ms(1000);                       //Задержка 1 сек.
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,450 :: 		}
	LJMP L_main36
;ADC.c,451 :: 		}
	SJMP #254
; end of _main
