%define	JADVAL_UZUNLIGI	6
%include "nasm-io.inc"
section .data
jadval	db	99, 98, 100, 2, 55, 56

section  text
tizim_global	main

main:
	xor	eax , eax
	lea	edi , [jadval]
	mov	ecx , JADVAL_UZUNLIGI
	mov	al , 100
	repnz	scasb
	jz	.topildi
	chop_et		`Jadvalda %i soni yo’q \n` , eax
	jmp	.chetlash

.topildi:
	dec	edi
	chop_et	`%i soni jadvalda topildi. Uning manzil: %p ` ,eax, edi

.chetlash:

ret
