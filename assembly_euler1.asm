;These are the assembly routines for Euler problem 1.
;x86-64 Instruction Set
;My machine has Intel i5-6200 Processors


global Execute


;c declaration: int Execute()
;find and return the sum of all the integers that are divisible by 3 or 5 under 1000
Execute:

	push rbp
	mov rbp,rsp

	;allocate a local variable at [rbp-4]. This will hold the total sum
	sub rsp,4

	;push rbx onto the stack to preserve value			
	push rbx					
	
	;set the local variable, the sum, to 0
	mov [rbp-4],DWORD 0
	
	;loop1 sums all the numbers that are divisible by 3
	;rcx is the counter
	mov rcx,1

	;rbx holds 3 for multiplication
	mov rbx,3					
	
		loop1_top:
		mov rax,rcx
		mul rbx						
		
		cmp rax,999
		jg loop1_bottom
		
		;add rax to the sum as long as rax is under 1000
		add [rbp-4],rax				
		inc rcx
		jmp loop1_top
		
		loop1_bottom:
	
	;loop2 sums all numbers that are divisible by 5
	;reset ecx for loop2
	mov rcx,1

	;rbx holds 5 for multiplication				
	mov rbx,5					
	
		loop2_top:
		mov rax,rcx					
		mul rbx						
		
		cmp rax,999
		jg loop2_bottom
		
		;add rax to the sum as long as rax is under 1000
		add [rbp-4],rax				
		inc rcx
		jmp loop2_top
		
		loop2_bottom:
	
	;loop3 subtracts all numbers that are divisible by 15 from the sum.
	;They are duplicates. Example: 30 is divisible by both 3 and 5. It has been counted twice
	;reset rcx for loop3
	mov rcx,1

	;use rbx to store 15 for multiplication				
	mov rbx,15					
	
		loop3_top:
		mov rax,rcx					
		mul rbx					
		
		cmp rax,999
		jg loop3_bottom
		
		;sub rax from the sum as long as rax is under 1000
		sub [rbp-4],rax			
		inc rcx
		jmp loop3_top
		
		loop3_bottom:
	
	;set rax to the sum for the return of the function
	mov rax,[rbp-4]			
		
	pop rbx
	mov rsp,rbp
	pop rbp
	ret
