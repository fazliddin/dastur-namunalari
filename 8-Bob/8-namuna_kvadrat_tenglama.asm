;; Qism dasturlari: ildiz, diskriminant
;; O'zgaruvchilar: a, b va c.

%include "nasm-io.inc"

section .bss
a	resd	1
b	resd	1
c	resd	1

section .text
extern	ildiz, diskriminant
tizim_global	main

main:
	enter	0 , 0
	chop_et		`Tenglama koeffitsentlarini kiriting (a,b,c) : `
	qabul_qil	`%i %i %i`, a, b, c

	push	dword[c] 		;; a,b va c lar diskriminant qism
	push	dword[b] 		;; dasturiga jo'natiladi.
	push	dword[a] 		
	call	diskriminant
	add	esp , 12 		;; stackni bo'shatamiz

	neg	dword[b] 		;; b → -b
	sal	dword[a] , 1 		;; a → 2a

	cmp	eax , 0
	jge	.manfiy_emas
	chop_et		`Tenglama ildizga ega emas\n`
	jmp	.tamom

.manfiy_emas:
	jnz	.ikkita_yechim
	mov	eax , [b] 		;; Demak, tenglama bitta yechimga ega
	cdq 				;; EAX → EDX:EAX, ishorali son sifatida
	idiv	dword[a]		;; EAX <- -b / 2a
	chop_et		`X = %i\n`, eax
	jmp	.tamom

.ikkita_yechim:
	push	eax 			;; Diskrimenantning ildizni
	call	ildiz 			;; hisoblaymiz.
	add	esp , 4
	mov	ecx , eax		;; Ildiz natijasini saqlab qo'yamiz
	add	eax , [b] 		;; EAX ← -b + ildiz(b*b - 4ac)
	cdq
	idiv	dword[a]		;; EAX <- ( -b + ildiz(b*b - 4ac) ) / 2a
	chop_et		`X1 = %i, `, eax
	mov	eax , [b]		;; EAX <- -b
	sub	eax , ecx 		;; EAX <- -b - ildiz(b*b - 4ac)
	cdq
	idiv	dword[a]		;; EAX <- ( -b - ildiz(b*b - 4ac) ) / 2a  
	chop_et		`X2 = %i\n`, eax

.tamom:
	leave

ret

