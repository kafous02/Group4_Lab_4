 ; Lab4
 ;
 ; Created: 3/24/2018 4:15:16 AM
 ; Author : Eugene Rockey

		 .org 0					;student discuss interrupts and vector table in report
		 jmp RESET				;student discuss reset in report
		 jmp INT0_H				;student discuss reset in report
		 jmp INT1_H				;student discuss reset in report
		 jmp PCINT0_H			;student discuss reset in report
		 jmp PCINT1_H			;student discuss reset in report
		 jmp PCINT2_H			;student discuss reset in report
		 jmp WDT				;student discuss reset in report
		 jmp TIM2_COMPA			;student discuss reset in report
		 jmp TIM2_COMPB			;student discuss reset in report
		 jmp TIM2_OVF			;student discuss reset in report
		 jmp TIM1_CAPT			;student discuss reset in report
		 jmp TIM1_COMPA			;student discuss reset in report
		 jmp TIM1_COMPB			;student discuss reset in report
		 jmp TIM1_OVF			;student discuss reset in report
		 jmp TIM0_COMPA			;student discuss reset in report
		 jmp TIM0_COMPB			;student discuss reset in report
		 jmp TIM0_OVF			;student discuss reset in report
		 jmp SPI_TC				;student discuss reset in report
		 jmp USART_RXC			;student discuss reset in report
		 jmp USART_UDRE			;student discuss reset in report
		 jmp USART_TXC			;student discuss reset in report
		 jmp ADCC				;student discuss reset in report
		 jmp EE_READY			;student discuss reset in report
		 jmp ANA_COMP			;student discuss reset in report
		 jmp TWI				;student discuss reset in report
		 jmp SPM_READY			;student discuss reset in report



RESET:	;Initialize the ATMega328P chip for the THIS embedded application.
		;initialize PORTB for Output
		cli
		ldi	r16,0xFF				;PB1 or OC1A Output
		out	DDRB,r16
;initialize and start Timer A, compare match, interrupt enabled
		ldi	r16,0xC0			;set OC to compare match set output to high level
		sts TCCR1A,r16			;Set OC1A on compare match
		ldi r16,0x04			;set clock prescaler
		sts TCCR1B,r16			;Sets prescaler to 1024
		ldi r16,0x80			;force output compare, set PB1 high
		sts TCCR1C,r16			;Forces output compare for channel A
		ldi r16,0x40			;Loads 0x40 into r16
		sts TCCR1A,r16			;Sets toggle of OC1A on compare match
		ldi	r18,0x0B			;loads 0x0B into r18
		ldi r17,0xB8			;Loads 0xB8 into r17
		lds r16,TCNT1L			;Loads the lower half of the timer value into r16
		add r17,r16				;Adds lower half of timer value and 0xB8, making the smallest possible time value 184
		lds r16,TCNT1H			;Loads the upper half of the timer value into r16
		adc r18,r16				;Adds with carry the upper value of the timer and 0x0B, which makes smallest possible value 11. The carry accounts for the potential of overflow when adding the lower half of the timer value
		sts OCR1AH,r18			;Stores upper value of timer plus r18 into the high part of the output compare register. This value will be continously compared to TCNT1H
		sts OCR1AL,r17			;Stores lower value of timer plus r17 into the low part of the output compare register. This value will be continously compared to TCNT1L
		ldi r19,0				;Zeroes the r19 register
		ldi r16,0x02			;Loads 0x02 into r16
		sts TIMSK1,r16			;Sets I flag in SREG and enables compare interrupts
		out TIFR1,r16			;Clears Timer/Counter 1, Output Compare A Match flag
		sei						;Sets global interrupt flag, effectively enabling interrupts in general
here:	rjmp here
		
INT0_H:
		nop			;external interrupt 0 handler
		reti
INT1_H:
		nop			;external interrupt 1 handler
		reti
PCINT0_H:
		nop			;pin change interrupt 0 handler
		reti
PCINT1_H:
		nop			;pin change interrupt 1 handler
		reti
PCINT2_H:
		nop			;pin change interrupt 2 handler
		reti
WDT:
		nop			;watch dog time out handler
		reti
TIM2_COMPA:
		nop			;TC 2 compare match A handler
		reti
TIM2_COMPB:
		nop			;TC 2 compare match B handler
		reti
TIM2_OVF:
		nop			;TC 2 overflow handler
		reti
TIM1_CAPT:
		nop			;TC 1 capture event handler
		reti
TIM1_COMPA:			;TC 1 compare match A handler
		sbrc	r19,0				;Skips next instruction if bit 0 in r19 is cleared
		rjmp	ONE					;Jumps to ONE label if bit 0 in r19 is set
		ldi		r17,0x1E			;Loads 0xE8 into r17
		ldi		r18,0x01			;Loads 0x0B into r18
		ldi		r19,1				;Loads 0x01 into r19 to rjmp to ONE
		rjmp	BEGIN				;Jumps to the BEGIN label	
ONE:	ldi		r17,0x1E			;Loads 0xE8 into r17
		ldi		r18,0x01			;Loads 0x0B into r18
		ldi		r19,0				;Loads 0x0 into r19, will skip this operation for next iteration
BEGIN:	lds		r16,OCR1AL			;Loads low part of value timer will be compared to into r16
		add		r17,r16				;Adds 0xE8 and the low value in output compare registers, changes point at which interrupt will be generated
		lds		r16,OCR1AH			;Loads high part of value timer will be compared to into r16
		adc		r18,r16				;Adds 0x0B and the high value in output compare registers, changes point at which interrupt will be generated
		sts		OCR1AH,r18			;Stores high part of new compare value into output compare register high
		sts		OCR1AL,r17			;Stores low part of new compare value into output compare register low
		reti						;Returns from interrupt to the top most program counter on the stack
TIM1_COMPB:
		nop			;TC 1 compare match B handler
		reti
TIM1_OVF:
		nop			;TC 1 overflow handler
		reti
TIM0_COMPA:
		nop			;TC 0 compare match A handler
		reti
TIM0_COMPB:			
		nop			;TC 1 compare match B handler
		reti
TIM0_OVF:
		nop			;TC 0 overflow handler
		reti
SPI_TC:
		nop			;SPI Transfer Complete
		reti
USART_RXC:
		nop			;USART receive complete
		reti
USART_UDRE:
		nop			;USART data register empty
		reti
USART_TXC:
		nop			;USART transmit complete
		reti
ADCC:
		nop			;ADC conversion complete
		reti
EE_READY:
		nop			;EEPROM ready
		reti
ANA_COMP:
		nop			;Analog Comparison complete 
		reti
TWI:
		nop			;I2C interrupt handler
		reti
SPM_READY:
		nop			;store program memory ready handler
		reti		

