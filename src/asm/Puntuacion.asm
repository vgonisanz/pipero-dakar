		ORG H'5000

;**********************************************************************
nPuntos:	LD 	.0,#30
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#11
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/ColorCar
		LD 	.0,#4
		ST 	.0,/ColorFon
		LD 	.0,#14
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.6,#Puntos
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		RTS

;**********************************************************************
;Actualiza Vector 

LeerPuntos:	PUSH 	.0
		LD 	.6,#Puntos
		LD 	.0,[.6++]
		ST 	.0,/Centmiles
		LD 	.0,[.6++]
		ST 	.0,/Decmiles
		LD 	.0,[.6++]
		ST 	.0,/Miles
		LD 	.0,[.6++]
		ST 	.0,/Centenas
		LD 	.0,[.6++]
		ST 	.0,/Decenas
		LD 	.0,[.6++]
		ST 	.0,/Unidades
		POP 	.0
		RTS

;**********************************************************************
GuardaPuntos:	PUSH 	.0
		LD 	.6,#Puntos
		LD 	.0,/Centmiles
		ST 	.0,[.6++]
		LD 	.0,/Decmiles
		ST 	.0,[.6++]
		LD 	.0,/Miles
		ST 	.0,[.6++]
		LD 	.0,/Centenas
		ST 	.0,[.6++]
		LD 	.0,/Decenas
		ST 	.0,[.6++]
		LD 	.0,/Unidades
		ST 	.0,[.6++]
		POP 	.0
		RTS

;**********************************************************************
;Suma Puntos y Actualiza Vector

SumaPuntos:	PUSH 	.0
		PUSH 	.1
		CALL 	#LeerPuntos
		CLR 	.1		
		LD 	.1,#48		; Pongo 0 en 1, para reseteos.

		LD 	.0,/Decenas
		CMP 	.0,#57
		BZ 	#Mas1		; Si es 57-->9,pongo a 0 y sumo uno siguiente
		INC 	.0		; Sino, incremento normal.
		ST 	.0,/Decenas
		BR 	#FinSuma
		
Mas1:		ST 	.1,/Decenas
		LD 	.0,/Centenas
		CMP 	.0,#57
		BZ 	#Mas2		; Si es 57-->9,pongo a 0 y sumo uno siguiente
		INC 	.0		; Sino, incremento normal.
		ST 	.0,/Centenas
		BR 	#FinSuma

Mas2:		ST 	.1,/Centenas
		LD 	.0,/Miles
		CMP 	.0,#57
		BZ 	#Mas3		; Si es 57-->9,pongo a 0 y sumo uno siguiente
		INC 	.0		; Sino, incremento normal.
		ST 	.0,/Miles
		BR 	#FinSuma

Mas3:		ST 	.1,/Miles
		LD 	.0,/Decmiles
		CMP 	.0,#57
		BZ 	#Mas4		; Si es 57-->9,pongo a 0 y sumo uno siguiente
		INC 	.0		; Sino, incremento normal.
		ST 	.0,/Decmiles
		BR 	#FinSuma

Mas4:		ST 	.1,/Decmiles
		LD 	.0,/Centmiles 	; Confiamos en que alguien no juege tanto como	
		INC 	.0		; Para llegar a esta puntuación :D
		ST 	.0,/Centmiles


FinSuma:	CALL 	#GuardaPuntos 	; Guardo puntos en el vector
		CALL 	#nPuntos	; Actualiza la puntuación

		pop 	.1
		pop 	.0
		RTS

;**********************************************************************
END