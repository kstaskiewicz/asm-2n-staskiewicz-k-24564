extern printf
extern open
extern write
extern close



section .data

tab: dq 40, 160, 154, 364, 1027, 310, 1216, 991, 820, 307, 123456789012345678, 12, 13


section .rodata
format: db "%ld, ", 10, 0
file: db "zaliczenie.txt", 0
fileFlags: dq 0102o         ; create file + read and write mode
fileMode:  dq 00666o        ; user has read write permission


section .bss

tab01: resq 10		;tablica tab/3
tabw: resb 6		;tablica ktorą będziemy zapisywać w pliku


section .text

global main

main:

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
    

    call open			; otwieramy plik "zaliczenie.txt"

    push rax		;zapisujemy na stos uchwyt pliku żeby się nie zapodział

    mov rdi, rax	;parametry do funkcji write; pierwszy parametr
    mov rsi, tabw	; 2 parametr co zapisujemy
    mov rdx, 6		; 3 parametr ile zapisujemy

    call write		;zapisujemy do pliku
    
    pop rdi		;pobieramy ze stosu uchwyt do pliku


    call close		;zamykamy plik

    mov rdi, format
    mov rsi, rax

    xor rax, rax



    
    pop r12 ;przywracamy rejestr do stanu początkowego

    ;ret    

