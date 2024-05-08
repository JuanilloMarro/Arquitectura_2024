; Autor: JuanilloMaroo
; llamada a funciones de sistema - ejecucion de comandos del sistema

%include        '../../../utils/stdio32.asm'


SECTION         .data
    command         db          "/bin/echo", 0H             ; comando a ejecutar
    msg             db          "hola arquitectura 1", 0H   ; mensaje a desplegar

    ; crear lista de argumentos de estructura
    args            dd          command
                    dd          msg
                    dd          0H      ; null
    enviroment      dd          0H

SECTION         .text
    global      _start

_start:
    mov         eax, enviroment
    mov         ecx, args
    mov         ebx, command
    mov         eax, 11
    int         80h

    call        sys_exit