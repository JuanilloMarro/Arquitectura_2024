SECTION .data
clear_str		db	    1Bh, '[2J', 1Bh, '[3J', 0h
 msg_not_number     db      "El valor no contiene valores validos para numero", 0H
 base_div			dd		10

SECTION .bss
    temporal:         resb        255

SECTION .text

; --------------Calculo de longitud de cadena-------------------
; srtLen(eax=cadena) -> eax int n = longitud
strLen:
	push	ebx		; ebx en la pila
	mov	ebx, eax	; mueve la direccion de la cadena ebx

sigChar:
	cmp	byte[eax], 0	; if msg(eax)== 0
	jz	finLen		; 	saltar al final
	inc 	eax
	jmp	sigChar		; Len op

finLen:
	sub	eax, ebx
	pop	ebx
	ret
;------------------Impresion en pantalla-----------------
; void printStr(eax = cadena)
printStr:
	push	 edx
	push	 ecx
	push	 ebx	;guardar el contenido en la pila
	push	 eax
	; Llamada a calculo de longitud
	; eax <- strLen(eax = cadena)
	call	 strLen

	mov	edx, eax
	pop    	eax
	mov	ecx, eax
	mov	ebx, 1
	mov	eax, 4
	int	80h

	; sacar los datos a donde estaban
	pop	ebx
	pop	ecx
	pop	edx
	ret

;-------------------Imprimir cadena con salto de linea--------------
; void prinStrLn(eax = cadena)
; imprime la cadena en pantalla seguida por la impresion de un salto de linea
printStrLn:
	call	printStr
	push	eax
	mov	eax, 0Ah
	push	eax
	mov	eax, esp
	call	printStr
	pop	eax
	pop	eax
	ret
;-----------Imprimir entero----------
printInt:
	push	eax
	push	ecx
	push	edx
	push	esi
	mov	ecx, 0

divLoop:
	inc	ecx		; conteo de digitos
	mov	edx, 0		; limpiar parte alta del dividendo
	mov	esi, 10		; esi = 10 (divisor)
	idiv	esi		; <edx:eax> / esi
	add	edx, 48		; residuo edx y cociente en eax
	push	edx
	cmp	eax, 0
printLoop:
	dec	ecx
	mov	eax, esp
	call	printStr
	pop	eax
	cmp	ecx, 0
	jnz	printLoop
	pop	esi
	pop	edx
	pop	ecx
	pop	eax
	ret
	jnz	divLoop


;------------------Imprimir entero con salto de linea--------
printIntLn:
	call	printInt
	push	eax
	mov	eax, 0Ah
	push	eax
	mov	eax, esp
	call	printStr
	pop	eax
	pop	eax
	ret

;-------------Pasar string o caracter a un número-----------
no_es_numero          db      "El valor no contiene valores validos para numero", 0H
cadena_numero:
    .copia:
        push        edx
        push        ecx
        push        ebx
        push        esi

    mov         ebx,0
    mov         esi, eax

    .ciclo:
        movzx   edx, byte[esi]
        cmp     dl, 0
        je      .ok

        cmp     dl, 48
        jl      .no_se_puede
        cmp     dl, 57
        jg      .no_se_puede

        sub     dl, 48
        imul    ebx, 10
        add     ebx, edx

        inc     esi
        jmp     .ciclo

    .no_se_puede:
        push        eax
        mov         eax, no_es_numero
        call        printStrLn
        pop         eax

    .ok:
        mov     eax, ebx

    .recuperar:
        pop     esi
        pop     ebx
        pop     ecx
        pop     edx
    ret


;-------------------Pedir valores en consola (INPUT)----------------
Input:
    ; copia de seguridad
    push        edx
    push        ecx
    push        ebx

    mov         eax, 3
    mov         ebx, 0
    mov         ecx, temporal
    mov         edx, 255
    int         80H

    ; Busca el salto de línea en el temporal
    push        edi
    mov         edi, ecx
    mov         ecx, eax
    xor         eax, eax
    cld
    repne       scasb
    je          .replace_jumpline

    mov         byte [edi + ecx], 0H

    .replace_jumpline:
        mov         byte [edi + eax - 1], 0H

    pop         edi
    pop         ebx
    pop         ecx
    pop         edx

    mov         eax, temporal
    ret

;----------------Conversion------------------------

;----------------PASAR UNA CADENA A UN ENTERO------------
cadena_a_entero:
    .copia_s:
        push        edx
        push        ecx
        push        ebx
        push        esi

    mov         ebx,0
    mov         esi, eax

    .recorrido:
        movzx   edx, byte[esi]      ; cargar en edx el siguiente byte del string en cl
        cmp     dl, 0               ; fin de caneda?
        je      .oki

        cmp     dl, 48              ; es menor a 0?
        jl      .invalido
        cmp     dl, 57              ; es mayor a 9?
        jg      .invalido

        sub     dl, 48              ; cl -= ASCII('0')
        imul    ebx, 10             ; multiplica el acumulador por 10
        add     ebx, edx            ; sumamos el valur numerico al acumulador

        inc     esi                 ; continuamos el recorrido
        jmp     .recorrido

    .invalido:
        push        eax
        mov         eax, msg_not_number
        call        printStrLn
        pop         eax

    .oki:
        mov     eax, ebx

    .devol:
        pop     esi
        pop     ebx
        pop     ecx
        pop     edx
    ret

;---------------PASAR UN ENTERO A CADENA--------------
entero_a_cadena:
    .copia_s:
        push        edx
        push        ecx
        push        ebx
        push        esi
    .iniciar:
        mov         esi, temporal     ; guardamos los valores en el temporal
        xor         ecx, ecx        ; reiniciamos el contador

        .recorrido:
            cmp         eax, 0          ; numeros terminados
            jle         .termin         ; termina bucle

            xor         edx, edx

            mov         ebx, [base_div]
            div         ebx

            .posiciones:
                add         dl, 48
                mov         byte[esi], dl
                inc         esi

            jmp         .recorrido
        .termin:
            push        esi
            .longitudcalc_cadena:  			 ; para calcular la longitud de la cadena
                mov         eax, temporal
                call        strLen
                mov         edi, eax

            mov         esi, temporal
            lea         edi, [esi+edi-1]
            .recorridoi:
                mov         al, [esi]       ; carga el primer caracter
                xchg        al, [edi]       ; intercambia el primer y ultimo valor
                mov         [esi], al       ; guarda el caracter en el ulitmo lugar
                inc         esi
                dec         edi
                cmp         esi, edi
                jl          .recorridoi

        .end:
            pop         esi
            mov         byte[esi], 0H       ; la cadena termina en null
            mov         eax, temporal         ; eax -> temporal

    .devol:
        pop         esi
        pop         ebx
        pop         ecx
        pop         edx
    ret

;-------------------FIn de codigo-------------------------
endP:
	mov	ebx, 0		; return 0
	mov	eax, 1		; llamar a SYS_EXIT
	int	80h
