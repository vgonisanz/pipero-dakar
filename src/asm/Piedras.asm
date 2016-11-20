		ORG H'2300

;**********************************************************************
; Todas las funciones referentes a las piedras, menos reset piedra (borrar vectores)
;**********************************************************************
PintaPiedras:	PUSH 	.0				
		PUSH 	.1
		PUSH 	.2
		PUSH 	.5
		PUSH 	.6
		LD	.0,/NumPiedras
		LD	.1,#PiedrasX
		LD	.2,#PiedrasY
PP:		LD	.5,[.1++]
		ST 	.5,/Xinicial
		ST 	.5,/Xactual
		LD	.5,[.2++]
		ST 	.5,/Yinicial
		ST 	.5,/Yactual
		LD	.5,#0		; Colores piedra (car,fondo)
		ST	.5,/ColorCar
		LD	.5,#26
		ST	.5,/ColorFon
		LD 	.5,#1
		ST 	.5,/nFilas
		ST 	.5,/nActual
		LD	.6,#TablaPiedra
		PUSH	.0
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		POP	.0
		DEC 	.0
		BNZ 	#PP
		POP 	.6
		POP 	.5
		POP 	.2
		POP 	.1
		POP 	.0
		RTS

;**********************************************************************
MuevePiedras:	PUSH	.0			
		PUSH	.1		
		PUSH	.2		
		LD	.0,#Piedrasy
		LD	.1,/NumPiedras
MP:		LD	.2,[.0]
		INC	.2
		ST	.2,[.0++]
		DEC	.1
		BNZ	#MP
		CALL	#ColiFront
		POP	.2
		POP	.1
		POP  	.0
		RTS

;**********************************************************************
BorraPiedras:	PUSH 	.0				
		PUSH 	.1
		PUSH	.2
		PUSH 	.5
		PUSH 	.6
		LD	.0,/NumPiedras
		LD	.1,#Piedrasx
		LD	.2,#Piedrasy
BP:		LD	.5,[.1++]
		ST 	.5,/xInicial
		ST 	.5,/xActual
		LD	.5,[.2++]
		ST 	.5,/yInicial
		ST 	.5,/yActual
		LD	.5,#0		; Colores piedra (car,fondo)
		ST	.5,/ColorCar
		LD	.5,#6
		ST	.5,/ColorFon
		LD 	.5,#1
		ST 	.5,/nFilas
		ST 	.5,/nActual
		LD	.6,#TablaNoPiedra
		PUSH 	.0
		CALL	#PintarTabla
		CALL 	#EsperaFinTabla
		POP 	.0
		DEC 	.0
		BNZ 	#BP
		POP 	.6
		POP 	.5
		POP 	.2
		POP 	.1
		POP 	.0
		RTS

;**********************************************************************
QuitaPiedras:	PUSH	.0			
		PUSH	.1
		PUSH	.2
		PUSH	.3
		PUSH	.4		
		PUSH	.5
		PUSH 	.6	
		LD	.0,#Piedrasy
		LD	.1,[.0]
		CMP	.1,#25		; Posici�n en la que desaparece
		BNZ	#FinQP
		CALL 	#SumaPuntos	; Suma 30 puntos cada piedra quitada
		CALL 	#SumaPuntos
		CALL 	#SumaPuntos
		LD 	.0,/PiedrasBorradas	;Contamos Piedras borradas
		INC	.0			;para puntuaci�n y velocidad
		ST	.0,/PiedrasBorradas
		LD	.0,#Piedrasx
		LD	.1,#Piedrasy
		LD	.2,#Piedrasx
		LD	.3,#Piedrasy
		LD	.4,/NumPiedras
		ADD	.2,#2
		ADD	.3,#2
RepitQuitar:	LD	.5,[.2++]
		ST	.5,[.0++]
		LD	.5,[.3++]
		ST	.5,[.1++]
		DEC	.4
		BNZ	#RepitQuitar
		LD	.4,/NumPiedras
		DEC	.4
		ST	.4,/NumPiedras
		LD 	.4,/PiedrasBorradas
		CMP	.4,#5			; 5� piedra
		BNZ	#Velocidad2
		CALL 	#BajarTres
Velocidad2:	CMP	.4,#13			; 13� piedra
		BNZ	#Velocidad3
		CALL 	#BajarTres
Velocidad3:	CMP	.4,#30			; 30� piedra
		BNZ	#Velocidad4
		CALL 	#BajarTres
Velocidad4:	CMP	.4,#50			; 50� piedra
		BNZ	#FinQP
		CALL 	#BajarTres

FinQP:		CALL 	#SumaPuntos	; Suma 10 puntos cada bajada de pieza
		CALL 	#ElNivel	; Actualiza el nivel, si es que ha
		POP	.6		; cambiado
		POP	.5
		POP	.4
		POP	.3
		POP	.2
		POP	.1		
		POP	.0
		RTS

;**********************************************************************
NuevaPiedra:	PUSH	.0			
		PUSH	.1
		PUSH	.2
		PUSH	.3
RepiteAle:	CALL	#Aleatorio
		AND	.0,#B'0000000000011111
		CMP	.0,#19			; si es menor k 19 lo pillo
		BGT	#RepiteAle
		ADD	.0,#2			; pongo en l�mites

		LD	.1,#Piedrasx		; Cargo vectores piedras
		LD	.2,/NumPiedras		;Si no piedras, cargo aleatorio
		ADD 	.2,#0			;en primera posici�n de PiedrasX
		BNZ 	#Seguir			;y salgo de la funci�n
		ST	.0,[.1]			;Si 1 o m�s Piedras,salto a seguir
		BR	#FinNP			

Seguir:		BR	#Inicialice		;Vamos hacia la derecha buscando
Repet:		ADD	.1,#2			;la primera posici�n libre para
Inicialice:	LD	.3,[.1]			;insertar la nueva piedra.
		ADD	.3,#0
		BNZ	#Repet
		ST	.0,[.1]	
FinNP:		INC	.2
		ST	.2,/NumPiedras
		POP	.3
		POP	.2
		POP	.1
		POP	.0
		RTS

;**********************************************************************
ResetPiedras:	PUSH	.0
		PUSH	.1
		PUSH	.2
		PUSH	.3
		PUSH 	.4
		LD	.1,#Piedrasx
		LD	.2,#Piedrasy
		LD	.3,#10
Siguie:		LD	.4,#0
		ST	.4,[.1++]
		ST	.4,[.2++]
		DEC.3
		BNZ	#Siguie
		ST	.3,/NumPiedras
		POP	.4
		POP	.3
		POP	.2
		POP	.1
		POP	.0
		RTS

;**********************************************************************
BajarTres:	PUSH 	.1		;Funci�n que reduce el Tiempo Espera
		LD	.1,/Tespera	;Acelera el juego
		SUB 	.1,#3
		ST	.1,/Tespera
		POP 	.1
		RTS

;**********************************************************************
END


