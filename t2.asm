;
;Autor: Cesar Darinel Ortiz
;Tarea: 2 laboratorio
;FechaEntrega: 27/09/2018
;

.model small
.stack 256
.data
;========================Variables declaradas aqui===========================
letrero DB 'INSERTE UNA CADENA NO MAS DE 50 CARACTERES-->: $'	                ; Cadena a desplegar
pedirvariable DB 'INSERTE LA VARIABLE A BUSCAR : $'	; Cadena a desplegar
text DB 'EL CARACTER A BUSCAR ES : $'	        ; Cadena a desplegar
text2 DB 'Y SE REPITE : $'	        ; Cadena a desplegar
arregloConDatos db 51 dup (0)		                ; buffer de lectura de cadena
variableBuscada db 1 dup (0)			            ; buffer de lectura de cadena
count db 1 dup (2)
segundodigito db 1 dup (2)			                        ; buffer de lectura de cadena
.code
;============================================================================
inicio:	
			mov ax,@data
			mov ds,ax
			mov es,ax                  	;set segment register
			and sp,not 3               	;align stack to avoid AC fault
;====================================Código==================================  

			mov ah,09				        ;Para mostrar en pantalla una cadena
			mov dx, offset letrero			;posición de la cadena a montar
			int 21h                         ; llamo al sistema 

			mov bx,00						; no se si se necesita pero programacion fucional inicio todo en cero
ciclodelectura:
			mov ah,01						;para lectura de teclado.
			int 21h							;llamada al SO
			cmp al,13						;verifico si se pulsó el Enter.
			je imprimoLetreroCaptura
			mov arregloConDatos[bx],al		;copio el caracter tomado en el buffer.
			cmp bx,50						;verifico si debo de salir.
			je imprimoLetreroCaptura                       
			inc bx							;apunto a la sgte. posición del buffer.
			jmp ciclodelectura

imprimoLetreroCaptura:

			mov ah,09				        ;Para mostrar en pantalla una cadena
			mov dx, offset pedirvariable	;posición de la cadena a montar
			int 21h

			mov ah,01					    ;para lectura de teclado.
			int 21h							;llamada al SO
			mov variableBuscada,al

			mov bx,00						; no se si se necesita pero programacion fucional inicio todo en cero
			mov count,00				    ; sino inicializando cero
			mov al,variableBuscada			;muevo a al para comparar 
ciclodeconteo:
			cmp arregloConDatos[bx],al;
			jne nocuento
			inc count
	nocuento:
			cmp bx,50						;verifico si debo de salir.
			je letreroFinal                       
			inc bx							;apunto a la sgte. posición del buffer.
			jmp ciclodeconteo

letreroFinal:
			mov al,count
			aam ; separo
			mov count,ah
			mov segundodigito,al

			mov ah,02						;para mostrar caracter
			mov dl,10                       ;imprimo el caracter de salto de linea 
			int 21h                         ;llamada sistema 
			
			mov ah,09				        ;Para mostrar en pantalla una cadena
			mov dx, offset text2	;posición de la cadena a montar
			int 21h

			add count,48
			mov ah,02						;para mostrar caracter
			mov dl,count                       ;imprimo el caracter de salto de linea 
			int 21h

			add segundodigito,48
			mov ah,02						;para mostrar caracter
			mov dl,segundodigito                       ;imprimo el caracter de salto de linea 
			int 21h

			mov ah,02						;para mostrar caracter
			mov dl,10                       ;imprimo el caracter de salto de linea 
			int 21h
			

;************************************************************************
Salida:
;============================================================================
.exit
end inicio


















