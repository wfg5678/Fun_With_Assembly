;These are the assembly routines for Euler problem 9.
;x86-64 Instruction Set
;My machine has Intel i5-6200 Processors


global FindTriple


;c function declaration: int CheckTriple(int a, int b, int c)
;
;This function tests if a^2 + b^2 = c^2
;a is stored in rdi
;b is stored in rsi
;c is stored in rdx
;This follows the amd64 calling convention although that is not 
;necessary for a stand alone function
;
;function returns 1 in rax if a, b, and c are pythagorean triple

_CheckTriple:
	
	push rbp
	mov rbp,rsp

	;preserve rdx. rdx value lost when using mul
	mov r8,rdx		

	;a^2 in rdi
	mov rax,rdi					
	mul rax							
	mov rdi,rax					
	
	;b^2 in rsi
	mov rax,rsi				
	mul rax							
	mov rsi,rax					
	
	;c^2 in r8
	mov rax,r8				
	mul rax							
	mov r8,rax				
	
	;move a^2 into rax
	mov rax,rdi	

	;rax now holds a^2 + b^2				
	add rax,rsi				

	;compare a*a + b*b to c*c
	cmp r8,rax				
	je return_true
	
	mov rax,0						
	jmp endpt
	
	return_true:
	mov rax,1						

	endpt:
	
	mov rsp,rbp
	pop rbp
	
	ret
	

	
;c declaration: void FindTriple(int* answer);
;int* answer is a pointer to an array of 3 ints. This is the best way to return the a,b,c values
;finds the pythagorean triple

FindTriple:
	
	push rbp
	mov rbp,rsp
	
	;preserve rbx and rsi before using
	push rbx
	push rsi

	;push address of answer on to stack to preserve
	push rdi 	
	
	;set counter of loop1 to 1		
	mov rcx,1							

	loop1_top:
		
		;set the loop2 counter, ebx, to the loop1 counter
		mov rbx,rcx						
			
		loop2_top:
			
			mov rax,QWORD 1000
			sub rax,rbx
			sub rax,rcx					
			
			mov rdi,rcx
			mov rsi,rbx
			mov rdx,rax
			
			;determines if the three numbers are a pythogorean triple	
			call _CheckTriple			
			
			;if true....
			cmp rax,1					
			jne bottom
			

			;if the triple is pythagorean triple
			;pop the address of int* answer into rdi
			pop rdi
			mov [rdi], rcx
			mov [rdi+4], rbx 

			mov rax,DWORD 1000			
			sub rax,rbx
			sub rax,rcx
			mov [rdi+8],rax
			
			jmp return_answer
			
			
			bottom:

			;increment the loop2 counter
			add rbx,QWORD 1			
			cmp rbx,QWORD 500					
			jl loop2_top
		

		;increment the loop1 counter
		add rcx,QWORD 1					
		cmp rcx,QWORD 500
		jl loop1_top
	
	;return 0 if routine cannot find an appropriate triple
	mov rax,0							
			
	return_answer:

	mov rax,0
	pop rsi
	pop rbx
	mov rsp,rbp
	pop rbp
	ret







