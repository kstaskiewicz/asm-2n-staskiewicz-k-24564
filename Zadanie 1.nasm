section .data
   Num1 dw 4212
   Num2 dw 1275
   Num3 dw 985
   Num4 dw 125

section .bss
   Ans1 resw 1
   Ans2 resw 1
   Ans3 resw 1
   Ans4 resw 1
   Ans5 resw 1
   Ans6 resw 1
   Ans7 resd 1
   Ans8 resd 1
   Ans9 resd 1
   Ans10 resb 1
   Ans11 resb 1
   Ans12 resb 1
   
section txt.
   global _start

_start:
mov ax, word [Num1]
add ax, word [Num2]
mov word [Ans1], ax

mov ax, word [Num1]
add ax, word [Num3]
mov word [Ans2], ax

mov ax, word [Num3]
add ax, word [Num4]
mov word [Ans3], ax

mov ax, word [Num1]
sub ax, word [Num2]
mov word [Ans4], ax

mov ax, word [Num1]
sub ax, word [Num3]
mov word [Ans5], ax

mov ax, word [Num2]
sub ax, word [Num4]
mov word [Ans6], ax

call _mul
call _end

_end:
mov rax, 60
mov rdi, 0
syscall

_mul:
mov ax, word [Num1]
mul word [Num3]
mov word [Ans7], ax
mov word [Ans7 + 2], dx

mov ax, word [Num2]
mul word [Num2]
mov word [Ans8], ax
mov word [Ans8 + 2], dx

mov ax, word [Num2]
mul word [Num4]
mov word [Ans9], ax
mov word [Ans9 + 2], dx

