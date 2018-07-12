;
; Lab4ExtraCredigt.asm
;
; Created: 7/12/2018 11:43:17 AM
; Author : Kevin Fou
;

Init:
	cli
	ldi		r16,0xFF				;PB1 or OC1A Output
	out		DDRB,r16
	ldi		r16,0xC0			;set OC to compare match set output to high level
	sts		TCCR1A,r16			;Sets bits 7 and 6 in TCCR1A. "Set OC1A (PB1) on compare match"
	ldi		r16,0x14			;set clock prescaler, 0x04 = 00000100
	sts		TCCR1B,r16			;Sets bit 2 of TCCR1B, sets prescaler "(clk_I/O)/256"
	ldi		r16,0x80			;force output compare, set PB1 high
	sts		TCCR1C,r16			;Set bit 7 of TCCR1C, Force Output Compare for Channel A
								;Only active when WGM1[3:0] specifies non-PWM mode
								;Since COM1A bits are both set to 1, the effect of the forced compare sets PB1 if there is a match
	ldi		r16,0x89			;r16 = 10001001 in 8-bit binary
	sts		TCCR1A,r16			;Sets bit 7 in TCCR1A, "Clear OC1A on compare match(PB1 output set to low on match)", sets WGM to mode 9 PWM, Phase and Frequency Correct
	ldi		r18,0x01			;r18 = 00001011
	ldi		r17,0x04			;r17 = 10111000, 0x0BB8 = 3000 in decimal
	lds		r16,TCNT1L			;Load current Timer/Counter 1 low byte value into r16
	add		r17,r16				;Low byte of 0x0BB8 added to low byte of Timer/Counter 1
	lds		r16,TCNT1H			;Load current Timer/Counter 1 high byte value into r16
	adc		r18,r16				;High byte of 0x0BB8 added to high byte of Timer/Counter 1
	sts		ICR1L, r17
	sts		ICR1H, r18
	ldi		r16,0x87                ;initialize ADC
    sts		ADCSRA,r16              ;stores 0x87 into ADC configuration SRAM  location
    ldi		r16,0x40                ;Loads 0x40 into r16
    sts		ADMUX,r16               ;Stores the value of r16 into the ADC multiplexer selection memory space in SRAM
    ldi		r16,7                   ;Loads 0 into r16
    sts		ADCSRB,r16              ;Stores 0 into ADCSRB memory space which puts ADC in free roaming mode
	out		TIFR1,r16			;Clears OCF1A flag by writing logic one to its bit location. 
								;Automatically cleared when Output Compare Match A interrupt vector is executed
								;This flag is set when counter value TCNT1 matches Output Compare Register A OCR1A
	ldi		r16,0x0
	sts		DDRC, r16
	sei						;Sets global interrupt flag. Enables Timer/Counter 1 Output Compare A Match interrupt

ADC_Get:
        ldi     r16,0xE7            ;Load 231 into r16
        sts     ADCSRA,r16          ;Move 231 from r16 to ADC Control and Status Register A
A2V1:   lds     r16,ADCSRA          ;Load the ADC Control and Status Register A into r16
        sbrc    r16,ADSC            ;Skip the following instruction if the ADC Start Conversion bit is cleared
        rjmp    A2V1                ;Loop back into A2V1, continually scanning for ADCSRA to be 1
        lds     r16,0x01            ;ADCL must be read first, then ADCH, to ensure that the content of the Data Registers belongs to the same conversion
        sts     OCR1AL,r16            ;Store ADCL into SRAM Label LADC
        lds     r16,0x05            ;The rest of ADC is read
        sts     OCR1AH,r16            ;Store ADCH into SRAM Label HADC
		rjmp	A2V1

TIM1_COMPA:	
	nop
	reti

