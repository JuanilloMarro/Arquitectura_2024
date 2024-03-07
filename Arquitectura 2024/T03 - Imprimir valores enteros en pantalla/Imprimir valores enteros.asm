; Programa para imprimir un valor entero
; Juan Diego Marroquín Escobar 1689821

%include '../../stdio/stdio32.asm'

SECCIÓN .data
msg_solicitud: db 'Ingrese un valor entero: ', 10, 0H
buffer: resb 11

SECCIÓN .text
global _start

_start:
  ; Solicitar el valor entero al usuario
  mov rax, msg_solicitud
  call printString

  ; Leer el valor entero del usuario
  call readInt
  mov esi, eax ; esi -> buffer

  ; Imprimir el valor con salto de línea
  mov rax, esi
  call printIntLn

  ; Imprimir el valor sin salto de línea
  mov rax, esi
  call printInt

  ; Salir del programa
  mov rax, 60
  mov rdi, 0
  syscall
