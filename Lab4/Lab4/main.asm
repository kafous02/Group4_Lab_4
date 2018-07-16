 ; Lab4
 ;
 ; Created: 3/24/2018 4:15:16 AM
 ; Author : Eugene Rockey			

		.org	0			;start interrupt table at 0x0
		jmp		Init		;include RESET interrupt at 0x0	

Init:	cli					;clear interrupts
		ldi		r16,0x87    ;loads 0x87 into r16
		sts		ADCSRA,r16	;stores r16 into ADCSRA, enabling ADC, 128 division factor 
		ldi		r16,0x40    ;loads 0x40 into r16
		sts		ADMUX,r16   ;stores r16 into ADMUX, voltage reference of AVcc with external capacitor at AREF pin
		ldi		r16,0		;loads 0x00 into r16  
		sts		ADCSRB,r16	;stores r16 into ADCSRB, enables free running mode
		ldi		r16,0x02	;load 0x02 into register r16
		out		DDRB,r16	;set port DDRB to 0x02, allowing output to LCD
		ldi		r16,0xC2	;load 0xC2 into register r16
		sts		TCCR1A,r16	;sets TC1 Control Register A to 0xC2 [Set OC1A/OC1B on Compare Match, mode 14 - Fast PWM]       
		ldi		r16,0x1B	;load 0x1B into register r16
		sts		TCCR1B,r16	;sets TC1 Control Register B to 0x1B [Set clock prescaler to clk(I/O)/64, mode 14 - Fast PWM]       
		ldi		r16,0x08	;loads 0x08 into r16
		ldi		r17,0x23	;loads 0x23 into r17
		sts		ICR1H,r16	;stores r16 into ICR1H
		sts		ICR1L,r17	;stores r17 into ICR1L, setting max duty cycle to 2083. (16,000,000 Hz CPU / (120 Hz desired * 64 prescalar))
		ldi		r16,0x00	;loads 0x00 into r16
		ldi		r17,0x53	;loads 0x23 into r17
		sts		OCR1AH,r16	;stores r16 into OCR1AH
		sts		OCR1AL,r17	;stores r17 into OCR1AL, setting LCD to default at max brightness

Loop:	rcall	ADC_Get		;call ADCGet to update ADC values
		ldi		r16,0xF0	;loads decimal 240 into r16
		lds		r18,ADCL	;loads the lower ADC nibbles into r18
		lds		r17,ADCH	;loads the upper ADC nibbles into r17
		cp		r18,r16		;compares the lower ADC nibbles to decimal 240
		brge	lvl1		;set lcd brightness to duty cycle 1/11 (max brightness) if ADC >= 240
		ldi		r16,0xEB	;loads decimal 235 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 230
		brge	lvl2		;set lcd brightness to duty cycle 2/11 (high brightness) if ADC >= 230
		ldi		r16,0xE6	;loads decimal 230 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 220
		brge	lvl3a		;set lcd brightness to duty cycle 3/11 (high brightness) if ADC >= 220
		ldi		r16,0xE1	;loads decimal 225 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 210
		brge	lvl4a		;set lcd brightness to duty cycle 4/11 (high brightness) if ADC >= 210
		ldi		r16,0xDC	;loads decimal 220 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 200
		brge	lvl5a		;set lcd brightness to duty cycle 5/11 (medium brightness) if ADC >= 200
		ldi		r16,0xD7	;loads decimal 215 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 190
		brge	lvl6a		;set lcd brightness to duty cycle 6/11 (medium brightness) if ADC >= 190
		ldi		r16,0xD2	;loads decimal 210 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 180
		brge	lvl7a		;set lcd brightness to duty cycle 7/11 (medium brightness) if ADC >= 180
		ldi		r16,0xCD	;loads decimal 205 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 170
		brge	lvl8a		;set lcd brightness to duty cycle 8/11 (low brightness) if ADC >= 170
		ldi		r16,0xC8	;loads decimal 200 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 160
		brge	lvl9a		;set lcd brightness to duty cycle 9/11 (low brightness) if ADC >= 160
		ldi		r16,0xC3	;loads decimal 195 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl10a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xBE	;loads decimal 190 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl11a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xB9	;loads decimal 185 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl12a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xB4	;loads decimal 180 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl13a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xAF	;loads decimal 175 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl14a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xAA	;loads decimal 170 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl15a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xA5	;loads decimal 165 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl16a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0xA0	;loads decimal 160 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl17a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0x9B	;loads decimal 155 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl18a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150
		ldi		r16,0x96	;loads decimal 150 into r16
		cp		r18,r16		;compares the lower ADC nibbles to decimal 150
		brge	lvl19a		;set lcd brightness to duty cycle 10/11 (low brightness) if ADC > 150

lvl1:	ldi		r16,0x00	;load 0x00 in register r16
		ldi		r17,0x53	;load 0x53 in register r17, representing a duty cycle of 0083
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 0083, giving the lcd a max brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl2:	ldi		r16,0x00	;load 0x01 in register r16
		ldi		r17,0xB7	;load 0x1B in register r17, representing a duty cycle of 0183
		sts		OCR1AH,r16	;store 0x01 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x1B to SRAM address OCR1AL, setting the duty cycle to 0283, giving the lcd a high brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl3a:	jmp	lvl3b

lvl4a:	jmp	lvl4b

lvl5a:	jmp	lvl5b

lvl6a:	jmp	lvl6b

lvl7a:	jmp	lvl7b

