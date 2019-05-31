;; Maqsad:
;;	Ushbu dastur beriladigan ikkita sonni qabul
;;	qilib, ular o'rtasidagi masofani Heming algoritmi
;;	bo'yicha hisoblaydi.
;;
;; O'zgaruvchilar:
;;	son1 va son2 - ikki son, DL - masofa.
	
%include "nasm-io.inc"

section	.bss
son1	resd	1
son2	resd	1

section .text
tizim_global	main

main:
 	chop_et		`Ikkita son kiriting: `
 	qabul_qil	`%i %i`, son1, son2
 	mov	edx , 0
 	mov	ecx , 32

loop_boshi:
	clc
	mov	bl , 0
	rol	dword[son1] , 1
	adc	bl , 0
	rol	dword [son2] , 1
	adc	bl , 0
	cmp	bl , 1
	jnz	bir_xil
	add	dl , bl
bir_xil:
	loop	loop_boshi

	chop_et		`%i va %i o'rtasidagi masofa %i ga teng \n`, \
	[son1], [son2], edx

ret

