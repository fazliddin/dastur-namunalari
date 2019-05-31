;; Asosiy dastur.
;;
;; Maqsad:
;;	Ikki sonning kvadrat ildizining yig'indisini hisoblaydi.
;;	Ildiz qism dasturidan foydalanadi.
;;
;; O'zgaruvchilar:
;;	a va b - ikkita qo'shiluvchi, EDI - yig'indi.

%include "nasm-io.inc"

section .bss
son1	resd	1
son2	resd	1

section .text
tizim_global	main

main:
	chop_et		`Ikkita son kiriting : `
	qabul_qil	`%i %i`, son1, son2
	mov	ebx , [son1]	;; Son ildiz qism dasturiga EBX da jo'natalida.
	mov	ecx , davom1	;; Qaytish manzili ECX da jo'natiladi.
	jmp	ildiz

davom1:
	mov	edi , eax	;; son1 ning kvadrat ildizini EDI da saqlaymiz.
	
	mov	ebx , [son2]	;; Son ildiz qism dasturiga EBX da jo'natalida.
	mov	ecx , davom2	;; Qaytish manzili ECX da jo'natiladi.
	jmp	ildiz

davom2:
	add	edi , eax
	chop_et		`Javob = %i \n`, edi

ret

;; Ildiz qism dasturi.
;;
;; Maqsad:
;;	Ushbu qism dasturi sonning kvadrat ildizini hisoblaydi.
;; 
;; Qiymatlar:
;;	EBX registeri orqali ildizi hisoblanish kerak bo'lgan
;;	son qabul qilinadi. ECX da qaytish manzili bo'lishi kerak.
;;
;; Natija:
;;	Hisoblangan kvadrat ildiz EAX da qaytariladi.

section .bss
xn	resd	1		;; x(n), n = {1, ..., n}

section	.text

ildiz:
	chop_et		`Ildiz qism dasturi ishga tushdi \n`
	
	mov	eax , ebx	;; Jo'natilgan qiymatni EAX ga o'zlashtiramiz, ya'ni EAX <- a
	mov	[xn] , eax
	shr	dword [xn] , 1	;; x(1) <- a / 2

takrorlanish:
	xor	edx , edx	;; EDX:EAX ning to'ng'ich 4 baytini nollaymiz
	div	dword [xn]	;; EAX <- a / x(n)
	add	eax , [xn]	;; EAX <- x(n) + a / x(n)
	shr	eax , 1		;; EAX <- (x(n) + a / x(n)) / 2, bu yerda EAX = x(n+1)
	cmp	eax , [xn]	;; (EAX = x(n)) ?
	jz	topildi
	mov	[xn] , eax	;; x(n) <- x(n+1)
	mov	eax , ebx	;; Jo'natilgan qiymatni tiklaymiz
	jmp	takrorlanish

topildi:
	jmp	ecx		;; Orqaga qaytamiz
