#define __SFR_OFFSET 0
	
#include   "avr/io.h"

INIC:
	SER 	R16
	OUT 	DDRB, R16
main:
	LDI	0b00000001
	OUT 	PORTB, R16
	CALL	DELAY
	CLR 	R16
	OUT 	PORTB, R16
	CALL	DELAY
	JMP	main


DELAY:
	push r18
	push r19
	push r20
  	ldi r20, 15
ciclo0:	ldi r19, 200
ciclo1:	ldi r18, 111
ciclo2:	dec r18
	brne ciclo2

	dec r19
	brne ciclo1
		 
	dec r20
	brne ciclo0

	pop r20
	pop r19
	pop r18
	ret
