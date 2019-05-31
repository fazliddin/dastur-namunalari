#include <stdio.h> 

int diskriminant(int, int, int) __attribute__ ((cdecl)); 
unsigned ildiz(unsigned) __attribute__ ((cdecl)); 
 
int main() 
{
	int a,b,c;
	while(1)
	{
		printf("a b c:");
		scanf("%i%i%i",&a,&b,&c);
		printf("b*b-4ac = %i\n",diskriminant(a,b,c));
	}

return 0; 
}
