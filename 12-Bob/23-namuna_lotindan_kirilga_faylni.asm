%include "22-namuna_c_qism_dasturlari.inc" 
%include "nasm-io.inc" 

section	.bss 
yoziladigan_fayl_tr	resd	1
o_qiladigan_fayl_tr	resd	1 

%define	fayl_nomi_uzn	200 
o_qi_fayl_nomi	resb	fayl_nomi_uzn 
yoz_fayl_nomi	resb	fayl_nomi_uzn 

%define	qator_uzunligi	100 
qator	resb	qator_uzunligi		 

n	resd	1 

section	.text 
tizim_global	main 

main: 
	chop_et     `O'girilishi kerak bo'lgan fayl nomi: ` 
	qabul_qil   `%s`, o_qi_fayl_nomi 
	
	chop_et     `Yangi fayl nomi: ` 
	qabul_qil   `%s`, yoz_fayl_nomi 

	faylni_ochish o_qi_fayl_nomi, O_QISH_MAQ 
	cmp	eax , 0 
	ja	.o_qiladigan_fayl_ochildi 
	chop_et	`%s faylini ochib bo'lmadi \n`, o_qi_fayl_nomi 
	jmp	.yakun 

.o_qiladigan_fayl_ochildi: 
	mov	[o_qiladigan_fayl_tr] , eax 

	faylni_ochish yoz_fayl_nomi, YOZISH_MAQ 
	cmp	eax , 0 
	ja	.yoziladigan_fayl_ochildi 
	chop_et	`%s faylini ochib bo'lmadi \n`, yoz_fayl_nomi 
	jmp	.yakun 

.yoziladigan_fayl_ochildi: 
	mov	[yoziladigan_fayl_tr] , eax 

.ko_chirish: 
	fayldan_o_qish [o_qiladigan_fayl_tr],qator, qator_uzunligi 
	mov	[n] , eax 

	push	dword [n] 
	push	dword qator 
	call	o_girish 
	add	esp , 2 * 4 

	faylga_yozish	[yoziladigan_fayl_tr], qator, [n] 

	cmp	dword[n] , 0 
	jnz	.ko_chirish 

	faylni_yopish [o_qiladigan_fayl_tr] 
	faylni_yopish [yoziladigan_fayl_tr] 

.yakun: 
	dasturni_yakunlash 0 

;; o_girish qism dasturi. 
;; 
;; Maqsad: 
;;	qolipdagi lotin harflarini mos kirilchasiga o'girish. 
;;	KOE8-R raqamlash turidan foydalaniladi. 
;;	C dagi e'lon qilinishi: 
;;	int o_girish(char * qolip, int uzunlik); 
;; 
;; Qiymatlar: 
;;	qolip - qolip manzili 
;;	uzunlik - qolip uzunligi 
;; 

%define	qolip	[ebp+8] 
%define	n		[ebp+12] 

%define	lotin_a	97 
%define	lotin_z	122 
 
%define	lotin_A	65 
%define	lotin_Z	90 
 
%define	kichik_harflar_farqi	96 
%define	bosh_harflar_farqi		160 

o_girish: 
	enter	0 , 0 
	push	edi 
 	push	esi 
 	push	ecx 
 
 	mov	edi , qolip 
 	mov	esi , qolip 
 	mov	ecx , n 
 
 	test	ecx , ecx 
	jz	.yakun	 
 
.lp_boshi: 
 	lodsb 
 	cmp	al , lotin_a 
 	jb	.kichik_harf_emas		;;%if (al < lotin_a) 
 	cmp	al , lotin_z 
 	ja	.kichik_harf_emas		;;%if (al > lotin_z) 
 	add	al , kichik_harflar_farqi 
 
 	jmp	.bosh_harf_emas 
 
.kichik_harf_emas: 
 	cmp	al , lotin_A 
	jb	.bosh_harf_emas			;;%if (al < lotin_A) 
	cmp	al , lotin_Z 
	ja	.bosh_harf_emas			;;%if (al > lotin_Z) 
 	add	al , bosh_harflar_farqi 
 	 
.bosh_harf_emas: 
	stosb 
 	loop	.lp_boshi 
 
.yakun: 
	pop	ecx 
	pop	esi 
 	pop	edi 
 	leave 
ret
