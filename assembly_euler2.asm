;Find the sum of the even Fibonacci numbers under 4,000,000

global Execute

;rsi stores the current second largest term of the fib sequence
;rdi stores the current largest term of the fib sequence
;rbx stores 2 for division operations
;rax and rdx are used in division
;The sum of all the even terms is stored in [rbp-4]

Execute:
	push rbp
	mov rbp,rsp
	sub rsp,4		;Allocate space for a local variable, [rbp-4]. This space will save the sum
	push rbx		;Preserve the values of rbx,rsi, and rdi while used in the routine
	push rsi
	push rdi
	
	mov [rbp-4],DWORD 0	;Set sum to 0
	mov rbx,2		;Set rbx to 2 for modulus operations
	mov rsi,1		;First number in fib sequence is 1
	mov rdi,2		;Second number in fib sequence is 2
	
	loop1_top:
	cmp rdi,4000000
	jge loop1_bottom
	
	xor rdx,rdx		;Clear rdx for division
	mov rax,rdi		;Move rdi into rax for division
	div rbx			;Test if next number of fibanci sequence is divisible 2 (even). rax/2
	cmp rdx,0		;Test to see if the remainder is 0
	jne not_divisible_by_2
	
	add [rbp-4],rdi		;Add even terms to sum
	not_divisible_by_2:			
	
	mov rax,rdi		;Use rax as a placeholder while getting the next terms of the fibanci sequence
	add rdi,rsi		;Add two terms together to get next term of fib sequence
	mov rsi,rax		;Set old second largest term to new second largest term
	jmp loop1_top	
	loop1_bottom:
	
	mov rax,[rbp-4]		;Set rax to the sum stored in [rbp-4] for the return from routine
	
	pop rdi			;Return the saved values to proper registers
	pop rsi
	pop rbx
	mov rsp,rbp
	pop rbp
	ret
