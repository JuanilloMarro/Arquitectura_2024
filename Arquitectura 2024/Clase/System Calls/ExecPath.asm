; Autor: JuanilloMarro
; llamada a funciones de sistema - ejecucion de comandos del sistema

%include        '../../../utils/stdio32.asm'


SECTION         .data
    command         db          "/bin/echo", 0H             ; comando a ejecutar
    format          db          "-e", 0H                    ; format
    env1            db          "$PATH", 0H
    msg             db          "tu path es: ", 0H

    ; crear lista de argumentos de estructura
    args            dd          command
                    dd          format
                    dd          env1
                    dd          0H      ; null
    enviroment      dd          env1
                    dd          0H

SECTION         .text
    global      _start

_start:
    mov         eax, enviroment
    mov         ecx, args
    mov         ebx, command
    mov         eax, 11
    int         80h

    call        sys_exit