; Conversor de cadenas
; Juan Diego Marroquín Escobar 1689821

%include '../../stdio/stdio32.asm'  

SECTION .data
  msg_request: db 'Ingrese la cadena: ', 10, 0H  ; Mensaje para solicitar la cadena
  msg_upper: db 'Mayúsculas: ', 0H                 ; Mensaje para mayúsculas
  msg_lower: db 'Minúsculas: ', 0H                 ; Mensaje para minúsculas
  buffer: resb 255                               

SECTION .text
global _start

_start:
  ; Solicitar cadena al usuario
  mov rax, msg_request
  call printString

  ; Leer cadena del usuario
  call readline
  mov esi, eax ; 

  ; Convertir a mayúsculas
  push esi
  call upCase  
  add rsp, 8   

  ; Imprimir cadena en mayúsculas
  mov rax, msg_upper
  call printString
  mov rax, esi
  call printString

  ; Convertir a minúsculas
  push esi
  call loCase    add rsp, 8   

  ; Imprimir cadena en minúsculas
  mov rax, msg_lower
  call printString
  mov rax, esi
  call printString

  ; Salir del programa
  mov rax, 60
  mov rdi, 0
  syscall