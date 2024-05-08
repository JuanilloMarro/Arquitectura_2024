; Autor: JuanilloMarro
; Busqueda


%include        '../../../utils/stdio32.asm'

SECTION .data
    filename        db      'readme.txt', 0H
    filecontent     db      '-actualizado-', 10, 0H
SECTION .bss
SECTION .text
    global      _start

_start:
    ; Open write only
    mov         ecx, 1          ; O_W_READONLY
    mov         ebx, filename   ; file name
    mov         eax, 5          ; SYS_OPEN
    int         80H             ; kernel

    ; read and move to end of file
    mov         edx, 2          ; 2 = finle end | SEEK_END
    mov         ecx, 0          ; cursor moves 0 bytes
    mov         ebx, eax        ; ebx = HANDLER | DESCRIPTOR
    mov         eax, 19         ; SYS_LSEEK
    int         80h             ; kernel

    ; calc length
    push        eax
    mov         eax, filecontent
    call        strLen

    mov         edx, eax        ; number of bytes to write
    pop         eax
    mov         ecx, filecontent; content to write
    mov         ebx, ebx        ; move DESCRIPTOR to ebx
    mov         eax, 4          ; SYS_WRITE
    int         80H

    call        sys_exit