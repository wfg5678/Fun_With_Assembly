/*This is the solution to Project Euler 6. The answer is 25164150.
The problem ask to find the difference between the sum of the squares of integers
up to and including 100 and the square of the sum of integers up to and including 100.
The routines are written in assembly in the file assembly_euler6.asm.


   https://projecteuler.net/problem=6

   How to compile, link and run:

   1. Make an object file from euler6.c
   $ gcc -c euler6.c -o euler6.o

   2. Make an object file from assembly_euler6.asm
   $ nasm -f elf64 -o assembly_euler6.o assembly_euler6.asm

   3. Link object files together to make executable
   $ gcc -o euler6 euler6.o assembly_euler6.o

   4. Run
   $ ./euler6

*/



#include <stdio.h>
#include <stdlib.h>

extern int Sum_Of_Squares();
extern int Square_Of_Sums();

int main(){	

  int sumofsqrs=Sum_Of_Squares();
  int sqrofsums=Square_Of_Sums();

  int dif = sqrofsums - sumofsqrs;
	
  printf("Here is the answer: %d - %d = %d\n",sqrofsums ,sumofsqrs ,dif);
	
  return 0;
	}
