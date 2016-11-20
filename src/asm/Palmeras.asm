		ORG H'3500

;**********************************************************************
PintarArena:	PUSH	.0		; Función que pinta diversos elementos
		LD 	.0,#26
		ST 	.0,/CuentaLineas
		LD 	.0,#0
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#0
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#43
		ST 	.0,/ColorFon
		LD 	.0,#40
		ST 	.0,/nFilas
		ST 	.0,/nActual
ySigo2:		LD 	.6,#TablaArena
		CALL	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/yInicial
		INC	.0
		ST 	.0,/yInicial	
		ST 	.0,/yActual	
		LD 	.0,#40
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD	.0,/CuentaLineas
		DEC	.0
		ST	.0,/CuentaLineas
		BNZ 	#ySigo2
		POP	.0
		RTS

;**********************************************************************
PintarPalm:	PUSH 	.0
		LD 	.0,#1
		ST 	.0,/xInicial
		ST 	.0,/xActual
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#8
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaPal2
		LD 	.6,#TablaPal1
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL	#EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST	.0,/MultiColor

		LD	.0,#9
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#15
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#8
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaPal2
		LD 	.6,#TablaPal1
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,#32
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#3
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#8
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaPal2
		LD 	.6,#TablaPal1
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor	
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,#36
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#18
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaCactus
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL	 #PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,#25
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#12
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaCactus
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL	 #PintarTabla
		CALL	 #EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,#15
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#5
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaCactus
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1			; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL	 #PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0			; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		POP	 .0
		RTS

;**********************************************************************
END

