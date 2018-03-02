
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
	SJMP L__readData54
L__readData55:
	MOV C, #231
	RRC A
	XCH A, readData__cs_L0+0
	RRC A
	XCH A, readData__cs_L0+0
L__readData54:
	DJNZ R0, L__readData55
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
	SJMP L__readData56
L__readData57:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData56:
	DJNZ R0, L__readData57
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
	SJMP L__drawPoint58
L__drawPoint59:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint58:
	DJNZ R0, L__drawPoint59
	MOV drawPoint__cs_L0+1, A
;ADC.c,134 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint60
L__drawPoint61:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint60:
	DJNZ R0, L__drawPoint61
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
;ADC.c,144 :: 		setYAddress(x % 64);
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
;ADC.c,145 :: 		}
L_drawPoint3:
;ADC.c,146 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,147 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,148 :: 		for (count = 0; count < limit - 1; count++) {
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
;ADC.c,149 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint62
L__drawPoint63:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint62:
	DJNZ R0, L__drawPoint63
	MOV drawPoint_mask_L0+0, A
;ADC.c,148 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,150 :: 		}
	SJMP L_drawPoint4
L_drawPoint5:
;ADC.c,151 :: 		if(y > 0) {
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
;ADC.c,152 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint64
L__drawPoint65:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint64:
	DJNZ R0, L__drawPoint65
	MOV drawPoint_mask_L0+0, A
;ADC.c,153 :: 		}
L_drawPoint7:
;ADC.c,154 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,155 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,156 :: 		}
	RET
; end of _drawPoint

_drawPointCS2:
;ADC.c,158 :: 		void drawPointCS2(int x, int y) {
;ADC.c,159 :: 		int count = 0;
	MOV drawPointCS2_count_L0+0, #0
	MOV drawPointCS2_count_L0+1, #0
	MOV drawPointCS2_limit_L0+0, #0
	MOV drawPointCS2_limit_L0+1, #0
	MOV drawPointCS2_mask_L0+0, #1
	MOV drawPointCS2_mask_L0+1, #0
;ADC.c,160 :: 		int limit = 0;
;ADC.c,161 :: 		int mask = 0b00000001;
;ADC.c,163 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPointCS2_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPointCS2_y+0
	INC R0
	SJMP L__drawPointCS266
L__drawPointCS267:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPointCS266:
	DJNZ R0, L__drawPointCS267
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,165 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,166 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,167 :: 		setYAddress(x % 64);
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_drawPointCS2_x+0
	MOV R1, FARG_drawPointCS2_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
	LCALL _setYAddress+0
;ADC.c,168 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,169 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPointCS2_y+0
	MOV R1, FARG_drawPointCS2_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPointCS2_limit_L0+0, 0
	MOV drawPointCS2_limit_L0+1, 1
;ADC.c,170 :: 		for (count = 0; count < limit - 1; count++) {
	MOV drawPointCS2_count_L0+0, #0
	MOV drawPointCS2_count_L0+1, #0
L_drawPointCS28:
	CLR C
	MOV A, drawPointCS2_limit_L0+0
	SUBB A, #1
	MOV R1, A
	MOV A, drawPointCS2_limit_L0+1
	SUBB A, #0
	MOV R2, A
	CLR C
	MOV A, drawPointCS2_count_L0+0
	SUBB A, R1
	MOV A, R2
	XRL A, #128
	MOV R0, A
	MOV A, drawPointCS2_count_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawPointCS29
;ADC.c,171 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPointCS2_mask_L0+0
	INC R0
	SJMP L__drawPointCS268
L__drawPointCS269:
	CLR C
	RLC A
	XCH A, drawPointCS2_mask_L0+1
	RLC A
	XCH A, drawPointCS2_mask_L0+1
L__drawPointCS268:
	DJNZ R0, L__drawPointCS269
	MOV drawPointCS2_mask_L0+0, A
;ADC.c,170 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPointCS2_count_L0+0
	MOV drawPointCS2_count_L0+0, A
	MOV A, #0
	ADDC A, drawPointCS2_count_L0+1
	MOV drawPointCS2_count_L0+1, A
;ADC.c,172 :: 		}
	SJMP L_drawPointCS28
L_drawPointCS29:
;ADC.c,173 :: 		if(y > 0) {
	SETB C
	MOV A, FARG_drawPointCS2_y+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_drawPointCS2_y+1
	XRL A, #128
	SUBB A, R0
	JC L_drawPointCS211
;ADC.c,174 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPointCS2_mask_L0+0
	INC R0
	SJMP L__drawPointCS270
L__drawPointCS271:
	CLR C
	RLC A
	XCH A, drawPointCS2_mask_L0+1
	RLC A
	XCH A, drawPointCS2_mask_L0+1
L__drawPointCS270:
	DJNZ R0, L__drawPointCS271
	MOV drawPointCS2_mask_L0+0, A
;ADC.c,175 :: 		}
L_drawPointCS211:
;ADC.c,176 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPointCS2_mask_L0+0
	LCALL _writeData+0
;ADC.c,177 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,178 :: 		}
	RET
