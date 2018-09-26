;
;Autor: Cesar Darinel Ortiz
;Tarea: 2 laboratorio
;FechaEntrega: 27/09/2018
;

.model small
.stack 256
.data
;========================Variables declaradas aqui===========================
letrero DB 'INSERTE UNA CADENA NO MAS DE 50 CARACTERES-->: $'	; texto a solicita la cadena
pedirvariable DB 'INSERTE LA VARIABLE A BUSCAR : $'		; texto inserta variable a buscar 
text2 DB 'Y SE REPITE : $'	        			; Cadena a desplegar
arregloConDatos db 51 dup (0)		                	; buffer de lectura de cadena
variableBuscada db 1 dup (0)			            	; la variable que estamos buscando
count db 1 dup (2)						; un contador 
segundodigito db 1 dup (2)			                ; sendo digito para imprimir
.code
;============================================================================
inicio:	
			mov ax,@data			;	
			mov ds,ax			;
			mov es,ax                  	;set segment register
			and sp,not 3               	;align stack to avoid AC fault
;====================================Código==================================  

			mov ah,09			;Para mostrar en pantalla una cadena
			mov dx, offset letrero		;posición de la cadena a montar
			int 21h                         ;llamo al sistema 

			mov bx,00			;no se si se necesita pero programacion fucional inicio todo en cero
ciclodelectura:
			mov ah,01			;para lectura de teclado.
			int 21h				;llamada al SO
			cmp al,13			;verifico si se pulsó el Enter.
			je imprimoLetreroCaptura	;saltamos a solicitar el caracter si preciona enter
			mov arregloConDatos[bx],al	;copio el caracter tomado en el buffer.
			cmp bx,50			;verifico si debo de salir.
			je imprimoLetreroCaptura        ;si escribimos mas de 50 caracteres dejo de leer               
			inc bx				;apunto a la sgte. posición del buffer.
			jmp ciclodelectura		;continuo leyendo

imprimoLetreroCaptura:

			mov ah,09			;Para mostrar en pantalla una cadena
			mov dx, offset pedirvariable	;posición de la cadena a montar
			int 21h				;llamada al sistema

			mov ah,01			;para lectura de teclado.
			int 21h				;llamada al SO
			mov variableBuscada,al		;muevo lo que esta en al al campo variablebuscada

			mov bx,00			;no se si se necesita pero programacion fucional inicio todo en cero
			mov count,00			;sino inicializando cero
			mov al,variableBuscada		;muevo a al para comparar 
ciclodeconteo:
			cmp arregloConDatos[bx],al;	;comparo el monto con la variable a buscar
			jne nocuento			;si no son iguales no cuento 
			inc count			;si son iguales cuento lavariable
	nocuento:					
			cmp bx,50			;verifico si debo de salir.
			je letreroFinal                 ;salimos del cilo y vamos al final     
			inc bx				;apunto a la sgte. posición del buffer.
			jmp ciclodeconteo		;retornamos al ciclo	

letreroFinal:
			mov al,count			;paso el monto a al para separarlos
			aam 				;separo el monto de al en dosquedan (ah/al)
			mov count,ah			;muevo el monto de ah a la variable a presentar
			mov segundodigito,al		;muevo el monto de al a la variable a presentar

			mov ah,02			;para mostrar caracter
			mov dl,10                       ;imprimo el caracter de salto de linea 
			int 21h                         ;llamada sistema 
			
			mov ah,09			;Para mostrar en pantalla una cadena
			mov dx, offset text2	        ;posición de la cadena a montar
			int 21h               		;Llamada al sistema 

			add count,48			;sumo 48 para que pase a la tabla ascii
			mov ah,02			;para mostrar caracter
			mov dl,count                    ;imprimo el caracter de salto de linea 
			int 21h				;Llamada al sistema

			add segundodigito,48            ;sumo 48 para que pase a la tabla ascii
			mov ah,02			;para mostrar caracter
			mov dl,segundodigito            ;imprimo el caracter de salto de linea 
			int 21h				;Llamada a sistema
			

;************************************************************************
Salida:
;============================================================================
.exit
end inicio


















