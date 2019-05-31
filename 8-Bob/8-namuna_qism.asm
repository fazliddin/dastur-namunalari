%include "nasm-io.inc"

section .text
global ildiz, diskriminant

;; Diskriminant qism dasturi.
;;
;; Maqsad:
;; 	Stack orqali uchta qiymat qabul qiladi: a = [ebp + 8],
;;	b = [ebp + 12], c = [ebp + 16] va b*b – 4*a*c ni hisoblaydi.
;;
;; C tilidagi e'lon qilinishi:	
;;	int diskriminant(int a, int b, int c);
;;
;; Natija:
;;	Hisoblangan diskriminant EAX da qaytariladi.

diskriminant: 
 	enter	0 , 0
 	push	ecx 				;; Registerlar qiymatlarini stackka yuklaymiz
 	push	edx
 	push	ebx
 	
 	mov	ecx , [ebp + 16]	;; ECX <- c
 	mov	ebx , [ebp + 12] 	;; EBX <- b
 	mov	eax , [ebp + 8] 	;; EAX <- a
 	cdq
 	imul	ecx 			;; EAX <- a*c
	mov	ecx , eax		;; ECX <- a*c
	mov	eax , ebx
 	cdq
 	imul	ebx 			;; EAX ← b*b
 	neg	ecx
	lea	eax , [eax + 4*ecx]	;; EAX <- b2 - 4ac

 	pop	ebx
 	pop	edx
 	pop	ecx
  	leave
 	ret 

;; Ildiz qism dasturi.
;;
;; Maqsad:
;;	Ushbu qism dasturi sonning kvadrat ildizini hisoblaydi.
;; 
;; Qiymatlar:
;;	Ildizi hisoblanish kerak bo'lgan
;;	son stack orqali qabul qilinadi.
;; Natija:
;;	Hisoblangan kvadrat ildiz EAX da qaytariladi.

section	.text

ildiz:
	enter	4 , 0 			;; x(n) uchun
	push	edx			;; Qism dasturda EDX ishlatiladi
	
	mov	eax , [ebp + 8]		;; Jo'natilgan qiymatni EAX ga o'zlashtiramiz, ya'ni EAX <- a
	mov	[ebp-4] , eax
	shr	dword [ebp-4] , 1	;; x(1) <- a / 2

.takrorlanish:
	xor	edx , edx		;; EDX:EAX ning to'ng'ich 4 baytini nollaymiz
	div	dword [ebp-4]		;; EAX <- a / x(n)
	add	eax , [ebp-4]		;; EAX <- x(n) + a / x(n)
	shr	eax , 1			;; EAX <- (x(n) + a / x(n)) / 2, bu yerda EAX = x(n+1)
	cmp	eax , [ebp-4]		;; (EAX = x(n)) ?
	jz	.topildi
	mov	[ebp-4] , eax		;; x(n) <- x(n+1)
	mov	eax , [ebp + 8]		;; Jo'natilgan qiymatni tiklaymiz
	jmp	.takrorlanish

.topildi:
	pop	edx

	leave
	ret				;; Orqaga qaytamiz

