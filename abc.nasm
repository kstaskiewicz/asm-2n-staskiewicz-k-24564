section .data
    tb1    dq  40, 160, 154, 364, 1027, 310, 1216, 991, 820, 307    
    dzielnik dq 3
    file_name   db  "zaliczenie.txt",0
    
    

section .bss
    tb2 resb 10
    tbw resb 6
    fd_out  resb    1
    fd_in   resb    1
    

section .text
    global _start

_start:
    mov rcx,10
    mov rsi,0  
    
    l1:
        mov rax, qword [tb1+rsi*8]
        sub rax, 10
        push rax 
        inc rsi  
     loop l1
    mov rcx, 10
    mov rdi, 0

    l2:
        pop rax  
        div qword [dzielnik] 
        mov qword [tb2+rdi*8],rax 
        inc rdi
     loop l2

    
    mov rcx, 10
    mov rdi, 0
    mov rsi, 0
    
    

    l3:
        mov rbx, qword [tb2+rdi*8]
        cmp rbx,255
        jg koniec
        tak:
            mov byte [tbw+rsi*1], bl
            inc rsi          
        koniec:
            inc rdi
     loop l3


    mov rax, 2
    mov rdi, file_name
    mov rsi, 65
    mov rdx, 0644o
    syscall

    mov [fd_in], rax

    mov rax, 1
    mov rdi, [fd_in]
    mov rsi, tbw
    mov rdx, 6
    syscall
    
    

    
                     
_end:
    mov rax, 60
    mov rdi, 0
    syscall