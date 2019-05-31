%define	KATAKLAR_SONI	10	
%include "nasm-io.inc"

section .data
qolip1	dw	1,3,5,7,11,13,17,19,23,29

section .bss
qolip2	resw	10

section .text
tizim_global	main

main:
	cld			;; juda muhim!
	lea	esi , [qolip1]
	lea	edi , [qolip2]
	mov	ecx , KATAKLAR_SONI

.lp_boshi:
	lodsw			;; AX ← qolip1[i]
	stosw			;; qolip2[i] ← AX
	loop	.lp_boshi

	mov	ecx , KATAKLAR_SONI
	xor	eax , eax
	xor	ebx , ebx
	lea	esi , [qolip2]

.lp_boshi2:

	lodsw
	chop_et		`qolip2[%i] = %i \n`, ebx, eax
	inc	ebx
	loop	.lp_boshi2

ret

