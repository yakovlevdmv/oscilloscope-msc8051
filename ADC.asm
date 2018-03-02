
_setXAddress:
;ADC.c,27 :: 		void setXAddress(int x) {
;ADC.c,28 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,29 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,30 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,32 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,34 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,35 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,36 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,41 :: 		void setYAddress(int y) {
;ADC.c,42 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,43 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,44 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,46 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,48 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,49 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,50 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,55 :: 		void setZAddress(int z) {
;ADC.c,56 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,57 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,58 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,60 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,62 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,63 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,64 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,69 :: 		void writeData(char _data) {
;ADC.c,70 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,71 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,72 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,74 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,75 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,76 :: 		}
	RET
; end of _writeData

_readData:
;ADC.c,83 :: 		int readData(int x, int y) {
;ADC.c,84 :: 		int buf = 0;
	MOV readData_buf_L0+0, #0
	MOV readData_buf_L0+1, #0
;ADC.c,85 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_readData_x+1
	MOV readData__cs_L0+0, FARG_readData_x+0
	INC R0
	SJMP L__readData50
L__readData51:
	MOV C, #231
	RRC A
	XCH A, readData__cs_L0+0
	RRC A
	XCH A, readData__cs_L0+0
L__readData50:
	DJNZ R0, L__readData51
	MOV readData__cs_L0+1, A
;ADC.c,86 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,87 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,88 :: 		LCD_RW = 1;
	SETB P2_5_bit+0
;ADC.c,90 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_readData_y+1
	MOV FARG_setXAddress_x+0, FARG_readData_y+0
	INC R0
	SJMP L__readData52
L__readData53:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData52:
	DJNZ R0, L__readData53
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,91 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,93 :: 		if (_cs == 0 ) {
	MOV A, readData__cs_L0+0
	ORL A, readData__cs_L0+1
	JNZ L_readData0
;ADC.c,94 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,95 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,96 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_readData_x+0
	MOV FARG_setYAddress_y+1, FARG_readData_x+1
	LCALL _setYAddress+0
;ADC.c,97 :: 		} else {
	SJMP L_readData1
L_readData0:
;ADC.c,98 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,99 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,100 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,101 :: 		}
L_readData1:
;ADC.c,103 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,104 :: 		buf = P0;
	MOV readData_buf_L0+0, PCON+0
	CLR A
	MOV readData_buf_L0+1, A
;ADC.c,105 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,106 :: 		return buf;
	MOV R0, readData_buf_L0+0
	MOV R1, readData_buf_L0+1
;ADC.c,107 :: 		}
	RET
; end of _readData

_displayOn:
;ADC.c,112 :: 		void displayOn() {
;ADC.c,113 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,114 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,115 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,117 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,120 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,121 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,122 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,129 :: 		void drawPoint(int x, int y) {
;ADC.c,130 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,131 :: 		int limit = 0;
;ADC.c,132 :: 		int mask = 0b00000001;
;ADC.c,133 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint54
L__drawPoint55:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint54:
	DJNZ R0, L__drawPoint55
	MOV drawPoint__cs_L0+1, A
;ADC.c,134 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint56
L__drawPoint57:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint56:
	DJNZ R0, L__drawPoint57
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,136 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
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
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,147 :: 		for (count = 0; count < limit - 1; count++) {
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
;ADC.c,148 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint58
L__drawPoint59:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint58:
	DJNZ R0, L__drawPoint59
	MOV drawPoint_mask_L0+0, A
;ADC.c,147 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
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
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint60
L__drawPoint61:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint60:
	DJNZ R0, L__drawPoint61
	MOV drawPoint_mask_L0+0, A
;ADC.c,152 :: 		}
L_drawPoint7:
;ADC.c,153 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,154 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,155 :: 		}
	RET
; end of _drawPoint

_resetPoint:
;ADC.c,157 :: 		void resetPoint(int x, int y) {
;ADC.c,158 :: 		int count = 0;
;ADC.c,159 :: 		int limit = 0;
;ADC.c,160 :: 		int mask = 0b00000000;
	MOV resetPoint_mask_L0+0, #0
	MOV resetPoint_mask_L0+1, #0
;ADC.c,161 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_resetPoint_x+1
	MOV resetPoint__cs_L0+0, FARG_resetPoint_x+0
	INC R0
	SJMP L__resetPoint62
L__resetPoint63:
	MOV C, #231
	RRC A
	XCH A, resetPoint__cs_L0+0
	RRC A
	XCH A, resetPoint__cs_L0+0
L__resetPoint62:
	DJNZ R0, L__resetPoint63
	MOV resetPoint__cs_L0+1, A
;ADC.c,162 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_resetPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_resetPoint_y+0
	INC R0
	SJMP L__resetPoint64
L__resetPoint65:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__resetPoint64:
	DJNZ R0, L__resetPoint65
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,164 :: 		if (_cs == 0 ) {
	MOV A, resetPoint__cs_L0+0
	ORL A, resetPoint__cs_L0+1
	JNZ L_resetPoint8
;ADC.c,165 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,166 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,167 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_resetPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_resetPoint_x+1
	LCALL _setYAddress+0
;ADC.c,168 :: 		} else {
	SJMP L_resetPoint9
L_resetPoint8:
;ADC.c,169 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,170 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,171 :: 		setYAddress(64 + (x % 64));
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_resetPoint_x+0
	MOV R1, FARG_resetPoint_x+1
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
;ADC.c,172 :: 		}
L_resetPoint9:
;ADC.c,173 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,181 :: 		writeData(mask);
	MOV FARG_writeData__data+0, resetPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,182 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,183 :: 		}
	RET
; end of _resetPoint

_initSPI:
;ADC.c,206 :: 		void initSPI() {
;ADC.c,207 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,209 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,216 :: 		void rs232init() {
;ADC.c,217 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,218 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,219 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,220 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,221 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,222 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,223 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,224 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,231 :: 		void transmit(char b) {
;ADC.c,232 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,233 :: 		while(TI_bit == 0) {}
L_transmit10:
	JB TI_bit+0, L_transmit11
	NOP
	SJMP L_transmit10
L_transmit11:
;ADC.c,234 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,236 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,238 :: 		void transmitString(char* str) {
;ADC.c,239 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,241 :: 		while (*p) {
L_transmitString12:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString13
;ADC.c,242 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,243 :: 		}
	SJMP L_transmitString12
L_transmitString13:
;ADC.c,244 :: 		}
	RET
; end of _transmitString

_transmitStringln:
;ADC.c,246 :: 		void transmitStringln(char* str) {
;ADC.c,247 :: 		char *p = &str[0];
	MOV transmitStringln_p_L0+0, FARG_transmitStringln_str+0
;ADC.c,249 :: 		while (*p) {
L_transmitStringln14:
	MOV R0, transmitStringln_p_L0+0
	MOV A, @R0
	JZ L_transmitStringln15
;ADC.c,250 :: 		transmit(*(p++));
	MOV R0, transmitStringln_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitStringln_p_L0+0
;ADC.c,251 :: 		}
	SJMP L_transmitStringln14
L_transmitStringln15:
;ADC.c,254 :: 		transmit('\r');
	MOV FARG_transmit_b+0, #13
	LCALL _transmit+0
;ADC.c,255 :: 		transmit('\n');
	MOV FARG_transmit_b+0, #10
	LCALL _transmit+0
;ADC.c,256 :: 		}
	RET
; end of _transmitStringln

_writeSPI:
;ADC.c,261 :: 		void writeSPI(int _data) {
;ADC.c,262 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,263 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,268 :: 		int readSPI() {
;ADC.c,270 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,271 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,272 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,277 :: 		void delay() {
;ADC.c,278 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,279 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,285 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,287 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,288 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data16
;ADC.c,289 :: 		SPI_init_data += 0b00000000;
;ADC.c,290 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data17
L_adc_get_data16:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data66
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data66:
	JNZ L_adc_get_data18
;ADC.c,291 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,292 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data19
L_adc_get_data18:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data67
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data67:
	JNZ L_adc_get_data20
;ADC.c,293 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,294 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data21
L_adc_get_data20:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data68
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data68:
	JNZ L_adc_get_data22
;ADC.c,295 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,296 :: 		}
L_adc_get_data22:
L_adc_get_data21:
L_adc_get_data19:
L_adc_get_data17:
;ADC.c,297 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,298 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,303 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,304 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data23:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data24
	NOP
	SJMP L_adc_get_data23
L_adc_get_data24:
;ADC.c,305 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,308 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,309 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data25:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data26
	NOP
	SJMP L_adc_get_data25
L_adc_get_data26:
;ADC.c,310 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,313 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,314 :: 		while(SPIF_bit != 1) {}
L_adc_get_data27:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data28
	NOP
	SJMP L_adc_get_data27
L_adc_get_data28:
;ADC.c,315 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,318 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,320 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data29:
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
	JNZ L_adc_get_data29
	MOV ?lstr_1_ADC+0, adc_get_data__data_L0+0
	MOV ?lstr_1_ADC+1, adc_get_data__data_L0+1
;ADC.c,321 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,326 :: 		int getBit(int position, int byte) {
;ADC.c,327 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit69
L__getBit70:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit69:
	DJNZ R2, L__getBit70
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,328 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,330 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,331 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,332 :: 		int i = 0;
;ADC.c,334 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,336 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue30:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue31
;ADC.c,337 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue71
L__parseADCValue72:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue71:
	DJNZ R0, L__parseADCValue72
	MOV parseADCValue_result_L0+0, A
;ADC.c,338 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,336 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,339 :: 		}
	SJMP L_parseADCValue30
L_parseADCValue31:
;ADC.c,341 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue33:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue34
;ADC.c,342 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue73
L__parseADCValue74:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue73:
	DJNZ R0, L__parseADCValue74
	MOV parseADCValue_result_L0+0, A
;ADC.c,343 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,341 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,344 :: 		}
	SJMP L_parseADCValue33
L_parseADCValue34:
;ADC.c,346 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,347 :: 		}
	RET
; end of _parseADCValue

_getInputValue:
;ADC.c,352 :: 		float getInputValue(int _data) {
;ADC.c,353 :: 		return 4.096 * _data / 4096;
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
;ADC.c,354 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,364 :: 		float getGain(int _data) {
;ADC.c,365 :: 		return 2. * (_data / 1000.);
	MOV R0, FARG_getGain__data+0
	MOV R1, FARG_getGain__data+1
	LCALL _Int2Double+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #122
	MOV 7, #68
	LCALL _Div_32x32_FP+0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV 7, #64
	LCALL _Mul_32x32_FP+0
;ADC.c,366 :: 		}
	RET
; end of _getGain

_getMainSignalValue:
;ADC.c,368 :: 		float getMainSignalValue(float gain, float ) {
;ADC.c,370 :: 		}
	RET
; end of _getMainSignalValue

_strConstCpy:
;ADC.c,384 :: 		void strConstCpy(char *dest, const char *source) {
;ADC.c,385 :: 		while(*source)
L_strConstCpy36:
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	JZ L_strConstCpy37
;ADC.c,386 :: 		*dest++ = *source++ ;
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
	SJMP L_strConstCpy36
L_strConstCpy37:
;ADC.c,388 :: 		*dest = 0 ;
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, #0
;ADC.c,389 :: 		}
	RET
; end of _strConstCpy

_debugADC:
;ADC.c,401 :: 		void debugADC() {
;ADC.c,414 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__debugADC+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__debugADC+0
L_debugADC38:
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
	JNZ L_debugADC38
	MOV R0, _adc_data+0
	MOV @R0, FLOC__debugADC+0
	INC R0
	MOV @R0, FLOC__debugADC+1
;ADC.c,418 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV debugADC_adc_result_L0+0, 0
	MOV debugADC_adc_result_L0+1, 1
;ADC.c,420 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV debugADC_inputValue_L0+0, 0
	MOV debugADC_inputValue_L0+1, 1
	MOV debugADC_inputValue_L0+2, 2
	MOV debugADC_inputValue_L0+3, 3
;ADC.c,425 :: 		strConstCpy(textBuffer, ch0);         //"channel 0"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch0+0
	MOV FARG_strConstCpy_source+1, _ch0+1
	LCALL _strConstCpy+0
;ADC.c,426 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,431 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,432 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,437 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,438 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,440 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, debugADC_adc_result_L0+0
	MOV FARG_IntToStr_input+1, debugADC_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #debugADC_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,441 :: 		transmitString(textBuffer);             //Передача в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,446 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,447 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,452 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,453 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,455 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,456 :: 		transmitStringln(textBuffer);
	MOV FARG_transmitStringln_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,458 :: 		Delay_ms(1000);                         //Задержка в 1 секунду
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,463 :: 		*adc_data = adc_get_data(1);
	MOV FARG_adc_get_data_channel+0, #1
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__debugADC+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__debugADC+0
L_debugADC39:
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
	JNZ L_debugADC39
	MOV R0, _adc_data+0
	MOV @R0, FLOC__debugADC+0
	INC R0
	MOV @R0, FLOC__debugADC+1
;ADC.c,467 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV debugADC_adc_result_L0+0, 0
	MOV debugADC_adc_result_L0+1, 1
;ADC.c,472 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV debugADC_inputValue_L0+0, 0
	MOV debugADC_inputValue_L0+1, 1
	MOV debugADC_inputValue_L0+2, 2
	MOV debugADC_inputValue_L0+3, 3
;ADC.c,473 :: 		k = getGain(adc_result);                //Расчет коэффициента усиления
	MOV FARG_getGain__data+0, debugADC_adc_result_L0+0
	MOV FARG_getGain__data+1, debugADC_adc_result_L0+1
	LCALL _getGain+0
	MOV debugADC_k_L0+0, 0
	MOV debugADC_k_L0+1, 1
	MOV debugADC_k_L0+2, 2
	MOV debugADC_k_L0+3, 3
;ADC.c,482 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,483 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,487 :: 		strConstCpy(textBuffer, ch1);           //"channel 1"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch1+0
	MOV FARG_strConstCpy_source+1, _ch1+1
	LCALL _strConstCpy+0
;ADC.c,488 :: 		transmitStringln(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitStringln_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,490 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,491 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,493 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, debugADC_adc_result_L0+0
	MOV FARG_IntToStr_input+1, debugADC_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #debugADC_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,494 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,499 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,500 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,505 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,506 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,508 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,509 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,514 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,515 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,520 :: 		strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _GAIN_STR+0
	MOV FARG_strConstCpy_source+1, _GAIN_STR+1
	LCALL _strConstCpy+0
;ADC.c,521 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,523 :: 		FloatToStr(k, textBuffer);             //Расчитанный коэффициент усиления к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_k_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_k_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_k_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_k_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,524 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,529 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,530 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,531 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,536 :: 		Delay_ms(1000);                       //Задержка 1 сек.
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,537 :: 		}
	RET
; end of _debugADC

_FillBrightness:
;ADC.c,539 :: 		void FillBrightness(int brightness) {
;ADC.c,541 :: 		for(x = 0; x <=128; x++) {
	MOV FillBrightness_x_L0+0, #0
	MOV FillBrightness_x_L0+1, #0
L_FillBrightness40:
	SETB C
	MOV A, FillBrightness_x_L0+0
	SUBB A, #128
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FillBrightness_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_FillBrightness41
;ADC.c,542 :: 		for(y = 0; y <=64; y++) {
	MOV FillBrightness_y_L0+0, #0
	MOV FillBrightness_y_L0+1, #0
L_FillBrightness43:
	SETB C
	MOV A, FillBrightness_y_L0+0
	SUBB A, #64
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FillBrightness_y_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_FillBrightness44
;ADC.c,543 :: 		resetPoint(x,y);
	MOV FARG_resetPoint_x+0, FillBrightness_x_L0+0
	MOV FARG_resetPoint_x+1, FillBrightness_x_L0+1
	MOV FARG_resetPoint_y+0, FillBrightness_y_L0+0
	MOV FARG_resetPoint_y+1, FillBrightness_y_L0+1
	LCALL _resetPoint+0
;ADC.c,542 :: 		for(y = 0; y <=64; y++) {
	MOV A, #1
	ADD A, FillBrightness_y_L0+0
	MOV FillBrightness_y_L0+0, A
	MOV A, #0
	ADDC A, FillBrightness_y_L0+1
	MOV FillBrightness_y_L0+1, A
;ADC.c,544 :: 		}
	SJMP L_FillBrightness43
L_FillBrightness44:
;ADC.c,541 :: 		for(x = 0; x <=128; x++) {
	MOV A, #1
	ADD A, FillBrightness_x_L0+0
	MOV FillBrightness_x_L0+0, A
	MOV A, #0
	ADDC A, FillBrightness_x_L0+1
	MOV FillBrightness_x_L0+1, A
;ADC.c,545 :: 		}
	SJMP L_FillBrightness40
L_FillBrightness41:
;ADC.c,558 :: 		}
	RET
; end of _FillBrightness

_clear:
;ADC.c,560 :: 		void clear() {
;ADC.c,561 :: 		FillBrightness(0);
	MOV FARG_FillBrightness_brightness+0, #0
	MOV FARG_FillBrightness_brightness+1, #0
	LCALL _FillBrightness+0
;ADC.c,562 :: 		}
	RET
; end of _clear

_fill:
;ADC.c,564 :: 		void fill() {
;ADC.c,565 :: 		FillBrightness(255);
	MOV FARG_FillBrightness_brightness+0, #255
	MOV FARG_FillBrightness_brightness+1, #0
	LCALL _FillBrightness+0
;ADC.c,566 :: 		}
	RET
; end of _fill

_main:
	MOV SP+0, #128
;ADC.c,568 :: 		void main() {
;ADC.c,571 :: 		int flag = 0;
;ADC.c,573 :: 		initSPI(); //Инициализация SPI
	LCALL _initSPI+0
;ADC.c,574 :: 		rs232init(); // Инициализация RS232
	LCALL _rs232init+0
;ADC.c,576 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,577 :: 		Delay_us(1);
	NOP
;ADC.c,579 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,581 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,582 :: 		clear();
	LCALL _clear+0
;ADC.c,583 :: 		while(1) {
L_main46:
;ADC.c,588 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main48:
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
	JNZ L_main48
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,592 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,594 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,595 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,597 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, main_adc_result_L0+0
	MOV FARG_IntToStr_input+1, main_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #main_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,598 :: 		transmitString(textBuffer);             //Передача в RS232
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,603 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,604 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,609 :: 		y = 64 - adc_result / LCD_Y_LIMIT;
	MOV R2, #6
	MOV A, main_adc_result_L0+1
	MOV R0, main_adc_result_L0+0
	INC R2
	SJMP L__main75
L__main76:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__main75:
	DJNZ R2, L__main76
	MOV R1, A
	CLR C
	MOV A, #64
	SUBB A, R0
	MOV FARG_drawPoint_y+0, A
	MOV A, #0
	SUBB A, R1
	MOV FARG_drawPoint_y+1, A
;ADC.c,610 :: 		drawPoint(x, y);
	MOV FARG_drawPoint_x+0, main_x_L0+0
	MOV FARG_drawPoint_x+1, main_x_L0+1
	LCALL _drawPoint+0
;ADC.c,611 :: 		x = x + 1;
	MOV A, #1
	ADD A, main_x_L0+0
	MOV main_x_L0+0, A
	MOV A, #0
	ADDC A, main_x_L0+1
	MOV main_x_L0+1, A
;ADC.c,612 :: 		if (x == 128) {
	MOV A, #128
	XRL A, main_x_L0+0
	JNZ L__main77
	MOV A, #0
	XRL A, main_x_L0+1
L__main77:
	JNZ L_main49
;ADC.c,614 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,615 :: 		clear();
	LCALL _clear+0
;ADC.c,616 :: 		}
L_main49:
;ADC.c,623 :: 		}
	LJMP L_main46
;ADC.c,625 :: 		}
	SJMP #254
; end of _main
