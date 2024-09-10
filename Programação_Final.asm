CONTA	EQU	255     ;faz a contagem de "1" sinal lógico para realizar a interrupção.
LCD	EQU	P1      ;porta que passa os valores para o lcd.
RS	EQU	P2.0    ;controla display.
RW	EQU	P2.1    ;controla display.
EN	EQU	P2.2    ;controla display.
ENT0	BIT	P3.2    ;recebe o sinal lógico de INT0.
ENT1	BIT	P3.3    ;recebe o sinal lógico de INT0.

	ORG	0
	LJMP	MAIN	;programa principal.
	
	ORG	0003H   ;Interrupção que adiciona 4 pontos.
	LJMP	LOOP1	;Pula para loop1 para realizar o processo de somar 4 no placar.
	
	ORG	0013H	;Interrupção que adiciona 2 pontos.
	LJMP	LOOP2	;Pula para loop2 para realizar o processo de somar 2 no placar.

	ORG	001BH	;Interrupção que zera os placar.
	LJMP	PERDEU	;fim de jogo.


MAIN:			;programa principal.
	MOV P1,#0	;zera a porta p1 para.
	MOV IE,#88H	;habilita todas interrupções.
	SETB EA		
	SETB EX0
	SETB EX1
	MOV TL1,#CONTA	;carrega o valor no timer1.
	MOV TH1,#CONTA	
	MOV TMOD,#60H	;configura o timer.
	SETB TR1
	CLR RW		;começa a rotina para inicialização do lcd.
	CALL INI
	MOV A,#0C4H
	CALL CML
	JMP ACENDE

ACENDE:		
	JNB ENT0,TABELA	;se as interrupções forem acionas pula para a "tabela".
	JNB ENT1,TABELA
	MOV R0,#48	;move para o R0 (referente a unidade), o valor do algarismo "0".
	MOV R1,#48	;move para o R1 (referente a dezena), o valor do algarismo "0".
	MOV R2,#48	;move para o R2 (referente a centena), o valor do algarismo "0".
	MOV R3,#48	;move para o R3 (referente a milhar), o valor do algarismo "0".
	MOV R4,#48	;move para o R4 (referente a dezena de milhar), o valor do algarismo "0".
	MOV R5,#48	;move para o R5 (referente a centena de milhar), o valor do algarismo "0".
	MOV A,#0
	CALL ACENDE1	;salta para rotina acende1.
	JMP $

TABELA:			
	CJNE R0,#48,TABELAR0	;verifica se o valor e referente ao algarismo "0", se não salta para 
	CJNE R1,#48,TABELAR1	;tabela referente ao registrador.
	CJNE R2,#48,TABELAR2
	CJNE R3,#48,TABELAR3
	CJNE R4,#48,TABELAR4
	CJNE R5,#48,TABELAR5
	LJMP ACENDE1
TABELAR0:
	LJMP TABELA1
TABELAR1:
	LJMP TABELA2
TABELAR2:
	LJMP TABELA3
TABELAR3:
	LJMP TABELA4
TABELAR4:
	LJMP TABELA5
TABELAR5:
	LJMP TABELA6

TABELA1:			;tabela referente ao R0 que verifica se o algarismo está entre "0 a 9".
	CJNE R0,#49,TABELA9	
	LJMP ACENDE1
TABELA9:
	CJNE R0,#50,TABELA10
	LJMP ACENDE1
TABELA10:
	CJNE R0,#51,TABELA11
	LJMP ACENDE1
TABELA11:
	CJNE R0,#52,TABELA12
	LJMP ACENDE1
TABELA12:
	CJNE R0,#53,TABELA13
	LJMP ACENDE1
TABELA13:
	CJNE R0,#54,TABELA14
	LJMP ACENDE1
TABELA14:
	CJNE R0,#55,TABELA15
	LJMP ACENDE1
TABELA15:
	CJNE R0,#56,ZERA0
	LJMP ACENDE1
ZERA0:				;adiciona 1 no registrador R1(para aumentar o valor da dezena).
	MOV R0,#48		;volta o valor do registrador R0 para referente ao algarismo "0".
	LCALL DELAY
	MOV A,R1
	ADD A,#1
	MOV R1,A
	LJMP TABELA2	
TABELA2:			;tabela referente ao R1 que verifica se o algarismo está entre "0 a 9".
	CJNE R1,#49,TABELA16
	LJMP ACENDE1
