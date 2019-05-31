%include "21-namuna_linux_tizim_xizmatlari.inc"

section	.bss
yoziladigan_fayl_tr	resd	1		;; Yoziladigan fayl tartib raqami
o_qiladigan_fayl_tr	resd	1		;; O’qiladigan fayl tartib raqami

%define	fayl_nomi_uzn	200
o_qiladigan_fayl_nomi	resb	fayl_nomi_uzn
yoziladigan_fayl_nomi	resb	fayl_nomi_uzn

%define	qator_uzunligi	100			;; 100 baytdan o’qiymiz
qator	resb	qator_uzunligi		

n	resd	1

section	.data
taklif1	db	"Nusxa olinadigan fayl nomi: ",0
taklif1_uzunligi	equ	$-taklif1

taklif2	db	"Yangi fayl nomi: ",0
taklif2_uzunligi	equ	$-taklif2

xato	db	"Faylni ochib bo'lmadi",0
xato_uzunligi	equ	$-xato

section	.text
global	main

main:
	faylga_yozish STDOUT, taklif1, taklif1_uzunligi
	fayldan_o_qish STDIN, o_qiladigan_fayl_nomi, fayl_nomi_uzn
	mov	byte[o_qiladigan_fayl_nomi+eax-1] , 0

	faylga_yozish STDOUT, taklif2, taklif2_uzunligi
	fayldan_o_qish STDIN, yoziladigan_fayl_nomi, fayl_nomi_uzn
	mov	byte[yoziladigan_fayl_nomi+eax-1] , 0

	faylni_ochish o_qiladigan_fayl_nomi, O_QISH_MAQ
	cmp	eax , 0
	ja	o_qiladigan_fayl_ochildi
	faylga_yozish STDOUT, xato, xato_uzunligi
	jmp	yakun

o_qiladigan_fayl_ochildi:
	mov	[o_qiladigan_fayl_tr] , eax

	faylni_ochish yoziladigan_fayl_nomi, (YARATISH_MAQ | YOZISH_MAQ | TOZALASH_MAQ)
	cmp	eax , 0
	ja	yoziladigan_fayl_ochildi
	faylga_yozish STDOUT, xato, xato_uzunligi
	jmp	yakun

yoziladigan_fayl_ochildi:
	mov	[yoziladigan_fayl_tr] , eax
	
ko_chirish:
	fayldan_o_qish	[o_qiladigan_fayl_tr], qator, qator_uzunligi
	mov	[n] , eax
	faylga_yozish	[yoziladigan_fayl_tr], qator, eax

	cmp	dword[n] , 0
	jnz	ko_chirish

	faylni_yopish [o_qiladigan_fayl_tr]
	faylni_yopish [yoziladigan_fayl_tr]

yakun:
	dasturni_yakunlash 0
