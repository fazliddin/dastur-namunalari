%include "nasm-io.inc"		;; tizim_global uchun

section .text
tizim_global qolipdan_qidir

;; Qolipda qidirish qism dasturi.
;;
;; Maqsad:
;;	Berilgan qiymatni qolipdan qidiradigan qism dasturi.
;;	C dagi e'lon qilinishi:
;;	int qolipdan_qidir(char * qolip, char qiymat, int uzunlik);
;;
;; Qiymatlar:
;;	qolip - qidiruv amalga oshiriladigan qolip manzili
;;	qiymat - qidiriladigan qiymat
;;	uzunlik - qolip uzunligi
;;
;; Natija:
;;	Agar qiymat topilsa uning qolipdagi tartib raqami,
;;	aks holda -1 qaytariladi.


%define	qolip	ebp+8
%define	qiymat	[ebp+12]
%define	uzunlik	[ebp+16]

qolipdan_qidir:
	enter	0 , 0
	push	edi	;; Ishlatiladigan registerlarning
	push	ecx	;; qiymatini stackda saqlab qo'yamiz

	mov	edi , [qolip]
	mov	al , qiymat
	mov	ecx , uzunlik

	repnz	scasb
	jz	.topildi
	mov	eax , -1
	jmp	.chetlash

.topildi:
	mov	eax , uzunlik			;; EAX <- uzunlik
	neg	ecx				;; ECX <- -ECX
	lea	eax , [eax + ecx - 1]		;; EAX <- EAX + (-ECX) -1

.chetlash:
	pop	ecx
	pop	edi
	leave
ret

