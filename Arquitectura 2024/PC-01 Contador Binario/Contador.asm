; Autor: JuanilloMarro
; 10 de abril de 2024
; Contador Binario

%include    '../../../utils/stdio32.asm'

SECTION .data
    msg         dw      'esto ', 0H
    msg1        dw      'es algo', 0H
    num         dd      120

SECTION .bss

SECTION .text
    global      _start


_start:
    ; imprimimos los valores
    mov         eax, msg
    call        println
    mov         eax, msg1
    call        println

    ; pasamos los parametros
    mov         eax, msg
    mov         edx, msg1
;    call        concat      ; concat(eax, edx) <- eax = eax + ebx
    call        println
    ; convertimos un int a string
    

    ;covnertimos el valor a int
;    call        strToInteger
;    add         eax, 4
;    call        println

    call        printLoop
    call        sys_exit


printLoop:
    mov         ecx, 0      ; ecx = 0
nextNum:
    mov         eax, ecx    ; eax = ecx (dir en memoria)
    add         eax, 48     ; eax = eax + 48 = chr(eax)
    
    push        eax         ; pila.push(eax)
    mov         eax, esp    ; eax = pila.last
    call        println

    pop         eax         ; sacamos el valor de la pila
    inc         ecx         ;
    cmp         ecx, 11     ; revisamos si vale 9
    jl          nextNum 

    ret