
_setXAddress:
;ADC.c,36 :: 		void setXAddress(int x) {
;ADC.c,37 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,38 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,39 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,41 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,43 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,44 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,45 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,50 :: 		void setYAddress(int y) {
;ADC.c,51 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,52 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,53 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,55 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,57 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,58 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,59 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,64 :: 		void setZAddress(int z) {
;ADC.c,65 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,66 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,67 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,69 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,71 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,72 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,73 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,78 :: 		void writeData(char _data) {
;ADC.c,79 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,80 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,81 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,83 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,84 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,85 :: 		}
	RET
; end of _writeData

_readData:
;ADC.c,92 :: 		int readData(int x, int y) {
;ADC.c,93 :: 		int buf = 0;
	MOV readData_buf_L0+0, #0
	MOV readData_buf_L0+1, #0
;ADC.c,94 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_readData_x+1
	MOV readData__cs_L0+0, FARG_readData_x+0
	INC R0
	SJMP L__readData55
L__readData56:
	MOV C, #231
	RRC A
	XCH A, readData__cs_L0+0
	RRC A
	XCH A, readData__cs_L0+0
L__readData55:
	DJNZ R0, L__readData56
	MOV readData__cs_L0+1, A
;ADC.c,95 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,96 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,97 :: 		LCD_RW = 1;
	SETB P2_5_bit+0
;ADC.c,99 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_readData_y+1
	MOV FARG_setXAddress_x+0, FARG_readData_y+0
	INC R0
	SJMP L__readData57
L__readData58:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData57:
	DJNZ R0, L__readData58
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,100 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,102 :: 		if (_cs == 0 ) {
	MOV A, readData__cs_L0+0
	ORL A, readData__cs_L0+1
	JNZ L_readData0
;ADC.c,103 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,104 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,105 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_readData_x+0
	MOV FARG_setYAddress_y+1, FARG_readData_x+1
	LCALL _setYAddress+0
;ADC.c,106 :: 		} else {
	SJMP L_readData1
L_readData0:
;ADC.c,107 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,108 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,109 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,110 :: 		}
L_readData1:
;ADC.c,112 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,113 :: 		buf = P0;
	MOV readData_buf_L0+0, PCON+0
	CLR A
	MOV readData_buf_L0+1, A
;ADC.c,114 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,115 :: 		return buf;
	MOV R0, readData_buf_L0+0
	MOV R1, readData_buf_L0+1
;ADC.c,116 :: 		}
	RET
; end of _readData

_displayOn:
;ADC.c,121 :: 		void displayOn() {
;ADC.c,122 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,123 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,124 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,126 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,129 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,130 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,131 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,138 :: 		void drawPoint(int x, int y) {
;ADC.c,139 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,140 :: 		int limit = 0;
;ADC.c,141 :: 		int mask = 0b00000001;
;ADC.c,142 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint59
L__drawPoint60:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint59:
	DJNZ R0, L__drawPoint60
	MOV drawPoint__cs_L0+1, A
;ADC.c,143 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint61
L__drawPoint62:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint61:
	DJNZ R0, L__drawPoint62
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,145 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
	JNZ L_drawPoint2
;ADC.c,146 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,147 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,148 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,149 :: 		} else {
	SJMP L_drawPoint3
L_drawPoint2:
;ADC.c,150 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,151 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,153 :: 		setYAddress(x % 64);
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_drawPoint_x+0
	MOV R1, FARG_drawPoint_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
	LCALL _setYAddress+0
;ADC.c,154 :: 		}
L_drawPoint3:
;ADC.c,155 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,156 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,157 :: 		for (count = 0; count < limit - 1; count++) {
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
;ADC.c,158 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint63
L__drawPoint64:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint63:
	DJNZ R0, L__drawPoint64
	MOV drawPoint_mask_L0+0, A
;ADC.c,157 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,159 :: 		}
	SJMP L_drawPoint4
L_drawPoint5:
;ADC.c,160 :: 		if(y > 0) {
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
;ADC.c,161 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint65
L__drawPoint66:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint65:
	DJNZ R0, L__drawPoint66
	MOV drawPoint_mask_L0+0, A
;ADC.c,162 :: 		}
L_drawPoint7:
;ADC.c,163 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,164 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,165 :: 		}
	RET
; end of _drawPoint

_resetPoint:
;ADC.c,167 :: 		void resetPoint(int x, int y) {
;ADC.c,168 :: 		int count = 0;
;ADC.c,169 :: 		int limit = 0;
;ADC.c,170 :: 		int mask = 0b00000000;
	MOV resetPoint_mask_L0+0, #0
	MOV resetPoint_mask_L0+1, #0
;ADC.c,171 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_resetPoint_x+1
	MOV resetPoint__cs_L0+0, FARG_resetPoint_x+0
	INC R0
	SJMP L__resetPoint67
L__resetPoint68:
	MOV C, #231
	RRC A
	XCH A, resetPoint__cs_L0+0
	RRC A
	XCH A, resetPoint__cs_L0+0
L__resetPoint67:
	DJNZ R0, L__resetPoint68
	MOV resetPoint__cs_L0+1, A
;ADC.c,172 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_resetPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_resetPoint_y+0
	INC R0
	SJMP L__resetPoint69
L__resetPoint70:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__resetPoint69:
	DJNZ R0, L__resetPoint70
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,174 :: 		if (_cs == 0 ) {
	MOV A, resetPoint__cs_L0+0
	ORL A, resetPoint__cs_L0+1
	JNZ L_resetPoint8
;ADC.c,175 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,176 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,177 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_resetPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_resetPoint_x+1
	LCALL _setYAddress+0
;ADC.c,178 :: 		} else {
	SJMP L_resetPoint9
L_resetPoint8:
;ADC.c,179 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,180 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,181 :: 		setYAddress(x % 64);
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_resetPoint_x+0
	MOV R1, FARG_resetPoint_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
	LCALL _setYAddress+0
;ADC.c,182 :: 		}
L_resetPoint9:
;ADC.c,183 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,191 :: 		writeData(mask);
	MOV FARG_writeData__data+0, resetPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,192 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,193 :: 		}
	RET
; end of _resetPoint

_initSPI:
;ADC.c,216 :: 		void initSPI() {
;ADC.c,217 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,219 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,226 :: 		void rs232init() {
;ADC.c,227 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,228 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,229 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,230 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,231 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,232 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,233 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,234 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,241 :: 		void transmit(char b) {
;ADC.c,242 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,243 :: 		while(TI_bit == 0) {}
L_transmit10:
	JB TI_bit+0, L_transmit11
	NOP
	SJMP L_transmit10
L_transmit11:
;ADC.c,244 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,246 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,248 :: 		void transmitString(char* str) {
;ADC.c,249 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,251 :: 		while (*p) {
L_transmitString12:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString13
;ADC.c,252 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,253 :: 		}
	SJMP L_transmitString12
L_transmitString13:
;ADC.c,254 :: 		}
	RET
; end of _transmitString

_transmitStringln:
;ADC.c,256 :: 		void transmitStringln(char* str) {
;ADC.c,257 :: 		char *p = &str[0];
	MOV transmitStringln_p_L0+0, FARG_transmitStringln_str+0
;ADC.c,259 :: 		while (*p) {
L_transmitStringln14:
	MOV R0, transmitStringln_p_L0+0
	MOV A, @R0
	JZ L_transmitStringln15
;ADC.c,260 :: 		transmit(*(p++));
	MOV R0, transmitStringln_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitStringln_p_L0+0
;ADC.c,261 :: 		}
	SJMP L_transmitStringln14
L_transmitStringln15:
;ADC.c,264 :: 		transmit('\r');
	MOV FARG_transmit_b+0, #13
	LCALL _transmit+0
;ADC.c,265 :: 		transmit('\n');
	MOV FARG_transmit_b+0, #10
	LCALL _transmit+0
;ADC.c,266 :: 		}
	RET
; end of _transmitStringln

_writeSPI:
;ADC.c,271 :: 		void writeSPI(int _data) {
;ADC.c,272 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,273 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,278 :: 		int readSPI() {
;ADC.c,280 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,281 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,282 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,287 :: 		void delay() {
;ADC.c,288 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,289 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,295 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,297 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,298 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data16
;ADC.c,299 :: 		SPI_init_data += 0b00000000;
;ADC.c,300 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data17
L_adc_get_data16:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data71
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data71:
	JNZ L_adc_get_data18
;ADC.c,301 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,302 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data19
L_adc_get_data18:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data72
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data72:
	JNZ L_adc_get_data20
;ADC.c,303 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,304 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data21
L_adc_get_data20:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data73
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data73:
	JNZ L_adc_get_data22
;ADC.c,305 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,306 :: 		}
L_adc_get_data22:
L_adc_get_data21:
L_adc_get_data19:
L_adc_get_data17:
;ADC.c,307 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,308 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,313 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,314 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data23:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data24
	NOP
	SJMP L_adc_get_data23
L_adc_get_data24:
;ADC.c,315 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,318 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,319 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data25:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data26
	NOP
	SJMP L_adc_get_data25
L_adc_get_data26:
;ADC.c,320 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,323 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,324 :: 		while(SPIF_bit != 1) {}
L_adc_get_data27:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data28
	NOP
	SJMP L_adc_get_data27
L_adc_get_data28:
;ADC.c,325 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,328 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,330 :: 		return _data;
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
;ADC.c,331 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,336 :: 		int getBit(int position, int byte) {
;ADC.c,337 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit74
L__getBit75:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit74:
	DJNZ R2, L__getBit75
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,338 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,340 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,341 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,342 :: 		int i = 0;
;ADC.c,344 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,346 :: 		for(i = 7; i >= 0; i--) {
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
;ADC.c,347 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue76
L__parseADCValue77:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue76:
	DJNZ R0, L__parseADCValue77
	MOV parseADCValue_result_L0+0, A
;ADC.c,348 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,346 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,349 :: 		}
	SJMP L_parseADCValue30
L_parseADCValue31:
;ADC.c,351 :: 		for (i = 7; i >=5; i--) {
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
;ADC.c,352 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue78
L__parseADCValue79:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue78:
	DJNZ R0, L__parseADCValue79
	MOV parseADCValue_result_L0+0, A
;ADC.c,353 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,351 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,354 :: 		}
	SJMP L_parseADCValue33
L_parseADCValue34:
;ADC.c,356 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,357 :: 		}
	RET
; end of _parseADCValue

_getInputValue:
;ADC.c,362 :: 		float getInputValue(int _data) {
;ADC.c,363 :: 		return 4.096 * _data / 4096;
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
;ADC.c,364 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,374 :: 		float getGain(int _data) {
;ADC.c,375 :: 		return 2. * (_data / 1000.);
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
;ADC.c,376 :: 		}
	RET
; end of _getGain

_getMainSignalValue:
;ADC.c,378 :: 		float getMainSignalValue(float gain, float ) {
;ADC.c,380 :: 		}
	RET
; end of _getMainSignalValue

_strConstCpy:
;ADC.c,394 :: 		void strConstCpy(char *dest, const char *source) {
;ADC.c,395 :: 		while(*source) {
L_strConstCpy36:
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	JZ L_strConstCpy37
;ADC.c,396 :: 		*dest++ = *source++;
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
;ADC.c,397 :: 		}
	SJMP L_strConstCpy36
L_strConstCpy37:
;ADC.c,398 :: 		*dest = 0 ;
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, #0
;ADC.c,399 :: 		}
	RET
; end of _strConstCpy

_debugADC:
;ADC.c,517 :: 		void debugADC() {
;ADC.c,530 :: 		*adc_data = adc_get_data(0);
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
;ADC.c,534 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV debugADC_adc_result_L0+0, 0
	MOV debugADC_adc_result_L0+1, 1
;ADC.c,536 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV debugADC_inputValue_L0+0, 0
	MOV debugADC_inputValue_L0+1, 1
	MOV debugADC_inputValue_L0+2, 2
	MOV debugADC_inputValue_L0+3, 3
;ADC.c,541 :: 		strConstCpy(textBuffer, ch0);         //"channel 0"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch0+0
	MOV FARG_strConstCpy_source+1, _ch0+1
	LCALL _strConstCpy+0
;ADC.c,542 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,547 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,548 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,553 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,554 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,556 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, debugADC_adc_result_L0+0
	MOV FARG_IntToStr_input+1, debugADC_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #debugADC_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,557 :: 		transmitString(textBuffer);             //Передача в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,562 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,563 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,568 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,569 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,571 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,572 :: 		transmitStringln(textBuffer);
	MOV FARG_transmitStringln_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,574 :: 		Delay_ms(1000);                         //Задержка в 1 секунду
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,579 :: 		*adc_data = adc_get_data(1);
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
;ADC.c,583 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV debugADC_adc_result_L0+0, 0
	MOV debugADC_adc_result_L0+1, 1
;ADC.c,588 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV debugADC_inputValue_L0+0, 0
	MOV debugADC_inputValue_L0+1, 1
	MOV debugADC_inputValue_L0+2, 2
	MOV debugADC_inputValue_L0+3, 3
;ADC.c,589 :: 		k = getGain(adc_result);                //Расчет коэффициента усиления
	MOV FARG_getGain__data+0, debugADC_adc_result_L0+0
	MOV FARG_getGain__data+1, debugADC_adc_result_L0+1
	LCALL _getGain+0
	MOV debugADC_k_L0+0, 0
	MOV debugADC_k_L0+1, 1
	MOV debugADC_k_L0+2, 2
	MOV debugADC_k_L0+3, 3
;ADC.c,598 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,599 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,603 :: 		strConstCpy(textBuffer, ch1);           //"channel 1"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch1+0
	MOV FARG_strConstCpy_source+1, _ch1+1
	LCALL _strConstCpy+0
;ADC.c,604 :: 		transmitStringln(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitStringln_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,606 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,607 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,609 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, debugADC_adc_result_L0+0
	MOV FARG_IntToStr_input+1, debugADC_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #debugADC_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,610 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,615 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,616 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,621 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,622 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,624 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,625 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,630 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,631 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,636 :: 		strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _GAIN_STR+0
	MOV FARG_strConstCpy_source+1, _GAIN_STR+1
	LCALL _strConstCpy+0
;ADC.c,637 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,639 :: 		FloatToStr(k, textBuffer);             //Расчитанный коэффициент усиления к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_k_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_k_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_k_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_k_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,640 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,645 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,646 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,647 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,652 :: 		Delay_ms(1000);                       //Задержка 1 сек.
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,653 :: 		}
	RET
; end of _debugADC

_FillBrightness:
;ADC.c,655 :: 		void FillBrightness(int limit) {
;ADC.c,657 :: 		for(x = 0; x <=limit; x++) {
	MOV FillBrightness_x_L0+0, #0
	MOV FillBrightness_x_L0+1, #0
L_FillBrightness40:
	SETB C
	MOV A, FillBrightness_x_L0+0
	SUBB A, FARG_FillBrightness_limit+0
	MOV A, FARG_FillBrightness_limit+1
	XRL A, #128
	MOV R0, A
	MOV A, FillBrightness_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_FillBrightness41
;ADC.c,658 :: 		for(y = 0; y <=64; y++) {
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
;ADC.c,659 :: 		resetPoint(x,y);
	MOV FARG_resetPoint_x+0, FillBrightness_x_L0+0
	MOV FARG_resetPoint_x+1, FillBrightness_x_L0+1
	MOV FARG_resetPoint_y+0, FillBrightness_y_L0+0
	MOV FARG_resetPoint_y+1, FillBrightness_y_L0+1
	LCALL _resetPoint+0
;ADC.c,658 :: 		for(y = 0; y <=64; y++) {
	MOV A, #1
	ADD A, FillBrightness_y_L0+0
	MOV FillBrightness_y_L0+0, A
	MOV A, #0
	ADDC A, FillBrightness_y_L0+1
	MOV FillBrightness_y_L0+1, A
;ADC.c,660 :: 		}
	SJMP L_FillBrightness43
L_FillBrightness44:
;ADC.c,657 :: 		for(x = 0; x <=limit; x++) {
	MOV A, #1
	ADD A, FillBrightness_x_L0+0
	MOV FillBrightness_x_L0+0, A
	MOV A, #0
	ADDC A, FillBrightness_x_L0+1
	MOV FillBrightness_x_L0+1, A
;ADC.c,661 :: 		}
	SJMP L_FillBrightness40
L_FillBrightness41:
;ADC.c,662 :: 		}
	RET
; end of _FillBrightness

_clear:
;ADC.c,664 :: 		void clear(int limit) {
;ADC.c,665 :: 		FillBrightness(limit);
	MOV FARG_FillBrightness_limit+0, FARG_clear_limit+0
	MOV FARG_FillBrightness_limit+1, FARG_clear_limit+1
	LCALL _FillBrightness+0
;ADC.c,666 :: 		}
	RET
; end of _clear

_fill:
;ADC.c,668 :: 		void fill() {
;ADC.c,669 :: 		FillBrightness(255);
	MOV FARG_FillBrightness_limit+0, #255
	MOV FARG_FillBrightness_limit+1, #0
	LCALL _FillBrightness+0
;ADC.c,670 :: 		}
	RET
; end of _fill

_drawVLine:
;ADC.c,672 :: 		void drawVLine(int column) {
;ADC.c,673 :: 		int count = 0;
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
	MOV drawVLine_mask_L0+0, #255
	MOV drawVLine_mask_L0+1, #0
;ADC.c,674 :: 		int mask = 0b11111111;
;ADC.c,675 :: 		int _cs = column / 64;
	MOV R0, #6
	MOV A, FARG_drawVLine_column+1
	MOV drawVLine__cs_L0+0, FARG_drawVLine_column+0
	INC R0
	SJMP L__drawVLine80
L__drawVLine81:
	MOV C, #231
	RRC A
	XCH A, drawVLine__cs_L0+0
	RRC A
	XCH A, drawVLine__cs_L0+0
L__drawVLine80:
	DJNZ R0, L__drawVLine81
	MOV drawVLine__cs_L0+1, A
;ADC.c,677 :: 		for(count = 0; count < 8; count++) {
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
L_drawVLine46:
	CLR C
	MOV A, drawVLine_count_L0+0
	SUBB A, #8
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawVLine_count_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawVLine47
;ADC.c,678 :: 		if (_cs == 0 ) {
	MOV A, drawVLine__cs_L0+0
	ORL A, drawVLine__cs_L0+1
	JNZ L_drawVLine49
;ADC.c,679 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,680 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,681 :: 		setYAddress(column);
	MOV FARG_setYAddress_y+0, FARG_drawVLine_column+0
	MOV FARG_setYAddress_y+1, FARG_drawVLine_column+1
	LCALL _setYAddress+0
;ADC.c,682 :: 		} else {
	SJMP L_drawVLine50
L_drawVLine49:
;ADC.c,683 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,684 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,685 :: 		setYAddress(column % 64);
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_drawVLine_column+0
	MOV R1, FARG_drawVLine_column+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
	LCALL _setYAddress+0
;ADC.c,686 :: 		}
L_drawVLine50:
;ADC.c,687 :: 		setXAddress(count);
	MOV FARG_setXAddress_x+0, drawVLine_count_L0+0
	MOV FARG_setXAddress_x+1, drawVLine_count_L0+1
	LCALL _setXAddress+0
;ADC.c,688 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,689 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawVLine_mask_L0+0
	LCALL _writeData+0
;ADC.c,677 :: 		for(count = 0; count < 8; count++) {
	MOV A, #1
	ADD A, drawVLine_count_L0+0
	MOV drawVLine_count_L0+0, A
	MOV A, #0
	ADDC A, drawVLine_count_L0+1
	MOV drawVLine_count_L0+1, A
;ADC.c,690 :: 		}
	SJMP L_drawVLine46
L_drawVLine47:
;ADC.c,692 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,693 :: 		}
	RET
; end of _drawVLine

_main:
	MOV SP+0, #128
;ADC.c,695 :: 		void main() {
;ADC.c,698 :: 		int flag = 0;
;ADC.c,700 :: 		initSPI(); //Инициализация SPI
	LCALL _initSPI+0
;ADC.c,701 :: 		rs232init(); // Инициализация RS232
	LCALL _rs232init+0
;ADC.c,703 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,704 :: 		Delay_us(1);
	NOP
;ADC.c,706 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,708 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,709 :: 		clear(128);
	MOV FARG_clear_limit+0, #128
	MOV FARG_clear_limit+1, #0
	LCALL _clear+0
;ADC.c,710 :: 		adc_result = 4000;
	MOV main_adc_result_L0+0, #160
	MOV main_adc_result_L0+1, #15
;ADC.c,711 :: 		drawVLine(100);
	MOV FARG_drawVLine_column+0, #100
	MOV FARG_drawVLine_column+1, #0
	LCALL _drawVLine+0
;ADC.c,712 :: 		while(1) {
L_main51:
;ADC.c,714 :: 		*adc_data = adc_get_data(1);
	MOV FARG_adc_get_data_channel+0, #1
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main53:
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
	JNZ L_main53
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,715 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,717 :: 		strConstCpy(textBuffer, RESULT_STR);
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,718 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,720 :: 		IntToStr(adc_result, textBuffer);
	MOV FARG_IntToStr_input+0, main_adc_result_L0+0
	MOV FARG_IntToStr_input+1, main_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #main_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,721 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,723 :: 		strConstCpy(textBuffer, CRLF);
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,724 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,726 :: 		y = 64 - adc_result / LCD_Y_LIMIT;
	MOV R2, #6
	MOV A, main_adc_result_L0+1
	MOV R0, main_adc_result_L0+0
	INC R2
	SJMP L__main82
L__main83:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__main82:
	DJNZ R2, L__main83
	MOV R1, A
	CLR C
	MOV A, #64
	SUBB A, R0
	MOV FARG_drawPoint_y+0, A
	MOV A, #0
	SUBB A, R1
	MOV FARG_drawPoint_y+1, A
;ADC.c,727 :: 		y = y - 1;
	CLR C
	MOV A, FARG_drawPoint_y+0
	SUBB A, #1
	MOV FARG_drawPoint_y+0, A
	MOV A, FARG_drawPoint_y+1
	SUBB A, #0
	MOV FARG_drawPoint_y+1, A
;ADC.c,728 :: 		drawPoint(x, y);
	MOV FARG_drawPoint_x+0, main_x_L0+0
	MOV FARG_drawPoint_x+1, main_x_L0+1
	LCALL _drawPoint+0
;ADC.c,729 :: 		x = x + 1;
	MOV A, #1
	ADD A, main_x_L0+0
	MOV main_x_L0+0, A
	MOV A, #0
	ADDC A, main_x_L0+1
	MOV main_x_L0+1, A
;ADC.c,730 :: 		if (x == 100) {
	MOV A, #100
	XRL A, main_x_L0+0
	JNZ L__main84
	MOV A, #0
	XRL A, main_x_L0+1
L__main84:
	JNZ L_main54
;ADC.c,731 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,732 :: 		clear(99);
	MOV FARG_clear_limit+0, #99
	MOV FARG_clear_limit+1, #0
	LCALL _clear+0
;ADC.c,733 :: 		}
L_main54:
;ADC.c,734 :: 		}
	LJMP L_main51
;ADC.c,735 :: 		}
	SJMP #254
; end of _main
