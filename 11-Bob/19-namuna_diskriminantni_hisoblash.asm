%include	"nasm-io.inc"

section .bss
a  resq 1			;; Qo'sh aniqlikdagi sonlarni
b  resq 1			;; saqlash uchun o'zgaruvchilar.
c  resq 1
d  resq 1

section .data
koef dw  4

section text 
tizim_global main

main:
	chop_et		`a, b va c ni kiriting: `
	qabul_qil	`%lf %lf %lf`, a, b, c

	fild  word[koef]	;; ST0 ← 4
	fmul  qword[a]		;; ST0 ← 4*a
	fmul  qword[c]		;; ST0 ← 4*a*c
 
	fld   qword[b]		;; ST0 ← b
	fmul  qword[b]		;; ST0 ← ST0 * b
	
	fsub	st1
	fstp	qword[d]
	
	chop_et		`b*b – 4*a*c = %g \n`, [d], [d+4]
	
ret
