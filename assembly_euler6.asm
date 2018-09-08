;These are the assembly routines for Project Euler problem 6.
;x86-64 Instruction Set
;My machine has Intel i5-6200 Processors


global Sum_Of_Squares
global Square_Of_Sums

;c declaration: int Sum_Of_Squares()
;local variable [rbp-4] holds the sum of the squares
;rcx acts as a counter
Sum_Of_Squares:
	
	push rbp
	mov rbp,rsp
	sub rsp, 4			;Allocate space for a local variable, [rbp-4]. This will hold the sum
	
	mov [rbp-4],DWORD 0		;Set the sum to 0
	mov rcx, 100		;Set the counter to 100
	
	loop1_top:
		
		mov rax,rcx
		mul rcx			;Multiply rcx*rcx. The result goes into rax
		add [rbp-4],rax
		
		dec rcx
		jnz loop1_top
			
	mov rax,[rbp-4]			;Move the sum into rax for return
	
	
	mov rsp,rbp
	pop rbp
	
	ret


;c declaration: int Square_Of_Sums()	
Square_Of_Sums:

	push rbp
	mov rbp,rsp
	sub rsp, 4			;Allocate space for one local variable, [rbp-4]. This will hold the sum.
	
	mov [rbp-4],DWORD 0		;Clear local variable. Set sum to 0.
	mov rcx, 100			;Set the counter to 100
	
	loop2_top:
	
		add [rbp-4],rcx		;add the counter to the sum
		dec rcx
		jnz loop2_top
	
	mov rax,[rbp-4]			;move sum into rax for multiplication
	mul rax				;multiply rax*rax (sum*sum). Note that the result of the multiplication is 
					;in rax, ready for the return
	
	mov rsp,rbp
	pop rbp
	
	ret