lvl8a:	jmp	lvl8b

lvl9a:	jmp	lvl9b

lvl10a:	jmp	lvl10b

lvl11a:	jmp	lvl11b

lvl12a:	jmp	lvl12b

lvl13a:	jmp	lvl13b

lvl14a:	jmp	lvl14b

lvl15a:	jmp	lvl15b

lvl16a:	jmp	lvl16b

lvl17a:	jmp	lvl17b

lvl18a:	jmp	lvl18b

lvl19a:	jmp	lvl19b

lvl3b:	ldi		r16,0x01	;load 0x01 in register r16
		ldi		r17,0x1B	;load 0xE3 in register r17, representing a duty cycle of 0283
		sts		OCR1AH,r16	;store 0x01 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0xE3 to SRAM address OCR1AL, setting the duty cycle to 0483, giving the lcd a high brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl4b:	ldi		r16,0x01	;load 0x02 in register r16
		ldi		r17,0x7F	;load 0xAB in register r17, representing a duty cycle of 0383
		sts		OCR1AH,r16	;store 0x02 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0xAB to SRAM address OCR1AL, setting the duty cycle to 0683, giving the lcd a high brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl5b:	ldi		r16,0x01	;load 0x03 in register r16
		ldi		r17,0xE3	;load 0x73 in register r17, representing a duty cycle of 0483
		sts		OCR1AH,r16	;store 0x03 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x73 to SRAM address OCR1AL, setting the duty cycle to 0883, giving the lcd a medium brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl6b:	ldi		r16,0x02	;load 0x04 in register r16
		ldi		r17,0x47	;load 0x3B in register r17, representing a duty cycle of 0583
		sts		OCR1AH,r16	;store 0x04 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x3B to SRAM address OCR1AL, setting the duty cycle to 1083, giving the lcd a medium brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl7b:	ldi		r16,0x02	;load 0x05 in register r16
		ldi		r17,0xAB	;load 0x03 in register r17, representing a duty cycle of 0683
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 1283, giving the lcd a medium brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl8b:	ldi		r16,0x03	;load 0x05 in register r16
		ldi		r17,0x0F	;load 0xCB in register r17, representing a duty cycle of 0783
		sts		OCR1AH,r16	;store 0x05 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0xCB to SRAM address OCR1AL, setting the duty cycle to 1483, giving the lcd a low brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl9b:	ldi		r16,0x03	;load 0x06 in register r16
		ldi		r17,0x73	;load 0x93 in register r17, representing a duty cycle of 0883
		sts		OCR1AH,r16	;store 0x06 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x93 to SRAM address OCR1AL, setting the duty cycle to 1683, giving the lcd a low brightness
		rjmp	Loop		;jump back to start to get a new adc value
		
lvl10b:	ldi		r16,0x03	;load 0x07 in register r16
		ldi		r17,0xD7	;load 0x5B in register r17, representing a duty cycle of 0983
		sts		OCR1AH,r16	;store 0x07 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x5B to SRAM address OCR1AL, setting the duty cycle to 1883, giving the lcd a low brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl11b:	ldi		r16,0x04	;load 0x08 in register r16
		ldi		r17,0x3B	;load 0x23 in register r17, representing a duty cycle of 1083
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl12b:	ldi		r16,0x04	;load 0x08 in register r16
		ldi		r17,0x9F	;load 0x23 in register r17, representing a duty cycle of 1183
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl13b:	ldi		r16,0x05	;load 0x08 in register r16
		ldi		r17,0x03	;load 0x23 in register r17, representing a duty cycle of 1283
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl14b:	ldi		r16,0x05	;load 0x08 in register r16
		ldi		r17,0x67	;load 0x23 in register r17, representing a duty cycle of 1383
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl15b:	ldi		r16,0x05	;load 0x08 in register r16
		ldi		r17,0xCB	;load 0x23 in register r17, representing a duty cycle of 1483
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl16b:	ldi		r16,0x06	;load 0x08 in register r16
		ldi		r17,0x2F	;load 0x23 in register r17, representing a duty cycle of 1583
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl17b:	ldi		r16,0x06	;load 0x08 in register r16
		ldi		r17,0x93	;load 0x23 in register r17, representing a duty cycle of 1683
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl18b:	ldi		r16,0x07	;load 0x08 in register r16
		ldi		r17,0x5B	;load 0x23 in register r17, representing a duty cycle of 1883
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value

lvl19b:	ldi		r16,0x08	;load 0x08 in register r16
		ldi		r17,0x23	;load 0x23 in register r17, representing a duty cycle of 2083
		sts		OCR1AH,r16	;store 0x00 to SRAM address OCR1AH
		sts		OCR1AL,r17	;store 0x53 to SRAM address OCR1AL, setting the duty cycle to 2083, giving the lcd a min brightness
		rjmp	Loop		;jump back to start to get a new adc value
		
		sei					;set enable interrupts

ADC_Get:
		ldi     r16,0xC7	;load 1100 0111 to r16
		sts     ADCSRA,r16  ;store r16 to SRAM address ADCSRA to enable ADC & start ADC conversion, 128 division factor
A2V1:   lds     r16,ADCSRA  ;load from SRAM address ADCSRA into r16
        sbrc    r16,ADSC    ;skip if bit 6 in r16 cleared, meaning ADC complete
        rjmp    A2V1        ;jump again to see if ADC conversion is complete
        ret					;return, ADC conversion completed