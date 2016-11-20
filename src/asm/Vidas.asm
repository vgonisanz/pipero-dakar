		ORG H'3200

;********************************************************************************
; Las vidas, controla si se ha acabado el juego y pinta GameOver si es el caso
; Además para el procesador cuando es Game Over	
;********************************************************************************

Vidas:		PUSH 	.0
		PUSH 	.1

		LD 	.1,/NumeroVidas		;Comprueba Vidas, y si no quedan (=0)
		BZ 	#GAMEOVER		;Vamos a Gameover
		
		DEC 	.1			;Decrementa uno para ver cuantas	
		LD 	.0,#25			;vidas hay que pintar
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD	.0,#18
		ST	.0,/yInicial
		ST	.0,/yActual
		CALL	#PintarVida		;Pinta 1ª Vida
		CALL 	#EsperaFinTabla

		SUB	.1,#0			;Comprueba si hay que pintar más vidas	
		BZ 	#FinVidas
		DEC 	.1			;Decrementa uno para ver cuantas
		LD 	.0,#28			;vidas hay que pintar
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#18
		ST 	.0,/yInicial
		ST 	.0,/yActual
		CALL 	#PintarVida		;Pinta 2ª Vida
		CALL 	#EsperaFinTabla

		SUB 	.1,#0			;Comprueba si hay que pintar más vidas	
		BZ 	#FinVidas
		DEC 	.1			;Decrementa uno para ver cuantas
		LD 	.0,#31			;vidas hay que pintar
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#18
		ST 	.0,/yInicial
		ST 	.0,/yActual
		CALL 	#PintarVida		;Pinta 3ª Vida
		CALL 	#EsperaFinTabla

FinVidas:	POP 	.1
		POP 	.0
		RTS

;********************************************************************************
; FASE FINAL DEL PROGRAMA, EL GAME OVER APAGA EL PROGRAMA!!!!! NO FUNCIón!!!!

GAMEOVER:	LD 	.0,#26
		ST 	.0,/CuentaLineas
		LD 	.0,#0			;Pos X
		ST	.0,/xInicial
		ST	.0,/xActual
		LD 	.0,#0			;Pos Y
		ST	.0,/yInicial
		ST	.0,/yActual
		LD 	.0,#14			;color car
		ST	.0,/ColorCar	
		LD 	.0,#43			;color fondo
		ST	.0,/ColorFon
		LD 	.0,#36
		ST	.0,/nFilas
		ST	.0,/nActual
ySigo:		LD 	.6,#TablaGo1
		CALL	#PintarTabla
		CALL 	#EsperaFinTabla

		LD 	.0,/xInicial
		ST	.0,/xActual
		LD	.0,/yInicial
		INC 	.0
		ST	.0,/yInicial	
		ST	.0,/yActual	
		LD	.0,#40
		ST	.0,/nFilas
		ST	.0,/nActual
		LD	.0,/CuentaLineas
		DEC 	.0
		ST	.0,/CuentaLineas
		BNZ 	#ySigo
		
		CALL 	#PintarPalm

		LD	.0,#15			;Pos X
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD	.0,#12			;Pos Y
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#43			;color fondo
		ST 	.0,/ColorFon
		LD	.0,#9
		ST	.0,/nFilas
		ST 	.0,/nActual
		LD	.6,#TablaGo2
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

; Texto puntuación

		LD 	.0,#25
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#10
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/ColorCar
		LD 	.0,#4
		ST 	.0,/ColorFon
		LD 	.0,#14
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.6,#Puntuacion
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		CALL 	#nPuntos		; Actualiza la puntuación

		HALT

;********************************************************************************
PintarVida:	PUSH 	.0			; Pinta una vida cuando se le llama

		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaCarColor4
		LD 	.6,#TablaCoche
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor
		POP 	.0
		RTS

;********************************************************************************
BorrarVidas:	LD 	.0,#24			;Pos X
		ST	.0,/xInicial
		ST	.0,/xActual
		LD	.0,#18			;Pos Y
		ST	.0,/yInicial
		ST	.0,/yActual
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#4			;color fondo
		ST	.0,/ColorFon
		LD	.0,#12
		ST	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#Frase12
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		LD 	.0,#24			;Pos X
		ST	.0,/xInicial
		ST 	.0,/xActual
		LD	.0,#19			;Pos Y
		ST	.0,/yInicial
		ST 	.0,/yActual
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#4			;color fondo
		ST 	.0,/ColorFon
		LD	.0,#12
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD	.6,#Frase12
		CALL	#PintarTabla
		CALL 	#EsperaFinTabla

		LD 	.0,#24			;Pos X
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD	.0,#20			;Pos Y
		ST 	.0,/yInicial
		ST	.0,/yActual
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#4			;color fondo
		ST 	.0,/ColorFon
		LD	.0,#12
		ST	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#Frase12
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		LD	.0,#24			;Pos X
		ST	.0,/xInicial
		ST 	.0,/xActual
		LD	.0,#21			;Pos Y
		ST	.0,/yInicial
		ST	.0,/yActual
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#4			;color fondo
		ST 	.0,/ColorFon
		LD	.0,#12
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD	.6,#Frase12
		CALL	#PintarTabla
		CALL 	#EsperaFinTabla

		LD 	.0,#24			;Pos X
		ST	.0,/xInicial
		ST	.0,/xActual
		LD	.0,#22			;Pos Y
		ST	.0,/yInicial
		ST 	.0,/yActual	
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#4			;color fondo
		ST	.0,/ColorFon
		LD	.0,#12
		ST 	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#Frase12
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		LD	.0,#24			;Pos X
		ST	.0,/xInicial
		ST	.0,/xActual
		LD 	.0,#23			;Pos Y
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD	.0,#14			;color car
		ST	.0,/ColorCar
		LD	.0,#4			;color fondo
		ST 	.0,/ColorFon
		LD	.0,#12
		ST 	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#Frase12
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		RTS

;********************************************************************************
END