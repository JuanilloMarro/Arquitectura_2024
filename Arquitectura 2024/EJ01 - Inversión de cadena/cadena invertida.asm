; Invertir cadena
; Juan Diego Marroquín Escobar 1689821


%include '../../stdio/stdio32.asm'  

extern printf
section .data
	cadena db 'Hola mundo!', 0x0 section .text
 	global main, invertir_cadena

invertir_cadena:
  	push	ebp
  	mov ebp, esp
  	mov eax, [ebp+8]
  	push word 0

cadena_en_pila:
                
  	mov bl, byte [eax]
  	test bl, bl
  	jz fin_cadena_en_pila            
  	push bx
  	inc eax
  	jmp cadena_en_pila

fin_cadena_en_pila:
	mov eax, [ebp + 8]

invertir:
  	pop bx
  	mov byte [eax], bl
  	inc eax
  	test bl, bl
  	jnz invertir
  	leave
  	ret

main:
  	mov eax, cadena 
  	push eax
               
call invertir_cadena
  	mov eax, cadena   
  	push eax

  	call printf
  	add esp, 4    
  	mov eax, 0