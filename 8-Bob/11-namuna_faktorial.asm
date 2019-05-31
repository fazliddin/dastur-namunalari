;; Asosiy dastur
%include "nasm-io.inc"

 section .bss 
 n	resd	1 
 
section .text 
tizim_global	main

main: 
 	chop_et		`n sonini kiriting: ` 
 	qabul_qil	`%u`, n 
 
 	push	dword [n]
 	call	faktorial
 	add	esp , 4
 
 	chop_et		`Javob: %u! = %u \n`, [n] , eax
 	ret

;; Faktorial qism dasturi.
;;
;; Maqsad:
;;	Jo'natilgan qiymatgacha faktorialni hisoblaydigan qism dasturi.
;; 
;; Natija:
;;	Hisoblangan faktorial EAX da qaytariladi.
faktorial: 
 	enter	4 , 0 	; Natija uchun vaqtinchalik joy.
 	pusha
 	mov	eax , [ebp+8]		; EAX ← Jo'natilgan qiymat.
 	cmp	eax , 1			; Agar EAX birga teng bo'lsa,
 	jbe	.tamom			; o'z-o'zini chaqirish tugatiladi.
 	dec	eax
 	push	eax
 	call	faktorial
 	add	esp , 4
 	mul	dword [ebp+8]		; EDX:EAX ← t * (t-1) , t=1...n
 
 .tamom:
 	mov	[ebp - 4] , eax
 	popa
 	mov	eax , [ebp - 4]
 	leave
 	ret

