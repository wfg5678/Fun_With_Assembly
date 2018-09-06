/*This is the solution to project euler problem 1.
The question asks what is the sum of all numbers under 1000 that are divisible by 3 or 5
The bulk of the computation is performed in the sub routine Execute. This is found in the 
file assembly_routines.asm.
The answer is 233168
*/
#include <stdio.h>
extern int Execute();

int main(){

	int  count = Execute();
	printf("Here is the answer: %d\n", count);
	return 0;
	
	}
