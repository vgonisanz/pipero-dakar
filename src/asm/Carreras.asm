		ORG H'100
	
		Include "Funciones.asm"
		Include "Tablas.asm"
		Include "Inicio.asm"
		Include "Vidas.asm"
		Include "Palmeras.asm"
		Include "Piedras.asm"
		Include "Colisiones.asm"
		Include "Puntuacion.asm"

; Inicio del PROGRAMA PRINCIPAL

;********************************************************************************
;Variables Generales:

xInicial: 	 DW ?		;Posiciones para pintar
yInicial:	 DW ?
xActual:	 DW ?
yActual:	 DW ?
nFilas: 	 DW ?		;Número de espacios por fila
nActual:	 DW ?
CaracterNow:	 DW ?
ColorCar:	 DW ?
ColorFon:	 DW ?
FinTabla:	 DW 0		; Comprueba si ha terminado de pintar una tabla
NumeroVidas:	 DW ?		; Vidas
MultiColor:	 DW ?
PosCarx:	 DW ?		; Posición del coche en todo momento
PosCary:	 DW ?
Semilla:	 DW ?
CuentaLineas:	 DW ?
VarInicio:	 DW 0
HayCoche:	 DW 0
NumPiedras:	 DW 0
Tespera:	 DW ?		; Tiempo del contador (1 = 50 ms)
PiedrasBorradas: DW 0		; Contador de piedras quitadas
Iteracion:	 DW 0		; Var auxiliar de vueltas del bucle

;********************************************************************************		
;Variables puntuación

Puntos:		DW 48,48,48,48,48,48,0
Centmiles:	DW 48
Decmiles:	DW 48
Miles:		DW 48
Centenas:	DW 48
Decenas:	DW 48
Unidades:	DW 48

;********************************************************************************
;Variables Piedras Aleatorias:

Piedrasx:	DW 0,0,0,0,0,0,0,0,0,0
Piedrasy:	DW 0,0,0,0,0,0,0,0,0,0

;********************************************************************************
;Teclas para usar:

TECLA_IZDA 	EQU H'25
TECLA_DCHA 	EQU H'27
TECLA_ESPACIO	EQU H'20


MIN_X 		EQU 2
MAX_X 		EQU 19

;********************************************************************************
; Prepara el juego

Inicio: 	LD 	.7,#H'8000 	; Inicia puntero pila
						
		LD	.0,#2		; Estado int activo teclado
		OUT	.0,/160
		STI			; Habilita interrupciones
			
		LD 	.0,#3		; Pongo vidas iniciales
		ST 	.0,/NumeroVidas
		LD 	.0,#13
		ST 	.0,/Tespera
	
;Inicialización del juego 		Pantalla de bienvenida

		CALL 	#PintarArena
		CALL 	#PintarPalm
		LD 	.0,#8		;Pos X
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#12		;Pos Y
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#1		;Color Car
		ST 	.0,/ColorCar
		LD 	.0,#43		;Color Fondo
		ST 	.0,/ColorFon
		LD 	.0,#12
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.6,#TablaBien1
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		LD 	.0,#8		;Pos X
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#13		;Pos Y
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#1		;color car
		ST 	.0,/ColorCar
		LD 	.0,#43		;color fondo
		ST 	.0,/ColorFon
		LD 	.0,#16
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.6,#TablaBien2
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

			
Akialao:	LD 	.0,/VarInicio
		BZ 	#Akialao	; Cuando pulse Espacio pintará 
					; lo necesario para jugar

; Inicio y pinto vidas

		CALL 	#Iniciosemilla	;Cargo la semilla

