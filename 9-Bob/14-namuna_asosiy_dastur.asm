%include "nasm-io.inc"
%include "14-namuna_lotindan_kirilga.inc"

section	.data
qator1	db	"Men makro vositalar haqida bilaman",0
lotindan_kirilga qator2, "Men makro vositalar haqida bilaman"

section	.text
tizim_global	main

main:
	chop_et	`Lotin: %s \nKiril: %s \n`, qator1, qator2
ret

