section .data

tab: dq 40, 160, 154, 364, 1027, 310, 1216, 991, 820, 307


section .data

file db "zaliczenie.txt", 0
fileFlags dq 0102o         ; create file + read and write mode
fileMode  dq 00666o        ; user has read write permission


section .bss
fd    resq 1
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
    pop RAX
    mov rcx, 3
    xor rdx, rdx
    div rcx

    mov qword [tab01 + 8*r12], rax		;zapis do tablicy

    inc r12		;powiększamy iterator

    cmp r12, 10
    jl petla04		;skok warunkowy dopuki r12<10

    

;teraz będziemy wybierać elementy <= 255    
    mov r12, 0
    mov rcx, 0
petla06:

    cmp qword[tab01 + 8*r12], 255

    jg opusc		;skok warunkowy gdy: qword[tab01 + 8*r12] > 255

    mov rax, qword[tab01+8*r12]
    mov byte [tabw + 1*rcx], AL
    inc rcx

opusc:
    inc r12

    cmp r12, 10
    jl petla06		;skok warunkowy gdy wyczerpiemy cała tablice

    

    ; 3 parametry do funkcji open
    mov rdi, file
    mov rsi, [fileFlags]
    mov rdx, [fileMode]
    

SaveFile:
        call OpenFile
        call WriteFile
        call CloseFile


    OpenFile:
            mov rax, 2          
            mov rdi, file
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

