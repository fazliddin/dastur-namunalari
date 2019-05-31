%include "22-namuna_c_qism_dasturlari.inc"
%include "nasm-io.inc"

section	.bss
yoziladigan_fayl_tr	resd	1		;; Yoziladigan fayl tartib raqami
o_qiladigan_fayl_tr	resd	1		;; O’qiladigan fayl tartib raqami

%define	fayl_nomi_uzn	200
o_qiladigan_fayl_nomi	resb	fayl_nomi_uzn
yoziladigan_fayl_nomi	resb	fayl_nomi_uzn

%define	qator_uzunligi	100			;; 100 baytdan o’qiymiz
qator	resb	qator_uzunligi		

n	resd	1

section	.text
tizim_global	main

main:
        chop_et     `Nusxa olinadigan fayl nomi: `
        qabul_qil   `%s`, o_qiladigan_fayl_nomi

        chop_et     `Yangi fayl nomi: `
        qabul_qil   `%s`, yoziladigan_fayl_nomi

	faylni_ochish o_qiladigan_fayl_nomi, O_QISH_MAQ
	cmp	eax , 0
	ja	o_qiladigan_fayl_ochildi
	chop_et	`%s faylini ochib bo'lmadi \n`, o_qiladigan_fayl_nomi
	jmp	yakun

o_qiladigan_fayl_ochildi:
	mov	[o_qiladigan_fayl_tr] , eax

	faylni_ochish yoziladigan_fayl_nomi, YOZISH_MAQ
	cmp	eax , 0
	ja	yoziladigan_fayl_ochildi
	chop_et	`%s faylini ochib bo'lmadi \n`, o_qiladigan_fayl_nomi
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
