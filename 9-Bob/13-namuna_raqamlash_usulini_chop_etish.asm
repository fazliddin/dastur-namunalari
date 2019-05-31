%include "nasm-io.inc"

section	.data
belgilar:
	%assign	harf	1		;; 0 emas, 1 dan boshlaymiz
	%rep	255
		%defstr	raqam	harf
		db	`\t`, raqam, `) `, harf, `\n`
		%assign	harf	harf+1
	%endrep
	db	0			;; qator so'ngi

section	.text
tizim_global	main

main:
	chop_et		`%s`, belgilar
ret
