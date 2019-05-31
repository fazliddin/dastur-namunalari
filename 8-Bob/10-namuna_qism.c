int diskriminant(int, int, int) __attribute__ ((cdecl)); 
unsigned ildiz(unsigned) __attribute__ ((cdecl)); 
 
unsigned ildiz(unsigned a) 
{ 
 	unsigned xn = 0,formula; 
 	formula = a / 2; 
 	while(formula != xn) 
 	{ 
 		xn = formula; 
 		formula = (xn + a / xn) / 2; 
 	} 
return xn; 
} 
 
int diskriminant(int a, int b, int c) 
{ 
return b*b-4*a*c; 
} 
