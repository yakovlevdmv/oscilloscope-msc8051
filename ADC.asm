
_setXAddress:
;ADC.c,114 :: 		void setXAddress(int x) {
;ADC.c,115 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,116 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,117 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,119 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,121 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,122 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,123 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,125 :: 		void setYAddress(int y) {
;ADC.c,126 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,127 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,128 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,130 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,132 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,133 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,134 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,136 :: 		void setZAddress(int z) {
;ADC.c,137 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,138 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,139 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,141 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,143 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,144 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,145 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,147 :: 		void writeData(char _data) {
;ADC.c,148 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,149 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,150 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,152 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,153 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,154 :: 		}
	RET
; end of _writeData

_readData:
;ADC.c,156 :: 		int readData(int x, int y) {
;ADC.c,157 :: 		int buf = 0;
	MOV readData_buf_L0+0, #0
	MOV readData_buf_L0+1, #0
;ADC.c,158 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_readData_x+1
	MOV readData__cs_L0+0, FARG_readData_x+0
	INC R0
	SJMP L__readData113
L__readData114:
	MOV C, #231
	RRC A
	XCH A, readData__cs_L0+0
	RRC A
	XCH A, readData__cs_L0+0
L__readData113:
	DJNZ R0, L__readData114
	MOV readData__cs_L0+1, A
;ADC.c,159 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,160 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,161 :: 		LCD_RW = 1;
	SETB P2_5_bit+0
;ADC.c,163 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_readData_y+1
	MOV FARG_setXAddress_x+0, FARG_readData_y+0
	INC R0
	SJMP L__readData115
L__readData116:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__readData115:
	DJNZ R0, L__readData116
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,164 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,166 :: 		if (_cs == 0 ) {
	MOV A, readData__cs_L0+0
	ORL A, readData__cs_L0+1
	JNZ L_readData0
;ADC.c,167 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,168 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,169 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_readData_x+0
	MOV FARG_setYAddress_y+1, FARG_readData_x+1
	LCALL _setYAddress+0
;ADC.c,170 :: 		} else {
	SJMP L_readData1
L_readData0:
;ADC.c,171 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,172 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,173 :: 		setYAddress(64 + (x % 64));
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
;ADC.c,174 :: 		}
L_readData1:
;ADC.c,176 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,177 :: 		buf = P0;
	MOV readData_buf_L0+0, PCON+0
	CLR A
	MOV readData_buf_L0+1, A
;ADC.c,178 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,179 :: 		return buf;
	MOV R0, readData_buf_L0+0
	MOV R1, readData_buf_L0+1
;ADC.c,180 :: 		}
	RET
; end of _readData

_displayOn:
;ADC.c,182 :: 		void displayOn() {
;ADC.c,183 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,184 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,185 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,187 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,189 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,190 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,191 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,193 :: 		void drawPoint(int x, int y, int flag) {
;ADC.c,194 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,195 :: 		int limit = 0;
;ADC.c,196 :: 		int mask = 0b00000001;
;ADC.c,197 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint117
L__drawPoint118:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint117:
	DJNZ R0, L__drawPoint118
	MOV drawPoint__cs_L0+1, A
;ADC.c,198 :: 		if (flag == 1) {
	MOV A, #1
	XRL A, FARG_drawPoint_flag+0
	JNZ L__drawPoint119
	MOV A, #0
	XRL A, FARG_drawPoint_flag+1
L__drawPoint119:
	JNZ L_drawPoint2
;ADC.c,199 :: 		mask = 0b00000000;
	MOV drawPoint_mask_L0+0, #0
	MOV drawPoint_mask_L0+1, #0
;ADC.c,200 :: 		}
L_drawPoint2:
;ADC.c,201 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint120
L__drawPoint121:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint120:
	DJNZ R0, L__drawPoint121
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,203 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
	JNZ L_drawPoint3
;ADC.c,204 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,205 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,206 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,207 :: 		} else {
	SJMP L_drawPoint4
L_drawPoint3:
;ADC.c,208 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,209 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,210 :: 		setYAddress(x % 64);
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
;ADC.c,211 :: 		}
L_drawPoint4:
;ADC.c,212 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,213 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,214 :: 		for (count = 0; count < limit - 1; count++) {
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
L_drawPoint5:
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
	JNC L_drawPoint6
;ADC.c,215 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint122
L__drawPoint123:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint122:
	DJNZ R0, L__drawPoint123
	MOV drawPoint_mask_L0+0, A
;ADC.c,214 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,216 :: 		}
	SJMP L_drawPoint5
L_drawPoint6:
;ADC.c,217 :: 		if(y > 0) {
	SETB C
	MOV A, FARG_drawPoint_y+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_drawPoint_y+1
	XRL A, #128
	SUBB A, R0
	JC L_drawPoint8
;ADC.c,218 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint124
L__drawPoint125:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint124:
	DJNZ R0, L__drawPoint125
	MOV drawPoint_mask_L0+0, A
;ADC.c,219 :: 		}
L_drawPoint8:
;ADC.c,220 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,221 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,222 :: 		}
	RET
; end of _drawPoint

_drawMask:
;ADC.c,224 :: 		void drawMask(int x, int y, int mask) {
;ADC.c,225 :: 		int count = 0;
;ADC.c,226 :: 		int limit = 0;
;ADC.c,227 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawMask_x+1
	MOV drawMask__cs_L0+0, FARG_drawMask_x+0
	INC R0
	SJMP L__drawMask126
L__drawMask127:
	MOV C, #231
	RRC A
	XCH A, drawMask__cs_L0+0
	RRC A
	XCH A, drawMask__cs_L0+0
L__drawMask126:
	DJNZ R0, L__drawMask127
	MOV drawMask__cs_L0+1, A
;ADC.c,228 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawMask_y+1
	MOV FARG_setXAddress_x+0, FARG_drawMask_y+0
	INC R0
	SJMP L__drawMask128
L__drawMask129:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawMask128:
	DJNZ R0, L__drawMask129
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,230 :: 		if (_cs == 0 ) {
	MOV A, drawMask__cs_L0+0
	ORL A, drawMask__cs_L0+1
	JNZ L_drawMask9
;ADC.c,231 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,232 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,233 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawMask_x+0
	MOV FARG_setYAddress_y+1, FARG_drawMask_x+1
	LCALL _setYAddress+0
;ADC.c,234 :: 		} else {
	SJMP L_drawMask10
L_drawMask9:
;ADC.c,235 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,236 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,237 :: 		setYAddress(x % 64);
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
;ADC.c,238 :: 		}
L_drawMask10:
;ADC.c,239 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,240 :: 		writeData(mask);
	MOV FARG_writeData__data+0, FARG_drawMask_mask+0
	LCALL _writeData+0
;ADC.c,241 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,242 :: 		}
	RET
; end of _drawMask

_drawVLine:
;ADC.c,244 :: 		void drawVLine(int column) {
;ADC.c,245 :: 		int count = 0;
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
	MOV drawVLine_mask_L0+0, #255
	MOV drawVLine_mask_L0+1, #0
;ADC.c,246 :: 		int mask = 0b11111111;
;ADC.c,247 :: 		int _cs = column / 64;
	MOV R0, #6
	MOV A, FARG_drawVLine_column+1
	MOV drawVLine__cs_L0+0, FARG_drawVLine_column+0
	INC R0
	SJMP L__drawVLine130
L__drawVLine131:
	MOV C, #231
	RRC A
	XCH A, drawVLine__cs_L0+0
	RRC A
	XCH A, drawVLine__cs_L0+0
L__drawVLine130:
	DJNZ R0, L__drawVLine131
	MOV drawVLine__cs_L0+1, A
;ADC.c,249 :: 		for(count = 0; count < 8; count++) {
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
L_drawVLine11:
	CLR C
	MOV A, drawVLine_count_L0+0
	SUBB A, #8
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawVLine_count_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawVLine12
;ADC.c,250 :: 		if (_cs == 0 ) {
	MOV A, drawVLine__cs_L0+0
	ORL A, drawVLine__cs_L0+1
	JNZ L_drawVLine14
;ADC.c,251 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,252 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,253 :: 		setYAddress(column);
	MOV FARG_setYAddress_y+0, FARG_drawVLine_column+0
	MOV FARG_setYAddress_y+1, FARG_drawVLine_column+1
	LCALL _setYAddress+0
;ADC.c,254 :: 		} else {
	SJMP L_drawVLine15
L_drawVLine14:
;ADC.c,255 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,256 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,257 :: 		setYAddress(column % 64);
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
;ADC.c,258 :: 		}
L_drawVLine15:
;ADC.c,259 :: 		setXAddress(count);
	MOV FARG_setXAddress_x+0, drawVLine_count_L0+0
	MOV FARG_setXAddress_x+1, drawVLine_count_L0+1
	LCALL _setXAddress+0
;ADC.c,260 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,261 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawVLine_mask_L0+0
	LCALL _writeData+0
;ADC.c,249 :: 		for(count = 0; count < 8; count++) {
	MOV A, #1
	ADD A, drawVLine_count_L0+0
	MOV drawVLine_count_L0+0, A
	MOV A, #0
	ADDC A, drawVLine_count_L0+1
	MOV drawVLine_count_L0+1, A
;ADC.c,262 :: 		}
	SJMP L_drawVLine11
L_drawVLine12:
;ADC.c,264 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,265 :: 		}
	RET
; end of _drawVLine

_resetPoint:
;ADC.c,267 :: 		void resetPoint(int x, int y) {
;ADC.c,268 :: 		int mask = 0b00000000;
	MOV resetPoint_mask_L0+0, #0
	MOV resetPoint_mask_L0+1, #0
;ADC.c,269 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_resetPoint_x+1
	MOV resetPoint__cs_L0+0, FARG_resetPoint_x+0
	INC R0
	SJMP L__resetPoint132
L__resetPoint133:
	MOV C, #231
	RRC A
	XCH A, resetPoint__cs_L0+0
	RRC A
	XCH A, resetPoint__cs_L0+0
L__resetPoint132:
	DJNZ R0, L__resetPoint133
	MOV resetPoint__cs_L0+1, A
;ADC.c,270 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_resetPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_resetPoint_y+0
	INC R0
	SJMP L__resetPoint134
L__resetPoint135:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__resetPoint134:
	DJNZ R0, L__resetPoint135
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,272 :: 		if (_cs == 0 ) {
	MOV A, resetPoint__cs_L0+0
	ORL A, resetPoint__cs_L0+1
	JNZ L_resetPoint16
;ADC.c,273 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,274 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,275 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_resetPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_resetPoint_x+1
	LCALL _setYAddress+0
;ADC.c,276 :: 		} else {
	SJMP L_resetPoint17
L_resetPoint16:
;ADC.c,277 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,278 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,279 :: 		setYAddress(x % 64);
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
;ADC.c,280 :: 		}
L_resetPoint17:
;ADC.c,281 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,282 :: 		writeData(mask);
	MOV FARG_writeData__data+0, resetPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,283 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,284 :: 		}
	RET
; end of _resetPoint

_clear:
;ADC.c,286 :: 		int clear(int limit_left, int limit_right) {
;ADC.c,288 :: 		if (limit_left >= limit_right) return -1;
	CLR C
	MOV A, FARG_clear_limit_left+0
	SUBB A, FARG_clear_limit_right+0
	MOV A, FARG_clear_limit_right+1
	XRL A, #128
	MOV R0, A
	MOV A, FARG_clear_limit_left+1
	XRL A, #128
	SUBB A, R0
	JC L_clear18
	MOV R0, #255
	MOV R1, #255
	RET
L_clear18:
;ADC.c,290 :: 		for(x = limit_left; x < limit_right; x++) {
	MOV clear_x_L0+0, FARG_clear_limit_left+0
	MOV clear_x_L0+1, FARG_clear_limit_left+1
L_clear19:
	CLR C
	MOV A, clear_x_L0+0
	SUBB A, FARG_clear_limit_right+0
	MOV A, FARG_clear_limit_right+1
	XRL A, #128
	MOV R0, A
	MOV A, clear_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clear20
;ADC.c,291 :: 		for(y = 0; y <=64; y=y+8) {
	MOV clear_y_L0+0, #0
	MOV clear_y_L0+1, #0
L_clear22:
	SETB C
	MOV A, clear_y_L0+0
	SUBB A, #64
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, clear_y_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clear23
;ADC.c,292 :: 		drawPoint(x, y, 1);
	MOV FARG_drawPoint_x+0, clear_x_L0+0
	MOV FARG_drawPoint_x+1, clear_x_L0+1
	MOV FARG_drawPoint_y+0, clear_y_L0+0
	MOV FARG_drawPoint_y+1, clear_y_L0+1
	MOV FARG_drawPoint_flag+0, #1
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,291 :: 		for(y = 0; y <=64; y=y+8) {
	MOV A, #8
	ADD A, clear_y_L0+0
	MOV clear_y_L0+0, A
	MOV A, #0
	ADDC A, clear_y_L0+1
	MOV clear_y_L0+1, A
;ADC.c,293 :: 		}
	SJMP L_clear22
L_clear23:
;ADC.c,290 :: 		for(x = limit_left; x < limit_right; x++) {
	MOV A, #1
	ADD A, clear_x_L0+0
	MOV clear_x_L0+0, A
	MOV A, #0
	ADDC A, clear_x_L0+1
	MOV clear_x_L0+1, A
;ADC.c,294 :: 		}
	SJMP L_clear19
L_clear20:
;ADC.c,295 :: 		return 0;
	MOV R0, #0
	MOV R1, #0
;ADC.c,296 :: 		}
	RET
; end of _clear

_initSPI:
;ADC.c,304 :: 		void initSPI() {
;ADC.c,305 :: 		SPCR = 0b01010001;
	MOV SPCR+0, #81
;ADC.c,306 :: 		}
	RET
; end of _initSPI

_rs232init:
;ADC.c,308 :: 		void rs232init() {
;ADC.c,309 :: 		PCON = 0x80;
	MOV PCON+0, #128
;ADC.c,310 :: 		TMOD = 0x022;
	MOV TMOD+0, #34
;ADC.c,311 :: 		TCON = 0x40;
	MOV TCON+0, #64
;ADC.c,312 :: 		SCON = 0x50;
	MOV SCON+0, #80
;ADC.c,313 :: 		TH1 = 0x0F5;
	MOV TH1+0, #245
;ADC.c,314 :: 		P3 = 0x003;
	MOV P3+0, #3
;ADC.c,315 :: 		TR1_bit=1;
	SETB TR1_bit+0
;ADC.c,316 :: 		}
	RET
; end of _rs232init

_transmit:
;ADC.c,318 :: 		void transmit(char b) {
;ADC.c,319 :: 		SBUF = b;
	MOV SBUF+0, FARG_transmit_b+0
;ADC.c,320 :: 		while(TI_bit == 0) {}
L_transmit25:
	JB TI_bit+0, L_transmit26
	NOP
	SJMP L_transmit25
L_transmit26:
;ADC.c,321 :: 		TI_bit = 0;
	CLR TI_bit+0
;ADC.c,323 :: 		}
	RET
; end of _transmit

_transmitString:
;ADC.c,325 :: 		void transmitString(char* str) {
;ADC.c,326 :: 		char *p = &str[0];
	MOV transmitString_p_L0+0, FARG_transmitString_str+0
;ADC.c,328 :: 		while (*p) {
L_transmitString27:
	MOV R0, transmitString_p_L0+0
	MOV A, @R0
	JZ L_transmitString28
;ADC.c,329 :: 		transmit(*(p++));
	MOV R0, transmitString_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC transmitString_p_L0+0
;ADC.c,330 :: 		}
	SJMP L_transmitString27
L_transmitString28:
;ADC.c,331 :: 		}
	RET
; end of _transmitString

_writeSPI:
;ADC.c,333 :: 		void writeSPI(int _data) {
;ADC.c,334 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,335 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,338 :: 		int readSPI() {
;ADC.c,340 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, R6+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,341 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,342 :: 		}
	RET
; end of _readSPI

_delay:
;ADC.c,344 :: 		void delay() {
;ADC.c,345 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,346 :: 		}
	RET
; end of _delay

_adc_get_data:
;ADC.c,348 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,350 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,351 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data29
;ADC.c,352 :: 		SPI_init_data += 0b00000000;
;ADC.c,353 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data30
L_adc_get_data29:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data136
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data136:
	JNZ L_adc_get_data31
;ADC.c,354 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,355 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data32
L_adc_get_data31:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data137
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data137:
	JNZ L_adc_get_data33
;ADC.c,356 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,357 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data34
L_adc_get_data33:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data138
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data138:
	JNZ L_adc_get_data35
;ADC.c,358 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,359 :: 		}
L_adc_get_data35:
L_adc_get_data34:
L_adc_get_data32:
L_adc_get_data30:
;ADC.c,360 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,361 :: 		CS = 0;
	CLR P2_0_bit+0
;ADC.c,364 :: 		writeSPI(SPI_init_data);
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,365 :: 		while(SPIF_bit != 1) {}
L_adc_get_data36:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data37
	NOP
	SJMP L_adc_get_data36
L_adc_get_data37:
;ADC.c,366 :: 		_data.first = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,368 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,369 :: 		while(SPIF_bit != 1) {}
L_adc_get_data38:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data39
	NOP
	SJMP L_adc_get_data38
L_adc_get_data39:
;ADC.c,370 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,372 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,373 :: 		while(SPIF_bit != 1) {}
L_adc_get_data40:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data41
	NOP
	SJMP L_adc_get_data40
L_adc_get_data41:
;ADC.c,374 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,376 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,378 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data42:
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
	JNZ L_adc_get_data42
	MOV ?lstr_1_ADC+0, adc_get_data__data_L0+0
	MOV ?lstr_1_ADC+1, adc_get_data__data_L0+1
;ADC.c,379 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,381 :: 		int getBit(int position, int byte) {
;ADC.c,382 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit139
L__getBit140:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit139:
	DJNZ R2, L__getBit140
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,383 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,385 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,386 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,387 :: 		int i = 0;
;ADC.c,389 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,391 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue43:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue44
;ADC.c,392 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue141
L__parseADCValue142:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue141:
	DJNZ R0, L__parseADCValue142
	MOV parseADCValue_result_L0+0, A
;ADC.c,393 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,391 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,394 :: 		}
	SJMP L_parseADCValue43
L_parseADCValue44:
;ADC.c,396 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue46:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue47
;ADC.c,397 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue143
L__parseADCValue144:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue143:
	DJNZ R0, L__parseADCValue144
	MOV parseADCValue_result_L0+0, A
;ADC.c,398 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,396 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,399 :: 		}
	SJMP L_parseADCValue46
L_parseADCValue47:
;ADC.c,401 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,402 :: 		}
	RET
; end of _parseADCValue

_getInputValue:
;ADC.c,404 :: 		float getInputValue(int _data) {
;ADC.c,405 :: 		return 4.096 * _data / 4096;
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
;ADC.c,406 :: 		}
	RET
; end of _getInputValue

_getGain:
;ADC.c,408 :: 		float getGain(int _data) {
;ADC.c,409 :: 		return 2. * (_data / 1000.);
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
;ADC.c,410 :: 		}
	RET
; end of _getGain

_strConstCpy:
;ADC.c,424 :: 		void strConstCpy(char *dest, const char *source) {
;ADC.c,425 :: 		while(*source) {
L_strConstCpy49:
	MOV 130, FARG_strConstCpy_source+0
	MOV 131, FARG_strConstCpy_source+1
	CLR A
	MOVC A, @A+DPTR
	MOV R0, A
	JZ L_strConstCpy50
;ADC.c,426 :: 		*dest++ = *source++;
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
;ADC.c,427 :: 		}
	SJMP L_strConstCpy49
L_strConstCpy50:
;ADC.c,428 :: 		*dest = 0 ;
	MOV R0, FARG_strConstCpy_dest+0
	MOV @R0, #0
;ADC.c,429 :: 		}
	RET
; end of _strConstCpy

_drawHighValue:
;ADC.c,431 :: 		void drawHighValue(int number) {
;ADC.c,435 :: 		IntToStr(number, numBuffer);
	MOV FARG_IntToStr_input+0, FARG_drawHighValue_number+0
	MOV FARG_IntToStr_input+1, FARG_drawHighValue_number+1
	MOV FARG_IntToStr_output+0, #drawHighValue_numBuffer_L0+0
	LCALL _IntToStr+0
;ADC.c,439 :: 		p = &numBuffer[0];
	MOV drawHighValue_p_L0+0, #drawHighValue_numBuffer_L0+0
;ADC.c,440 :: 		x = 95;
	MOV drawHighValue_x_L0+0, #95
	MOV drawHighValue_x_L0+1, #0
;ADC.c,441 :: 		while (*p) {
L_drawHighValue51:
	MOV R0, drawHighValue_p_L0+0
	MOV A, @R0
	JNZ #3
	LJMP L_drawHighValue52
;ADC.c,443 :: 		if(*p == '9') {
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #57
	JNZ L_drawHighValue53
;ADC.c,444 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue54:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue55
;ADC.c,445 :: 		drawMask(x, 8, Calibri6x7[7 * 9 + i]);
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
;ADC.c,446 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,444 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,447 :: 		}
	SJMP L_drawHighValue54
L_drawHighValue55:
;ADC.c,449 :: 		} else if (*p == '8') {
	LJMP L_drawHighValue57
L_drawHighValue53:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #56
	JNZ L_drawHighValue58
;ADC.c,450 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue59:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue60
;ADC.c,451 :: 		drawMask(x, 8, Calibri6x7[7 * 8 + i]);
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
;ADC.c,452 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,450 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,453 :: 		}
	SJMP L_drawHighValue59
L_drawHighValue60:
;ADC.c,454 :: 		}  else if (*p == '7') {
	LJMP L_drawHighValue62
L_drawHighValue58:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #55
	JNZ L_drawHighValue63
;ADC.c,455 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue64:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue65
;ADC.c,456 :: 		drawMask(x, 8, Calibri6x7[7 * 7 + i]);
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
;ADC.c,457 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,455 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,458 :: 		}
	SJMP L_drawHighValue64
L_drawHighValue65:
;ADC.c,459 :: 		} else if (*p == '6') {
	LJMP L_drawHighValue67
L_drawHighValue63:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #54
	JNZ L_drawHighValue68
;ADC.c,460 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue69:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue70
;ADC.c,461 :: 		drawMask(x, 8, Calibri6x7[7 * 6 + i]);
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
;ADC.c,462 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,460 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,463 :: 		}
	SJMP L_drawHighValue69
L_drawHighValue70:
;ADC.c,464 :: 		} else if (*p == '5') {
	LJMP L_drawHighValue72
L_drawHighValue68:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #53
	JNZ L_drawHighValue73
;ADC.c,465 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue74:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue75
;ADC.c,466 :: 		drawMask(x, 8, Calibri6x7[7 * 5 + i]);
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
;ADC.c,467 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,465 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,468 :: 		}
	SJMP L_drawHighValue74
L_drawHighValue75:
;ADC.c,469 :: 		} else if (*p == '4') {
	LJMP L_drawHighValue77
L_drawHighValue73:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #52
	JNZ L_drawHighValue78
;ADC.c,470 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue79:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue80
;ADC.c,471 :: 		drawMask(x, 8, Calibri6x7[7 * 4 + i]);
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
;ADC.c,472 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,470 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,473 :: 		}
	SJMP L_drawHighValue79
L_drawHighValue80:
;ADC.c,474 :: 		} else if (*p == '3') {
	LJMP L_drawHighValue82
L_drawHighValue78:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #51
	JNZ L_drawHighValue83
;ADC.c,475 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue84:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue85
;ADC.c,476 :: 		drawMask(x, 8, Calibri6x7[7 * 3 + i]);
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
;ADC.c,477 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,475 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,478 :: 		}
	SJMP L_drawHighValue84
