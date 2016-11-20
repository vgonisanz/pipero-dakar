		ORG H'1000

;********************************************************************************
Tempo:		PUSH 	.0		;Función que interpreta cuanto hay que esperar
		PUSH 	.1
		LD 	.0,/Tespera
		CLR 	.1
		OUT 	.1,/180
		OUT 	.0,/181
		LD 	.1,#4
		OUT 	.1,/180
		CLR 	.1
BucleEspera:	IN 	.1,/180
		AND 	.1,#1
		BZ 	#BucleEspera
		POP 	.1
		POP 	.0
		RTS

;********************************************************************************	
ElNivel:	PUSH 	.0		;Escribe el número del nivel por pantalla
		PUSH 	.1
		LD 	.0,#29
		OUT 	.0,/195
		LD 	.0,#5
		OUT 	.0,/196
		LD 	.0,#3
		ST 	.0,/ColorCar
		LD 	.0,#4
		ST 	.0,/ColorFon
		LD 	.0,#7
		LD 	.1,/Tespera	
		ASR	.1,#1
		ADD 	.0,#48			;Traduce a codigo numero ASCII	
		SUB 	.0,.1
		CMP 	.0,#55			;Ajusta de Nivel 1 a 5
		BNZ	#C5
		SUB	.0,#2
		BR	#NC
C5:		CMP	.0,#53
		BNZ	#C4
		SUB	.0,#1
		BR	#NC
C4:		CMP 	.0,#52
		BNZ	#NC
		SUB	.0,#1		
NC:		ST 	.0,/CaracterNow
		LD 	.0,/ColorCar		;Color Carácter
		OUT 	.0,/197
		LD 	.0,/ColorFon		;Color Fondo
		OUT 	.0,/198
		LD 	.0,/CaracterNow		
		OUT 	.0,/193
		POP 	.1
		POP 	.0
		RTS

;********************************************************************************
; Devuelve en el registro 0 un valor aleatorio

InicioSemilla:	PUSH 	.0
		LD 	.0,#H'1329
		ST 	.0,/Semilla
		POP 	.0
		RTS

Aleatorio:	PUSH 	.1
		LD 	.0,/Semilla
		LD 	.1,.0
		AND 	.1,#B'0100000000000000
		BZ 	#SigueAleatorio
		NOT 	.0

SigueAleatorio:	LSR 	.0
		LD 	.0,/Semilla
		ROL 	.0
		AND 	.0,#B'01111111111111111
		ST 	.0,/Semilla		
		POP 	.1			
		RTS

;********************************************************************************
; Función: EscribirCaracter
; Descripción: Escribe un caracter de un cuadrado
; Parámetros: ver variables para pintar un cuadrado de 6 x 6
; Devuelve: nada

EscribirCaracter:
		PUSH 	.0
		LD 	.0,[.6++]
		BZ 	#FinalizarTabla
		ST 	.0,/CaracterNow

EscribirX:	LD 	.0,/nActual
		BZ 	#ReiniciarX
		DEC 	.0
		ST 	.0,/nActual
		LD 	.0,/xActual		;Pos X
		OUT 	.0,/195
		INC 	.0
		ST 	.0,/xActual
		LD 	.0,/yActual		;Pos Y
		OUT 	.0,/196
		LD 	.0,/MultiColor
		BZ 	#SinColor
		LD 	.0,[.5++]
		ST 	.0,/ColorCar
		LD 	.0,[.5++]
		ST 	.0,/ColorFon
SinColor:	LD 	.0,/ColorCar		;Color Carácter
		OUT 	.0,/197
		LD 	.0,/ColorFon		;Color Fondo
		OUT 	.0,/198
		LD 	.0,/CaracterNow		
		OUT 	.0,/193
		BR 	#FinalizarTabla


ReiniciarX:	LD 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.0,/yActual
		INC 	.0
		ST 	.0,/yActual
		LD 	.0,/xInicial
		ST 	.0,/xActual
		BR 	#EscribirX

		
FinalizarTabla:	ST 	.0,/FinTabla
		POP 	.0
		RTS

;********************************************************************************
; Función: Pintartabla
; Descripción: Escribe un cuadrado en una zona de la pantalla
; Parámetros:
; R0: pos X de esquina superior izquierda del cuadrado (X < 36)
; R1: pos Y de esquina superior izquierda del cuadrado (Y < 16)
; R2: color del cuadrado a pintar (0 ? color ? 255).
; Devuelve: nada

PintarTabla:
		CLR 	.4 			; Inhabilita
		OUT 	.4,/192 		; interrupciones de video
		CALL 	#EsperaPantalla 	; Espera fin escritura

		CALL 	#EscribirCaracter

		LD 	.0,#2 			; Habilita interrupciones
		OUT 	.0,/192 		; de video.
	
		RTS 				; Vuelve.

;********************************************************************************
; Función: EsperaPantalla
; Descripción: Espera a que la pantalla esté lista para imprimir
; un carácter.
; Parámetros: ninguno
; Devuelve: nada

EsperaPantalla: PUSH  	.0
BucleEspPant: 	IN 	.0,/192
		AND 	.0,#1
		BZ 	#BucleEspPant
		POP 	.0
		RTS

;********************************************************************************
EsperaFinTabla:		
		LD 	.0,/FinTabla
		BNZ 	#EsperaFinTabla
		RTS

;********************************************************************************

END

