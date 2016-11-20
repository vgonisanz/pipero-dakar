		ORG H'1400
	
; Toda TABLA debe acabar con un CERO!!!!
; Letras pulsar espacio	para esperar a empezar el juego	
; Prepara el coche y el terreno para participar

;********************************************************************************
PintarInicio:	
		CALL 	#ResetPiedras	;Resetea el vector piedras
		CALL 	#Road1
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL	#Road2
		CALL 	#Road2
		CALL	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2
		CALL 	#Road2

;Pide pulsar Espacio para Iniciar (Función tipo para pintar)
		LD 	.0,#25			
		ST 	.0,/xInicial
		ST	.0,/xActual
		LD 	.0,#2			
		ST	.0,/yInicial
		ST 	.0,/yActual
		LD	.0,#1			
		ST	.0,/ColorCar
		LD	.0,#43			
		ST	.0,/ColorFon
		LD	.0,#20
		ST	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#TablaPulsa
		CALL	 #PintarTabla
		CALL	 #EsperaFinTabla
		
		CALL	 #BorrarVidas
		CALL	 #Vidas

		LD	.0,#0			;Ponemos VarInicio a 0 para que se
		ST	.0,/VarInicio		;quede en el bucle Akialao2 y no 
						;salga hasta pulsar Espacio, que lo
Akialao2:	LD	.0,/VarInicio		;modificará, y saldrá de ahí
		BZ 	#Akialao2		;Cuando pulse Espacio pintará

;Comienza el juego

		LD 	.0,#6	
		ST 	.0,/Iteracion		;Establece iteraciones si ha explotado el coche

		LD	.0,#10
		ST 	.0,/HayCoche
		LD	.0,#17			; Pongo el coche
		ST	.0,/PosCarx
		LD	.0,#20
		ST	.0,/PosCary
		CALL 	#PintarCoche
;VAMOS!
		LD	.0,#25			;Pos X
		ST	.0,/xInicial
		ST	.0,/xActual
		LD	.0,#2			;Pos Y
		ST	.0,/yInicial
		ST 	.0,/yActual
		LD	.0,#14			;color car
		ST 	.0,/ColorCar
		LD 	.0,#43			;color fondo
		ST	.0,/ColorFon
		LD	.0,#20
		ST 	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#TablaVamos
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		CALL 	#NuevaPiedra   		;IMPORTANTE INICIALIZAR

		RTS

;********************************************************************************
;Funcion Carretera 1,2 y Siguiente

Road1:		LD 	.0,#2
		ST	.0,/ColorCar
		LD	.0,#6
		ST 	.0,/ColorFon
		LD 	.0,#0
		ST 	.0,/xActual
		ST 	.0,/xInicial
		ST 	.0,/yActual
		ST 	.0,/yInicial
		LD	.0,#24
		ST	.0,/nFilas
		ST	.0,/nActual
		LD	.6,#TablaCarretera
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla	
		RTS

Road2:		LD	.0,#0
		ST 	.0,/xActual
		ST	.0,/xInicial
		LD	.6,#TablaCarretera
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		RTS

SigRoad:	LD	.0,/yActual
		INC 	.0
		ST 	.0,/yActual
		RTS

;********************************************************************************

END