L_drawHighValue85:
;ADC.c,479 :: 		} else if (*p == '2') {
	LJMP L_drawHighValue87
L_drawHighValue83:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #50
	JNZ L_drawHighValue88
;ADC.c,480 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue89:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue90
;ADC.c,481 :: 		drawMask(x, 8, Calibri6x7[7 * 2 + i]);
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
;ADC.c,482 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,480 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,483 :: 		}
	SJMP L_drawHighValue89
L_drawHighValue90:
;ADC.c,484 :: 		} else if (*p == '1') {
	LJMP L_drawHighValue92
L_drawHighValue88:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #49
	JNZ L_drawHighValue93
;ADC.c,485 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue94:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue95
;ADC.c,486 :: 		drawMask(x, 8, Calibri6x7[7 * 1 + i]);
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
;ADC.c,487 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,485 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,488 :: 		}
	SJMP L_drawHighValue94
L_drawHighValue95:
;ADC.c,489 :: 		} else if (*p == '0') {
	SJMP L_drawHighValue97
L_drawHighValue93:
	MOV R0, drawHighValue_p_L0+0
	MOV 1, @R0
	MOV A, R1
	XRL A, #48
	JNZ L_drawHighValue98
;ADC.c,490 :: 		for(i = 0; i < 7; i++) {
	MOV drawHighValue_i_L0+0, #0
	MOV drawHighValue_i_L0+1, #0
L_drawHighValue99:
	CLR C
	MOV A, drawHighValue_i_L0+0
	SUBB A, #7
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawHighValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawHighValue100
;ADC.c,491 :: 		drawMask(x, 8, Calibri6x7[7 * 0 + i]);
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
;ADC.c,492 :: 		x = x + 1;
	MOV A, #1
	ADD A, drawHighValue_x_L0+0
	MOV drawHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_x_L0+1
	MOV drawHighValue_x_L0+1, A
;ADC.c,490 :: 		for(i = 0; i < 7; i++) {
	MOV A, #1
	ADD A, drawHighValue_i_L0+0
	MOV drawHighValue_i_L0+0, A
	MOV A, #0
	ADDC A, drawHighValue_i_L0+1
	MOV drawHighValue_i_L0+1, A
;ADC.c,493 :: 		}
	SJMP L_drawHighValue99
L_drawHighValue100:
;ADC.c,494 :: 		}
L_drawHighValue98:
L_drawHighValue97:
L_drawHighValue92:
L_drawHighValue87:
L_drawHighValue82:
L_drawHighValue77:
L_drawHighValue72:
L_drawHighValue67:
L_drawHighValue62:
L_drawHighValue57:
;ADC.c,495 :: 		transmit(*(p++));
	MOV R0, drawHighValue_p_L0+0
	MOV FARG_transmit_b+0, @R0
	LCALL _transmit+0
	INC drawHighValue_p_L0+0
;ADC.c,496 :: 		}
	LJMP L_drawHighValue51
