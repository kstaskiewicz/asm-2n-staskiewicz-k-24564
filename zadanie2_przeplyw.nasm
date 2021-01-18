section .data
    n dq 15
	sum dq 0
	
	
section .bss
    result reso 1
	
	
section .text
    global _start
	
_start:
    mov rax, 1
	mov rcx, qword[n]
	
	sumLoop:
	    add qword[sum], rax
		inc rax
		dec rcx
		cmp rcx, 0
		jne sumLoop
		mov rax, qword [sum]
		mul rax
		mov qword[result], rax
		
		
_end:
    mov rax, 60
	mov rdi, 0
	syscall