;; Asosiy dastur.
%include "nasm-io.inc"

section .data
a	dd	9
b	dd	21

section .text
tizim_global	main

main:
	chop_et		`a = %i, b = %i \n`, [a], [b]
	push	dword b		;; b ning manzili stackka yuklandi.
	push	dword a		;; a ning manzili stackka yuklandi.
	call	almash
	add	esp , 8		;; Jo'natilgan qiymatlar stackdan o'chiriladi.
	chop_et		`a = %i, b = %i \n`, [a], [b]
	
ret
 
;; Almash qism dasturi.
;;
;; Maqsad:
;;	Ikki o'zgaruvchi qiymatini o'zaro almashtirish.
;; 
;; Qiymatlar:
;;	O'zgaruvchilar manzillari stack orqali jo'natiladi.

almash:
	mov	eax , [esp+4]	;; a ning manzili
	mov	ebx , [esp+8]	;; b ning manzili
	push	dword[eax]
	push	dword[ebx]
	pop	dword[eax]
	pop	dword[ebx]
ret