TABELA16:
	CJNE R1,#50,TABELA17
	LJMP ACENDE1
TABELA17:
	CJNE R1,#51,TABELA18
	LJMP ACENDE1
TABELA18:
	CJNE R1,#52,TABELA19
	LJMP ACENDE1
TABELA19:
	CJNE R1,#53,TABELA20
	LJMP ACENDE1
TABELA20:
	CJNE R1,#54,TABELA21
	LJMP ACENDE1
TABELA21:
	CJNE R1,#55,TABELA22
	LJMP ACENDE1
TABELA22:
	CJNE R1,#56,ZERA1
	LJMP ACENDE1
ZERA1:				;adiciona 1 no registrador R2(para aumentar o valor da centena).
	MOV A,R2		;volta o valor do registrador R1 para referente ao algarismo "0".
	ADD A,#1
	MOV R2,A
	MOV R1,#48
	JMP TABELA3
	
TABELA3:			;tabela referente ao R2 que verifica se o algarismo está entre "0 a 9".
	CJNE R2,#49,TABELA23
	LJMP ACENDE1
TABELA23:
	CJNE R2,#50,TABELA24
	LJMP ACENDE1
TABELA24:
	CJNE R2,#51,TABELA25
	LJMP ACENDE1
TABELA25:
	CJNE R2,#52,TABELA26
	LJMP ACENDE1
TABELA26:
	CJNE R2,#53,TABELA27
	LJMP ACENDE1
TABELA27:
	CJNE R2,#54,TABELA28
	LJMP ACENDE1
TABELA28:
	CJNE R2,#55,TABELA29
	LJMP ACENDE1
TABELA29:
	CJNE R2,#56,ZERA2
	LJMP ACENDE1
ZERA2:				;adiciona 1 no registrador R3(para aumentar o valor da milhar).
	MOV R2,#48		;volta o valor do registrador R2 para referente ao algarismo "0".
	MOV A,R3
	ADD A,#1
	MOV R3,A
	LJMP TABELA4	
TABELA4:			;tabela referente ao R3 que verifica se o algarismo está entre "0 a 9".
	CJNE R3,#49,TABELA30
	LJMP ACENDE1
TABELA30:
	CJNE R3,#50,TABELA31
	LJMP ACENDE1
TABELA31:
	CJNE R3,#51,TABELA32
	LJMP ACENDE1
TABELA32:
	CJNE R3,#52,TABELA33
	LJMP ACENDE1
TABELA33:
	CJNE R3,#53,TABELA34
	LJMP ACENDE1
TABELA34:
	CJNE R3,#54,TABELA35
	LJMP ACENDE1
TABELA35:
	CJNE R3,#55,TABELA36
	LJMP ACENDE1
TABELA36:
	CJNE R3,#56,ZERA3
	LJMP ACENDE1
ZERA3:				;adiciona 1 no registrador R4(para aumentar o valor da dezena de milhar).
	MOV R3,#48		;volta o valor do registrador R3 para referente ao algarismo "0".
	MOV A,R4
	ADD A,#1
	MOV R4,A
	LJMP TABELA5	
TABELA5:			;tabela referente ao R4 que verifica se o algarismo está entre "0 a 9".
	CJNE R4,#49,TABELA37
	LJMP ACENDE1
TABELA37:
	CJNE R4,#50,TABELA38
	LJMP ACENDE1
TABELA38:
	CJNE R4,#51,TABELA39
	LJMP ACENDE1
TABELA39:
	CJNE R4,#52,TABELA40
	LJMP ACENDE1
TABELA40:
	CJNE R4,#53,TABELA41
	LJMP ACENDE1
TABELA41:
	CJNE R4,#54,TABELA42
	LJMP ACENDE1
TABELA42:
	CJNE R4,#55,TABELA43
	LJMP ACENDE1
TABELA43:
	CJNE R4,#56,ZERA4
	LJMP ACENDE1
ZERA4:				;adiciona 1 no registrador R5(para aumentar o valor da centena de milhar).
	MOV R4,#48		;volta o valor do registrador R4 para referente ao algarismo "0".
	MOV A,R5
	ADD A,#1
	MOV R5,A
	LJMP TABELA6	
TABELA6:			;tabela referente ao R5 que verifica se o algarismo está entre "0 a 9".
	CJNE R5,#49,TABELA44
	LJMP ACENDE1