; end of _drawPointCS2

_resetPoint:
;ADC.c,180 :: 		void resetPoint(int x, int y) {
;ADC.c,181 :: 		int count = 0;
;ADC.c,182 :: 		int limit = 0;
;ADC.c,183 :: 		int mask = 0b00000000;
	MOV resetPoint_mask_L0+0, #0
	MOV resetPoint_mask_L0+1, #0
;ADC.c,184 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_resetPoint_x+1
	MOV resetPoint__cs_L0+0, FARG_resetPoint_x+0
	INC R0
	SJMP L__resetPoint72
L__resetPoint73:
	MOV C, #231
	RRC A
	XCH A, resetPoint__cs_L0+0
	RRC A
	XCH A, resetPoint__cs_L0+0
L__resetPoint72:
	DJNZ R0, L__resetPoint73
	MOV resetPoint__cs_L0+1, A
;ADC.c,185 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_resetPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_resetPoint_y+0
	INC R0
	SJMP L__resetPoint74
L__resetPoint75:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__resetPoint74:
	DJNZ R0, L__resetPoint75
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,187 :: 		if (_cs == 0 ) {
	MOV A, resetPoint__cs_L0+0
	ORL A, resetPoint__cs_L0+1
	JNZ L_resetPoint12
;ADC.c,188 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,189 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,190 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_resetPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_resetPoint_x+1
	LCALL _setYAddress+0
;ADC.c,191 :: 		} else {
	SJMP L_resetPoint13
L_resetPoint12:
;ADC.c,192 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,193 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,194 :: 		setYAddress(x % 64);
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
;ADC.c,195 :: 		}
L_resetPoint13:
;ADC.c,196 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,204 :: 		writeData(mask);
	MOV FARG_writeData__data+0, resetPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,205 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,206 :: 		}
	RET
; end of _resetPoint

