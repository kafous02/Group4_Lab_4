 ; Lab4
 ;
 ; Created: 3/24/2018 4:15:16 AM
 ; Author : Eugene Rockey			

		.org	0			
		jmp		Init			

Init:	cli					
		ldi		r16,0x87    
		sts		ADCSRA,r16	
		ldi		r16,0x40    
		sts		ADMUX,r16   
		ldi		r16,0		  
		sts		ADCSRB,r16	
		ldi		r16,0x02	
		out		DDRB,r16	
		ldi		r16,0xC2	
		sts		TCCR1A,r16	       
		ldi		r16,0x1B	
		sts		TCCR1B,r16	       
		ldi		r16,0x08	
		ldi		r17,0x23	
		sts		ICR1H,r16	
		sts		ICR1L,r17	
		ldi		r16,0x00	
		ldi		r17,0x53	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	

Loop:	rcall	ADC_Get		
		ldi		r16,0xF0	
		lds		r18,ADCL	
		lds		r17,ADCH	
		cp		r18,r16		
		brge	lvl1		
		ldi		r16,0xEB	
		cp		r18,r16		
		brge	lvl2		
		ldi		r16,0xE6	
		cp		r18,r16		
		brge	lvl3a		
		ldi		r16,0xE1	
		cp		r18,r16		
		brge	lvl4a		
		ldi		r16,0xDC	
		cp		r18,r16		
		brge	lvl5a		
		ldi		r16,0xD7	
		cp		r18,r16		
		brge	lvl6a		
		ldi		r16,0xD2	
		cp		r18,r16		
		brge	lvl7a		
		ldi		r16,0xCD	
		cp		r18,r16		
		brge	lvl8a		
		ldi		r16,0xC8	
		cp		r18,r16		
		brge	lvl9a		
		ldi		r16,0xC3	
		cp		r18,r16		
		brge	lvl10a		
		ldi		r16,0xBE	
		cp		r18,r16		
		brge	lvl11a		
		ldi		r16,0xB9	
		cp		r18,r16		
		brge	lvl12a		
		ldi		r16,0xB4	
		cp		r18,r16		
		brge	lvl13a		
		ldi		r16,0xAF	
		cp		r18,r16		
		brge	lvl14a		
		ldi		r16,0xAA	
		cp		r18,r16		
		brge	lvl15a		
		ldi		r16,0xA5	
		cp		r18,r16		
		brge	lvl16a		
		ldi		r16,0xA0	
		cp		r18,r16		
		brge	lvl17a		
		ldi		r16,0x9B	
		cp		r18,r16		
		brge	lvl18a		
		ldi		r16,0x96	
		cp		r18,r16		
		brge	lvl19a		

lvl1:	ldi		r16,0x00	
		ldi		r17,0x53	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl2:	ldi		r16,0x00	
		ldi		r17,0xB7	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

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

lvl3b:	ldi		r16,0x01	
		ldi		r17,0x1B	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl4b:	ldi		r16,0x01	
		ldi		r17,0x7F	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl5b:	ldi		r16,0x01	
		ldi		r17,0xE3	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl6b:	ldi		r16,0x02	
		ldi		r17,0x47	
		sts		OCR1AH,r16
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl7b:	ldi		r16,0x02	
		ldi		r17,0xAB	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl8b:	ldi		r16,0x03	
		ldi		r17,0x0F	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl9b:	ldi		r16,0x03	
		ldi		r17,0x73	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		
		
lvl10b:	ldi		r16,0x03	
		ldi		r17,0xD7	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl11b:	ldi		r16,0x04	
		ldi		r17,0x3B	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl12b:	ldi		r16,0x04	
		ldi		r17,0x9F	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl13b:	ldi		r16,0x05	
		ldi		r17,0x03	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl14b:	ldi		r16,0x05	
		ldi		r17,0x67	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl15b:	ldi		r16,0x05	
		ldi		r17,0xCB	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl16b:	ldi		r16,0x06	
		ldi		r17,0x2F	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl17b:	ldi		r16,0x06	
		ldi		r17,0x93	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl18b:	ldi		r16,0x07	
		ldi		r17,0x5B	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		

lvl19b:	ldi		r16,0x08	
		ldi		r17,0x23	
		sts		OCR1AH,r16	
		sts		OCR1AL,r17	
		rjmp	Loop		
		
		sei					

ADC_Get:
		ldi     r16,0xC7	
		sts     ADCSRA,r16  
A2V1:   lds     r16,ADCSRA  
        sbrc    r16,ADSC    
        rjmp    A2V1        
        ret					