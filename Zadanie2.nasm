section .data
a db 3
b db 9

section .bss
A resw 1 
B resb 1
C resd 1

section .text
global _start

_start:

mov al, byte [a]
nul al
mow word [A], ax

mov al, byte [b]
nul al
mow word [B], al

mov ax, word [A]
add ax, word [B]
mov word [C], ax
mov word [C + 2], dx

_end:
mov rax, 60
mov rdi, 0
syscall


