#include <stdio.h>
//#include <stdlib.h>

/* Find the pythagorean triple such that a+b+c =1000.
Answer is 200,375,400
*/


extern void FindTriple(int* answer);

int main(){	
	
  int answer[3] = {0,0,0};
	
  FindTriple(&answer);
  printf("here is the answer: %d %d %d\n", answer[0],answer[1],answer[2]);
	
	
  return 0;
	
}
