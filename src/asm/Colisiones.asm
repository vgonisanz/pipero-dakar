		ORG H'6000

;**********************************************************************
ColiLatIzd:
		PUSH	.0
		PUSH	.1
		PUSH	.2
		LD 	.0,/haycoche	;Si no hay coche, no explota
		BZ	#NoexplotaI
		LD	.0,#Piedrasx	
		LD	.1,#Piedrasy
		LD	.2,/PosCarx	;Carga posición x lateral izquierdo
		LD	.0,[.0]
		LD	.1,[.1]
		CMP	.1,#20		;Compara si hay piedra a la altura coche
		BLT	#NoexplotaI
		CMP	.0,.2		;Compara si hay piedra junto al coche
		BNZ	#NoexplotaI
		CALL	#Explosion
 NoexplotaI:	POP	.2
		POP	.1
		POP	.0
		RTS

;**********************************************************************
ColiLatDcha:
		PUSH	.0
		PUSH	.1
		PUSH	.2
		LD 	.0,/haycoche	;Si no hay coche, no explota
		BZ	#NoexplotaD
		LD	.0,#Piedrasx
		LD	.1,#Piedrasy
		LD	.2,/PosCarx  	;Carga posición x lateral izquierdo
		ADD	.2,#2		;Suma dos, para ser x del lateral derecho
		LD	.0,[.0]
		LD	.1,[.1]
		CMP	.1,#20		;Compara si hay piedra a la altura coche
		BLT	#NoexplotaD
		CMP	.0,.2		;Compara si hay piedra junto al coche
		BNZ	#NoexplotaD
		CALL	#Explosion
 NoexplotaD:	POP	.2
		POP	.1
		POP	.0
		RTS

;**********************************************************************
ColiFront:	
		PUSH	.0
		PUSH	.1
		LD	.0,/Piedrasy	;Comprueba si primera piedra está	
		CMP	.0,#19		;en fila del morro
		BLE	#NoexplotaF	
		LD	.0,/Piedrasx	
		LD	.1,/PosCarx
		CMP	.0,.1		;Comprueba si está en parachoques izquierdo
		BZ	#ExplotaF
		INC	.1
		CMP	.0,.1		;Comprueba si está en parachoques frontal
		BZ	#ExplotaF
		INC	.1
		CMP	.0,.1		;Comprueba si está en parachoques izquierdo
		BZ	#ExplotaF
		BR	#NoexplotaF
ExplotaF:	CALL	#Explosion
NoexplotaF:	POP	.1
		POP	.0
		RTS

;**********************************************************************
Explosion:	LD 	.0,#0		; Desactiva movimiento del coche
		ST 	.0,/HayCoche
		STI
		CALL 	#BorrarCoche	; Borra el coche
		LD 	.0,/NumeroVidas	; Quita una vida
		DEC 	.0
		ST 	.0,/NumeroVidas
		CALL 	#PintarFuego
		CALL 	#PintarInicio
Nada:		STI
		RTS

;**********************************************************************
PintarFuego:	PUSH 	.0

		LD 	.0,#26
		ST 	.0,/CuentaLineas
OtraExp:	LD 	.0,/PosCarx
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaBorrarCar3
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1		; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0		; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,/PosCarx
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaBorrarCar4
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1		; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0		; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,/PosCarx
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaBorrarCar5
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1		; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0		; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor

		LD 	.0,/PosCarx
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaBorrarCar6
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1		; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0		; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor
; Pone el bom
		LD 	.0,/PosCarx		;Pos X
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary		;Pos Y
		INC 	.0
		INC 	.0
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#1		;color car
		ST 	.0,/ColorCar
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.6,#Bom
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		LD 	.0,/CuentaLineas
		DEC 	.0
		ST 	.0,/CuentaLineas
		BZ 	#FinFuego
		JMP 	#OtraExp	;No va otro direccionamiento, uso salto absoluto

FinFuego:	CALL 	#BorrarCoche	
		POP 	.0
		RTS

;**********************************************************************
END