TABELA44:
	CJNE R5,#50,TABELA45
	LJMP ACENDE1
TABELA45:
	CJNE R5,#51,TABELA46
	LJMP ACENDE1
TABELA46:
	CJNE R5,#52,TABELA47
	LJMP ACENDE1
TABELA47:
	CJNE R5,#53,TABELA48
	LJMP ACENDE1
TABELA48:
	CJNE R5,#54,TABELA49
	LJMP ACENDE1
TABELA49:
	CJNE R5,#55,TABELA50
	LJMP ACENDE1
TABELA50:
	CJNE R5,#56,ZERA5
	LJMP ACENDE1
ZERA5:
	MOV R5,#48		;volta o valor do registrador R0 para referente ao algarismo "0".
	MOV A,R6
	ADD A,#1
	MOV R6,A
	LJMP ACENDE1	


	
ACENDE1:			;rotina para mandar os valores dos registradores para a porta P1.
	CALL CML1
	MOV A,R5
	CALL WRL
	MOV A,R4
	CALL WRL
	MOV A,R3
	CALL WRL
	MOV A,R2
	CALL WRL
	MOV A,R1
	CALL WRL
	MOV A,R0
	CALL WRL
	LCALL DELAY
	RETI

INI:				;rotina de inicialização do lcd.
	MOV A,#38H
	CALL CML
	MOV A,#06H
	CALL CML
	MOV A,#01H
	CALL CML
	MOV A,#00CH
	CALL CML
	RET

CML:				;rotina de configuração do modo de receber dados do lcd.
	CLR RS
	CLR EN
	MOV LCD,A
	SETB EN
	CALL DELAY
	CLR EN
	RET
CML1:				;rotina utilizada para fazer o valor anterior sair do placar.		
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	CLR RS
	CLR EN
	MOV LCD,#01H
	SETB EN
	CALL DELAY
	CLR EN
	RET

WRL:				;rotina que escreve no lcd.
	SETB RS
	CLR EN
	MOV LCD,A
	SETB EN
	CALL DELAY
	CLR EN
	RET

LOOP1:				;função da interrupção que soma ao R0 o valor 4.
	MOV A,R0
	ADD A,#4
	MOV R0,A
	JB ENT0,$
	LJMP ACENDE		;depois de fazer a soma, pula para o ACENDE.

LOOP2:				;função da interrupção que soma ao R0 o valor 2.
	MOV A,R0
	ADD A,#2
	MOV R0,A
	JB ENT1,$
	LJMP ACENDE		;depois de fazer a soma, pula para o ACENDE.

PERDEU:				;rotina que irá zerar o valor do placar.
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	CALL PERDEU1

PERDEU1:			;nesta parte da rotina irá piscar o valor atual para mostrar a pontuação alcançada.
	LCALL DELAY
	CALL CML1
	LCALL DELAY
	MOV A,R5
	LCALL DELAY
	CALL WRL
	LCALL DELAY
	MOV A,R4
	LCALL DELAY
	CALL WRL
	LCALL DELAY
	MOV A,R3
	LCALL DELAY
	CALL WRL
	LCALL DELAY
	MOV A,R2
	LCALL DELAY
	CALL WRL
	LCALL DELAY
	MOV A,R1
	LCALL DELAY
	CALL WRL
	LCALL DELAY
	MOV A,R0
	LCALL DELAY
	CALL WRL
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	LCALL DELAY
	JMP PERDEU2

PERDEU2:			;neste passo se inicia o processo de "zerar" os registradores para "#48"(refente ao algarismo 0)
	MOV R0,#48
	MOV R1,#48
	MOV R2,#48
	MOV R3,#48
	MOV R4,#48
	MOV R5,#48
	JMP PERDEU3

PERDEU3:			;escreve o valor no lcd, assim zerando o placar e reinicando a contagem.
	CALL CML1
	MOV A,R5
	CALL WRL
	MOV A,R4
	CALL WRL
	MOV A,R3
	CALL WRL
	MOV A,R2
	CALL WRL
	MOV A,R1
	CALL WRL
	MOV A,R0
	CALL WRL
	RETI



DELAY:				;rotina de delay (aproximadamente 10ms)			
	MOV R7,#14

LD1:
	MOV R6,#0FAH
	DJNZ R6,$
	DJNZ R7,LD1
	RET
	END			;fim do programa