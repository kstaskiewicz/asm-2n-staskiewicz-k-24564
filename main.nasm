section .data
   tab1    dq  40, 160, 154, 364, 1027, 310, 1216, 991, 820, 307
   
   file_name dq "plik.txt", 0
   
section .bss
    tab2 resq 10
    tabw resb 6
    
    fd resb 1
    
   
section .text
    global _start
    
    
_start:

       mov rcx, 10
       mov rsi, 0
       mov rbx, 10

subLoop:

       mov rax, [tab1+rsi*8]
       sub rbx, [tab1+rsi*8]
       mov [tab1+rsi*8], rax
       inc rsi
       push rsi
       loop subLoop
       
       
       mov rcx, 6
       mov rsi, 0
       mov rbx, 3
       
divLoop:
       pop rax
       mov [tab2+rsi*8], rax
       div rbx
       inc rsi
       push rsi
       loop divLoop
       
       
       mov rcx, 10
       mov rsi, 0
       mov rbx, 0
       
revLoop:
       
       mov rax, [tab2+rsi*8]
       mov rax, rsi
       mov byte [rdi], al  ; do poprawy ( zadania punkt 3 )
       cmp rax, 255
       jbe revSkip
       push rax
       inc rbx
revSkip:
       inc rsi
       loop revLoop
       
    
       mov rax, 2
       mov rdi, file_name
       mov rsi, 65
       mov rdx, 0644o
       syscall
       
       mov [fd], rax
       
       mov rax, 1
       mov rdi, [fd]
       mov rsi, tabw
       mov rdx, 6
       syscall
       
       mov rax, 3
       mov rdi, [fd]
       syscall
       
       
       

_end:
     
     mov rax, 60
     mov rdi, 0
     syscall