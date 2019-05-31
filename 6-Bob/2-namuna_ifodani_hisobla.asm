;; Maqsad:
;;	Ushbu dastur y = (a + b)/c ni hisoblaydi va
;;	y ni natija sifatida chop etadi.
	
%include "nasm-io.inc"
 
section	.bss
y	resd	1

section	.data
a	db	6
b	db	10
c	db	2

section	.text
tizim_global	main

main:
	mov	al , [a]
	cbw			;; AX <- AL
	movsx	bx , [b]	;; BX <- b
	add	ax , bx		;; AX <- a + b
	idiv	byte[c]		;; AL <- AX / c, qoldiq AH da bo'ladi.
 	cbw			;; AX <- AL
 	cwde			;; EAX <- AX
	mov	[y] , eax	;; y <- (a+b)/c
	chop_et		`Natija: y = %i\n`, [y]

ret
