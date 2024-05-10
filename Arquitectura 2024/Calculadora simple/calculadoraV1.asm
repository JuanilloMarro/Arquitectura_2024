%include 'stdio32.asm'

SECTION .data
	msg1	db	'Ingrese una operacion: ', 0h
		
SECTION .bss
	cadena:	resb	255

SECTION .text
	global _start

_start:
	mov     eax,msg1
    	call    printStr
    	mov     eax,cadena
    	call    Input
	
	
;--------Leer----------			;proeso de lectura de cadena operatoria
operacion:
    	cmp   	byte[eax],0h			;Si se acaba termina
    	je      fin
    	cmp     byte[eax],48			;Si [eax] men a 48 es simbolo de operacion
    	jl      operador
    	cmp     byte[eax],58			;Si [eax] men a 58 es un numero
    	jl      num
    	cmp     byte[eax],58			;si [eax] may a 58 no es valido
    	jg      sig
    

suma:						;proceso suma
    	pop     ebx
    	mov     edx,ebx
    	pop     ebx
    	add     ebx,edx
    	push    ebx
    	jmp     sig

resta:						;proceso resta
    	pop     ebx
    	mov     edx,ebx
    	pop     ebx
    	sub     ebx,edx
    	push    ebx
    	jmp     sig

multiplicacion:				;proceso multiplicacion
    	pop     ebx
    	mov     edx,ebx
    	pop     ebx
    	push    eax
    	mov     eax,ebx
    	imul    edx
    	mov     ebx,eax
    	pop     eax
    	push    ebx
    	jmp     sig

operador:
    	cmp     byte[eax],43    		;+
    	je      suma            
    	cmp     byte[eax],45    		;-
    	je      resta   	
    	cmp     byte[eax],42    		;*
    	je      multiplicacion   
    	cmp     byte[eax],47    		;/
    	je      division
    	jmp     sig

division:					;proceso division
    	pop     ebx
    	pop     edx
    	push    eax
    	mov     eax,edx
    	mov     edx,0
    	idiv    ebx
    	mov     ebx,eax
    	pop     eax
    	push    ebx
    	jmp     sig
    	
;-----------------reconocimiento de ascii para dar valor----------
num:
    	cmp     byte[eax],48
    	je	cero
    
    	cmp     byte[eax],49
    	je	uno
    
    	cmp     byte[eax],50
    	je	dos
    
    	cmp     byte[eax],51
    	je	tres
    
    	cmp     byte[eax],52
    	je	cuatro
    	
    	cmp     byte[eax],53
    	je	cinco
    
    	cmp     byte[eax],54
    	je 	seis
    
    	cmp     byte[eax],55
    	je	siete
    
    	cmp     byte[eax],56
    	je	ocho
    
    	cmp     byte[eax],57
    	je	nueve
    
;--------------------------Asigancion de valores para la pila----------    
cero:    
    	mov     ebx,0
    	push    ebx
    	jmp     sig
uno:
    	mov     ebx,1
    	push    ebx
    	jmp     sig
dos:
    	mov     ebx,2
    	push    ebx
    	jmp     sig
tres:
    	mov     ebx,3
    	push    ebx
    	jmp     sig
cuatro:
    	mov     ebx,4
    	push    ebx
    	jmp     sig
cinco:
    	mov     ebx,5
    	push    ebx
    	jmp     sig
seis:
    	mov     ebx,6
    	push    ebx
    	jmp     sig
siete:
    	mov     ebx,7
    	push    ebx
    	jmp     sig
ocho:
    	mov     ebx,8
    	push    ebx
    	jmp     sig
nueve:
    	mov     ebx,9   
    	push    ebx
    	jmp     sig

sig:
    	inc     eax
    	jmp     operacion   
;-----------fin del programa---------
fin:
    	mov     eax,ebx
    	call    printInt
    	call    endP
