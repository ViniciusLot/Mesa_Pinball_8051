	ORG	0
	LJMP	MAIN

	ORG	0003H
	LJMP	EST0
	
	ORG	0013H
	LJMP	EST1
	
EST0:
	MOV	A,R6
	JMP	LOOP1

EST1:
	MOV	A,R7
	JMP	LOOP1

MAIN:	
	MOV	P1,#0
	MOV	A,#0
	MOV	R6,#0101B
	MOV	R7,#1010B
	SETB	IT1
	SETB	EX0
	SETB	EX1
	SETB	EA
	JMP	$

LOOP1:
	MOV	P1,A
	RETI


	END