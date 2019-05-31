%include	"nasm-io.inc"

section .bss
a  resq 1			
b  resq 1

section .text 
tizim_global main

main:
	chop_et		`a ni kiriting: `
	qabul_qil	`%lf` , a

	push	dword[a+4]
	push	dword[a]
	call	kasr_ildiz
	add	esp , 8

	fstp	qword[b]
	chop_et		`kasr_ildiz(a) = %g \n`, [b], [b+4]
	
ret

;; Kasr ildiz qism dasturi.
;;
;; Maqsad:
;;	Sonning kvadrat ildizi qo'sh aniqlikdagi kasr son
;;	sifatida hisoblanadi.
;;	C dagi e'lon qilinishi:
;;	float kasr_ildiz(float a);
;;
;; Qiymatlar:
;;	a - kvadrat ildizi hisoblanadigan qiymat.
;;
;; Natija:
;;	kvadrat ildiz ST0 registerida qaytariladi.

;; Jo'natilgan qiymat
%define	a	[ebp + 8]

;; Mahalliy o'zgaruvchilar
%define	ikki	word[ebp - 8]
%define	eps	dword[ebp - 4]

kasr_ildiz:
	enter	8 , 0
	mov	eps , __float32__(0.000001)
	fld	eps		;; ST0 <- eps
	fld	qword a
	mov	ikki , 2	;; x(1) = a/2
	fidiv	ikki		;; ST0 <- x(n)
	fld	qword a		;; ST0 <- a , ST1 <- x(n)

.takrorlanish:
	fdiv	st1		;; ST0 <- a/x(n)
	fadd	st1		;; ST0 <- x(n) + a/x(n)
	fidiv	ikki		;; ST0 <- ( x(n) + a/x(n) ) / 2
				;; Demak, ST0 = x(n+1), ST1 = x(n)
	fxch	st1		;; ST0 <- x(n), ST1 <- x(n+1)
	fsub	st1		;; ST0 <- x(n) - x(n+1)
	fabs			;; ST0 <- |x(n) - x(n+1)|, oradagi farqning moduli
	
	fcomip	st2		;; |x(n) - x(n+1)| < eps ?
	jbe	.topildi

	fld	qword a		;; ST0 <- a, ST1 <- x(n+1)
	jmp	.takrorlanish

.topildi:
	fxch	st1		;; ST0 <- eps, ST1 <- natija
	fstp	qword[ebp - 8]	;; ST0 <- natija
	leave
	ret

