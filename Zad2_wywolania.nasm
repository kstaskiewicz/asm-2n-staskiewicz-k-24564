section .bss
      fd_out resb 1
      fd_in  resb 1
      info   resb 26


section .data
      file_name db "plik.txt", 0
      msg       db "To jest nowy plik", 10
      len       equ $-msg

section .text
   global _start


_start: 
     mov rax, 2
     mov rdi, file_name
     mov rsi, 577
     mov rdx, 8644o
syscall

     mov [fd_out], rax

     mov rax, 1
     mov rdi, [fd_out]
     mov rsi, msg
     mov rdx, len
syscall

     mov rax, 3
     mov rdi, [fd_out]
syscall


     mov rax, 2
     mov rdi, file_name
     mov rsi, 0
syscall

     mov [fd_in], rax

     mov rax, 0
     mov rdi, [fd_in]
     mov rsi, info
     mov rdx, 26
syscall

     mov rax, 3
     mov rdi, [fd_in]
syscall

_end:

     mov rax, 60
     mov rdi, 0
syscall