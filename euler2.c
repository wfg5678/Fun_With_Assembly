/*This the solution to Euler problem 2. The problem asks to find the sum of the even members of the fibancci sequence under 400000. The computation is completed in the file assembly_routines.asm. 
The answer is 4613732.

 https://projecteuler.net/problem=2

   How to compile, link and run:

   1. Make an object file from euler2.c
   $ gcc -c euler2.c -o euler2.o

   2. Make an object file from assembly_euler2.asm
   $ nasm -f elf64 -o assembly_euler2.o assembly_euler2.asm

   3. Link object files together to make executable
   $ gcc -o euler2 euler2.o assembly_euler2.o

   4. Run
   $ ./euler2

*/

#include <stdio.h>
extern int Execute();

int main(){
  int sum = Execute();
  printf("Here is the answer: %d\n", sum);
  return 0;
	
}
