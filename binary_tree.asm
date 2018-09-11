;An implementation of binary tree in x86-64 Assembly
;Follows the AMD64 calling convention for UNIX
;Uses recursion to insert keys in the proper places
;Uses recursion to print the tree from small -> large

;	make object file from .asm file
;	$ nasm -f elf64 -o tree.o tree.asm

;	link the object file
;	$ gcc -o tree tree.o

;	run
;	$ ./tree



;The format of the node "struct":
; 20 bytes total
; 0-3 store a 32 bit int
; 4-11 store a pointer to a lesser value 20 byte struct
; 12-19 store a pointer to a greater value 20 byte struct

;	This is the equivalent of the C code:
;	struct node{
;		int key;
;		struct node* left_child;
;		struct node* right_child;
;	};


;uses the following library functions:

extern srand
extern rand
extern printf
extern time
extern malloc

section .data

	fmt1: db "%d ", 10,0
	
section .text

global main

	main:
	push rbp
	mov rbp, rsp
	
	sub rsp,48

	call seed_rand
	
	;get a value between 0 and 1000 for the root node
	call get_rand

	;pass the return of get_rand to create_head
	mov rdi,rax
		
	call create_head

	;the r13 register holds the address of the head of the tree
	mov r13, rax		
	
	;use r12 as a counter
	mov r12,100		
	

	loop_top:
	
		;gets a value from 0 to 999. Result returned in rax
		call get_rand	
	
		;load the value to add into rdi register
		mov rdi, rax	

		;move the address of the tree root into the rsi register
		mov rsi, r13			
	
		call add_node
	
		dec r12
		jnz loop_top
	
	
	mov rdi, r13
	call print_tree
	
	add rsp,48
	mov rsp, rbp
	pop rbp
	
	ret

	
;recursive function that prints the tree from smallest key to largest
;rdi holds the address of the root of the tree
;essentially the same as:
;	void print_tree(struct node* curr){
;		
;		if(curr == NULL){
;			return;
;		}
;		print_tree(curr->left_child);
;
;		printf("%d\n", curr->key);
;
;		print_tree(curr->right_child);
;		
;		return;
;	}

print_tree:

	push rbp
	mov rbp,rsp
	sub rsp,48

	cmp rdi, 0
	je end_print_tree

	;save the address of current node in [rbp-16]
	mov [rbp-16],rdi
	mov rbx, rdi

	;if rbx holds address of node [rbx+4] holds pointer to left_child
	mov rdi, [rbx+4]

	call print_tree

	mov rdi, fmt1

	;grab stored address
	mov rbx,[rbp-16]
	mov rsi, [rbx]

	call printf

	mov rdi, [rbx+12]
	call print_tree

	end_print_tree:
	
	add rsp,48
	mov rsp,rbp
	pop rbp
	ret
	
	

;Recursive function to add a node in the proper place
;rdi holds the key to add
;rsi holds the address of the root of the array
add_node:
	push rbp
	mov rbp,rsp
	sub rsp,48
	
  	;load dword value into r14. Should zero upper 32 bits of rbx
	mov r14d, [rsi]	

	cmp rdi,r14
	jle value_lesser
	
	;if key to add is greater than the key held in node with memory address in rsi
	mov rbx,[rsi+12]

	cmp rbx,0
	je add_greater
	
	;if the pointer to the greater branch is not null call the function again
	
		;mov the address of the greater node to rdx register
		mov rsi,rbx				
			
		call add_node
		jmp end_add_node
	
	;if the pointer to the greater branch is null add a new node
	add_greater:

		push rdi		;preserve key to add
		push rsi		;preserve the address of the current node
			
		mov rdi,20		;allocate 20 bytes of space for another node
		call malloc
		
		pop rsi
		pop rdi
	
		mov [rax], edi		;add the key to add in the allocated space
		mov rdi,0
		mov [rax+4], rdi	;set left and right child pointers to 0 (null)
		mov [rax+12], rdi
		
		mov [rsi+12],rax	;move the address of the new node to the spot for the right pointer
		jmp end_add_node
	
	value_lesser:			;(or equal to)
	
	;if key to add is less than the key held in the node with memory address in rsi
		mov rbx,[rsi+4]
		cmp rbx,0
		je add_lesser
	
	;if the pointer to the lesser branch is not null call the function again
	
		mov rsi,rbx		;mov the address of the greater node to rsi register
					;remember that rdi still holds the key to add
		call add_node
		jmp end_add_node
	
	;if the pointer to the lesser branch is null add a new node
	add_lesser:
		
		push rdi		;preserve key to add
		push rsi		;preserve the address of the current node

		mov rcx,20		;allocate 20 bytes of space for another node
		call malloc

		pop rsi
		pop rdi
				
		mov [rax], edi		;add the key to add in the allocated space
		mov rdi,0
		mov [rax+4], rdi	;set left and right pointers to 0 (null)
		mov [rax+12], rdi
		
		mov [rsi+4],rax		;move the address of the new node to the spot for the left pointer
		jmp end_add_node
	
	end_add_node:
	

	add rsp,48
	mov rsp, rbp
	pop rbp
	
	ret
	
	
	
;create head of the tree. Accepts a key in rdi. 
;Stores this value in the allocated space and returns
;a pointer to the 20 bytes allocated

create_head:
	push rbp
	mov rbp, rsp
	sub rsp, 48
	
	push rdi			;preserve the key passed to create_head
	
	mov rdi,20			;allocate 20 bytes of space for root node
	call malloc
	
	pop rdi

	mov [rax], edi			;save the key passed to create_head in the allocated space
					;use edi rather than rdi to pass 32 bit key

	mov rdi,0
	mov [rax+4], rdi		;set left and right child pointers to 0 (null)
	mov [rax+12], rdi
	
	add rsp, 48
	mov rsp, rbp
	pop rbp
	
	ret
	
	
	

;the equivalent of calling srand(time(NULL)) in C
seed_rand:
	push rbp
	mov rbp,rsp
	sub rsp, 48		
	
	xor rdi,rdi  		;zero rdi as the NULL parameter in time(NULL)

	
	call time		;the time function returns the number of seconds since 1/1/70
	
	mov rdi, rax		;move the return of time to rdi for srand
			
	call srand
	
	add rsp, 48
	mov rsp,rbp
	pop rbp
	
	ret


;this function returns an int between 0 and 1000
get_rand:
	push rbp
	mov rbp, rsp
	sub rsp,48			;allocate the shadow space
	
	call rand			;returns random number in rax
	
	xor rdx,rdx			;clear register for div
	mov rsi, qword 1000	
	div rsi				;divide rdx:rax by 1000
	
	mov rax, rdx			;move the remainder of the division to rax for division
					;this is essentially mod 1000
						
	add rsp,48
	mov rsp,rbp
	pop rbp
	
	ret

	
