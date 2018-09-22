;
;Autor: Cesar Darinel Ortiz
;Tarea: Laboratorio 2
;FechaEntrega: 27/09/2018
;
.model small
.stack 256
.data
;========================Variables declaradas aqui===========================
letrero DB ' INSERTE UNA CADENA :$'	                ; Cadena a desplegar
pedirvariable DB ' INSERTE LA VARIABLE A BUSCAR :$'	; Cadena a desplegar
buffercapura db 51 dup (0)		                   	; buffer de lectura de cadena
variableBuscada db 1 dup (0)			            ; buffer de lectura de cadena
.code
;============================================================================
INICIO:	
			mov ax,@data
			mov ds,ax
			mov es, ax                  		;set segment register
			and sp, not 3               		;align stack to avoid AC fault
;====================================Código==================================  
			mov ah,09				        ; Para mostrar en pantalla una cadena
			mov dx, offset letrero			; posición de la cadena a montar
			int 21h
ciclolectura:
			mov ah,01				; para lectura de teclado.
			int 21h					;llamada al SO
			cmp al,13				;verifico si se pulsó el Enter.
			je ImprimoLetrerocaptura
			mov buffercapura[bx],al				;copio el caracter tomado en el buffer.
			inc cl					            ;cuento tecla pulsada

			cmp Ch,buffercapura[bx]				;verifico si debo de salir.
			je Salida
			inc bx					; apunto a la sgte. posición del buffer.
			jmp ciclolectura

ImprimoLetrerocaptura:
			mov Ch,'q'				        ;caracter para terminar la captura
			mov ah,09				        ; Para mostrar en pantalla una cadena
			mov dx, offset pedirvariable			; posición de la cadena a montar
			int 21h
			je Salida
Salida:
;============================================================================
.exit
end INICIO


















