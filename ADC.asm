
_setXAddress:
;ADC.c,41 :: 		void setXAddress(int x) {
;ADC.c,42 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,43 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,44 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,46 :: 		x = x + 0b10111000;
	MOV A, #184
	ADD A, FARG_setXAddress_x+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setXAddress_x+1
	MOV R1, A
	MOV FARG_setXAddress_x+0, 0
	MOV FARG_setXAddress_x+1, 1
;ADC.c,48 :: 		P0 = x;
	MOV P0+0, 0
;ADC.c,49 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,50 :: 		}
	RET
; end of _setXAddress

_setYAddress:
;ADC.c,52 :: 		void setYAddress(int y) {
;ADC.c,53 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,54 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,55 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,57 :: 		y = y + 0b01000000;
	MOV A, #64
	ADD A, FARG_setYAddress_y+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setYAddress_y+1
	MOV R1, A
	MOV FARG_setYAddress_y+0, 0
	MOV FARG_setYAddress_y+1, 1
;ADC.c,59 :: 		P0 = y;
	MOV P0+0, 0
;ADC.c,60 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,61 :: 		}
	RET
; end of _setYAddress

_setZAddress:
;ADC.c,63 :: 		void setZAddress(int z) {
;ADC.c,64 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,65 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,66 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,68 :: 		z = z + 0b11000000;
	MOV A, #192
	ADD A, FARG_setZAddress_z+0
	MOV R0, A
	MOV A, #0
	ADDC A, FARG_setZAddress_z+1
	MOV R1, A
	MOV FARG_setZAddress_z+0, 0
	MOV FARG_setZAddress_z+1, 1
;ADC.c,70 :: 		P0 = z;
	MOV P0+0, 0
;ADC.c,71 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,72 :: 		}
	RET
; end of _setZAddress

_writeData:
;ADC.c,74 :: 		void writeData(char _data) {
;ADC.c,75 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,76 :: 		LCD_RS = 1;
	SETB P2_4_bit+0
;ADC.c,77 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,79 :: 		P0 = _data;
	MOV P0+0, FARG_writeData__data+0
;ADC.c,80 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,81 :: 		}
	RET
; end of _writeData

_displayOn:
;ADC.c,83 :: 		void displayOn() {
;ADC.c,84 :: 		LCD_EN = 1;
	SETB P2_6_bit+0
;ADC.c,85 :: 		LCD_RS = 0;
	CLR P2_4_bit+0
;ADC.c,86 :: 		LCD_RW = 0;
	CLR P2_5_bit+0
;ADC.c,88 :: 		P0 = 0x3f;
	MOV P0+0, #63
;ADC.c,90 :: 		LCD_CS1B=0;
	CLR P2_2_bit+0
;ADC.c,91 :: 		LCD_CS2B=0;
	CLR P2_3_bit+0
;ADC.c,92 :: 		}
	RET
; end of _displayOn

