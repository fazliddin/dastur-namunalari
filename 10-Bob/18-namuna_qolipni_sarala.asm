%include "nasm-io.inc"

%define	qolip_uzunligi	10

section .data
saralanadigan_qolip	dd	12, 4, 5, 8, 1, -94, 2, 37, 2, -100

section  .text
tizim_global	main
main:
	push	dword qolip_uzunligi
	push	dword saralanadigan_qolip
	call	saralash
	add	esp , 8

	mov	ecx , qolip_uzunligi
	xor	eax , eax

.lp_boshi2:
	chop_et		`saralanadigan_qolip[%i] = %i \n`, eax, [saralanadigan_qolip + eax*4]
	inc	eax
	loop	.lp_boshi2

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Saralash qism dasturi.
;;
;; Maqsad:
;;	Qolip qiymatlari kichikdan kattaga qarab saralanadi.
;;	C dagi e'lon qilinishi:
;;	void saralash(int * qolip, unsigned uzunlik);
;;
;; Qiymatlar:
;;	qolip - saralanadigan qolip manzili
;;	uzunlik - qolip uzunligi
;;
;; Qism dasturining C dagi ko'rinishi:
;;
;;	void saralash(int * qolip, unsigned uzunlik)
;;	{
;;		unsigned i,j;
;;		int vaqtincha;
;;
;;		for(i = 1; i < uzunlik; i++)
;;			for(j = 0; j < i; j++)
;;			{
;;				if(qolip[j] > qolip[i])
;;				{
;;					vaqtincha = qolip[j];
;;					qolip[j] = qolip[i];
;;					qolip[i] = vaqtincha;
;;				}
;;			}
;;	}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%define	qolip	ebp+8
%define	uzunlik	[ebp+12]

saralash:
	enter	0 , 0
	mov	edi , [qolip]
	xor	ecx , ecx			;; i

.lp_katta:
	inc	ecx
	cmp	ecx , uzunlik
	jae	.tamom
	xor	ebx , ebx			;; j

.lp_kichik:
	cmp	ebx , ecx
	jae	.lp_katta
	mov	eax , [edi+ecx*4]		;; EAX <- Qolip[i]
	cmp	[edi+ebx*4] , eax		;; if(qolip[j] > qolip[i])
	jle	.almashtirish_kerak_emas

	mov	edx , dword[edi+ebx*4]	;; EDX <- Qolip[j]
	mov	dword[edi+ebx*4] , eax	;; Qolip[j] <- Qolip[i]
	mov	dword[edi+ecx*4] , edx	;; Qolip[i] <- EDX
	
.almashtirish_kerak_emas:
	inc	ebx
	jmp	.lp_kichik

.tamom:
	leave
ret
