#include <stdio.h> 

int diskriminant(int, int, int) __attribute__ ((cdecl)); 
unsigned ildiz(unsigned) __attribute__ ((cdecl)); 

int main() 
{ 
	int a, b, c, x, D; 
	printf("Tenglama koeffitsentlarini kiriting (a,b,c) : "); 
 	scanf("%i %i %i", &a, &b, &c); 
 
 	D = diskriminant(a,b,c); 
	if(D < 0)
 	{
 		printf("Tenglama ildizga ega emas.\n");
 		goto tamom; 
 	} 
 	if(D == 0) 
 	{	 
 		x = (int) -b / (2*a); 
 		printf("X = %i.\n", x); 
 	} 
 	else 
 	{ 
 		D = ildiz(D); 
 		x = (int) (-b + D) / (2*a); 
 		printf("X1 = %i, ", x); 
 		x = (int) (-b - D) / (2*a); 
 		printf("X2 = %i.\n", x); 
	} 
 
tamom: 
return 0; 
} 