_initSPI:
;ADC.c,229 :: 		void initSPI() {
;ADC.c,230 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,232 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,239 :: 		void rs232init() {
;ADC.c,240 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,241 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,242 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,243 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,244 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,245 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,246 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,247 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,254 :: 		void transmit(char b) {
;ADC.c,255 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,256 :: 		while(TI_bit == 0) {}
L_transmit14:
	JB TI_bit+0, L_transmit15
	NOP
	SJMP L_transmit14
L_transmit15:
;ADC.c,257 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,259 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,261 :: 		void transmitString(char* str) {
;ADC.c,262 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,264 :: 		while (*p) {
L_transmitString16:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString17
;ADC.c,265 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,266 :: 		}
	SJMP L_transmitString16
L_transmitString17:
;ADC.c,267 :: 		}
	RET
; end of _transmitString

_transmitStringln:
;ADC.c,269 :: 		void transmitStringln(char* str) {
;ADC.c,270 :: 		char *p = &str[0];
	MOV transmitStringln_p_L0+0, FARG_transmitStringln_str+0
;ADC.c,272 :: 		while (*p) {
L_transmitStringln18:
	MOV R0, transmitStringln_p_L0+0
	MOV A, @R0
	JZ L_transmitStringln19
;ADC.c,273 :: 		transmit(*(p++));
	MOV R0, transmitStringln_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitStringln_p_L0+0
;ADC.c,274 :: 		}
	SJMP L_transmitStringln18
L_transmitStringln19:
;ADC.c,277 :: 		transmit('\r');
	MOV FARG_transmit_b+0, #13
	LCALL _transmit+0
;ADC.c,278 :: 		transmit('\n');
	MOV FARG_transmit_b+0, #10
	LCALL _transmit+0
;ADC.c,279 :: 		}
	RET
; end of _transmitStringln

_writeSPI:
;ADC.c,284 :: 		void writeSPI(int _data) {
;ADC.c,285 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,286 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,291 :: 		int readSPI() {
;ADC.c,293 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,294 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,295 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,300 :: 		void delay() {
;ADC.c,301 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,302 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,308 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,310 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,311 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data20
;ADC.c,312 :: 		SPI_init_data += 0b00000000;
;ADC.c,313 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data21
L_adc_get_data20:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data76
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data76:
	JNZ L_adc_get_data22
;ADC.c,314 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,315 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data23
L_adc_get_data22:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data77
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data77:
	JNZ L_adc_get_data24
;ADC.c,316 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,317 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data25
L_adc_get_data24:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data78
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data78:
	JNZ L_adc_get_data26
;ADC.c,318 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,319 :: 		}
L_adc_get_data26:
L_adc_get_data25:
L_adc_get_data23:
L_adc_get_data21:
;ADC.c,320 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,321 :: 		CS = 0; //Включение АЦП
	CLR P2_0_bit+0
;ADC.c,326 :: 		writeSPI(SPI_init_data);       //Отправка данных для установки режима АЦП
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,327 :: 		while(SPIF_bit != 1) {}     //Ждем конца отправки
L_adc_get_data27:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data28
	NOP
	SJMP L_adc_get_data27
L_adc_get_data28:
;ADC.c,328 :: 		_data.first = readSPI(); //Читаем результат
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,331 :: 		writeSPI(0b00000000); //Отправка данных
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,332 :: 		while(SPIF_bit != 1) {} //Ждем конца отправки
L_adc_get_data29:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data30
	NOP
	SJMP L_adc_get_data29
L_adc_get_data30:
;ADC.c,333 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,336 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,337 :: 		while(SPIF_bit != 1) {}
L_adc_get_data31:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data32
	NOP
	SJMP L_adc_get_data31
L_adc_get_data32:
;ADC.c,338 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,341 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,343 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data33:
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
	JNZ L_adc_get_data33
	MOV ?lstr_1_ADC+0, adc_get_data__data_L0+0
	MOV ?lstr_1_ADC+1, adc_get_data__data_L0+1
;ADC.c,344 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,349 :: 		int getBit(int position, int byte) {
;ADC.c,350 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit79
L__getBit80:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit79:
	DJNZ R2, L__getBit80
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,351 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,353 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,354 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,355 :: 		int i = 0;
;ADC.c,357 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,359 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue34:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue35
;ADC.c,360 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue81
L__parseADCValue82:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue81:
	DJNZ R0, L__parseADCValue82
	MOV parseADCValue_result_L0+0, A
;ADC.c,361 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,359 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,362 :: 		}
	SJMP L_parseADCValue34
L_parseADCValue35:
;ADC.c,364 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue37:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue38
;ADC.c,365 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue83
L__parseADCValue84:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue83:
	DJNZ R0, L__parseADCValue84
	MOV parseADCValue_result_L0+0, A
;ADC.c,366 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,364 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,367 :: 		}
	SJMP L_parseADCValue37
L_parseADCValue38:
;ADC.c,369 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,370 :: 		}
	RET
; end of _parseADCValue

_getInputValue:
;ADC.c,375 :: 		float getInputValue(int _data) {
;ADC.c,376 :: 		return 4.096 * _data / 4096;
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
;ADC.c,377 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,387 :: 		float getGain(int _data) {
;ADC.c,388 :: 		return 2. * (_data / 1000.);
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
;ADC.c,389 :: 		}
	RET
; end of _getGain

_getMainSignalValue:
;ADC.c,391 :: 		float getMainSignalValue(float gain, float ) {
;ADC.c,393 :: 		}
	RET
; end of _getMainSignalValue

_strConstCpy:
;ADC.c,407 :: 		void strConstCpy(char *dest, const char *source) {
;ADC.c,408 :: 		while(*source)
L_strConstCpy40:
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	JZ L_strConstCpy41
;ADC.c,409 :: 		*dest++ = *source++ ;
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
	SJMP L_strConstCpy40
L_strConstCpy41:
;ADC.c,411 :: 		*dest = 0 ;
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, #0
;ADC.c,412 :: 		}
	RET
; end of _strConstCpy

_debugADC:
;ADC.c,424 :: 		void debugADC() {
;ADC.c,437 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__debugADC+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__debugADC+0
L_debugADC42:
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
	JNZ L_debugADC42
	MOV R0, _adc_data+0
	MOV @R0, FLOC__debugADC+0
	INC R0
	MOV @R0, FLOC__debugADC+1
;ADC.c,441 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV debugADC_adc_result_L0+0, 0
	MOV debugADC_adc_result_L0+1, 1
;ADC.c,443 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV debugADC_inputValue_L0+0, 0
	MOV debugADC_inputValue_L0+1, 1
	MOV debugADC_inputValue_L0+2, 2
	MOV debugADC_inputValue_L0+3, 3
;ADC.c,448 :: 		strConstCpy(textBuffer, ch0);         //"channel 0"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch0+0
	MOV FARG_strConstCpy_source+1, _ch0+1
	LCALL _strConstCpy+0
;ADC.c,449 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,454 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,455 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,460 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,461 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,463 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, debugADC_adc_result_L0+0
	MOV FARG_IntToStr_input+1, debugADC_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #debugADC_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,464 :: 		transmitString(textBuffer);             //Передача в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,469 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,470 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,475 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,476 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,478 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,479 :: 		transmitStringln(textBuffer);
	MOV FARG_transmitStringln_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,481 :: 		Delay_ms(1000);                         //Задержка в 1 секунду
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,486 :: 		*adc_data = adc_get_data(1);
	MOV FARG_adc_get_data_channel+0, #1
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__debugADC+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__debugADC+0
L_debugADC43:
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
	JNZ L_debugADC43
	MOV R0, _adc_data+0
	MOV @R0, FLOC__debugADC+0
	INC R0
	MOV @R0, FLOC__debugADC+1
;ADC.c,490 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV debugADC_adc_result_L0+0, 0
	MOV debugADC_adc_result_L0+1, 1
;ADC.c,495 :: 		inputValue = getInputValue(adc_result); //Пересчет входного значения на основе выходного
	MOV FARG_getInputValue__data+0, 0
	MOV FARG_getInputValue__data+1, 1
	LCALL _getInputValue+0
	MOV debugADC_inputValue_L0+0, 0
	MOV debugADC_inputValue_L0+1, 1
	MOV debugADC_inputValue_L0+2, 2
	MOV debugADC_inputValue_L0+3, 3
;ADC.c,496 :: 		k = getGain(adc_result);                //Расчет коэффициента усиления
	MOV FARG_getGain__data+0, debugADC_adc_result_L0+0
	MOV FARG_getGain__data+1, debugADC_adc_result_L0+1
	LCALL _getGain+0
	MOV debugADC_k_L0+0, 0
	MOV debugADC_k_L0+1, 1
	MOV debugADC_k_L0+2, 2
	MOV debugADC_k_L0+3, 3
;ADC.c,505 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,506 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,510 :: 		strConstCpy(textBuffer, ch1);           //"channel 1"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _ch1+0
	MOV FARG_strConstCpy_source+1, _ch1+1
	LCALL _strConstCpy+0
;ADC.c,511 :: 		transmitStringln(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitStringln_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitStringln+0
;ADC.c,513 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,514 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,516 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, debugADC_adc_result_L0+0
	MOV FARG_IntToStr_input+1, debugADC_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #debugADC_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,517 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,522 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,523 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,528 :: 		strConstCpy(textBuffer, INPUT_STR);     //"ADC input: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _INPUT_STR+0
	MOV FARG_strConstCpy_source+1, _INPUT_STR+1
	LCALL _strConstCpy+0
;ADC.c,529 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,531 :: 		FloatToStr(inputValue, textBuffer);     //Расчитанное входное значение к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_inputValue_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_inputValue_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_inputValue_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_inputValue_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,532 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,537 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,538 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,543 :: 		strConstCpy(textBuffer, GAIN_STR);     //"Gain: "
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _GAIN_STR+0
	MOV FARG_strConstCpy_source+1, _GAIN_STR+1
	LCALL _strConstCpy+0
;ADC.c,544 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,546 :: 		FloatToStr(k, textBuffer);             //Расчитанный коэффициент усиления к строковому представлению
	MOV FARG_FloatToStr_fnum+0, debugADC_k_L0+0
	MOV FARG_FloatToStr_fnum+1, debugADC_k_L0+1
	MOV FARG_FloatToStr_fnum+2, debugADC_k_L0+2
	MOV FARG_FloatToStr_fnum+3, debugADC_k_L0+3
	MOV FARG_FloatToStr_str+0, #debugADC_textBuffer_L0+0
	LCALL _FloatToStr+0
;ADC.c,547 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,552 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #debugADC_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,553 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,554 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #debugADC_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,559 :: 		Delay_ms(1000);                       //Задержка 1 сек.
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,560 :: 		}
	RET
; end of _debugADC

_FillBrightness:
;ADC.c,562 :: 		void FillBrightness(int brightness) {
;ADC.c,564 :: 		for(x = 0; x <=128; x++) {
	MOV FillBrightness_x_L0+0, #0
	MOV FillBrightness_x_L0+1, #0
L_FillBrightness44:
	SETB C
	MOV A, FillBrightness_x_L0+0
	SUBB A, #128
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FillBrightness_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_FillBrightness45
;ADC.c,565 :: 		for(y = 0; y <=64; y++) {
	MOV FillBrightness_y_L0+0, #0
	MOV FillBrightness_y_L0+1, #0
L_FillBrightness47:
	SETB C
	MOV A, FillBrightness_y_L0+0
	SUBB A, #64
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FillBrightness_y_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_FillBrightness48
;ADC.c,566 :: 		resetPoint(x,y);
	MOV FARG_resetPoint_x+0, FillBrightness_x_L0+0
	MOV FARG_resetPoint_x+1, FillBrightness_x_L0+1
	MOV FARG_resetPoint_y+0, FillBrightness_y_L0+0
	MOV FARG_resetPoint_y+1, FillBrightness_y_L0+1
	LCALL _resetPoint+0
;ADC.c,565 :: 		for(y = 0; y <=64; y++) {
	MOV A, #1
	ADD A, FillBrightness_y_L0+0
	MOV FillBrightness_y_L0+0, A
	MOV A, #0
	ADDC A, FillBrightness_y_L0+1
	MOV FillBrightness_y_L0+1, A
;ADC.c,567 :: 		}
	SJMP L_FillBrightness47
L_FillBrightness48:
;ADC.c,564 :: 		for(x = 0; x <=128; x++) {
	MOV A, #1
	ADD A, FillBrightness_x_L0+0
	MOV FillBrightness_x_L0+0, A
	MOV A, #0
	ADDC A, FillBrightness_x_L0+1
	MOV FillBrightness_x_L0+1, A
;ADC.c,568 :: 		}
	SJMP L_FillBrightness44
L_FillBrightness45:
;ADC.c,581 :: 		}
	RET
; end of _FillBrightness

_clear:
;ADC.c,583 :: 		void clear() {
;ADC.c,584 :: 		FillBrightness(0);
	MOV FARG_FillBrightness_brightness+0, #0
	MOV FARG_FillBrightness_brightness+1, #0
	LCALL _FillBrightness+0
;ADC.c,585 :: 		}
	RET
; end of _clear

_fill:
;ADC.c,587 :: 		void fill() {
;ADC.c,588 :: 		FillBrightness(255);
	MOV FARG_FillBrightness_brightness+0, #255
	MOV FARG_FillBrightness_brightness+1, #0
	LCALL _FillBrightness+0
;ADC.c,589 :: 		}
	RET
; end of _fill

_main:
	MOV SP+0, #128
;ADC.c,591 :: 		void main() {
;ADC.c,594 :: 		int flag = 0;
;ADC.c,596 :: 		initSPI(); //Инициализация SPI
	LCALL _initSPI+0
;ADC.c,597 :: 		rs232init(); // Инициализация RS232
	LCALL _rs232init+0
;ADC.c,599 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,600 :: 		Delay_us(1);
	NOP
;ADC.c,602 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,604 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,605 :: 		clear();
	LCALL _clear+0
;ADC.c,606 :: 		while(1) {
L_main50:
;ADC.c,611 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
	MOV FARG_adc_get_data_channel+1, #0
	MOV R3, #FLOC__main+0
	LCALL _adc_get_data+0
	MOV R3, #3
	MOV R0, _adc_data+0
	MOV R1, #FLOC__main+0
L_main52:
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
	JNZ L_main52
	MOV R0, _adc_data+0
	MOV @R0, FLOC__main+0
	INC R0
	MOV @R0, FLOC__main+1
;ADC.c,615 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
	MOV main_adc_result_L0+0, 0
	MOV main_adc_result_L0+1, 1
;ADC.c,617 :: 		strConstCpy(textBuffer, RESULT_STR);    //"ADC result: "
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _RESULT_STR+0
	MOV FARG_strConstCpy_source+1, _RESULT_STR+1
	LCALL _strConstCpy+0
;ADC.c,618 :: 		transmitString(textBuffer);
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,620 :: 		IntToStr(adc_result, textBuffer);       //Результат АЦП к строковому представлению
	MOV FARG_IntToStr_input+0, main_adc_result_L0+0
	MOV FARG_IntToStr_input+1, main_adc_result_L0+1
	MOV FARG_IntToStr_output+0, #main_textBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,621 :: 		transmitString(textBuffer);             //Передача в RS232
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,626 :: 		strConstCpy(textBuffer, CRLF);        //"\r\n"
	MOV FARG_strConstCpy_dest+0, #main_textBuffer_L0+0
	MOV FARG_strConstCpy_source+0, _CRLF+0
	MOV FARG_strConstCpy_source+1, _CRLF+1
	LCALL _strConstCpy+0
;ADC.c,627 :: 		transmitString(textBuffer);           //Отправка строки в RS232
	MOV FARG_transmitString_str+0, #main_textBuffer_L0+0
	LCALL _transmitString+0
;ADC.c,632 :: 		y = 64 - adc_result / LCD_Y_LIMIT;
	MOV R2, #6
	MOV A, main_adc_result_L0+1
	MOV R0, main_adc_result_L0+0
	INC R2
	SJMP L__main85
L__main86:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__main85:
	DJNZ R2, L__main86
	MOV R1, A
	CLR C
	MOV A, #64
	SUBB A, R0
	MOV FARG_drawPoint_y+0, A
	MOV A, #0
	SUBB A, R1
	MOV FARG_drawPoint_y+1, A
;ADC.c,633 :: 		drawPoint(x, y);
	MOV FARG_drawPoint_x+0, main_x_L0+0
	MOV FARG_drawPoint_x+1, main_x_L0+1
	LCALL _drawPoint+0
;ADC.c,634 :: 		x = x + 1;
	MOV A, #1
	ADD A, main_x_L0+0
	MOV main_x_L0+0, A
	MOV A, #0
	ADDC A, main_x_L0+1
	MOV main_x_L0+1, A
;ADC.c,635 :: 		if (x == 128) {
	MOV A, #128
	XRL A, main_x_L0+0
	JNZ L__main87
	MOV A, #0
	XRL A, main_x_L0+1
L__main87:
	JNZ L_main53
;ADC.c,637 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,638 :: 		clear();
	LCALL _clear+0
;ADC.c,639 :: 		}
L_main53:
;ADC.c,646 :: 		}
	LJMP L_main50
;ADC.c,647 :: 		}
	SJMP #254
; end of _main
