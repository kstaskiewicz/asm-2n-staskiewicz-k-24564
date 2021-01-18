section .data
        num1 dq 4125
		num2 dq 750
		num3 dq 1420
		
section .bss
        max resq 1
		
section .text
        global _start
		
		save:
		    mov qword[max], rbx
			mov rax, qword[max]
			mov rbx, qword[num3]
			dec rcx
			cmp rcx, 0
			jne check
			
			
	    check:
		    cmp rax, rbx
			jb save
			
_start:
    mov rax, qword[num1]
	mov rbx, qword[num2]
	mov qword[max], rax
	
	
	mov rcx, 2
	
	
	cmp rax, rbx
	jb save
	dec rcx
	mov rbx, qword[num3]
	cmp rax, rbx
	jb save
	
	
_end:
    mov rax, 60
	mov rdi, 0
	syscall