section .data 
yomon_qator	db	'1234567890' 	;; qator uchun 18 bayt ajratamiz
	times 8	db	0
uzunlik	equ	$-yomon_qator
section .text
global	main

main: 
 	mov	dword[yomon_qator+10] , 0x08048440		;; EBP uchun 
 	mov	dword[yomon_qator+14] , 0x08048440		;; RET uchun 
 
	;; Linuxda xotira bo'lagini andozasiz chop etish.
	mov	eax , 4 		;; Chop etish.
	mov	ebx , 1 		;; Qaysi faylga (1 – ekranga).
 	mov	ecx , yomon_qator 	;; Chop etiladigan qator manzili.
 	mov	edx , uzunlik		;; Belgilar soni.
	int	0x80 			;; Linuxga murojaat

	ret

