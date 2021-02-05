﻿section .data

tab: dq 40, 160, 154, 364, 1027, 310, 1216, 991, 820, 307


section .data

file_name db "zaliczenie.txt", 0



section .bss
fd_out  resb    1
fd_in   resb    1
tab01 resq 10		;tablica tab/3
tabw resb 6		;tablica ktorą będziemy zapisywać w pliku


section .text

global _start

_start:

    push r12		;zapiszemy sobie R12 bo będziemy używać jako iterator pętli a powinniśmy zostawyć ten rejest nienaruszony.

    mov r12, 9		;zaczynamy od ostatniego elementu
petla02:

    sub qword [tab+r12*8], 10		;odejmujemy 10

    push qword [tab+r12*8]		;zapisujemy na stosie
    
    dec r12		;pomniejszamy iterator

    cmp r12, 0
    jge petla02		;dopuki iterator >=0 to skaczemy



;dzielimy
    mov r12, 0;
petla04:
    pop rax
    mov rcx, 3
    xor rdx, rdx
    div rcx

    mov qword [tab01 + 8*r12], rax		;zapis do tablicy

    inc r12		;powiększamy iterator

    cmp r12, 10
    jl petla04		;skok warunkowy dopuki r12<10

    

;teraz będziemy wybierać elementy <= 255    
   Sort255:
        mov rax, [tab3+rsi*8]
        inc rsi
        cmp rax, 255
        ja Sort255
        mov byte [tabw+rbx], al
        inc rbx
        cmp rsi, 10
        jne Sort255
 
    SaveFile:
        call OpenFile
        call WriteFile
        call CloseFile
 
        OpenFile:
            mov rax, 2          
            mov rdi, file_name  
            mov rsi, 577      
            mov rdx, 0644o    
            syscall
            mov [fd], rax
            ret    
 
        WriteFile:
            mov rax, 1
            mov rdi, [fd]
            mov rsi, tabw    
            mov rdx, 6
            syscall
            ret
 
        CloseFile:
            mov rax, 3  
            mov rdi, [fd]
            syscall
 
_end:
    mov rax, 60
    mov rdi, 0
    syscall