L_drawHighValue52:
;ADC.c,497 :: 		}
	RET
; end of _drawHighValue

_clearHighValue:
;ADC.c,499 :: 		void clearHighValue() {
;ADC.c,501 :: 		for(x = 95; x < 128; x++) {
	MOV clearHighValue_x_L0+0, #95
	MOV clearHighValue_x_L0+1, #0
L_clearHighValue102:
	CLR C
	MOV A, clearHighValue_x_L0+0
	SUBB A, #128
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, clearHighValue_x_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clearHighValue103
;ADC.c,502 :: 		drawMask(x, 8, 0b00000000);
	MOV FARG_drawMask_x+0, clearHighValue_x_L0+0
	MOV FARG_drawMask_x+1, clearHighValue_x_L0+1
	MOV FARG_drawMask_y+0, #8
	MOV FARG_drawMask_y+1, #0
	MOV FARG_drawMask_mask+0, #0
	MOV FARG_drawMask_mask+1, #0
	LCALL _drawMask+0
;ADC.c,501 :: 		for(x = 95; x < 128; x++) {
	MOV A, #1
	ADD A, clearHighValue_x_L0+0
	MOV clearHighValue_x_L0+0, A
	MOV A, #0
	ADDC A, clearHighValue_x_L0+1
	MOV clearHighValue_x_L0+1, A
;ADC.c,504 :: 		}
	SJMP L_clearHighValue102
L_clearHighValue103:
;ADC.c,505 :: 		}
	RET
; end of _clearHighValue

_drawLine:
;ADC.c,507 :: 		void drawLine(int x0, int x1, int y0, int y1) {
;ADC.c,509 :: 		deltax = abs(x1 - x0); //9
	CLR C
	MOV A, FARG_drawLine_x1+0
	SUBB A, FARG_drawLine_x0+0
	MOV FARG_abs_a+0, A
	MOV A, FARG_drawLine_x1+1
	SUBB A, FARG_drawLine_x0+1
	MOV FARG_abs_a+1, A
	LCALL _abs+0
	MOV drawLine_deltax_L0+0, 0
	MOV drawLine_deltax_L0+1, 1
;ADC.c,510 :: 		deltay = abs(y1 - y0); //3
	CLR C
	MOV A, FARG_drawLine_y1+0
	SUBB A, FARG_drawLine_y0+0
	MOV FARG_abs_a+0, A
	MOV A, FARG_drawLine_y1+1
	SUBB A, FARG_drawLine_y0+1
	MOV FARG_abs_a+1, A
	LCALL _abs+0
;ADC.c,511 :: 		error = 0;
	MOV drawLine_error_L0+0, #0
	MOV drawLine_error_L0+1, #0
;ADC.c,512 :: 		deltaerr = deltay;     //3
	MOV drawLine_deltaerr_L0+0, 0
	MOV drawLine_deltaerr_L0+1, 1
;ADC.c,513 :: 		y = y0;                //1
	MOV drawLine_y_L0+0, FARG_drawLine_y0+0
	MOV drawLine_y_L0+1, FARG_drawLine_y0+1
;ADC.c,514 :: 		diry = y1 - y0;        //3
	CLR C
	MOV A, FARG_drawLine_y1+0
	SUBB A, FARG_drawLine_y0+0
	MOV R1, A
	MOV A, FARG_drawLine_y1+1
	SUBB A, FARG_drawLine_y0+1
	MOV R2, A
	MOV drawLine_diry_L0+0, 1
	MOV drawLine_diry_L0+1, 2
;ADC.c,515 :: 		if (diry > 0)
	SETB C
	MOV A, R1
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, R2
	XRL A, #128
	SUBB A, R0
	JC L_drawLine105
;ADC.c,516 :: 		diry = 1;          //1
	MOV drawLine_diry_L0+0, #1
	MOV drawLine_diry_L0+1, #0
L_drawLine105:
;ADC.c,517 :: 		if (diry < 0)
	CLR C
	MOV A, drawLine_diry_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, drawLine_diry_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_drawLine106
;ADC.c,518 :: 		diry = -1;
	MOV drawLine_diry_L0+0, #255
	MOV drawLine_diry_L0+1, #255
L_drawLine106:
;ADC.c,519 :: 		for (x = x0; x < x1; x++) {//ot 1 do 10
	MOV drawLine_x_L0+0, FARG_drawLine_x0+0
	MOV drawLine_x_L0+1, FARG_drawLine_x0+1
L_drawLine107:
	CLR C
	MOV A, drawLine_x_L0+0
	SUBB A, FARG_drawLine_x1+0
	MOV A, FARG_drawLine_x1+1
	XRL A, #128
	MOV R0, A
	MOV A, drawLine_x_L0+1
	XRL A, #128
	SUBB A, R0
	JC #3
	LJMP L_drawLine108
;ADC.c,520 :: 		drawPoint(x, y, 0);     //       1,1 | 2,1 |
	MOV FARG_drawPoint_x+0, drawLine_x_L0+0
	MOV FARG_drawPoint_x+1, drawLine_x_L0+1
	MOV FARG_drawPoint_y+0, drawLine_y_L0+0
	MOV FARG_drawPoint_y+1, drawLine_y_L0+1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,521 :: 		Delay_ms(1000);
	MOV R5, 7
	MOV R6, 86
	MOV R7, 60
	DJNZ R7, 
	DJNZ R6, 
	DJNZ R5, 
;ADC.c,522 :: 		error = error + deltaerr;     //  3  |  6  |
	MOV A, drawLine_error_L0+0
	ADD A, drawLine_deltaerr_L0+0
	MOV R3, A
	MOV A, drawLine_error_L0+1
	ADDC A, drawLine_deltaerr_L0+1
	MOV R4, A
	MOV drawLine_error_L0+0, 3
	MOV drawLine_error_L0+1, 4
;ADC.c,523 :: 		if (2 * error >= deltax) {    //  -  |  +  |
	MOV R0, #1
	MOV R2, 4
	MOV A, R3
	INC R0
	SJMP L__drawLine145
L__drawLine146:
	CLR C
	RLC A
	XCH A, R2
	RLC A
	XCH A, R2
L__drawLine145:
	DJNZ R0, L__drawLine146
	MOV R1, A
	CLR C
	MOV A, R1
	SUBB A, drawLine_deltax_L0+0
	MOV A, drawLine_deltax_L0+1
	XRL A, #128
	MOV R0, A
	MOV A, R2
	XRL A, #128
	SUBB A, R0
	JC L_drawLine110
;ADC.c,524 :: 		y = y + diry;            //     |
	MOV A, drawLine_y_L0+0
	ADD A, drawLine_diry_L0+0
	MOV drawLine_y_L0+0, A
	MOV A, drawLine_y_L0+1
	ADDC A, drawLine_diry_L0+1
	MOV drawLine_y_L0+1, A
;ADC.c,525 :: 		error = error - deltax;   //     |
	CLR C
	MOV A, drawLine_error_L0+0
	SUBB A, drawLine_deltax_L0+0
	MOV drawLine_error_L0+0, A
	MOV A, drawLine_error_L0+1
	SUBB A, drawLine_deltax_L0+1
	MOV drawLine_error_L0+1, A
;ADC.c,526 :: 		}
L_drawLine110:
;ADC.c,519 :: 		for (x = x0; x < x1; x++) {//ot 1 do 10
	MOV A, #1
	ADD A, drawLine_x_L0+0
	MOV drawLine_x_L0+0, A
	MOV A, #0
	ADDC A, drawLine_x_L0+1
	MOV drawLine_x_L0+1, A
;ADC.c,527 :: 		}
	LJMP L_drawLine107
L_drawLine108:
;ADC.c,529 :: 		}
	RET
; end of _drawLine

_main:
	MOV SP+0, #128
;ADC.c,531 :: 		void main() {
;ADC.c,534 :: 		int y = 0;
;ADC.c,535 :: 		int x = 0;
;ADC.c,536 :: 		float f = 0;
;ADC.c,538 :: 		initSPI();
	LCALL _initSPI+0
;ADC.c,539 :: 		rs232init();
	LCALL _rs232init+0
;ADC.c,541 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,542 :: 		Delay_us(1);
	NOP
;ADC.c,545 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,546 :: 		clear(0, 128);
	MOV FARG_clear_limit_left+0, #0
	MOV FARG_clear_limit_left+1, #0
	MOV FARG_clear_limit_right+0, #128
	MOV FARG_clear_limit_right+1, #0
	LCALL _clear+0
;ADC.c,550 :: 		drawPoint(1, 1,0);
	MOV FARG_drawPoint_x+0, #1
	MOV FARG_drawPoint_x+1, #0
	MOV FARG_drawPoint_y+0, #1
	MOV FARG_drawPoint_y+1, #0
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,552 :: 		drawPoint(10, 10,0);
	MOV FARG_drawPoint_x+0, #10
	MOV FARG_drawPoint_x+1, #0
	MOV FARG_drawPoint_y+0, #10
	MOV FARG_drawPoint_y+1, #0
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,554 :: 		drawLine(1,10,1,11);
	MOV FARG_drawLine_x0+0, #1
	MOV FARG_drawLine_x0+1, #0
	MOV FARG_drawLine_x1+0, #10
	MOV FARG_drawLine_x1+1, #0
	MOV FARG_drawLine_y0+0, #1
	MOV FARG_drawLine_y0+1, #0
	MOV FARG_drawLine_y1+0, #11
	MOV FARG_drawLine_y1+1, #0
	LCALL _drawLine+0
;ADC.c,557 :: 		while(1) {
L_main111:
;ADC.c,572 :: 		}
	SJMP L_main111
;ADC.c,573 :: 		}
	SJMP #254
; end of _main
