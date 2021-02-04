section .data
    tab1        dq  40, 160, 154, 364, 1027, 310, 1216, 991, 820, 307
    per         dq  3
    file_name   db  "zaliczenie.txt",0
 
section .bss
    fd      resb    1
    tab3    resq    10
    tabw    resb    6
 
section .text
    global _start
   
_start:
    mov rsi, 10
 
    SubLoop:
        dec rsi
        mov rax, qword[tab1+rsi*8]
        sub rax, 10
        push rax
        cmp rsi, 0
        jne SubLoop
       
    mov rsi, 10
 
    PopLoop:
        dec rsi
        mov rdx, 0
        pop rax
        div qword[per]            
        mov [tab3+rsi*8], rax
        cmp rsi, 0
        jne PopLoop
       
    mov rsi, 0
    mov rbx, 0
 
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