; Texto Vidas (Pinta el texto vida en la posición indicada. Este será el formato de
; instrucciones para pintar tablas (Posicion (x,y), Color Carácter, Color Fondo)

		LD 	.0,#24		;Cargamos las posiciones (x,y) donde pintar
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#17
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/ColorCar	;Elegimos color de carácter
		LD 	.0,#4
		ST 	.0,/ColorFon	;Elegimos color de fondo
		LD 	.0,#14
		ST 	.0,/nFilas	;Número de filas de la tabla a pintar
		ST 	.0,/nActual
		LD 	.6,#FraseVidas	;Tabla a pintar
		CALL 	#PintarTabla	;Estas dos llamadas a funciones pintan
		CALL 	#EsperaFinTabla	;hasta que llega el fin de la tabla

;Texto puntuación (Siguiendo la misma estructura para pintar)
		
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
;Texto Nivel
		LD 	.0,#25
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,#4
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/ColorCar
		LD 	.0,#4
		ST 	.0,/ColorFon
		LD 	.0,#14
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.6,#Nivel
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla

		CALL 	#ElNivel	; Escribe el nivel en el que esta

		CALL 	#nPuntos
		CALL 	#PintarInicio	; Prepara el coche y Tablero			

Juego:		LD 	.0,#5
		ST 	.0,/Iteracion
			
Normal:		LD 	.0,/Iteracion
		BZ 	#Otra
		CALL 	#Tempo
		CALL 	#BorraPiedras
		CALL 	#MuevePiedras
		CALL 	#QuitaPiedras
		CALL 	#PintaPiedras
		LD 	.0,/Iteracion
		BZ 	#Otra
		DEC 	.0
		ST 	.0,/Iteracion
		BR 	#Normal


Otra:		CALL 	#Tempo
		CALL 	#BorraPiedras
		CALL 	#MuevePiedras
		CALL 	#QuitaPiedras
		CALL 	#NuevaPiedra
		CALL 	#PintaPiedras

		BR 	#Juego		;Todo el rato en el bucle
			
;********************************************************************************
Pintarcoche:	PUSH 	.0
		LD	.0,/PosCarx
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaCarColor3
		LD 	.6,#TablaCoche
		LD 	.0,#1		;ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL 	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0		;DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor
		POP 	.0
		RTS

Borrarcoche:	PUSH 	.0
		LD 	.0,/PosCarx
		ST 	.0,/xInicial
		ST 	.0,/xActual
		LD 	.0,/PosCary
		ST 	.0,/yInicial
		ST 	.0,/yActual
		LD 	.0,#3
		ST 	.0,/nFilas
		ST 	.0,/nActual
		LD 	.5,#TablaBorrarCar2
		LD 	.6,#TablaBorrarCar1
		LD 	.0,#1		; ACTIVA multicolor
		ST 	.0,/MultiColor
		CALL	#PintarTabla
		CALL 	#EsperaFinTabla
		LD 	.0,#0		; DESACTIVA MULTICOLOR
		ST 	.0,/MultiColor
		POP 	.0
		RTS

;********************************************************************************
;Movimiento de las teclas:

Leinicie:	PUSH 	.4
		LD 	.4,#1
		ST 	.4,/VarInicio
		POP 	.4
		RTS

MoverIzk:	PUSH 	.4
		LD 	.4,/HayCoche		;Comprueba si ha empezao el juego
		BZ 	#Pasando1
		LD 	.4,/PosCarx
		CMP 	.4,#MIN_X		;Comprueba si pisa la raya
		BZ 	#Pasando1
		STI
		CALL 	#BorrarCoche	 
		LD 	.4,/PosCarx		;Mueve a la izquierda
		DEC 	.4
		ST 	.4,/PosCarx
		CALL 	#PintarCoche
Pasando1:	POP 	.4
		RTS

MoverDcha:	PUSH 	.4
		LD 	.4,/HayCoche		;Comprueba si ha empezao el juego
		BZ 	#Pasando2
		LD 	.4,/PosCarx
		CMP 	.4,#MAX_X		;Comprueba si pisa la raya
		BZ 	#Pasando2
		STI
		CALL 	#BorrarCoche	 
		LD 	.4,/PosCarx		;Mueve a la derecha
		INC 	.4
		ST 	.4,/PosCarx
		STI
		CALL 	#PintarCoche
Pasando2:	POP 	.4
		RTS


;********************************************************************************
;Interpretación de las teclas:

Tecla:	 	CMP 	.0,#TECLA_DCHA		;Comprueba si es Dcha la tecla pulsada
		BNZ 	#Izquierda		;Sino, va a comprobar si es Izda
		CALL 	#MoverDcha		;Si es Derecha, mueve a Derecha
		CALL 	#ColiLatDcha		;Comprueba si hay Colisión
		BR 	#AcabarTecla		

Izquierda:	CMP 	.0,#TECLA_IZDA		;Comprueba si es Dcha la tecla pulsada
		BNZ 	#Espacio		;Sino, va a comprobar si es Espacio
		CALL 	#MoverIzk		;Si es Izquierda, mueve a Izquierda
		CALL 	#ColiLatIzd		;Comprueba si hay colisión
		BR 	#AcabarTecla		

Espacio:	CMP 	.0,#TECLA_ESPACIO	;Comprueba si es Espacio la tecla pulsada
		BNZ 	#AcabarTecla		
		CALL 	#Leinicie		;Si es espacio, Cambia VarInicio (Leinicie)	
		BR 	#AcabarTecla


AcabarTecla:	BR 	#VueltaTecla

;********************************************************************************
; Rutina de interrupción: ISRTeclado		
; Descripción: Rutina de interrupción del teclao	

ISRTec: 	PUSH 	.0		; Guardaré dato teclado
		PUSH 	.1
		PUSH 	.4		; Va a ser la auxiliar
		CLR 	.0
		IN 	.0,/160		
		IN 	.0,/161		; Carga dato teclado
		BR 	#Tecla
vueltatecla:	POP 	.4
		POP 	.1
		POP 	.0
		STI
		RTI

;********************************************************************************
; Rutina de interrupción: ISRPantalla
; Descripción: Rutina de interrupción de la pantalla

ISRPantalla: 	PUSH 	.0
		IN 	.0,/192 		; Acknowledge interrupt
		CALL	#Escribircaracter
		POP 	.0
		STI
		RTI

;********************************************************************************
; Vectores de interrupción

		ORG 	H'FFF0
		DW 	ISRTec 		; Vector de interrupción del teclado

		ORG 	H'FFF2
		DW 	ISRPantalla 	; Vector de interrupción de la pantalla

		ORG 	H'FFFE
		DW 	Inicio 		; Vector de reset

;********************************************************************************
END





