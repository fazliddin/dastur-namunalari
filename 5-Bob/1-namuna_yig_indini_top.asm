;; Maqsad:
;;	Ushbu dastur beriladigan ikkita sonni qabul
;;	qilib, ularning yig'indisini hisoblab, natijani
;;	chop etadi.
;;
;; O'zgaruvchilar:
;;	a va b - ikkita qo'shiluvchi, EAX - yig'indi.
	
%include "nasm-io.inc"
 
section	.bss
a	resd	1
b	resd	1
 
section	.data
xayr	db	"Yana uchrashguncha, xayr.",0
 
section	.text
tizim_global	main

main:
 	chop_et		`Salom, bugun havo yaxshi! \n`
	chop_et		`Iltimos, ikkita son kiriting: `
	qabul_qil	`%i %i`, a, b
	mov	eax , [a]
	add	eax , [b]
	chop_et		`Natija: %i + %i = %i \n`, [a], [b], eax
	chop_et		`%s \n`, xayr

ret
