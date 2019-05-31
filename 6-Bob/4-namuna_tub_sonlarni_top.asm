;; Maqsad:
;;	Ushbu dastur berilgan songacha bo'lgan
;;	barch tub sonlarni chop etadi.
	
%include "nasm-io.inc"

section .data
maxraj	dd	2
ikki	dd	2
tubmi	db	1

section .bss 
chegara	resd	1
yarmi	resd	1

section .text 
tizim_global	main

main:
	chop_et		`Nechagacha bo'lgan tub sonlar topilsin? : ` 
	qabul_qil	`%i`, chegara 
	cmp	dword[chegara] , 2
	jb	near tamom 
 	chop_et		`2\n`		;; Ikkining tub ekanligi aniq
	mov	ecx , 3			;; x o'rnida ECX

asosiy_halqa:				;; C dagi "for"
 	cmp	[chegara] , ecx
	jb	tamom
	mov	edx , 0			;; EDX:EAX ning to'ng'ich to'rt baytini nollaymiz. 
	mov	eax , ecx		;; ECX ni bo'lishga tayyorlash. 
	div	dword[ikki]
	mov	ebx , eax		;; “yarmi” o'rnida EBX

ichki_halqa:				; C dagi "while" 
	cmp	ebx , [maxraj] 
	jb	ichki_halqa_oxiri 
	mov	edx , 0			;; EDX:EAX ning to'ng'ich to'rt baytini nollaymiz. 
	mov	eax , ecx		;; ECX ni bo'lishga tayyorlash. 
	div	dword [maxraj]
	inc	dword [maxraj]		;; C dagi “maxraj++”
	cmp	edx , 0 		;; Qoldiqni tekshiramiz
	jne	ichki_halqa 
	mov	byte [tubmi] , 0

ichki_halqa_oxiri:
	cmp	byte [tubmi] , 1	;; C dagi "if(tubmi)"
	jne	tub_emas
	chop_et	`%i\n`, ecx

tub_emas:
 	mov	byte [tubmi] , 1
 	mov	dword [maxraj] , 2 
 	inc	ecx
 	jmp	asosiy_halqa

tamom:

ret

