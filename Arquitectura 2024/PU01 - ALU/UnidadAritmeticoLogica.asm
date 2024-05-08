; Autor: JuanilloMarro
; 22 de Marzo de 2024
; Unidad Aritmético Lógica 



%include '../../../utils/stdio32.asm'

SECTIOn .data
	suma	db	'Suma: 90 + 9: ',0h
	resta	db	'Resta: 99 - 81: ',0h
	multi	db	'Multiplicacion 18 * 4: ',0h
	divi	db	'Division 72 / 5: ', 0h
	resi	db	' residuo: ',0h


SECTION .text
	global	_start

_start:
; Operación con suma
	mov	eax, suma
	call	print

	mov	eax, 90
	mov	ebx, 9
	add	eax, ebx
	call	iPrintLn

; Operación con resta
	push 	eax

	mov	eax, resta
	call	print

	pop 	eax
	mov 	ebx, 81
	sub	eax, ebx
	call	iPrintLn

; Operación con multiplicación
	push	eax

	mov	eax, multi
	call	print

	pop	eax
	mov	ebx, 4
	mul	ebx
	call	iPrintLn


; Operación con división
	push	eax
	
	mov	eax, divi
	call	print
	
	pop	eax
	push	edx
	mov	edx, 0
	mov	ebx, 5
	div	ebx
	call iPrintLn

	push	edx		;Guarda edx en pila, edx = residuo
	mov	eax, resi
	call	print
	pop	eax
	call	iPrintLn
	
	pop	edx

	call	sys_exit