
_setXAddress:
;ADC.c,37 :: 		void setXAddress(int x) {
;ADC.c,38 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,39 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,40 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,42 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,44 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,45 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,46 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,48 :: 		void setYAddress(int y) {
;ADC.c,49 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,50 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,51 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,53 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,55 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,56 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,57 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,59 :: 		void setZAddress(int z) {
;ADC.c,60 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,61 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,62 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,64 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,66 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,67 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,68 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,70 :: 		void writeData(char _data) {
;ADC.c,71 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,72 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,73 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,75 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,76 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,77 :: 		}
	RET
; end of _writeData

_displayOn:
;ADC.c,79 :: 		void displayOn() {
;ADC.c,80 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,81 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,82 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,84 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,86 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,87 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,88 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,90 :: 		void drawPoint(int x, int y, int flag) {
;ADC.c,91 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,92 :: 		int limit = 0;
;ADC.c,93 :: 		int mask = 0b00000001;
;ADC.c,94 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint66
L__drawPoint67:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint66:
	DJNZ R0, L__drawPoint67
	MOV drawPoint__cs_L0+1, A
;ADC.c,95 :: 		if (flag == 1) {
	MOV A, #1
	XRL A, FARG_drawPoint_flag+0
	JNZ L__drawPoint68
	MOV A, #0
	XRL A, FARG_drawPoint_flag+1
L__drawPoint68:
	JNZ L_drawPoint0
;ADC.c,96 :: 		mask = 0b00000000;
	MOV drawPoint_mask_L0+0, #0
	MOV drawPoint_mask_L0+1, #0
;ADC.c,97 :: 		}
L_drawPoint0:
;ADC.c,98 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint69
L__drawPoint70:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint69:
	DJNZ R0, L__drawPoint70
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,100 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
	JNZ L_drawPoint1
;ADC.c,101 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,102 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,103 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,104 :: 		} else {
	SJMP L_drawPoint2
L_drawPoint1:
;ADC.c,105 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,106 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,107 :: 		setYAddress(x % 64);
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
;ADC.c,108 :: 		}
L_drawPoint2:
;ADC.c,109 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,110 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,111 :: 		for (count = 0; count < limit - 1; count++) {
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
L_drawPoint3:
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
	JNC L_drawPoint4
;ADC.c,112 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint71
L__drawPoint72:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint71:
	DJNZ R0, L__drawPoint72
	MOV drawPoint_mask_L0+0, A
;ADC.c,111 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,113 :: 		}
	SJMP L_drawPoint3
L_drawPoint4:
;ADC.c,114 :: 		if(y > 0) {
	SETB C
	MOV A, FARG_drawPoint_y+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_drawPoint_y+1
	XRL A, #128
	SUBB A, R0
	JC L_drawPoint6
;ADC.c,115 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint73
L__drawPoint74:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint73:
	DJNZ R0, L__drawPoint74
	MOV drawPoint_mask_L0+0, A
;ADC.c,116 :: 		}
L_drawPoint6:
;ADC.c,117 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,119 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,120 :: 		}
	RET
; end of _drawPoint

_drawMask:
;ADC.c,122 :: 		void drawMask(int x, int y, int mask) {
;ADC.c,123 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawMask_x+1
	MOV drawMask__cs_L0+0, FARG_drawMask_x+0
	INC R0
	SJMP L__drawMask75
L__drawMask76:
	MOV C, #231
	RRC A
	XCH A, drawMask__cs_L0+0
	RRC A
	XCH A, drawMask__cs_L0+0
L__drawMask75:
	DJNZ R0, L__drawMask76
	MOV drawMask__cs_L0+1, A
;ADC.c,124 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawMask_y+1
	MOV FARG_setXAddress_x+0, FARG_drawMask_y+0
	INC R0
	SJMP L__drawMask77
L__drawMask78:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawMask77:
	DJNZ R0, L__drawMask78
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,126 :: 		if (_cs == 0 ) {
	MOV A, drawMask__cs_L0+0
	ORL A, drawMask__cs_L0+1
	JNZ L_drawMask7
;ADC.c,127 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,128 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,129 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawMask_x+0
	MOV FARG_setYAddress_y+1, FARG_drawMask_x+1
	LCALL _setYAddress+0
;ADC.c,130 :: 		} else {
	SJMP L_drawMask8
L_drawMask7:
;ADC.c,131 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,132 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,133 :: 		setYAddress(x % 64);
	MOV R4, #64
	MOV R5, #0
	MOV R0, FARG_drawMask_x+0
	MOV R1, FARG_drawMask_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
	LCALL _setYAddress+0
;ADC.c,134 :: 		}
L_drawMask8:
;ADC.c,135 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,136 :: 		writeData(mask);
	MOV FARG_writeData__data+0, FARG_drawMask_mask+0
	LCALL _writeData+0
;ADC.c,137 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,138 :: 		}
	RET
; end of _drawMask

_drawVLine:
;ADC.c,140 :: 		void drawVLine(int column) {
;ADC.c,141 :: 		int count = 0;
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
	MOV drawVLine_mask_L0+0, #255
	MOV drawVLine_mask_L0+1, #0
;ADC.c,142 :: 		int mask = 0b11111111;
;ADC.c,143 :: 		int _cs = column / 64;
	MOV R0, #6
	MOV A, FARG_drawVLine_column+1
	MOV drawVLine__cs_L0+0, FARG_drawVLine_column+0
	INC R0
	SJMP L__drawVLine79
L__drawVLine80:
	MOV C, #231
	RRC A
	XCH A, drawVLine__cs_L0+0
	RRC A
	XCH A, drawVLine__cs_L0+0
L__drawVLine79:
	DJNZ R0, L__drawVLine80
	MOV drawVLine__cs_L0+1, A
;ADC.c,145 :: 		for(count = 0; count < 8; count++) {
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
L_drawVLine9:
	CLR C
	MOV A, drawVLine_count_L0+0
	SUBB A, #8
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawVLine_count_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawVLine10
;ADC.c,146 :: 		if (_cs == 0 ) {
	MOV A, drawVLine__cs_L0+0
	ORL A, drawVLine__cs_L0+1
	JNZ L_drawVLine12
;ADC.c,147 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,148 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,149 :: 		setYAddress(column);
	MOV FARG_setYAddress_y+0, FARG_drawVLine_column+0
	MOV FARG_setYAddress_y+1, FARG_drawVLine_column+1
	LCALL _setYAddress+0
;ADC.c,150 :: 		} else {
	SJMP L_drawVLine13
L_drawVLine12:
;ADC.c,151 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,152 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,153 :: 		setYAddress(column % 64);
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
;ADC.c,154 :: 		}
L_drawVLine13:
;ADC.c,155 :: 		setXAddress(count);
	MOV FARG_setXAddress_x+0, drawVLine_count_L0+0
	MOV FARG_setXAddress_x+1, drawVLine_count_L0+1
	LCALL _setXAddress+0
;ADC.c,156 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,157 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawVLine_mask_L0+0
	LCALL _writeData+0
;ADC.c,145 :: 		for(count = 0; count < 8; count++) {
	MOV A, #1
	ADD A, drawVLine_count_L0+0
	MOV drawVLine_count_L0+0, A
	MOV A, #0
	ADDC A, drawVLine_count_L0+1
	MOV drawVLine_count_L0+1, A
;ADC.c,158 :: 		}
	SJMP L_drawVLine9
L_drawVLine10:
;ADC.c,160 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,161 :: 		}
	RET
; end of _drawVLine

_clear:
;ADC.c,163 :: 		int clear(int limit_left, int limit_right) {
;ADC.c,165 :: 		if (limit_left >= limit_right) return -1;
	CLR C
	MOV A, FARG_clear_limit_left+0
	SUBB A, FARG_clear_limit_right+0
	MOV A, FARG_clear_limit_right+1
	XRL A, #128
	MOV R0, A
	MOV A, FARG_clear_limit_left+1
	XRL A, #128
	SUBB A, R0
	JC L_clear14
	MOV R0, #255
	MOV R1, #255
	RET
L_clear14:
;ADC.c,167 :: 		for(x = limit_left; x < limit_right; x++) {
	MOV clear_x_L0+0, FARG_clear_limit_left+0
	MOV clear_x_L0+1, FARG_clear_limit_left+1
L_clear15:
	CLR C
	MOV A, clear_x_L0+0
	SUBB A, FARG_clear_limit_right+0
	MOV A, FARG_clear_limit_right+1
	XRL A, #128
	MOV R0, A
	MOV A, clear_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clear16
;ADC.c,168 :: 		for(y = 0; y <=64; y=y+8) {
	MOV clear_y_L0+0, #0
	MOV clear_y_L0+1, #0
L_clear18:
	SETB C
	MOV A, clear_y_L0+0
	SUBB A, #64
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, clear_y_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clear19
;ADC.c,170 :: 		drawMask(x,y, 0b00000000);
	MOV FARG_drawMask_x+0, clear_x_L0+0
	MOV FARG_drawMask_x+1, clear_x_L0+1
	MOV FARG_drawMask_y+0, clear_y_L0+0
	MOV FARG_drawMask_y+1, clear_y_L0+1
	MOV FARG_drawMask_mask+0, #0
	MOV FARG_drawMask_mask+1, #0
	LCALL _drawMask+0
;ADC.c,168 :: 		for(y = 0; y <=64; y=y+8) {
	MOV A, #8
	ADD A, clear_y_L0+0
	MOV clear_y_L0+0, A
	MOV A, #0
	ADDC A, clear_y_L0+1
	MOV clear_y_L0+1, A
;ADC.c,171 :: 		}
	SJMP L_clear18
L_clear19:
;ADC.c,167 :: 		for(x = limit_left; x < limit_right; x++) {
	MOV A, #1
	ADD A, clear_x_L0+0
	MOV clear_x_L0+0, A
	MOV A, #0
	ADDC A, clear_x_L0+1
	MOV clear_x_L0+1, A
;ADC.c,172 :: 		}
	SJMP L_clear15
L_clear16:
;ADC.c,173 :: 		return 0;
	MOV R0, #0
	MOV R1, #0
;ADC.c,174 :: 		}
	RET
; end of _clear

_initSPI:
;ADC.c,178 :: 		void initSPI() {
;ADC.c,179 :: 		SPCR = 0b01010011;
	MOV SPCR+0, #83
;ADC.c,180 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,182 :: 		void rs232init() {
;ADC.c,183 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,184 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,185 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,186 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,187 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,188 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,189 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,190 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,192 :: 		void transmit(char b) {
;ADC.c,193 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,194 :: 		while(TI_bit == 0) {}
L_transmit21:
	JB TI_bit+0, L_transmit22
	NOP
	SJMP L_transmit21
L_transmit22:
;ADC.c,195 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,197 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,199 :: 		void transmitString(char* str) {
;ADC.c,200 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,202 :: 		while (*p) {
L_transmitString23:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString24
;ADC.c,203 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,204 :: 		}
	SJMP L_transmitString23
L_transmitString24:
;ADC.c,205 :: 		}
	RET
; end of _transmitString

_writeSPI:
;ADC.c,207 :: 		void writeSPI(int _data) {
;ADC.c,208 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,209 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,212 :: 		int readSPI() {
;ADC.c,214 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,215 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,216 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,218 :: 		void delay() {
;ADC.c,219 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,220 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,222 :: 		short adc_get_data() {
;ADC.c,224 :: 		CS = 0;
	CLR P2_0_bit+0
;ADC.c,226 :: 		SPDR = 0b11000000;
	MOV SPDR+0, #192
;ADC.c,227 :: 		while(SPIF_bit != 1) {}
L_adc_get_data25:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data26
	NOP
	SJMP L_adc_get_data25
L_adc_get_data26:
;ADC.c,228 :: 		first = SPDR;
	MOV _first+0, R6+0
;ADC.c,230 :: 		SPDR = 0b00000000;
	MOV SPDR+0, #0
;ADC.c,231 :: 		while(SPIF_bit != 1) {}
L_adc_get_data27:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data28
	NOP
	SJMP L_adc_get_data27
L_adc_get_data28:
;ADC.c,232 :: 		second = SPDR;
	MOV _second+0, R6+0
;ADC.c,234 :: 		SPDR = 0b00000000;
	MOV SPDR+0, #0
;ADC.c,235 :: 		while(SPIF_bit != 1) {}
L_adc_get_data29:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data30
	NOP
	SJMP L_adc_get_data29
L_adc_get_data30:
;ADC.c,236 :: 		third = SPDR;
	MOV _third+0, R6+0
;ADC.c,238 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,240 :: 		first  = first & 0b00000001;
	ANL _first+0, #1
;ADC.c,242 :: 		third  = third & 0b11100000;
	ANL _third+0, #224
;ADC.c,244 :: 		MOV R0, _first+0
	MOV R0, _first+0
;ADC.c,245 :: 		MOV R1, _second+0
	MOV R1, _second+0
;ADC.c,246 :: 		MOV R2, _third+0
	MOV R2, _third+0
;ADC.c,247 :: 		MOV R3, #5
	MOV R3, 5
;ADC.c,250 :: 		MOV A, R0 ; R0 -> A
	MOV A, R0
;ADC.c,251 :: 		RRC A     ; Сдвиг A вправо
	RRC A
;ADC.c,252 :: 		MOV R0, A
	MOV R0, A
;ADC.c,253 :: 		SHIFT: ;Сдвиг
SHIFT:
;ADC.c,254 :: 		MOV A, R1 ;
	MOV A, R1
;ADC.c,255 :: 		RRC A     ;
	RRC A
;ADC.c,256 :: 		MOV R1, A
	MOV R1, A
;ADC.c,257 :: 		MOV A, R2 ;
	MOV A, R2
;ADC.c,258 :: 		RRC A      ;
	RRC A
;ADC.c,259 :: 		MOV R2, A  ;
	MOV R2, A
;ADC.c,260 :: 		MOV A, R3
	MOV A, R3
;ADC.c,261 :: 		DEC A
	DEC A
;ADC.c,262 :: 		MOV R3, A
	MOV R3, A
;ADC.c,263 :: 		JNZ SHIFT
	JNZ SHIFT
;ADC.c,265 :: 		MOV _first, R0
	MOV _first+0, R0
;ADC.c,266 :: 		MOV _second, R1
	MOV _second+0, R1
;ADC.c,267 :: 		MOV _third, R2
	MOV _third+0, R2
;ADC.c,269 :: 		return LCD_Y_LIMIT - ((second * 256 + third) / LCD_Y_LIMIT);//Деленное на LCD limit = 64 ==>> 256/64 = 4
	MOV R3, _second+0
	MOV R2, #0
	MOV R4, #0
	MOV R0, _third+0
	MOV A, _third+0
	RLC A
	CLR A
	SUBB A, 224
	MOV R1, A
	MOV A, R0
	ADD A, R2
	MOV R4, A
	MOV A, R1
	ADDC A, R3
	MOV R5, A
	MOV R2, #6
	MOV A, R5
	MOV R0, 4
	INC R2
	SJMP L__adc_get_data81
L__adc_get_data82:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__adc_get_data81:
	DJNZ R2, L__adc_get_data82
	MOV R1, A
	CLR C
	MOV A, #64
	SUBB A, R0
	MOV R0, A
;ADC.c,271 :: 		}
	RET
; end of _adc_get_data

_Abs:
;ADC.c,273 :: 		int Abs(int num) {
;ADC.c,274 :: 		if(num < 0)
	CLR C
	MOV A, FARG_Abs_num+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_Abs_num+1
	XRL A, #128
	SUBB A, R0
	JNC L_Abs32
;ADC.c,275 :: 		return -num;
	CLR C
	MOV A, #0
	SUBB A, FARG_Abs_num+0
	MOV R0, A
	MOV A, #0
	SUBB A, FARG_Abs_num+1
	MOV R1, A
	RET
L_Abs32:
;ADC.c,277 :: 		return num;
	MOV R0, FARG_Abs_num+0
	MOV R1, FARG_Abs_num+1
;ADC.c,278 :: 		}
	RET
; end of _Abs

_Brezenhem:
;ADC.c,280 :: 		void Brezenhem(int x0, int y0, int x1, int y1)
;ADC.c,284 :: 		int f = 0;
	MOV Brezenhem_f_L0+0, #0
	MOV Brezenhem_f_L0+1, #0
;ADC.c,285 :: 		A = y1 - y0;
	CLR C
	MOV A, FARG_Brezenhem_y1+0
	SUBB A, FARG_Brezenhem_y0+0
	MOV R0, A
	MOV A, FARG_Brezenhem_y1+1
	SUBB A, FARG_Brezenhem_y0+1
	MOV R1, A
	MOV Brezenhem_A_L0+0, 0
	MOV Brezenhem_A_L0+1, 1
;ADC.c,286 :: 		B = x0 - x1;
	CLR C
	MOV A, FARG_Brezenhem_x0+0
	SUBB A, FARG_Brezenhem_x1+0
	MOV Brezenhem_B_L0+0, A
	MOV A, FARG_Brezenhem_x0+1
	SUBB A, FARG_Brezenhem_x1+1
	MOV Brezenhem_B_L0+1, A
;ADC.c,287 :: 		if (abs(A) > abs(B))
	MOV FARG_Abs_num+0, 0
	MOV FARG_Abs_num+1, 1
	LCALL _Abs+0
	MOV FLOC__Brezenhem+0, 0
	MOV FLOC__Brezenhem+1, 1
	MOV FARG_Abs_num+0, Brezenhem_B_L0+0
	MOV FARG_Abs_num+1, Brezenhem_B_L0+1
	LCALL _Abs+0
	SETB C
	MOV A, FLOC__Brezenhem+0
	SUBB A, R0
	MOV A, R1
	XRL A, #128
	MOV R2, A
	MOV A, FLOC__Brezenhem+1
	XRL A, #128
	SUBB A, R2
	JC L_Brezenhem34
;ADC.c,288 :: 		sign = 1;
	MOV Brezenhem_sign_L0+0, #1
	MOV Brezenhem_sign_L0+1, #0
	SJMP L_Brezenhem35
L_Brezenhem34:
;ADC.c,290 :: 		sign = -1;
	MOV Brezenhem_sign_L0+0, #255
	MOV Brezenhem_sign_L0+1, #255
L_Brezenhem35:
;ADC.c,291 :: 		if (A < 0)
	CLR C
	MOV A, Brezenhem_A_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, Brezenhem_A_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Brezenhem36
;ADC.c,292 :: 		signa = -1;
	MOV Brezenhem_signa_L0+0, #255
	MOV Brezenhem_signa_L0+1, #255
	SJMP L_Brezenhem37
L_Brezenhem36:
;ADC.c,294 :: 		signa = 1;
	MOV Brezenhem_signa_L0+0, #1
	MOV Brezenhem_signa_L0+1, #0
L_Brezenhem37:
;ADC.c,295 :: 		if (B < 0)
	CLR C
	MOV A, Brezenhem_B_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, Brezenhem_B_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Brezenhem38
;ADC.c,296 :: 		signb = -1;
	MOV Brezenhem_signb_L0+0, #255
	MOV Brezenhem_signb_L0+1, #255
	SJMP L_Brezenhem39
L_Brezenhem38:
;ADC.c,298 :: 		signb = 1;
	MOV Brezenhem_signb_L0+0, #1
	MOV Brezenhem_signb_L0+1, #0
L_Brezenhem39:
;ADC.c,299 :: 		drawPoint(x0,y0, 0);
	MOV FARG_drawPoint_x+0, FARG_Brezenhem_x0+0
	MOV FARG_drawPoint_x+1, FARG_Brezenhem_x0+1
	MOV FARG_drawPoint_y+0, FARG_Brezenhem_y0+0
	MOV FARG_drawPoint_y+1, FARG_Brezenhem_y0+1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,300 :: 		x = x0;
	MOV Brezenhem_x_L0+0, FARG_Brezenhem_x0+0
	MOV Brezenhem_x_L0+1, FARG_Brezenhem_x0+1
;ADC.c,301 :: 		y = y0;
	MOV Brezenhem_y_L0+0, FARG_Brezenhem_y0+0
	MOV Brezenhem_y_L0+1, FARG_Brezenhem_y0+1
;ADC.c,302 :: 		if (sign == -1)
	MOV A, #255
	XRL A, Brezenhem_sign_L0+0
	JNZ L__Brezenhem83
	MOV A, #255
	XRL A, Brezenhem_sign_L0+1
L__Brezenhem83:
	JZ #3
	LJMP L_Brezenhem40
;ADC.c,304 :: 		do {
L_Brezenhem41:
;ADC.c,305 :: 		f += A*signa;
	MOV R0, Brezenhem_A_L0+0
	MOV R1, Brezenhem_A_L0+1
	MOV R4, Brezenhem_signa_L0+0
	MOV R5, Brezenhem_signa_L0+1
	LCALL _Mul_16x16+0
	MOV A, Brezenhem_f_L0+0
	ADD A, R0
	MOV R2, A
	MOV A, Brezenhem_f_L0+1
	ADDC A, R1
	MOV R3, A
	MOV Brezenhem_f_L0+0, 2
	MOV Brezenhem_f_L0+1, 3
;ADC.c,306 :: 		if (f > 0)
	SETB C
	MOV A, R2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, R3
	XRL A, #128
	SUBB A, R0
	JC L_Brezenhem44
;ADC.c,308 :: 		f -= B*signb;
	MOV R0, Brezenhem_B_L0+0
	MOV R1, Brezenhem_B_L0+1
	MOV R4, Brezenhem_signb_L0+0
	MOV R5, Brezenhem_signb_L0+1
	LCALL _Mul_16x16+0
	CLR C
	MOV A, Brezenhem_f_L0+0
	SUBB A, R0
	MOV Brezenhem_f_L0+0, A
	MOV A, Brezenhem_f_L0+1
	SUBB A, R1
	MOV Brezenhem_f_L0+1, A
;ADC.c,309 :: 		y += signa;
	MOV A, Brezenhem_y_L0+0
	ADD A, Brezenhem_signa_L0+0
	MOV Brezenhem_y_L0+0, A
	MOV A, Brezenhem_y_L0+1
	ADDC A, Brezenhem_signa_L0+1
	MOV Brezenhem_y_L0+1, A
;ADC.c,310 :: 		}
L_Brezenhem44:
;ADC.c,311 :: 		x -= signb;
	CLR C
	MOV A, Brezenhem_x_L0+0
	SUBB A, Brezenhem_signb_L0+0
	MOV R0, A
	MOV A, Brezenhem_x_L0+1
	SUBB A, Brezenhem_signb_L0+1
	MOV R1, A
	MOV Brezenhem_x_L0+0, 0
	MOV Brezenhem_x_L0+1, 1
;ADC.c,312 :: 		drawPoint(x, y, 0);
	MOV FARG_drawPoint_x+0, 0
	MOV FARG_drawPoint_x+1, 1
	MOV FARG_drawPoint_y+0, Brezenhem_y_L0+0
	MOV FARG_drawPoint_y+1, Brezenhem_y_L0+1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,313 :: 		} while (x != x1 || y != y1);
	MOV A, Brezenhem_x_L0+0
	XRL A, FARG_Brezenhem_x1+0
	JNZ L__Brezenhem84
	MOV A, Brezenhem_x_L0+1
	XRL A, FARG_Brezenhem_x1+1
L__Brezenhem84:
	JZ #3
	LJMP L_Brezenhem41
	MOV A, Brezenhem_y_L0+0
	XRL A, FARG_Brezenhem_y1+0
	JNZ L__Brezenhem85
	MOV A, Brezenhem_y_L0+1
	XRL A, FARG_Brezenhem_y1+1
L__Brezenhem85:
	JZ #3
	LJMP L_Brezenhem41
L__Brezenhem65:
;ADC.c,314 :: 		}
	LJMP L_Brezenhem47
L_Brezenhem40:
;ADC.c,317 :: 		do {
L_Brezenhem48:
;ADC.c,318 :: 		f += B*signb;
	MOV R0, Brezenhem_B_L0+0
	MOV R1, Brezenhem_B_L0+1
	MOV R4, Brezenhem_signb_L0+0
	MOV R5, Brezenhem_signb_L0+1
	LCALL _Mul_16x16+0
	MOV A, Brezenhem_f_L0+0
	ADD A, R0
	MOV R2, A
	MOV A, Brezenhem_f_L0+1
	ADDC A, R1
	MOV R3, A
	MOV Brezenhem_f_L0+0, 2
	MOV Brezenhem_f_L0+1, 3
;ADC.c,319 :: 		if (f > 0) {
	SETB C
	MOV A, R2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, R3
	XRL A, #128
	SUBB A, R0
	JC L_Brezenhem51
;ADC.c,320 :: 		f -= A*signa;
	MOV R0, Brezenhem_A_L0+0
	MOV R1, Brezenhem_A_L0+1
	MOV R4, Brezenhem_signa_L0+0
	MOV R5, Brezenhem_signa_L0+1
	LCALL _Mul_16x16+0
	CLR C
	MOV A, Brezenhem_f_L0+0
	SUBB A, R0
	MOV Brezenhem_f_L0+0, A
	MOV A, Brezenhem_f_L0+1
	SUBB A, R1
	MOV Brezenhem_f_L0+1, A
;ADC.c,321 :: 		x -= signb;
	CLR C
	MOV A, Brezenhem_x_L0+0
	SUBB A, Brezenhem_signb_L0+0
	MOV Brezenhem_x_L0+0, A
	MOV A, Brezenhem_x_L0+1
	SUBB A, Brezenhem_signb_L0+1
	MOV Brezenhem_x_L0+1, A
;ADC.c,322 :: 		}
L_Brezenhem51:
;ADC.c,323 :: 		y += signa;
	MOV A, Brezenhem_y_L0+0
	ADD A, Brezenhem_signa_L0+0
	MOV R0, A
	MOV A, Brezenhem_y_L0+1
	ADDC A, Brezenhem_signa_L0+1
	MOV R1, A
	MOV Brezenhem_y_L0+0, 0
	MOV Brezenhem_y_L0+1, 1
;ADC.c,324 :: 		drawPoint(x, y, 0);
	MOV FARG_drawPoint_x+0, Brezenhem_x_L0+0
	MOV FARG_drawPoint_x+1, Brezenhem_x_L0+1
	MOV FARG_drawPoint_y+0, 0
	MOV FARG_drawPoint_y+1, 1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,325 :: 		} while (x != x1 || y != y1);
	MOV A, Brezenhem_x_L0+0
	XRL A, FARG_Brezenhem_x1+0
	JNZ L__Brezenhem86
	MOV A, Brezenhem_x_L0+1
	XRL A, FARG_Brezenhem_x1+1
L__Brezenhem86:
	JZ #3
	LJMP L_Brezenhem48
	MOV A, Brezenhem_y_L0+0
	XRL A, FARG_Brezenhem_y1+0
	JNZ L__Brezenhem87
	MOV A, Brezenhem_y_L0+1
	XRL A, FARG_Brezenhem_y1+1
L__Brezenhem87:
	JZ #3
	LJMP L_Brezenhem48
L__Brezenhem64:
;ADC.c,326 :: 		}
L_Brezenhem47:
;ADC.c,327 :: 		}
	RET
; end of _Brezenhem

_main:
	MOV SP+0, #128
;ADC.c,329 :: 		void main() {
;ADC.c,333 :: 		short y = 0;
	MOV main_y_L0+0, #0
	MOV main_x_L0+0, #0
;ADC.c,334 :: 		unsigned short x = 0;
;ADC.c,339 :: 		prevx=0;
	MOV main_prevx_L0+0, #0
	MOV main_prevx_L0+1, #0
;ADC.c,340 :: 		prevy=0;
	MOV main_prevy_L0+0, #0
	MOV main_prevy_L0+1, #0
;ADC.c,342 :: 		initSPI();
	LCALL _initSPI+0
;ADC.c,344 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,345 :: 		Delay_us(1);
	NOP
;ADC.c,348 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,349 :: 		clear(0, 128);
	MOV FARG_clear_limit_left+0, #0
	MOV FARG_clear_limit_left+1, #0
	MOV FARG_clear_limit_right+0, #128
	MOV FARG_clear_limit_right+1, #0
	LCALL _clear+0
;ADC.c,351 :: 		while(1) {
L_main54:
;ADC.c,352 :: 		if(x < 128) {
	CLR C
	MOV A, main_x_L0+0
	SUBB A, #128
	JNC L_main56
;ADC.c,353 :: 		P3_1_bit = 1;
	SETB C
	MOV A, P3_1_bit+0
	MOV #224, C
	MOV P3_1_bit+0, A
;ADC.c,354 :: 		adc_buffer[x] = adc_get_data();
	MOV A, #main_adc_buffer_L0+0
	ADD A, main_x_L0+0
	MOV R0, A
	MOV FLOC__main+1, 0
	LCALL _adc_get_data+0
	MOV FLOC__main+0, 0
	MOV R0, FLOC__main+1
	MOV @R0, FLOC__main+0
;ADC.c,355 :: 		x = x + 1;
	INC main_x_L0+0
;ADC.c,356 :: 		P3_1_bit = 0;
	CLR C
	MOV A, P3_1_bit+0
	MOV #224, C
	MOV P3_1_bit+0, A
;ADC.c,357 :: 		} else {
	LJMP L_main57
L_main56:
;ADC.c,358 :: 		x = 0;
	MOV main_x_L0+0, #0
;ADC.c,359 :: 		for(; x < 128; x++) {
L_main58:
	CLR C
	MOV A, main_x_L0+0
	SUBB A, #128
	JNC L_main59
;ADC.c,360 :: 		y = adc_buffer[x];
	MOV A, #main_adc_buffer_L0+0
	ADD A, main_x_L0+0
	MOV R0, A
	MOV 1, @R0
	MOV main_y_L0+0, 1
;ADC.c,361 :: 		y = y - 1;
	CLR C
	MOV A, R1
	SUBB A, #1
	MOV main_y_L0+0, A
;ADC.c,362 :: 		if(x == 0) {
	MOV A, main_x_L0+0
	JNZ L_main61
;ADC.c,363 :: 		prevx = x;
	MOV main_prevx_L0+0, main_x_L0+0
	CLR A
	MOV main_prevx_L0+1, A
;ADC.c,364 :: 		prevy = y;
	MOV main_prevy_L0+0, main_y_L0+0
	MOV A, main_y_L0+0
	RLC A
	CLR A
	SUBB A, 224
	MOV main_prevy_L0+1, A
;ADC.c,365 :: 		} else if (x > 0) {
	SJMP L_main62
L_main61:
	SETB C
	MOV A, main_x_L0+0
	SUBB A, #0
	JC L_main63
;ADC.c,366 :: 		Brezenhem(prevx, prevy, x, y);
	MOV FARG_Brezenhem_x0+0, main_prevx_L0+0
	MOV FARG_Brezenhem_x0+1, main_prevx_L0+1
	MOV FARG_Brezenhem_y0+0, main_prevy_L0+0
	MOV FARG_Brezenhem_y0+1, main_prevy_L0+1
	MOV FARG_Brezenhem_x1+0, main_x_L0+0
	CLR A
	MOV FARG_Brezenhem_x1+1, A
	MOV FARG_Brezenhem_y1+0, main_y_L0+0
	MOV A, main_y_L0+0
	RLC A
	CLR A
	SUBB A, 224
	MOV FARG_Brezenhem_y1+1, A
	LCALL _Brezenhem+0
;ADC.c,367 :: 		prevx = x;
	MOV main_prevx_L0+0, main_x_L0+0
	CLR A
	MOV main_prevx_L0+1, A
;ADC.c,368 :: 		prevy = y;
	MOV main_prevy_L0+0, main_y_L0+0
	MOV A, main_y_L0+0
	RLC A
	CLR A
	SUBB A, 224
	MOV main_prevy_L0+1, A
;ADC.c,369 :: 		}
L_main63:
L_main62:
;ADC.c,359 :: 		for(; x < 128; x++) {
	INC main_x_L0+0
;ADC.c,370 :: 		}
	SJMP L_main58
L_main59:
;ADC.c,371 :: 		Delay_ms(500);
	MOV R5, 4
	MOV R6, 43
	MOV R7, 157
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,372 :: 		x = 0;
	MOV main_x_L0+0, #0
;ADC.c,373 :: 		clear(0, 128);
	MOV FARG_clear_limit_left+0, #0
	MOV FARG_clear_limit_left+1, #0
	MOV FARG_clear_limit_right+0, #128
	MOV FARG_clear_limit_right+1, #0
	LCALL _clear+0
;ADC.c,374 :: 		}
L_main57:
;ADC.c,375 :: 		}
	LJMP L_main54
;ADC.c,376 :: 		}
	SJMP #254
; end of _main
