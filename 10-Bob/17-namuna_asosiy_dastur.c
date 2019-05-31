#include <stdio.h>

int qolipdan_qidir(char * qolip, char qiymat, int uzunlik)
 __attribute__ ((cdecl));

void main()
{
	char	*qator = "abcdefght", qiymat1 = 'c';
	char	qolip[6] = {99, 98, 100, 2, 55, 56}, qiymat2 = 65;
	int	natija;

	natija = qolipdan_qidir(qator, qiymat1, 9);

	if(natija>=0)printf("Topildi: qator[%i] = %c. \n", natija, qator[natija]);
	else printf("Qatordan %c topilmadi \n", qiymat1);

	natija = qolipdan_qidir(qolip, qiymat2, 6);

	if(natija>=0)printf("Topildi: qolip[%i] = %c. \n", natija, qolip[natija]);
	else printf("Qolipdan %c topilmadi. \n", qiymat2);

}
