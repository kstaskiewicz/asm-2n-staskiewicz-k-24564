section .data
   qNum1 dq 4212
   qNum2 dq 1275
   qNum3 dq 987
   qNum4 dq 125
   dqAns ddq 0

section .bss
   qAns resq 7
   
section txt.
   global _start

_start:
call _mull:

_mull:
mov rax, qword[qNum1]
mul qword[qNum3]
mov qword [dqAns], rax
mov qword[dqAns+8], rdx
ret 