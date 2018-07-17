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
		brge	brit1boost		
		ldi		r16,0xEB	
		cp		r18,r16		
		brge	brit2boost		
		ldi		r16,0xE6	
		cp		r18,r16		
		brge	brit3boost		
		ldi		r16,0xE1	
		cp		r18,r16		
		brge	brit4boost		
		ldi		r16,0xDC	
		cp		r18,r16		
		brge	brit5boost		
		ldi		r16,0xD7	
		cp		r18,r16		
		brge	brit6boost		
		ldi		r16,0xD2	
		cp		r18,r16		
		brge	brit7boost		
		ldi		r16,0xCD	
		cp		r18,r16		
		brge	brit8boost		
		ldi		r16,0xC8	
		cp		r18,r16		
		brge	brit9boost		
		ldi		r16,0xC3	
		cp		r18,r16		
		brge	brit10boost		
		ldi		r16,0xBE	
		cp		r18,r16		
		brge	brit11boost		
		ldi		r16,0xB9	
		cp		r18,r16		
		brge	brit12boost		
		ldi		r16,0xB4	
		cp		r18,r16		
		brge	brit13boost		
		ldi		r16,0xAF	
		cp		r18,r16		
		brge	brit14boost		
		ldi		r16,0xAA	
		cp		r18,r16		
		brge	brit15boost		
		ldi		r16,0xA5	
		cp		r18,r16		
		brge	brit16boost		
		ldi		r16,0xA0	
		cp		r18,r16		
		brge	brit17boost		
		ldi		r16,0x9B	
		cp		r18,r16		
		brge	brit18boost		
		ldi		r16,0x96	
		cp		r18,r16		
		brge	brit19boost	
		
//Booster branches due to lacking range of conditional branching
brit1boost:		rjmp	brit1
brit2boost:		rjmp	brit2
brit3boost:		rjmp	brit3
brit4boost:		rjmp	brit4
brit5boost:		rjmp	brit5
brit6boost:		rjmp	brit6
brit7boost:		rjmp	brit7
brit8boost:		rjmp	brit8
brit9boost:		rjmp	brit9
brit10boost:	rjmp	brit10
brit11boost:	rjmp	brit11
brit12boost:	rjmp	brit12
brit13boost:	rjmp	brit13
brit14boost:	rjmp	brit14
brit15boost:	rjmp	brit15
brit16boost:	rjmp	brit16
brit17boost:	rjmp	brit17
brit18boost:	rjmp	brit18
brit19boost:	rjmp	brit19

brit1:
		ldi		r16,0x00
		ldi		r17,0x53
		call	ChangeBrit
		rjmp	Loop

brit2:
		ldi		r16,0x00
		ldi		r17,0xB7
		call	ChangeBrit
		rjmp	Loop

brit3:	
		ldi		r16,0x01
		ldi		r17,0x1B
		call	ChangeBrit
		rjmp	Loop

brit4:
		ldi		r16,0x01
		ldi		r17,0x7F
		call	ChangeBrit
		rjmp	Loop

brit5:
		ldi		r16,0x01
		ldi		r17,0xE3
		call	ChangeBrit
		rjmp	Loop

brit6:
		ldi		r16,0x02
		ldi		r17,0x47
		call	ChangeBrit
		rjmp	Loop

brit7:
		ldi		r16,0x02
		ldi		r17,0xAB
		call	ChangeBrit
		rjmp	Loop

brit8:	
		ldi		r16,0x03
		ldi		r17,0x0F
		call	ChangeBrit
		rjmp	Loop

brit9:
		ldi		r16,0x03
		ldi		r17,0x73
		call	ChangeBrit
		rjmp	Loop

brit10:	
		ldi		r16,0x03
		ldi		r17,0xD7
		call	ChangeBrit
		rjmp	Loop

brit11:	
		ldi		r16,0x03
		ldi		r17,0x3B
		call	ChangeBrit
		rjmp	Loop

brit12:	
		ldi		r16,0x04
		ldi		r17,0x9F
		call	ChangeBrit
		rjmp	Loop

brit13:	
		ldi		r16,0x05
		ldi		r17,0x03
		call	ChangeBrit
		rjmp	Loop

brit14:	
		ldi		r16,0x05
		ldi		r17,0x67
		call	ChangeBrit
		rjmp	Loop

brit15:	
		ldi		r16,0x05
		ldi		r17,0xCB
		call	ChangeBrit
		rjmp	Loop

brit16:	
		ldi		r16,0x06
		ldi		r17,0x2F
		call	ChangeBrit
		rjmp	Loop

brit17:	
		ldi		r16,0x06
		ldi		r17,0x93
		call	ChangeBrit
		rjmp	Loop

brit18:	
		ldi		r16,0x07
		ldi		r17,0x5B
		call	ChangeBrit
		rjmp	Loop

brit19:	
		ldi		r16,0x08
		ldi		r17,0x23
		call	ChangeBrit
		rjmp	Loop

ChangeBrit:
		sts		OCR1AH,r16
		sts		OCR1AL,r17
		ret

		sei					

ADC_Get:
		ldi     r16,0xC7	
		sts     ADCSRA,r16  
A2V1:   lds     r16,ADCSRA  
        sbrc    r16,ADSC    
        rjmp    A2V1        
        ret					