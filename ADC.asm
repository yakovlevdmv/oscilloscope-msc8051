
_setXAddress:
;ADC.c,75 :: 		void setXAddress(int x) {
;ADC.c,76 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,77 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,78 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,80 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,82 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,83 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,84 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,86 :: 		void setYAddress(int y) {
;ADC.c,87 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,88 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,89 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,91 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,93 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,94 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,95 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,97 :: 		void setZAddress(int z) {
;ADC.c,98 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,99 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,100 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,102 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,104 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,105 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,106 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,108 :: 		void writeData(char _data) {
;ADC.c,109 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,110 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,111 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,113 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,114 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,115 :: 		}
	RET
; end of _writeData

_displayOn:
;ADC.c,117 :: 		void displayOn() {
;ADC.c,118 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,119 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,120 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,122 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,124 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,125 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,126 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,128 :: 		void drawPoint(int x, int y, int flag) {
;ADC.c,129 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,130 :: 		int limit = 0;
;ADC.c,131 :: 		int mask = 0b00000001;
;ADC.c,132 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint139
L__drawPoint140:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint139:
	DJNZ R0, L__drawPoint140
	MOV drawPoint__cs_L0+1, A
;ADC.c,133 :: 		if (flag == 1) {
	MOV A, #1
	XRL A, FARG_drawPoint_flag+0
	JNZ L__drawPoint141
	MOV A, #0
	XRL A, FARG_drawPoint_flag+1
L__drawPoint141:
	JNZ L_drawPoint0
;ADC.c,134 :: 		mask = 0b00000000;
	MOV drawPoint_mask_L0+0, #0
	MOV drawPoint_mask_L0+1, #0
;ADC.c,135 :: 		}
L_drawPoint0:
;ADC.c,136 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint142
L__drawPoint143:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint142:
	DJNZ R0, L__drawPoint143
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,138 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
	JNZ L_drawPoint1
;ADC.c,139 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,140 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,141 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,142 :: 		} else {
	SJMP L_drawPoint2
L_drawPoint1:
;ADC.c,143 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,144 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,145 :: 		setYAddress(x % 64);
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
;ADC.c,146 :: 		}
L_drawPoint2:
;ADC.c,147 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,148 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,149 :: 		for (count = 0; count < limit - 1; count++) {
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
;ADC.c,150 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint144
L__drawPoint145:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint144:
	DJNZ R0, L__drawPoint145
	MOV drawPoint_mask_L0+0, A
;ADC.c,149 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,151 :: 		}
	SJMP L_drawPoint3
L_drawPoint4:
;ADC.c,152 :: 		if(y > 0) {
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
;ADC.c,153 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint146
L__drawPoint147:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint146:
	DJNZ R0, L__drawPoint147
	MOV drawPoint_mask_L0+0, A
;ADC.c,154 :: 		}
L_drawPoint6:
;ADC.c,155 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,156 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,157 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,158 :: 		}
	RET
; end of _drawPoint

_drawMask:
;ADC.c,160 :: 		void drawMask(int x, int y, int mask) {
;ADC.c,161 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawMask_x+1
	MOV drawMask__cs_L0+0, FARG_drawMask_x+0
	INC R0
	SJMP L__drawMask148
L__drawMask149:
	MOV C, #231
	RRC A
	XCH A, drawMask__cs_L0+0
	RRC A
	XCH A, drawMask__cs_L0+0
L__drawMask148:
	DJNZ R0, L__drawMask149
	MOV drawMask__cs_L0+1, A
;ADC.c,162 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawMask_y+1
	MOV FARG_setXAddress_x+0, FARG_drawMask_y+0
	INC R0
	SJMP L__drawMask150
L__drawMask151:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawMask150:
	DJNZ R0, L__drawMask151
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,164 :: 		if (_cs == 0 ) {
	MOV A, drawMask__cs_L0+0
	ORL A, drawMask__cs_L0+1
	JNZ L_drawMask7
;ADC.c,165 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,166 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,167 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawMask_x+0
	MOV FARG_setYAddress_y+1, FARG_drawMask_x+1
	LCALL _setYAddress+0
;ADC.c,168 :: 		} else {
	SJMP L_drawMask8
L_drawMask7:
;ADC.c,169 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,170 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,171 :: 		setYAddress(x % 64);
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
;ADC.c,172 :: 		}
L_drawMask8:
;ADC.c,173 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,174 :: 		writeData(mask);
	MOV FARG_writeData__data+0, FARG_drawMask_mask+0
	LCALL _writeData+0
;ADC.c,175 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,176 :: 		}
	RET
; end of _drawMask

_drawVLine:
;ADC.c,178 :: 		void drawVLine(int column) {
;ADC.c,179 :: 		int count = 0;
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
	MOV drawVLine_mask_L0+0, #255
	MOV drawVLine_mask_L0+1, #0
;ADC.c,180 :: 		int mask = 0b11111111;
;ADC.c,181 :: 		int _cs = column / 64;
	MOV R0, #6
	MOV A, FARG_drawVLine_column+1
	MOV drawVLine__cs_L0+0, FARG_drawVLine_column+0
	INC R0
	SJMP L__drawVLine152
L__drawVLine153:
	MOV C, #231
	RRC A
	XCH A, drawVLine__cs_L0+0
	RRC A
	XCH A, drawVLine__cs_L0+0
L__drawVLine152:
	DJNZ R0, L__drawVLine153
	MOV drawVLine__cs_L0+1, A
;ADC.c,183 :: 		for(count = 0; count < 8; count++) {
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
;ADC.c,184 :: 		if (_cs == 0 ) {
	MOV A, drawVLine__cs_L0+0
	ORL A, drawVLine__cs_L0+1
	JNZ L_drawVLine12
;ADC.c,185 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,186 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,187 :: 		setYAddress(column);
	MOV FARG_setYAddress_y+0, FARG_drawVLine_column+0
	MOV FARG_setYAddress_y+1, FARG_drawVLine_column+1
	LCALL _setYAddress+0
;ADC.c,188 :: 		} else {
	SJMP L_drawVLine13
L_drawVLine12:
;ADC.c,189 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,190 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,191 :: 		setYAddress(column % 64);
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
;ADC.c,192 :: 		}
L_drawVLine13:
;ADC.c,193 :: 		setXAddress(count);
	MOV FARG_setXAddress_x+0, drawVLine_count_L0+0
	MOV FARG_setXAddress_x+1, drawVLine_count_L0+1
	LCALL _setXAddress+0
;ADC.c,194 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,195 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawVLine_mask_L0+0
	LCALL _writeData+0
;ADC.c,183 :: 		for(count = 0; count < 8; count++) {
	MOV A, #1
	ADD A, drawVLine_count_L0+0
	MOV drawVLine_count_L0+0, A
	MOV A, #0
	ADDC A, drawVLine_count_L0+1
	MOV drawVLine_count_L0+1, A
;ADC.c,196 :: 		}
	SJMP L_drawVLine9
L_drawVLine10:
;ADC.c,198 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,199 :: 		}
	RET
; end of _drawVLine

_clear:
;ADC.c,201 :: 		int clear(int limit_left, int limit_right) {
;ADC.c,203 :: 		if (limit_left >= limit_right) return -1;
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
;ADC.c,205 :: 		for(x = limit_left; x < limit_right; x++) {
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
;ADC.c,206 :: 		for(y = 0; y <=64; y=y+8) {
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
;ADC.c,208 :: 		drawMask(x,y, 0b00000000);
	MOV FARG_drawMask_x+0, clear_x_L0+0
	MOV FARG_drawMask_x+1, clear_x_L0+1
	MOV FARG_drawMask_y+0, clear_y_L0+0
	MOV FARG_drawMask_y+1, clear_y_L0+1
	MOV FARG_drawMask_mask+0, #0
	MOV FARG_drawMask_mask+1, #0
	LCALL _drawMask+0
;ADC.c,206 :: 		for(y = 0; y <=64; y=y+8) {
	MOV A, #8
	ADD A, clear_y_L0+0
	MOV clear_y_L0+0, A
	MOV A, #0
	ADDC A, clear_y_L0+1
	MOV clear_y_L0+1, A
;ADC.c,209 :: 		}
	SJMP L_clear18
L_clear19:
;ADC.c,205 :: 		for(x = limit_left; x < limit_right; x++) {
	MOV A, #1
	ADD A, clear_x_L0+0
	MOV clear_x_L0+0, A
	MOV A, #0
	ADDC A, clear_x_L0+1
	MOV clear_x_L0+1, A
;ADC.c,210 :: 		}
	SJMP L_clear15
L_clear16:
;ADC.c,211 :: 		return 0;
	MOV R0, #0
	MOV R1, #0
;ADC.c,212 :: 		}
	RET
; end of _clear

_initSPI:
;ADC.c,216 :: 		void initSPI() {
;ADC.c,217 :: 		SPCR = 0b01010011;
	MOV SPCR+0, #83
;ADC.c,218 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,220 :: 		void rs232init() {
;ADC.c,221 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,222 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,223 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,224 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,225 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,226 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,227 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,228 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,230 :: 		void transmit(char b) {
;ADC.c,231 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,232 :: 		while(TI_bit == 0) {}
L_transmit21:
	JB TI_bit+0, L_transmit22
	NOP
	SJMP L_transmit21
L_transmit22:
;ADC.c,233 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,235 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,237 :: 		void transmitString(char* str) {
;ADC.c,238 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,240 :: 		while (*p) {
L_transmitString23:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString24
;ADC.c,241 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,242 :: 		}
	SJMP L_transmitString23
L_transmitString24:
;ADC.c,243 :: 		}
	RET
; end of _transmitString

_writeSPI:
;ADC.c,245 :: 		void writeSPI(int _data) {
;ADC.c,246 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,247 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,250 :: 		int readSPI() {
;ADC.c,252 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, SPIF_bit+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,253 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,254 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,256 :: 		void delay() {
;ADC.c,257 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,258 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,260 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,262 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,263 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data25
;ADC.c,264 :: 		SPI_init_data += 0b00000000;
;ADC.c,265 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data26
L_adc_get_data25:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data154
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data154:
	JNZ L_adc_get_data27
;ADC.c,266 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,267 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data28
L_adc_get_data27:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data155
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data155:
	JNZ L_adc_get_data29
;ADC.c,268 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,269 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data30
L_adc_get_data29:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data156
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data156:
	JNZ L_adc_get_data31
;ADC.c,270 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,271 :: 		}
L_adc_get_data31:
L_adc_get_data30:
L_adc_get_data28:
L_adc_get_data26:
;ADC.c,272 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,273 :: 		CS = 0;
	CLR P2_0_bit+0
;ADC.c,276 :: 		writeSPI(SPI_init_data);
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,277 :: 		while(SPIF_bit != 1) {}
L_adc_get_data32:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data33
	NOP
	SJMP L_adc_get_data32
L_adc_get_data33:
;ADC.c,278 :: 		_data.first = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,280 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,281 :: 		while(SPIF_bit != 1) {}
L_adc_get_data34:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data35
	NOP
	SJMP L_adc_get_data34
L_adc_get_data35:
;ADC.c,282 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,284 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,285 :: 		while(SPIF_bit != 1) {}
L_adc_get_data36:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data37
	NOP
	SJMP L_adc_get_data36
L_adc_get_data37:
;ADC.c,286 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,288 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,290 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data38:
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
	JNZ L_adc_get_data38
	MOV ?lstr_1_ADC+0, adc_get_data__data_L0+0
	MOV ?lstr_1_ADC+1, adc_get_data__data_L0+1
;ADC.c,291 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,293 :: 		int getBit(int position, int byte) {
;ADC.c,294 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit157
L__getBit158:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit157:
	DJNZ R2, L__getBit158
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,295 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,297 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,298 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,299 :: 		int i = 0;
;ADC.c,301 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,303 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue39:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue40
;ADC.c,304 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue159
L__parseADCValue160:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue159:
	DJNZ R0, L__parseADCValue160
	MOV parseADCValue_result_L0+0, A
;ADC.c,305 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,303 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,306 :: 		}
	SJMP L_parseADCValue39
L_parseADCValue40:
;ADC.c,308 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue42:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue43
;ADC.c,309 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue161
L__parseADCValue162:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue161:
	DJNZ R0, L__parseADCValue162
	MOV parseADCValue_result_L0+0, A
;ADC.c,310 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,308 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,311 :: 		}
	SJMP L_parseADCValue42
L_parseADCValue43:
;ADC.c,313 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,314 :: 		}
	RET
; end of _parseADCValue

_getInputValue:
;ADC.c,316 :: 		float getInputValue(int _data) {
;ADC.c,317 :: 		return 4.096 * _data / 4096;
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
;ADC.c,318 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,320 :: 		float getGain(int _data) {
;ADC.c,321 :: 		return 2. * (_data / 1000.);
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
;ADC.c,322 :: 		}
	RET
; end of _getGain

_strConstCpy:
;ADC.c,336 :: 		void strConstCpy(char *dest, const char *source) {
;ADC.c,337 :: 		while(*source) {
L_strConstCpy45:
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	JZ L_strConstCpy46
;ADC.c,338 :: 		*dest++ = *source++;
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
;ADC.c,339 :: 		}
	SJMP L_strConstCpy45
L_strConstCpy46:
;ADC.c,340 :: 		*dest = 0 ;
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, #0
;ADC.c,341 :: 		}
	RET
; end of _strConstCpy

_reverse:
;ADC.c,344 :: 		void reverse(char *str, int len)
;ADC.c,346 :: 		int i=0, j=len-1, temp;
	MOV reverse_i_L0+0, #0
	MOV reverse_i_L0+1, #0
	CLR C
	MOV A, FARG_reverse_len+0
	SUBB A, #1
	MOV reverse_j_L0+0, A
	MOV A, FARG_reverse_len+1
	SUBB A, #0
	MOV reverse_j_L0+1, A
;ADC.c,347 :: 		while (i<j)
L_reverse47:
	CLR C
	MOV A, reverse_i_L0+0
	SUBB A, reverse_j_L0+0
	MOV A, reverse_j_L0+1
	XRL A, #128
	MOV R0, A
	MOV A, reverse_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_reverse48
;ADC.c,349 :: 		temp = str[i];
	MOV A, FARG_reverse_str+0
	ADD A, reverse_i_L0+0
	MOV R0, A
	MOV reverse_temp_L0+0, @R0
	CLR A
	MOV reverse_temp_L0+1, A
;ADC.c,350 :: 		str[i] = str[j];
	MOV A, FARG_reverse_str+0
	ADD A, reverse_j_L0+0
	MOV R1, A
	MOV A, @R1
	MOV @R0, A
;ADC.c,351 :: 		str[j] = temp;
	MOV A, FARG_reverse_str+0
	ADD A, reverse_j_L0+0
	MOV R0, A
	MOV @R0, reverse_temp_L0+0
;ADC.c,352 :: 		i++; j--;
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
;ADC.c,353 :: 		}
	SJMP L_reverse47
L_reverse48:
;ADC.c,354 :: 		}
	RET
; end of _reverse

_intToStr:
;ADC.c,359 :: 		int intToStr(int x, char str[], int d)
;ADC.c,361 :: 		int i = 0;
	MOV intToStr_i_L0+0, #0
	MOV intToStr_i_L0+1, #0
;ADC.c,362 :: 		while (x)
L_intToStr49:
	MOV A, FARG_intToStr_x+0
	ORL A, FARG_intToStr_x+1
	JZ L_intToStr50
;ADC.c,364 :: 		str[i++] = (x%10) + '0';
	MOV A, FARG_intToStr_str+0
	ADD A, intToStr_i_L0+0
	MOV R0, A
	MOV FLOC__intToStr+0, 0
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_intToStr_x+0
	MOV R1, FARG_intToStr_x+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV A, #48
	ADD A, R0
	MOV R1, A
	MOV R0, FLOC__intToStr+0
	MOV @R0, 1
	MOV A, #1
	ADD A, intToStr_i_L0+0
	MOV intToStr_i_L0+0, A
	MOV A, #0
	ADDC A, intToStr_i_L0+1
	MOV intToStr_i_L0+1, A
;ADC.c,365 :: 		x = x/10;
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_intToStr_x+0
	MOV R1, FARG_intToStr_x+1
	LCALL _Div_16x16_S+0
	MOV FARG_intToStr_x+0, 0
	MOV FARG_intToStr_x+1, 1
;ADC.c,366 :: 		}
	SJMP L_intToStr49
L_intToStr50:
;ADC.c,370 :: 		while (i < d)
L_intToStr51:
	CLR C
	MOV A, intToStr_i_L0+0
	SUBB A, FARG_intToStr_d+0
	MOV A, FARG_intToStr_d+1
	XRL A, #128
	MOV R0, A
	MOV A, intToStr_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_intToStr52
;ADC.c,371 :: 		str[i++] = '0';
	MOV A, FARG_intToStr_str+0
	ADD A, intToStr_i_L0+0
	MOV R0, A
	MOV @R0, #48
	MOV A, #1
	ADD A, intToStr_i_L0+0
	MOV intToStr_i_L0+0, A
	MOV A, #0
	ADDC A, intToStr_i_L0+1
	MOV intToStr_i_L0+1, A
	SJMP L_intToStr51
L_intToStr52:
;ADC.c,373 :: 		reverse(str, i);
	MOV FARG_reverse_str+0, FARG_intToStr_str+0
	MOV FARG_reverse_len+0, intToStr_i_L0+0
	MOV FARG_reverse_len+1, intToStr_i_L0+1
	LCALL _reverse+0
;ADC.c,374 :: 		str[i] = '\0';
	MOV A, FARG_intToStr_str+0
	ADD A, intToStr_i_L0+0
	MOV R0, A
	MOV @R0, #0
;ADC.c,375 :: 		return i;
	MOV R0, intToStr_i_L0+0
	MOV R1, intToStr_i_L0+1
;ADC.c,376 :: 		}
	RET
; end of _intToStr

_ftoa:
;ADC.c,379 :: 		void ftoa(float n, char *res, int afterpoint)
;ADC.c,382 :: 		int ipart = (int)n;
	MOV R0, FARG_ftoa_n+0
	MOV R1, FARG_ftoa_n+1
	MOV R2, FARG_ftoa_n+2
	MOV R3, FARG_ftoa_n+3
	LCALL _Double2Ints+0
	MOV FLOC__ftoa+0, 0
	MOV FLOC__ftoa+1, 1
	MOV R0, FLOC__ftoa+0
	MOV R1, FLOC__ftoa+1
	LCALL _Int2Double+0
;ADC.c,385 :: 		float fpart = n - (float)ipart;
	MOV R4, 0
	MOV R5, 1
	MOV R6, 2
	MOV R7, 3
	MOV R0, FARG_ftoa_n+0
	MOV R1, FARG_ftoa_n+1
	MOV R2, FARG_ftoa_n+2
	MOV R3, FARG_ftoa_n+3
	LCALL _Sub_32x32_FP+0
	MOV ftoa_fpart_L0+0, 0
	MOV ftoa_fpart_L0+1, 1
	MOV ftoa_fpart_L0+2, 2
	MOV ftoa_fpart_L0+3, 3
;ADC.c,388 :: 		int i = intToStr(ipart, res, 0);
	MOV FARG_intToStr_x+0, FLOC__ftoa+0
	MOV FARG_intToStr_x+1, FLOC__ftoa+1
	MOV FARG_intToStr_str+0, FARG_ftoa_res+0
	MOV FARG_intToStr_d+0, #0
	MOV FARG_intToStr_d+1, #0
	LCALL _intToStr+0
	MOV ftoa_i_L0+0, 0
	MOV ftoa_i_L0+1, 1
;ADC.c,391 :: 		if (afterpoint != 0)
	MOV A, FARG_ftoa_afterpoint+0
	ORL A, FARG_ftoa_afterpoint+1
	JZ L_ftoa53
;ADC.c,393 :: 		res[i] = '.';  // add dot
	MOV A, FARG_ftoa_res+0
	ADD A, ftoa_i_L0+0
	MOV R0, A
	MOV @R0, #46
;ADC.c,398 :: 		fpart = fpart * pow(10, afterpoint);
	MOV FARG_pow_x+0, #0
	MOV FARG_pow_x+1, #0
	MOV FARG_pow_x+2, #32
	MOV FARG_pow_x+3, #65
	MOV R0, FARG_ftoa_afterpoint+0
	MOV R1, FARG_ftoa_afterpoint+1
	LCALL _Int2Double+0
	MOV FARG_pow_y+0, 0
	MOV FARG_pow_y+1, 1
	MOV FARG_pow_y+2, 2
	MOV FARG_pow_y+3, 3
	LCALL _pow+0
	MOV R4, ftoa_fpart_L0+0
	MOV R5, ftoa_fpart_L0+1
	MOV R6, ftoa_fpart_L0+2
	MOV R7, ftoa_fpart_L0+3
	LCALL _Mul_32x32_FP+0
	MOV ftoa_fpart_L0+0, 0
	MOV ftoa_fpart_L0+1, 1
	MOV ftoa_fpart_L0+2, 2
	MOV ftoa_fpart_L0+3, 3
;ADC.c,400 :: 		intToStr((int)fpart, res + i + 1, afterpoint);
	LCALL _Double2Ints+0
	MOV FARG_intToStr_x+0, 0
	MOV FARG_intToStr_x+1, 1
	MOV A, FARG_ftoa_res+0
	ADD A, ftoa_i_L0+0
	MOV FARG_intToStr_str+0, A
	INC FARG_intToStr_str+0
	MOV FARG_intToStr_d+0, FARG_ftoa_afterpoint+0
	MOV FARG_intToStr_d+1, FARG_ftoa_afterpoint+1
	LCALL _intToStr+0
;ADC.c,401 :: 		}
L_ftoa53:
;ADC.c,402 :: 		}
	RET
; end of _ftoa

_drawHighValue:
;ADC.c,404 :: 		void drawHighValue(float number) {
;ADC.c,409 :: 		ftoa(number, numBuffer, 2);
	MOV FARG_ftoa_n+0, FARG_drawHighValue_number+0
	MOV FARG_ftoa_n+1, FARG_drawHighValue_number+1
	MOV FARG_ftoa_n+2, FARG_drawHighValue_number+2
	MOV FARG_ftoa_n+3, FARG_drawHighValue_number+3
	MOV FARG_ftoa_res+0, #drawHighValue_numBuffer_L0+0
	MOV FARG_ftoa_afterpoint+0, #2
	MOV FARG_ftoa_afterpoint+1, #0
	LCALL _ftoa+0
;ADC.c,411 :: 		p = &numBuffer[0];
	MOV drawHighValue_p_L0+0, #drawHighValue_numBuffer_L0+0
;ADC.c,412 :: 		x = 95;
	MOV drawHighValue_x_L0+0, #95
	MOV drawHighValue_x_L0+1, #0
;ADC.c,413 :: 		while (*p) {
L_drawHighValue54:
	MOV R0, drawHighValue_p_L0+0
	MOV A, @R0
	JNZ #3
	LJMP L_drawHighValue55
;ADC.c,415 :: 		if(*p == '9') {
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #57
	JNZ L_drawHighValue56
;ADC.c,416 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue57:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue58
;ADC.c,417 :: 		drawMask(x, 8, Calibri6x7[7 * 9 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #63
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,418 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,416 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,419 :: 		}
	SJMP L_drawHighValue57
L_drawHighValue58:
;ADC.c,421 :: 		} else if (*p == '8') {
	LJMP L_drawHighValue60
L_drawHighValue56:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #56
	JNZ L_drawHighValue61
;ADC.c,422 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue62:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue63
;ADC.c,423 :: 		drawMask(x, 8, Calibri6x7[7 * 8 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #56
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,424 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,422 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,425 :: 		}
	SJMP L_drawHighValue62
L_drawHighValue63:
;ADC.c,426 :: 		}  else if (*p == '7') {
	LJMP L_drawHighValue65
L_drawHighValue61:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #55
	JNZ L_drawHighValue66
;ADC.c,427 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue67:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue68
;ADC.c,428 :: 		drawMask(x, 8, Calibri6x7[7 * 7 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #49
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,429 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,427 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,430 :: 		}
	SJMP L_drawHighValue67
L_drawHighValue68:
;ADC.c,431 :: 		} else if (*p == '6') {
	LJMP L_drawHighValue70
L_drawHighValue66:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #54
	JNZ L_drawHighValue71
;ADC.c,432 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue72:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue73
;ADC.c,433 :: 		drawMask(x, 8, Calibri6x7[7 * 6 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #42
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,434 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,432 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,435 :: 		}
	SJMP L_drawHighValue72
L_drawHighValue73:
;ADC.c,436 :: 		} else if (*p == '5') {
	LJMP L_drawHighValue75
L_drawHighValue71:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #53
	JNZ L_drawHighValue76
;ADC.c,437 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue77:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue78
;ADC.c,438 :: 		drawMask(x, 8, Calibri6x7[7 * 5 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #35
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,439 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,437 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,440 :: 		}
	SJMP L_drawHighValue77
L_drawHighValue78:
;ADC.c,441 :: 		} else if (*p == '4') {
	LJMP L_drawHighValue80
L_drawHighValue76:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #52
	JNZ L_drawHighValue81
;ADC.c,442 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue82:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue83
;ADC.c,443 :: 		drawMask(x, 8, Calibri6x7[7 * 4 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #28
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,444 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,442 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,445 :: 		}
	SJMP L_drawHighValue82
L_drawHighValue83:
;ADC.c,446 :: 		} else if (*p == '3') {
	LJMP L_drawHighValue85
L_drawHighValue81:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #51
	JNZ L_drawHighValue86
;ADC.c,447 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue87:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue88
;ADC.c,448 :: 		drawMask(x, 8, Calibri6x7[7 * 3 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #21
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,449 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,447 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,450 :: 		}
	SJMP L_drawHighValue87
L_drawHighValue88:
;ADC.c,451 :: 		} else if (*p == '2') {
	LJMP L_drawHighValue90
L_drawHighValue86:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #50
	JNZ L_drawHighValue91
;ADC.c,452 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue92:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue93
;ADC.c,453 :: 		drawMask(x, 8, Calibri6x7[7 * 2 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #14
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,454 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,452 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,455 :: 		}
	SJMP L_drawHighValue92
L_drawHighValue93:
;ADC.c,456 :: 		} else if (*p == '1') {
	LJMP L_drawHighValue95
L_drawHighValue91:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #49
	JNZ L_drawHighValue96
;ADC.c,457 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue97:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue98
;ADC.c,458 :: 		drawMask(x, 8, Calibri6x7[7 * 1 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #7
	ADD A, drawHighValue_i_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV R1, A
	MOV A, #_Calibri6x7+0
	ADD A, R0
	MOV R2, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, R1
	MOV R3, A
	MOV 130, 2
	MOV 131, 3
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,459 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,457 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,460 :: 		}
	SJMP L_drawHighValue97
L_drawHighValue98:
;ADC.c,461 :: 		} else if (*p == '0') {
	LJMP L_drawHighValue100
L_drawHighValue96:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #48
	JNZ L_drawHighValue101
;ADC.c,462 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue102:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue103
;ADC.c,463 :: 		drawMask(x, 8, Calibri6x7[7 * 0 + i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #_Calibri6x7+0
	ADD A, drawHighValue_i_L0+0
	MOV R1, A
	MOV A, hi(#_Calibri6x7+0)
	ADDC A, drawHighValue_i_L0+1
	MOV R2, A
	MOV 130, 1
	MOV 131, 2
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,464 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,462 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,465 :: 		}
	SJMP L_drawHighValue102
L_drawHighValue103:
;ADC.c,466 :: 		} else if (*p == '.') {
	SJMP L_drawHighValue105
L_drawHighValue101:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #46
	JNZ L_drawHighValue106
;ADC.c,467 :: 		for(i = 0; i < 5; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue107:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue108
;ADC.c,468 :: 		drawMask(x, 8, comma[i]);
	MOV FARG_drawMask_x+0, drawHighValue_x_L0+0
	MOV FARG_drawMask_x+1, drawHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV A, #_comma+0
	ADD A, drawHighValue_i_L0+0
	MOV R1, A
	MOV A, hi(#_comma+0)
	ADDC A, drawHighValue_i_L0+1
	MOV R2, A
	MOV 130, 1
	MOV 131, 2
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	MOV FARG_drawMask_mask+0, 0
	CLR A
	MOV FARG_drawMask_mask+1, A
	LCALL _drawMask+0
;ADC.c,469 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,467 :: 		for(i = 0; i < 5; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,470 :: 		}
	SJMP L_drawHighValue107
L_drawHighValue108:
;ADC.c,471 :: 		}
L_drawHighValue106:
L_drawHighValue105:
L_drawHighValue100:
L_drawHighValue95:
L_drawHighValue90:
L_drawHighValue85:
L_drawHighValue80:
L_drawHighValue75:
L_drawHighValue70:
L_drawHighValue65:
L_drawHighValue60:
;ADC.c,472 :: 		(*(p++));
	INC drawHighValue_p_L0+0
;ADC.c,474 :: 		}
	LJMP L_drawHighValue54
L_drawHighValue55:
;ADC.c,475 :: 		}
	RET
; end of _drawHighValue

_clearHighValue:
;ADC.c,477 :: 		void clearHighValue() {
;ADC.c,479 :: 		for(x = 95; x < 128; x++) {
	MOV clearHighValue_x_L0+0, #95
	MOV clearHighValue_x_L0+1, #0
L_clearHighValue110:
	CLR C
	MOV A, clearHighValue_x_L0+0
	SUBB A, #128
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, clearHighValue_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clearHighValue111
;ADC.c,480 :: 		drawMask(x, 8, 0b00000000);
	MOV FARG_drawMask_x+0, clearHighValue_x_L0+0
	MOV FARG_drawMask_x+1, clearHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV FARG_drawMask_mask+0, #0
	MOV FARG_drawMask_mask+1, #0
	LCALL _drawMask+0
;ADC.c,479 :: 		for(x = 95; x < 128; x++) {
	MOV A, #1
	ADD A, clearHighValue_x_L0+0
	MOV clearHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, clearHighValue_x_L0+1
	MOV clearHighValue_x_L0+1, A
;ADC.c,482 :: 		}
	SJMP L_clearHighValue110
L_clearHighValue111:
;ADC.c,483 :: 		}
	RET
; end of _clearHighValue

_Abs:
;ADC.c,485 :: 		int Abs(int num) {
;ADC.c,486 :: 		if(num < 0)
	CLR C
	MOV A, FARG_Abs_num+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_Abs_num+1
	XRL A, #128
	SUBB A, R0
	JNC L_Abs113
;ADC.c,487 :: 		return -num;
	CLR C
	MOV A, #0
	SUBB A, FARG_Abs_num+0
	MOV R0, A
	MOV A, #0
	SUBB A, FARG_Abs_num+1
	MOV R1, A
	RET
L_Abs113:
;ADC.c,489 :: 		return num;
	MOV R0, FARG_Abs_num+0
	MOV R1, FARG_Abs_num+1
;ADC.c,490 :: 		}
	RET
; end of _Abs

_Brezenhem:
;ADC.c,492 :: 		void Brezenhem(int x0, int y0, int x1, int y1)
;ADC.c,496 :: 		int f = 0;
	MOV Brezenhem_f_L0+0, #0
	MOV Brezenhem_f_L0+1, #0
;ADC.c,497 :: 		A = y1 - y0;
	CLR C
	MOV A, FARG_Brezenhem_y1+0
	SUBB A, FARG_Brezenhem_y0+0
	MOV R0, A
	MOV A, FARG_Brezenhem_y1+1
	SUBB A, FARG_Brezenhem_y0+1
	MOV R1, A
	MOV Brezenhem_A_L0+0, 0
	MOV Brezenhem_A_L0+1, 1
;ADC.c,498 :: 		B = x0 - x1;
	CLR C
	MOV A, FARG_Brezenhem_x0+0
	SUBB A, FARG_Brezenhem_x1+0
	MOV Brezenhem_B_L0+0, A
	MOV A, FARG_Brezenhem_x0+1
	SUBB A, FARG_Brezenhem_x1+1
	MOV Brezenhem_B_L0+1, A
;ADC.c,499 :: 		if (abs(A) > abs(B))
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
	JC L_Brezenhem115
;ADC.c,500 :: 		sign = 1;
	MOV Brezenhem_sign_L0+0, #1
	MOV Brezenhem_sign_L0+1, #0
	SJMP L_Brezenhem116
L_Brezenhem115:
;ADC.c,502 :: 		sign = -1;
	MOV Brezenhem_sign_L0+0, #255
	MOV Brezenhem_sign_L0+1, #255
L_Brezenhem116:
;ADC.c,503 :: 		if (A < 0)
	CLR C
	MOV A, Brezenhem_A_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, Brezenhem_A_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Brezenhem117
;ADC.c,504 :: 		signa = -1;
	MOV Brezenhem_signa_L0+0, #255
	MOV Brezenhem_signa_L0+1, #255
	SJMP L_Brezenhem118
L_Brezenhem117:
;ADC.c,506 :: 		signa = 1;
	MOV Brezenhem_signa_L0+0, #1
	MOV Brezenhem_signa_L0+1, #0
L_Brezenhem118:
;ADC.c,507 :: 		if (B < 0)
	CLR C
	MOV A, Brezenhem_B_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, Brezenhem_B_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_Brezenhem119
;ADC.c,508 :: 		signb = -1;
	MOV Brezenhem_signb_L0+0, #255
	MOV Brezenhem_signb_L0+1, #255
	SJMP L_Brezenhem120
L_Brezenhem119:
;ADC.c,510 :: 		signb = 1;
	MOV Brezenhem_signb_L0+0, #1
	MOV Brezenhem_signb_L0+1, #0
L_Brezenhem120:
;ADC.c,511 :: 		drawPoint(x0,y0, 0);
	MOV FARG_drawPoint_x+0, FARG_Brezenhem_x0+0
	MOV FARG_drawPoint_x+1, FARG_Brezenhem_x0+1
	MOV FARG_drawPoint_y+0, FARG_Brezenhem_y0+0
	MOV FARG_drawPoint_y+1, FARG_Brezenhem_y0+1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,512 :: 		x = x0;
	MOV Brezenhem_x_L0+0, FARG_Brezenhem_x0+0
	MOV Brezenhem_x_L0+1, FARG_Brezenhem_x0+1
;ADC.c,513 :: 		y = y0;
	MOV Brezenhem_y_L0+0, FARG_Brezenhem_y0+0
	MOV Brezenhem_y_L0+1, FARG_Brezenhem_y0+1
;ADC.c,514 :: 		if (sign == -1)
	MOV A, #255
	XRL A, Brezenhem_sign_L0+0
	JNZ L__Brezenhem163
	MOV A, #255
	XRL A, Brezenhem_sign_L0+1
L__Brezenhem163:
	JZ #3
	LJMP L_Brezenhem121
;ADC.c,516 :: 		do {
L_Brezenhem122:
;ADC.c,517 :: 		f += A*signa;
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
;ADC.c,518 :: 		if (f > 0)
	SETB C
	MOV A, R2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, R3
	XRL A, #128
	SUBB A, R0
	JC L_Brezenhem125
;ADC.c,520 :: 		f -= B*signb;
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
;ADC.c,521 :: 		y += signa;
	MOV A, Brezenhem_y_L0+0
	ADD A, Brezenhem_signa_L0+0
	MOV Brezenhem_y_L0+0, A
	MOV A, Brezenhem_y_L0+1
	ADDC A, Brezenhem_signa_L0+1
	MOV Brezenhem_y_L0+1, A
;ADC.c,522 :: 		}
L_Brezenhem125:
;ADC.c,523 :: 		x -= signb;
	CLR C
	MOV A, Brezenhem_x_L0+0
	SUBB A, Brezenhem_signb_L0+0
	MOV R0, A
	MOV A, Brezenhem_x_L0+1
	SUBB A, Brezenhem_signb_L0+1
	MOV R1, A
	MOV Brezenhem_x_L0+0, 0
	MOV Brezenhem_x_L0+1, 1
;ADC.c,524 :: 		drawPoint(x, y, 0);
	MOV FARG_drawPoint_x+0, 0
	MOV FARG_drawPoint_x+1, 1
	MOV FARG_drawPoint_y+0, Brezenhem_y_L0+0
	MOV FARG_drawPoint_y+1, Brezenhem_y_L0+1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,525 :: 		} while (x != x1 || y != y1);
	MOV A, Brezenhem_x_L0+0
	XRL A, FARG_Brezenhem_x1+0
	JNZ L__Brezenhem164
	MOV A, Brezenhem_x_L0+1
	XRL A, FARG_Brezenhem_x1+1
L__Brezenhem164:
	JZ #3
	LJMP L_Brezenhem122
	MOV A, Brezenhem_y_L0+0
	XRL A, FARG_Brezenhem_y1+0
	JNZ L__Brezenhem165
	MOV A, Brezenhem_y_L0+1
	XRL A, FARG_Brezenhem_y1+1
L__Brezenhem165:
	JZ #3
	LJMP L_Brezenhem122
L__Brezenhem138:
;ADC.c,526 :: 		}
	LJMP L_Brezenhem128
L_Brezenhem121:
;ADC.c,529 :: 		do {
L_Brezenhem129:
;ADC.c,530 :: 		f += B*signb;
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
;ADC.c,531 :: 		if (f > 0) {
	SETB C
	MOV A, R2
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, R3
	XRL A, #128
	SUBB A, R0
	JC L_Brezenhem132
;ADC.c,532 :: 		f -= A*signa;
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
;ADC.c,533 :: 		x -= signb;
	CLR C
	MOV A, Brezenhem_x_L0+0
	SUBB A, Brezenhem_signb_L0+0
	MOV Brezenhem_x_L0+0, A
	MOV A, Brezenhem_x_L0+1
	SUBB A, Brezenhem_signb_L0+1
	MOV Brezenhem_x_L0+1, A
;ADC.c,534 :: 		}
L_Brezenhem132:
;ADC.c,535 :: 		y += signa;
	MOV A, Brezenhem_y_L0+0
	ADD A, Brezenhem_signa_L0+0
	MOV R0, A
	MOV A, Brezenhem_y_L0+1
	ADDC A, Brezenhem_signa_L0+1
	MOV R1, A
	MOV Brezenhem_y_L0+0, 0
	MOV Brezenhem_y_L0+1, 1
;ADC.c,536 :: 		drawPoint(x, y, 0);
	MOV FARG_drawPoint_x+0, Brezenhem_x_L0+0
	MOV FARG_drawPoint_x+1, Brezenhem_x_L0+1
	MOV FARG_drawPoint_y+0, 0
	MOV FARG_drawPoint_y+1, 1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,537 :: 		} while (x != x1 || y != y1);
	MOV A, Brezenhem_x_L0+0
	XRL A, FARG_Brezenhem_x1+0
	JNZ L__Brezenhem166
	MOV A, Brezenhem_x_L0+1
	XRL A, FARG_Brezenhem_x1+1
L__Brezenhem166:
	JZ #3
	LJMP L_Brezenhem129
	MOV A, Brezenhem_y_L0+0
	XRL A, FARG_Brezenhem_y1+0
	JNZ L__Brezenhem167
	MOV A, Brezenhem_y_L0+1
	XRL A, FARG_Brezenhem_y1+1
L__Brezenhem167:
	JZ #3
	LJMP L_Brezenhem129
L__Brezenhem137:
;ADC.c,538 :: 		}
L_Brezenhem128:
;ADC.c,539 :: 		}
	RET
; end of _Brezenhem

_main:
	MOV SP+0, #128
;ADC.c,541 :: 		void main() {
;ADC.c,544 :: 		int y = 0;
;ADC.c,545 :: 		int x = 0;
;ADC.c,546 :: 		float inputValue = 0;
;ADC.c,547 :: 		float k = 0;
;ADC.c,554 :: 		initSPI();
	LCALL _initSPI+0
;ADC.c,555 :: 		rs232init();
	LCALL _rs232init+0
;ADC.c,557 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,558 :: 		Delay_us(1);
	NOP
;ADC.c,561 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,562 :: 		clear(0, 128);
	MOV FARG_clear_limit_left+0, #0
	MOV FARG_clear_limit_left+1, #0
	MOV FARG_clear_limit_right+0, #128
	MOV FARG_clear_limit_right+1, #0
	LCALL _clear+0
;ADC.c,563 :: 		drawVLine(92);
	MOV FARG_drawVLine_column+0, #92
	MOV FARG_drawVLine_column+1, #0
	LCALL _drawVLine+0
;ADC.c,565 :: 		while(1) {
L_main135:
;ADC.c,566 :: 		drawPoint(1,1,0);
	MOV FARG_drawPoint_x+0, #1
	MOV FARG_drawPoint_x+1, #0
	MOV FARG_drawPoint_y+0, #1
	MOV FARG_drawPoint_y+1, #0
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,567 :: 		drawPoint(1,40,0);
	MOV FARG_drawPoint_x+0, #1
	MOV FARG_drawPoint_x+1, #0
	MOV FARG_drawPoint_y+0, #40
	MOV FARG_drawPoint_y+1, #0
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,568 :: 		Brezenhem(1, 1, 1, 40);
	MOV FARG_Brezenhem_x0+0, #1
	MOV FARG_Brezenhem_x0+1, #0
	MOV FARG_Brezenhem_y0+0, #1
	MOV FARG_Brezenhem_y0+1, #0
	MOV FARG_Brezenhem_x1+0, #1
	MOV FARG_Brezenhem_x1+1, #0
	MOV FARG_Brezenhem_y1+0, #40
	MOV FARG_Brezenhem_y1+1, #0
	LCALL _Brezenhem+0
;ADC.c,601 :: 		}
	SJMP L_main135
;ADC.c,602 :: 		}
	SJMP #254
; end of _main
