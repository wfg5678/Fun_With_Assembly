/*This is the solution to project euler problem 1.
The question asks what is the sum of all numbers under 1000 that are divisible by 3 or 5
The bulk of the computation is performed in the sub routine Execute. This is found in the 
file assembly_euler1.asm.
The answer is 233168


   https://projecteuler.net/problem=1

   How to compile, link and run:

   1. Make an object file from euler1.c
   $ gcc -c euler1.c -o euler1.o

   2. Make and object file from assembly_euler9.asm
   $ nasm -f elf64 -o assembly_euler1.o assembly_euler1.asm

   3. Link object files together to make executable
   $ gcc -o euler1 euler1.o assembly_euler1.o

   4. Run
   $ ./euler1

*/




#include <stdio.h>
extern int Execute();

int main(){

  int  count = Execute();
  printf("Here is the answer: %d\n", count);
  return 0;
	
}
