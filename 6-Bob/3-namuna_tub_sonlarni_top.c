#include <stdio.h> 
int main() 
{ 
     unsigned int chegara, yarmi, x, maxraj = 2, tubmi = 1;
     printf("Nechagacha bo'lgan tub sonlar topilsin: ");
     scanf("%i",&chegara);
     
     if(chegara < 2) goto tamom;
     
     printf("2 \n");

     for(x=3; x<=chegara; x+=2)
     {
           yarmi = (int) x / 2;

           while(yarmi >= maxraj)
           {
               if((x % maxraj)==0)
               {
                    tubmi = 0;
                    break;
                }
                maxraj++;
           }
           if(tubmi)
                printf("%i\n",x);
           
           tubmi = 1;
           maxraj = 2;
     }

tamom:

return 0;
}