_drawPoint:
;ADC.c,94 :: 		void drawPoint(int x, int y, int flag) {
;ADC.c,95 :: 		int count = 0;
	MOV drawPoint_count_L0+0, #0
	MOV drawPoint_count_L0+1, #0
	MOV drawPoint_limit_L0+0, #0
	MOV drawPoint_limit_L0+1, #0
	MOV drawPoint_mask_L0+0, #1
	MOV drawPoint_mask_L0+1, #0
;ADC.c,96 :: 		int limit = 0;
;ADC.c,97 :: 		int mask = 0b00000001;
;ADC.c,98 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawPoint_x+1
	MOV drawPoint__cs_L0+0, FARG_drawPoint_x+0
	INC R0
	SJMP L__drawPoint78
L__drawPoint79:
	MOV C, #231
	RRC A
	XCH A, drawPoint__cs_L0+0
	RRC A
	XCH A, drawPoint__cs_L0+0
L__drawPoint78:
	DJNZ R0, L__drawPoint79
	MOV drawPoint__cs_L0+1, A
;ADC.c,99 :: 		if (flag == 1) {
	MOV A, #1
	XRL A, FARG_drawPoint_flag+0
	JNZ L__drawPoint80
	MOV A, #0
	XRL A, FARG_drawPoint_flag+1
L__drawPoint80:
	JNZ L_drawPoint0
;ADC.c,100 :: 		mask = 0b00000000;
	MOV drawPoint_mask_L0+0, #0
	MOV drawPoint_mask_L0+1, #0
;ADC.c,101 :: 		}
L_drawPoint0:
;ADC.c,102 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawPoint_y+1
	MOV FARG_setXAddress_x+0, FARG_drawPoint_y+0
	INC R0
	SJMP L__drawPoint81
L__drawPoint82:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawPoint81:
	DJNZ R0, L__drawPoint82
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,104 :: 		if (_cs == 0 ) {
	MOV A, drawPoint__cs_L0+0
	ORL A, drawPoint__cs_L0+1
	JNZ L_drawPoint1
;ADC.c,105 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,106 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,107 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawPoint_x+0
	MOV FARG_setYAddress_y+1, FARG_drawPoint_x+1
	LCALL _setYAddress+0
;ADC.c,108 :: 		} else {
	SJMP L_drawPoint2
L_drawPoint1:
;ADC.c,109 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,110 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,111 :: 		setYAddress(x % 64);
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
;ADC.c,112 :: 		}
L_drawPoint2:
;ADC.c,113 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,114 :: 		limit = y % 8;
	MOV R4, #8
	MOV R5, #0
	MOV R0, FARG_drawPoint_y+0
	MOV R1, FARG_drawPoint_y+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV drawPoint_limit_L0+0, 0
	MOV drawPoint_limit_L0+1, 1
;ADC.c,115 :: 		for (count = 0; count < limit - 1; count++) {
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
;ADC.c,116 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint83
L__drawPoint84:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint83:
	DJNZ R0, L__drawPoint84
	MOV drawPoint_mask_L0+0, A
;ADC.c,115 :: 		for (count = 0; count < limit - 1; count++) {
	MOV A, #1
	ADD A, drawPoint_count_L0+0
	MOV drawPoint_count_L0+0, A
	MOV A, #0
	ADDC A, drawPoint_count_L0+1
	MOV drawPoint_count_L0+1, A
;ADC.c,117 :: 		}
	SJMP L_drawPoint3
L_drawPoint4:
;ADC.c,118 :: 		if(y > 0) {
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
;ADC.c,119 :: 		mask = mask << 1;
	MOV R0, #1
	MOV A, drawPoint_mask_L0+0
	INC R0
	SJMP L__drawPoint85
L__drawPoint86:
	CLR C
	RLC A
	XCH A, drawPoint_mask_L0+1
	RLC A
	XCH A, drawPoint_mask_L0+1
L__drawPoint85:
	DJNZ R0, L__drawPoint86
	MOV drawPoint_mask_L0+0, A
;ADC.c,120 :: 		}
L_drawPoint6:
;ADC.c,121 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawPoint_mask_L0+0
	LCALL _writeData+0
;ADC.c,122 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,123 :: 		}
	RET
; end of _drawPoint

_drawMask:
;ADC.c,125 :: 		void drawMask(int x, int y, int mask) {
;ADC.c,126 :: 		int _cs = x / 64;
	MOV R0, #6
	MOV A, FARG_drawMask_x+1
	MOV drawMask__cs_L0+0, FARG_drawMask_x+0
	INC R0
	SJMP L__drawMask87
L__drawMask88:
	MOV C, #231
	RRC A
	XCH A, drawMask__cs_L0+0
	RRC A
	XCH A, drawMask__cs_L0+0
L__drawMask87:
	DJNZ R0, L__drawMask88
	MOV drawMask__cs_L0+1, A
;ADC.c,127 :: 		setXAddress(y/8);
	MOV R0, #3
	MOV A, FARG_drawMask_y+1
	MOV FARG_setXAddress_x+0, FARG_drawMask_y+0
	INC R0
	SJMP L__drawMask89
L__drawMask90:
	MOV C, #231
	RRC A
	XCH A, FARG_setXAddress_x+0
	RRC A
	XCH A, FARG_setXAddress_x+0
L__drawMask89:
	DJNZ R0, L__drawMask90
	MOV FARG_setXAddress_x+1, A
	LCALL _setXAddress+0
;ADC.c,129 :: 		if (_cs == 0 ) {
	MOV A, drawMask__cs_L0+0
	ORL A, drawMask__cs_L0+1
	JNZ L_drawMask7
;ADC.c,130 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,131 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,132 :: 		setYAddress(x);
	MOV FARG_setYAddress_y+0, FARG_drawMask_x+0
	MOV FARG_setYAddress_y+1, FARG_drawMask_x+1
	LCALL _setYAddress+0
;ADC.c,133 :: 		} else {
	SJMP L_drawMask8
L_drawMask7:
;ADC.c,134 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,135 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,136 :: 		setYAddress(x % 64);
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
;ADC.c,137 :: 		}
L_drawMask8:
;ADC.c,138 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,139 :: 		writeData(mask);
	MOV FARG_writeData__data+0, FARG_drawMask_mask+0
	LCALL _writeData+0
;ADC.c,140 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,141 :: 		}
	RET
; end of _drawMask

_drawVLine:
;ADC.c,143 :: 		void drawVLine(int column) {
;ADC.c,144 :: 		int count = 0;
	MOV drawVLine_count_L0+0, #0
	MOV drawVLine_count_L0+1, #0
	MOV drawVLine_mask_L0+0, #255
	MOV drawVLine_mask_L0+1, #0
;ADC.c,145 :: 		int mask = 0b11111111;
;ADC.c,146 :: 		int _cs = column / 64;
	MOV R0, #6
	MOV A, FARG_drawVLine_column+1
	MOV drawVLine__cs_L0+0, FARG_drawVLine_column+0
	INC R0
	SJMP L__drawVLine91
L__drawVLine92:
	MOV C, #231
	RRC A
	XCH A, drawVLine__cs_L0+0
	RRC A
	XCH A, drawVLine__cs_L0+0
L__drawVLine91:
	DJNZ R0, L__drawVLine92
	MOV drawVLine__cs_L0+1, A
;ADC.c,148 :: 		for(count = 0; count < 8; count++) {
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
;ADC.c,149 :: 		if (_cs == 0 ) {
	MOV A, drawVLine__cs_L0+0
	ORL A, drawVLine__cs_L0+1
	JNZ L_drawVLine12
;ADC.c,150 :: 		LCD_CS1B = 0;
	CLR P2_2_bit+0
;ADC.c,151 :: 		LCD_CS2B = 1;
	SETB P2_3_bit+0
;ADC.c,152 :: 		setYAddress(column);
	MOV FARG_setYAddress_y+0, FARG_drawVLine_column+0
	MOV FARG_setYAddress_y+1, FARG_drawVLine_column+1
	LCALL _setYAddress+0
;ADC.c,153 :: 		} else {
	SJMP L_drawVLine13
L_drawVLine12:
;ADC.c,154 :: 		LCD_CS1B = 1;
	SETB P2_2_bit+0
;ADC.c,155 :: 		LCD_CS2B = 0;
	CLR P2_3_bit+0
;ADC.c,156 :: 		setYAddress(column % 64);
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
;ADC.c,157 :: 		}
L_drawVLine13:
;ADC.c,158 :: 		setXAddress(count);
	MOV FARG_setXAddress_x+0, drawVLine_count_L0+0
	MOV FARG_setXAddress_x+1, drawVLine_count_L0+1
	LCALL _setXAddress+0
;ADC.c,159 :: 		setZAddress(0);
	MOV FARG_setZAddress_z+0, #0
	MOV FARG_setZAddress_z+1, #0
	LCALL _setZAddress+0
;ADC.c,160 :: 		writeData(mask);
	MOV FARG_writeData__data+0, drawVLine_mask_L0+0
	LCALL _writeData+0
;ADC.c,148 :: 		for(count = 0; count < 8; count++) {
	MOV A, #1
	ADD A, drawVLine_count_L0+0
	MOV drawVLine_count_L0+0, A
	MOV A, #0
	ADDC A, drawVLine_count_L0+1
	MOV drawVLine_count_L0+1, A
;ADC.c,161 :: 		}
	SJMP L_drawVLine9
L_drawVLine10:
;ADC.c,163 :: 		LCD_EN = 0;
	CLR P2_6_bit+0
;ADC.c,164 :: 		}
	RET
; end of _drawVLine

_clear:
;ADC.c,166 :: 		int clear(int limit_left, int limit_right) {
;ADC.c,168 :: 		if (limit_left >= limit_right) return -1;
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
;ADC.c,170 :: 		for(x = limit_left; x < limit_right; x++) {
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
;ADC.c,171 :: 		for(y = 0; y <=64; y=y+8) {
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
;ADC.c,173 :: 		drawMask(x,y, 0b00000000);
	MOV FARG_drawMask_x+0, clear_x_L0+0
	MOV FARG_drawMask_x+1, clear_x_L0+1
	MOV FARG_drawMask_y+0, clear_y_L0+0
	MOV FARG_drawMask_y+1, clear_y_L0+1
	MOV FARG_drawMask_mask+0, #0
	MOV FARG_drawMask_mask+1, #0
	LCALL _drawMask+0
;ADC.c,171 :: 		for(y = 0; y <=64; y=y+8) {
	MOV A, #8
	ADD A, clear_y_L0+0
	MOV clear_y_L0+0, A
	MOV A, #0
	ADDC A, clear_y_L0+1
	MOV clear_y_L0+1, A
;ADC.c,174 :: 		}
	SJMP L_clear18
L_clear19:
;ADC.c,170 :: 		for(x = limit_left; x < limit_right; x++) {
	MOV A, #1
	ADD A, clear_x_L0+0
	MOV clear_x_L0+0, A
	MOV A, #0
	ADDC A, clear_x_L0+1
	MOV clear_x_L0+1, A
;ADC.c,175 :: 		}
	SJMP L_clear15
L_clear16:
;ADC.c,176 :: 		return 0;
	MOV R0, #0
	MOV R1, #0
;ADC.c,177 :: 		}
	RET
; end of _clear

_initSPI:
;ADC.c,181 :: 		void initSPI() {
;ADC.c,182 :: 		SPCR = 0b01010011;
	MOV SPCR+0, #83
;ADC.c,183 :: 		}
	RET
; end of _initSPI

_writeSPI:
;ADC.c,185 :: 		void writeSPI(int _data) {
;ADC.c,186 :: 		SPDR = _data;
	MOV SPDR+0, FARG_writeSPI__data+0
;ADC.c,187 :: 		}
	RET
; end of _writeSPI

_readSPI:
;ADC.c,190 :: 		int readSPI() {
;ADC.c,192 :: 		_data = SPDR;
	MOV readSPI__data_L0+0, SPIF_bit+0
	CLR A
	MOV readSPI__data_L0+1, A
;ADC.c,193 :: 		return _data;
	MOV R0, readSPI__data_L0+0
	MOV R1, readSPI__data_L0+1
;ADC.c,194 :: 		}
	RET
; end of _readSPI

_adc_get_data:
;ADC.c,196 :: 		struct rcv_data adc_get_data(int channel) {
	MOV _adc_get_data_su_addr+0, 3
;ADC.c,198 :: 		int SPI_init_data = 0b11000000;
	MOV adc_get_data_SPI_init_data_L0+0, #192
	MOV adc_get_data_SPI_init_data_L0+1, #0
;ADC.c,199 :: 		if(channel == 0) {
	MOV A, FARG_adc_get_data_channel+0
	ORL A, FARG_adc_get_data_channel+1
	JNZ L_adc_get_data21
;ADC.c,200 :: 		SPI_init_data += 0b00000000;
;ADC.c,201 :: 		} else if(channel == 1) {
	SJMP L_adc_get_data22
L_adc_get_data21:
	MOV A, #1
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data93
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data93:
	JNZ L_adc_get_data23
;ADC.c,202 :: 		SPI_init_data += 0b00001000;
	MOV A, #8
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,203 :: 		} else if(channel == 2) {
	SJMP L_adc_get_data24
L_adc_get_data23:
	MOV A, #2
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data94
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data94:
	JNZ L_adc_get_data25
;ADC.c,204 :: 		SPI_init_data += 0b00010000;
	MOV A, #16
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,205 :: 		} else if(channel == 3) {
	SJMP L_adc_get_data26
L_adc_get_data25:
	MOV A, #3
	XRL A, FARG_adc_get_data_channel+0
	JNZ L__adc_get_data95
	MOV A, #0
	XRL A, FARG_adc_get_data_channel+1
L__adc_get_data95:
	JNZ L_adc_get_data27
;ADC.c,206 :: 		SPI_init_data += 0b00011000;
	MOV A, #24
	ADD A, adc_get_data_SPI_init_data_L0+0
	MOV adc_get_data_SPI_init_data_L0+0, A
	MOV A, #0
	ADDC A, adc_get_data_SPI_init_data_L0+1
	MOV adc_get_data_SPI_init_data_L0+1, A
;ADC.c,207 :: 		}
L_adc_get_data27:
L_adc_get_data26:
L_adc_get_data24:
L_adc_get_data22:
;ADC.c,208 :: 		P0 = SPI_init_data;
	MOV P0+0, adc_get_data_SPI_init_data_L0+0
;ADC.c,209 :: 		CS = 0;
	CLR P2_0_bit+0
;ADC.c,212 :: 		writeSPI(SPI_init_data);
	MOV FARG_writeSPI__data+0, adc_get_data_SPI_init_data_L0+0
	MOV FARG_writeSPI__data+1, adc_get_data_SPI_init_data_L0+1
	LCALL _writeSPI+0
;ADC.c,213 :: 		while(SPIF_bit != 1) {}
L_adc_get_data28:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data29
	NOP
	SJMP L_adc_get_data28
L_adc_get_data29:
;ADC.c,214 :: 		_data.first = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+0, 0
;ADC.c,216 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,217 :: 		while(SPIF_bit != 1) {}
L_adc_get_data30:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data31
	NOP
	SJMP L_adc_get_data30
L_adc_get_data31:
;ADC.c,218 :: 		_data.second = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+1, 0
;ADC.c,220 :: 		writeSPI(0b00000000);
	MOV FARG_writeSPI__data+0, #0
	MOV FARG_writeSPI__data+1, #0
	LCALL _writeSPI+0
;ADC.c,221 :: 		while(SPIF_bit != 1) {}
L_adc_get_data32:
	MOV A, SPIF_bit+0
	JB 224, L_adc_get_data33
	NOP
	SJMP L_adc_get_data32
L_adc_get_data33:
;ADC.c,222 :: 		_data.third = readSPI();
	LCALL _readSPI+0
	MOV adc_get_data__data_L0+2, 0
;ADC.c,224 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,226 :: 		return _data;
	MOV R3, #3
	MOV R0, _adc_get_data_su_addr+0
	MOV R1, #adc_get_data__data_L0+0
L_adc_get_data34:
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
	JNZ L_adc_get_data34
	MOV CS+0, adc_get_data__data_L0+0
	MOV CS+1, adc_get_data__data_L0+1
;ADC.c,227 :: 		}
	RET
; end of _adc_get_data

_getBit:
;ADC.c,229 :: 		int getBit(int position, int byte) {
;ADC.c,230 :: 		return (byte >> position) & 1;
	MOV R2, FARG_getBit_position+0
	MOV A, FARG_getBit_byte+1
	MOV R0, FARG_getBit_byte+0
	INC R2
	SJMP L__getBit96
L__getBit97:
	MOV C, #231
	RRC A
	XCH A, R0
	RRC A
	XCH A, R0
L__getBit96:
	DJNZ R2, L__getBit97
	MOV R1, A
	ANL 0, #1
	ANL 1, #0
;ADC.c,231 :: 		}
	RET
; end of _getBit

_parseADCValue:
;ADC.c,233 :: 		int parseADCValue(struct rcv_data *adc_data) {
;ADC.c,234 :: 		int result = 0b000000000000;
	MOV parseADCValue_result_L0+0, #0
	MOV parseADCValue_result_L0+1, #0
	MOV parseADCValue_i_L0+0, #0
	MOV parseADCValue_i_L0+1, #0
;ADC.c,235 :: 		int i = 0;
;ADC.c,237 :: 		result += getBit(0, adc_data->first);
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
;ADC.c,239 :: 		for(i = 7; i >= 0; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue35:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue36
;ADC.c,240 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue98
L__parseADCValue99:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue98:
	DJNZ R0, L__parseADCValue99
	MOV parseADCValue_result_L0+0, A
;ADC.c,241 :: 		result += getBit(i, adc_data->second);
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
;ADC.c,239 :: 		for(i = 7; i >= 0; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,242 :: 		}
	SJMP L_parseADCValue35
L_parseADCValue36:
;ADC.c,244 :: 		for (i = 7; i >=5; i--) {
	MOV parseADCValue_i_L0+0, #7
	MOV parseADCValue_i_L0+1, #0
L_parseADCValue38:
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #5
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, parseADCValue_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_parseADCValue39
;ADC.c,245 :: 		result <<= 1;
	MOV R0, #1
	MOV A, parseADCValue_result_L0+0
	INC R0
	SJMP L__parseADCValue100
L__parseADCValue101:
	CLR C
	RLC A
	XCH A, parseADCValue_result_L0+1
	RLC A
	XCH A, parseADCValue_result_L0+1
L__parseADCValue100:
	DJNZ R0, L__parseADCValue101
	MOV parseADCValue_result_L0+0, A
;ADC.c,246 :: 		result += getBit(i, adc_data->third);
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
;ADC.c,244 :: 		for (i = 7; i >=5; i--) {
	CLR C
	MOV A, parseADCValue_i_L0+0
	SUBB A, #1
	MOV parseADCValue_i_L0+0, A
	MOV A, parseADCValue_i_L0+1
	SUBB A, #0
	MOV parseADCValue_i_L0+1, A
;ADC.c,247 :: 		}
	SJMP L_parseADCValue38
L_parseADCValue39:
;ADC.c,249 :: 		return result;
	MOV R0, parseADCValue_result_L0+0
	MOV R1, parseADCValue_result_L0+1
;ADC.c,250 :: 		}
	RET
; end of _parseADCValue

_main:
	MOV SP+0, #128
;ADC.c,252 :: 		void main() {
;ADC.c,255 :: 		int y = 0;
;ADC.c,256 :: 		int x = 0;
	MOV 130, #?ICSmain_x_L0+0
	MOV 131, hi(#?ICSmain_x_L0+0)
	MOV R0, #main_x_L0+0
	MOV R1, #10
	LCALL ___CC2D+0
;ADC.c,257 :: 		int speed = 1;
;ADC.c,258 :: 		int pressed = -1;
;ADC.c,259 :: 		int pause = 0;
;ADC.c,260 :: 		int pause_pressed = -1;
;ADC.c,262 :: 		CS = 1;
	SETB P2_0_bit+0
;ADC.c,263 :: 		P3=0;
	MOV P3+0, #0
;ADC.c,264 :: 		Delay_us(1);
	NOP
;ADC.c,267 :: 		initSPI();
	LCALL _initSPI+0
;ADC.c,268 :: 		displayOn();
	LCALL _displayOn+0
;ADC.c,269 :: 		clear(0, 128);
	MOV FARG_clear_limit_left+0, #0
	MOV FARG_clear_limit_left+1, #0
	MOV FARG_clear_limit_right+0, #128
	MOV FARG_clear_limit_right+1, #0
	LCALL _clear+0
;ADC.c,271 :: 		while(1) {
L_main41:
;ADC.c,272 :: 		if(pause == 1 && x == 127) {
	MOV A, #1
	XRL A, main_pause_L0+0
	JNZ L__main102
	MOV A, #0
	XRL A, main_pause_L0+1
L__main102:
	JNZ L_main45
	MOV A, #127
	XRL A, main_x_L0+0
	JNZ L__main103
	MOV A, #0
	XRL A, main_x_L0+1
L__main103:
	JNZ L_main45
L__main77:
;ADC.c,273 :: 		if(P3_2_bit == 1) {
	MOV A, P3_2_bit+0
	JNB 224, L_main46
	NOP
;ADC.c,274 :: 		if (pause_pressed == -1) {
	MOV A, #255
	XRL A, main_pause_pressed_L0+0
	JNZ L__main104
	MOV A, #255
	XRL A, main_pause_pressed_L0+1
L__main104:
	JNZ L_main47
;ADC.c,275 :: 		if(pause == 0){
	MOV A, main_pause_L0+0
	ORL A, main_pause_L0+1
	JNZ L_main48
;ADC.c,276 :: 		pause = 1;
	MOV main_pause_L0+0, #1
	MOV main_pause_L0+1, #0
;ADC.c,277 :: 		} else {
	SJMP L_main49
L_main48:
;ADC.c,278 :: 		pause = 0;
	MOV main_pause_L0+0, #0
	MOV main_pause_L0+1, #0
;ADC.c,279 :: 		}
L_main49:
;ADC.c,280 :: 		}
L_main47:
;ADC.c,281 :: 		pause_pressed = 0;
	MOV main_pause_pressed_L0+0, #0
	MOV main_pause_pressed_L0+1, #0
;ADC.c,282 :: 		} else if(P3_2_bit == 0){
	SJMP L_main50
L_main46:
	MOV A, P3_2_bit+0
	JB 224, L_main51
	NOP
;ADC.c,283 :: 		pause_pressed = -1;
	MOV main_pause_pressed_L0+0, #255
	MOV main_pause_pressed_L0+1, #255
;ADC.c,284 :: 		}
L_main51:
L_main50:
;ADC.c,285 :: 		continue;
	SJMP L_main41
;ADC.c,286 :: 		} else {
L_main45:
;ADC.c,287 :: 		*adc_data = adc_get_data(0);
	MOV FARG_adc_get_data_channel+0, #0
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
;ADC.c,288 :: 		adc_result = parseADCValue(adc_data);
	MOV FARG_parseADCValue_adc_data+0, _adc_data+0
	LCALL _parseADCValue+0
;ADC.c,290 :: 		y = 64 - adc_result / LCD_Y_LIMIT;
	MOV R4, #6
	MOV A, R1
	MOV R2, 0
	INC R4
	SJMP L__main105
L__main106:
	MOV C, #231
	RRC A
	XCH A, R2
	RRC A
	XCH A, R2
L__main105:
	DJNZ R4, L__main106
	MOV R3, A
	CLR C
	MOV A, #64
	SUBB A, R2
	MOV FARG_drawPoint_y+0, A
	MOV A, #0
	SUBB A, R3
	MOV FARG_drawPoint_y+1, A
;ADC.c,291 :: 		y = y - 1;
	CLR C
	MOV A, FARG_drawPoint_y+0
	SUBB A, #1
	MOV FARG_drawPoint_y+0, A
	MOV A, FARG_drawPoint_y+1
	SUBB A, #0
	MOV FARG_drawPoint_y+1, A
;ADC.c,292 :: 		drawPoint(x, y, 0);
	MOV FARG_drawPoint_x+0, main_x_L0+0
	MOV FARG_drawPoint_x+1, main_x_L0+1
	MOV FARG_drawPoint_flag+0, #0
	MOV FARG_drawPoint_flag+1, #0
	LCALL _drawPoint+0
;ADC.c,293 :: 		x = x + 1;
	MOV A, #1
	ADD A, main_x_L0+0
	MOV main_x_L0+0, A
	MOV A, #0
	ADDC A, main_x_L0+1
	MOV main_x_L0+1, A
;ADC.c,294 :: 		if (x == 128) {
	MOV A, #128
	XRL A, main_x_L0+0
	JNZ L__main107
	MOV A, #0
	XRL A, main_x_L0+1
L__main107:
	JNZ L_main54
;ADC.c,295 :: 		x = 0;
	MOV main_x_L0+0, #0
	MOV main_x_L0+1, #0
;ADC.c,296 :: 		clear(0, 128);
	MOV FARG_clear_limit_left+0, #0
	MOV FARG_clear_limit_left+1, #0
	MOV FARG_clear_limit_right+0, #128
	MOV FARG_clear_limit_right+1, #0
	LCALL _clear+0
;ADC.c,297 :: 		}
L_main54:
;ADC.c,299 :: 		if(P3_2_bit == 1) {
	MOV A, P3_2_bit+0
	JNB 224, L_main55
	NOP
;ADC.c,300 :: 		if (pause_pressed == -1) {
	MOV A, #255
	XRL A, main_pause_pressed_L0+0
	JNZ L__main108
	MOV A, #255
	XRL A, main_pause_pressed_L0+1
L__main108:
	JNZ L_main56
;ADC.c,301 :: 		if(pause == 0){
	MOV A, main_pause_L0+0
	ORL A, main_pause_L0+1
	JNZ L_main57
;ADC.c,302 :: 		pause = 1;
	MOV main_pause_L0+0, #1
	MOV main_pause_L0+1, #0
;ADC.c,303 :: 		} else {
	SJMP L_main58
L_main57:
;ADC.c,304 :: 		pause = 0;
	MOV main_pause_L0+0, #0
	MOV main_pause_L0+1, #0
;ADC.c,305 :: 		}
L_main58:
;ADC.c,306 :: 		}
L_main56:
;ADC.c,307 :: 		pause_pressed = 0;
	MOV main_pause_pressed_L0+0, #0
	MOV main_pause_pressed_L0+1, #0
;ADC.c,308 :: 		} else if(P3_2_bit == 0){
	SJMP L_main59
L_main55:
	MOV A, P3_2_bit+0
	JB 224, L_main60
	NOP
;ADC.c,309 :: 		pause_pressed = -1;
	MOV main_pause_pressed_L0+0, #255
	MOV main_pause_pressed_L0+1, #255
;ADC.c,310 :: 		}
L_main60:
L_main59:
;ADC.c,312 :: 		if(P3_0_bit == 1) {
	MOV A, P3_0_bit+0
	JNB 224, L_main61
	NOP
;ADC.c,313 :: 		if (pressed == -1) {
	MOV A, #255
	XRL A, main_pressed_L0+0
	JNZ L__main109
	MOV A, #255
	XRL A, main_pressed_L0+1
L__main109:
	JNZ L_main62
;ADC.c,314 :: 		speed = speed + 1;
	MOV A, #1
	ADD A, main_speed_L0+0
	MOV main_speed_L0+0, A
	MOV A, #0
	ADDC A, main_speed_L0+1
	MOV main_speed_L0+1, A
;ADC.c,315 :: 		}
L_main62:
;ADC.c,316 :: 		pressed = 0;
	MOV main_pressed_L0+0, #0
	MOV main_pressed_L0+1, #0
;ADC.c,317 :: 		} else if(P3_0_bit == 0 && P3_1_bit != 1) {
	SJMP L_main63
L_main61:
	MOV A, P3_0_bit+0
	JB 224, L_main66
	NOP
	MOV A, P3_1_bit+0
	JB 224, L_main66
	NOP
L__main76:
;ADC.c,318 :: 		pressed = -1;
	MOV main_pressed_L0+0, #255
	MOV main_pressed_L0+1, #255
;ADC.c,319 :: 		} else if(P3_1_bit == 1) {
	SJMP L_main67
L_main66:
	MOV A, P3_1_bit+0
	JNB 224, L_main68
	NOP
;ADC.c,320 :: 		if (pressed == -1 && speed > 0) {
	MOV A, #255
	XRL A, main_pressed_L0+0
	JNZ L__main110
	MOV A, #255
	XRL A, main_pressed_L0+1
L__main110:
	JNZ L_main71
	SETB C
	MOV A, main_speed_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, main_speed_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_main71
L__main75:
;ADC.c,321 :: 		speed = speed - 1;
	CLR C
	MOV A, main_speed_L0+0
	SUBB A, #1
	MOV main_speed_L0+0, A
	MOV A, main_speed_L0+1
	SUBB A, #0
	MOV main_speed_L0+1, A
;ADC.c,322 :: 		}
L_main71:
;ADC.c,323 :: 		pressed = 0;
	MOV main_pressed_L0+0, #0
	MOV main_pressed_L0+1, #0
;ADC.c,324 :: 		} else if(P3_1_bit == 0) {
	SJMP L_main72
L_main68:
	MOV A, P3_1_bit+0
	JB 224, L_main73
	NOP
;ADC.c,325 :: 		pressed = -1;
	MOV main_pressed_L0+0, #255
	MOV main_pressed_L0+1, #255
;ADC.c,326 :: 		} else {
	SJMP L_main74
L_main73:
;ADC.c,327 :: 		pressed = -1;
	MOV main_pressed_L0+0, #255
	MOV main_pressed_L0+1, #255
;ADC.c,328 :: 		}
L_main74:
L_main72:
L_main67:
L_main63:
;ADC.c,330 :: 		Vdelay_ms(speed);
	MOV FARG_VDelay_ms_Time_ms+0, main_speed_L0+0
	MOV FARG_VDelay_ms_Time_ms+1, main_speed_L0+1
	LCALL _VDelay_ms+0
;ADC.c,332 :: 		}
	LJMP L_main41
;ADC.c,333 :: 		}
	SJMP #254
; end of _main
